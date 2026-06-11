from fastapi import APIRouter, UploadFile, File
from app.services.stt_service import speech_to_text

router = APIRouter(prefix="/api/stt")

@router.post("/convert")
async def stt_convert(file: UploadFile = File(...)):
    text = await speech_to_text(file.file)
    return {"text": text}
