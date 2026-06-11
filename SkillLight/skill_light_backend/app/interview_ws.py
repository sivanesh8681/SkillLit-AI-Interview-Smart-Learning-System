from fastapi import WebSocket, Depends
from app.interview_logic import process_answer
from app.voice import detect_silence

async def live_interview_socket(ws: WebSocket, premium=Depends(...)):
    await ws.accept()
    frames = []

    await ws.send_json({
        "type": "ai",
        "text": "Good morning, introduce yourself."
    })

    while True:
        chunk = await ws.receive_bytes()
        frames.append(chunk)

        if detect_silence(frames):
            answer = "transcribed_text"  # whisper later
            frames.clear()

            result = process_answer(answer)

            if result["end"]:
                await ws.send_json({"type": "end", "text": result["text"]})
                await ws.close()
                break

            await ws.send_json({
                "type":"ai",
                "text": result["text"],
                "emotion": result["emotion"]
            })
