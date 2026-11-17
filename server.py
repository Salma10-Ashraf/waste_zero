from pathlib import Path
from fastapi.responses import FileResponse
from main import app  # your existing backend, untouched

STATIC = Path(__file__).resolve().parent / "static"

# drop the old "/" JSON route so the Angular app opens at the main link
app.router.routes = [r for r in app.router.routes if getattr(r, "path", None) != "/"]

@app.get("/{full_path:path}")
def serve_frontend(full_path: str):
    f = (STATIC / full_path).resolve()
    if full_path and f.is_file() and STATIC.resolve() in f.parents:
        return FileResponse(f)
    return FileResponse(STATIC / "index.html")
