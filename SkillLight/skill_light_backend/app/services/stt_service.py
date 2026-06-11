from app.core.openai_client import client

async def speech_to_text(audio_file):
    response = client.audio.transcriptions.create(
        model="gpt-4o-mini-tts",
        file=audio_file
    )
    return response.text
