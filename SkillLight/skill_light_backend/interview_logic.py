import openai
import re

openai.api_key = "YOUR_OPENAI_KEY"

MAX_WARNINGS = 3
warnings = 0
history = []

SYSTEM_PROMPT = """
You are a professional job interviewer.
Only interview-related questions.
Encourage the candidate.
If off-topic, warn them.
"""

def is_unwanted(text):
    keywords = ["joke", "movie", "song", "abuse", "friend"]
    return any(k in text.lower() for k in keywords)

def analyze_emotion(text):
    score = {
        "confidence": 7,
        "clarity": 7,
        "stress": 3
    }
    if len(text.split()) < 5:
        score["confidence"] -= 2
        score["stress"] += 2
    return score

def process_answer(answer):
    global warnings, history

    if is_unwanted(answer):
        warnings += 1
        if warnings >= MAX_WARNINGS:
            return {
                "terminate": True,
                "text": "The interview has been terminated due to repeated violations."
            }
        return {
            "terminate": False,
            "text": f"This is an interview. Please stay professional. Warning {warnings}/3"
        }

    emotion = analyze_emotion(answer)

    history.append({"role": "user", "content": answer})
    history = history[-6:]  # sliding window (COST REDUCTION)

    response = openai.ChatCompletion.create(
        model="gpt-4o-mini",
        messages=[
            {"role": "system", "content": SYSTEM_PROMPT},
            *history
        ]
    )

    ai_text = response.choices[0].message.content
    history.append({"role": "assistant", "content": ai_text})

    return {
        "terminate": False,
        "text": ai_text,
        "emotion": emotion
    }
