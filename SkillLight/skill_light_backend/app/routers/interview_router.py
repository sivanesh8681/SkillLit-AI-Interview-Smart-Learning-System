import uuid
import os
from fastapi import APIRouter
from pydantic import BaseModel
from openai import OpenAI

router = APIRouter()

client = OpenAI(api_key=os.getenv("OPENAI_API_KEY"))

# ------------------------
# MODELS
# ------------------------
class StartInterview(BaseModel):
    difficulty: str
    duration: int

class Message(BaseModel):
    session_id: str
    text: str

sessions = {}

# ------------------------
# START INTERVIEW
# ------------------------
@router.post("/start")
def start_interview(data: StartInterview):
    session_id = str(uuid.uuid4())

    sessions[session_id] = {
        "difficulty": data.difficulty,
        "duration": data.duration,
        "history": []
    }

    return {"session_id": session_id}

# ------------------------
# INTERVIEW MESSAGE
# ------------------------
@router.post("/message")
def interview_message(data: Message):
    session = sessions.get(data.session_id)

    if not session:
        return {"end": True}

    prompt = f"""
You are a professional interviewer.
Difficulty: {session['difficulty']}.

Ask ONE short interview question at a time.
Be human, friendly, and realistic.
If the interview is finished, say exactly:
Interview completed
"""

    messages = [
        {"role": "system", "content": prompt},
        *session["history"],
        {"role": "user", "content": data.text},
    ]

    response = client.chat.completions.create(
        model="gpt-4o-mini",
        messages=messages
    )

    reply = response.choices[0].message.content

    session["history"].append({"role": "user", "content": data.text})
    session["history"].append({"role": "assistant", "content": reply})

    if "Interview completed" in reply:
        return {"end": True}

    return {"reply": reply}