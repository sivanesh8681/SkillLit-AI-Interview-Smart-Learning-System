from fastapi import APIRouter
from fastapi.responses import StreamingResponse
from app.services.tts_service import text_to_speech

router = APIRouter(prefix="/api/tts")

@router.post("/speak")
async def tts_speak(payload: dict):
    audio_data = await text_to_speech(payload["text"])

    return StreamingResponse(
        audio_data,
        media_type="audio/mpeg"
    )
