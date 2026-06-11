from fastapi import APIRouter, UploadFile, File
import uuid, os

from services.extractor import extract_text
from services.gpt_analyzer import analyze_resume

router = APIRouter()

UPLOAD_DIR = "uploads"
os.makedirs(UPLOAD_DIR, exist_ok=True)

@router.post("/upload")
async def upload_resume(file: UploadFile = File(...)):

    file_bytes = await file.read()
    file_id = str(uuid.uuid4())

    path = os.path.join(UPLOAD_DIR, f"{file_id}_{file.filename}")
    with open(path, "wb") as f:
        f.write(file_bytes)

    text = extract_text(file_bytes, file.filename)

    analysis = analyze_resume(text)

    return {
        "file_id": file_id,
        "analysis": analysis
    }