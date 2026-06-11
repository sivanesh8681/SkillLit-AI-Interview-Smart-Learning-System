from app.core.openai_client import ask_interviewer

sessions = {}

def start_interview(difficulty: str, duration: int):
    session_id = f"session_{len(sessions)+1}"
    sessions[session_id] = {
        "difficulty": difficulty,
        "duration": duration,
        "history": []
    }
    return session_id

def process_answer(session_id: str, user_text: str):
    session = sessions.get(session_id)

    if not session:
        return None

    system_prompt = f"""
You are a professional job interviewer.
Difficulty: {session['difficulty']}
Ask one short interview question at a time.
"""

    messages = [{"role": "system", "content": system_prompt}]
    messages += session["history"]
    messages.append({"role": "user", "content": user_text})

    reply = ask_interviewer(messages)

    session["history"].append({"role": "user", "content": user_text})
    session["history"].append({"role": "assistant", "content": reply})

    return reply