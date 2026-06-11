import os
import uuid
import io
import json
import base64
from pathlib import Path
from typing import List, Optional, Dict

from fastapi import FastAPI, HTTPException, UploadFile, File, Request
from pydantic import BaseModel
from fastapi.middleware.cors import CORSMiddleware
from fastapi.responses import Response, FileResponse
from fastapi.staticfiles import StaticFiles
from dotenv import load_dotenv
from openai import OpenAI
from slowapi import Limiter
from slowapi.util import get_remote_address
import requests

# Resume Extract libs
import fitz
import docx
from PIL import Image
import pytesseract

pytesseract.pytesseract.tesseract_cmd = r"C:\Program Files\Tesseract-OCR\tesseract.exe"

load_dotenv()

app = FastAPI(title="Skill Light AI - Complete Platform")

# ===================== FOLDERS =====================
os.makedirs("uploads", exist_ok=True)
os.makedirs("diagrams", exist_ok=True)
os.makedirs("audio", exist_ok=True)

app.mount("/diagrams", StaticFiles(directory="diagrams"), name="diagrams")
app.mount("/audio", StaticFiles(directory="audio"), name="audio")

# ===================== CORS =====================
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

client = OpenAI(api_key=os.getenv("OPENAI_API_KEY"))

# =====================================================================
#  INTERVIEW SESSION STORE — defined at module level so ALL endpoints
#  can access it. This was the root cause of the NameError bug.
# =====================================================================
_interview_sessions: dict = {}

# ===================== MODELS =====================
class LessonRequest(BaseModel):
    topic: str
    duration: str
    difficulty: str
    language: str = "english"

# ── Interview models ──────────────────────────────
class InterviewStartRequest(BaseModel):
    job_role: str = "Software Engineer"
    difficulty: str = "medium"
    duration_minutes: int = 10
    resume_context: str = ""

class InterviewMessageRequest(BaseModel):
    session_id: str
    text: str

class CodeEvalRequest(BaseModel):
    session_id: str
    code: str
    question: str

class InterviewTTSRequest(BaseModel):
    text: str
    voice: str = "alloy"

# ===================== HEALTH CHECK =====================
@app.get("/")
def health():
    return {
        "status": "Skill Light AI Running 🚀",
        "features": [
            "Premium Classroom Engine",
            "Multi-subject Teaching (Math, Chemistry, Physics, Biology)",
            "9 Languages Support",
            "Resume Analyzer",
            "AI Interview Engine",
            "OpenAI TTS + Whisper STT",
        ]
    }

# ===================== SUBJECT DETECTION =====================
def detect_subject_category(topic: str) -> Dict[str, any]:
    topic_lower = topic.lower()
    math_keywords = ["calculus", "derivative", "integral", "algebra", "geometry",
                    "trigonometry", "equation", "function", "polynomial", "quadratic",
                    "complex numbers", "matrix", "probability", "statistics", "aptitude",
                    "reasoning", "quantitative", "arithmetic", "numbers"]
    chemistry_keywords = ["chemistry", "molecule", "atom", "bond", "reaction", "element",
                         "compound", "periodic", "electron", "ion", "acid", "base",
                         "organic", "inorganic", "atomic", "chemical", "structure",
                         "oxidation", "reduction", "stoichiometry"]
    physics_keywords = ["physics", "force", "energy", "motion", "wave", "electricity",
                       "magnetic", "quantum", "thermodynamics", "mechanics", "optics",
                       "pressure", "circuit", "current", "voltage", "momentum"]
    biology_keywords = ["biology", "cell", "organism", "dna", "gene", "evolution",
                       "ecology", "anatomy", "photosynthesis", "respiration", "mitosis",
                       "meiosis", "protein", "enzyme", "tissue", "organ", "system",
                       "classification", "taxonomy"]
    engineering_keywords = ["engineering", "circuit", "electronics", "mechanical",
                          "electrical", "digital", "analog", "signal", "control",
                          "system", "design", "manufacturing"]
    medical_keywords = ["medical", "anatomy", "physiology", "pathology", "medicine",
                       "disease", "treatment", "diagnosis", "surgery", "therapy",
                       "pharmacology", "immunology"]

    if any(kw in topic_lower for kw in math_keywords):
        return {"subject": "mathematics", "needs_examples": True, "examples_per_concept": 2, "animation_type": "math_renderer"}
    elif any(kw in topic_lower for kw in chemistry_keywords):
        return {"subject": "chemistry", "needs_examples": False, "examples_per_concept": 0, "animation_type": "molecule_renderer"}
    elif any(kw in topic_lower for kw in physics_keywords):
        return {"subject": "physics", "needs_examples": False, "examples_per_concept": 0, "animation_type": "circuit_graph_renderer"}
    elif any(kw in topic_lower for kw in biology_keywords):
        return {"subject": "biology", "needs_examples": False, "examples_per_concept": 0, "animation_type": "biology_diagram_renderer"}
    elif any(kw in topic_lower for kw in engineering_keywords):
        return {"subject": "engineering", "needs_examples": False, "examples_per_concept": 0, "animation_type": "circuit_renderer"}
    elif any(kw in topic_lower for kw in medical_keywords):
        return {"subject": "medical", "needs_examples": False, "examples_per_concept": 0, "animation_type": "biology_diagram_renderer"}
    else:
        return {"subject": "general", "needs_examples": False, "examples_per_concept": 0, "animation_type": "flow_renderer"}

def get_animation_config(subject: str, concept_name: str) -> Dict:
    animations = {
        "mathematics": {
            "graph": {"renderer": "GraphRenderer", "type": "function_plot"},
            "derivative": {"renderer": "GraphRenderer", "type": "derivative_tangent"},
            "integration": {"renderer": "GraphRenderer", "type": "area_under_curve"},
            "equation": {"renderer": "MathEquationRenderer", "type": "equation_solving"},
            "geometry": {"renderer": "GraphRenderer", "type": "geometric_shapes"},
            "complex": {"renderer": "GraphRenderer", "type": "complex_plane"},
        },
        "chemistry": {
            "atom": {"renderer": "MoleculeRenderer", "type": "atomic_structure"},
            "molecule": {"renderer": "MoleculeRenderer", "type": "molecular_structure"},
            "bond": {"renderer": "MoleculeRenderer", "type": "bond_formation"},
            "reaction": {"renderer": "MoleculeRenderer", "type": "reaction_mechanism"},
            "periodic": {"renderer": "FlowRenderer", "type": "periodic_table"},
            "electron": {"renderer": "MoleculeRenderer", "type": "electron_configuration"},
        },
        "physics": {
            "circuit": {"renderer": "CircuitRenderer", "type": "electrical_circuit"},
            "wave": {"renderer": "GraphRenderer", "type": "wave_animation"},
            "motion": {"renderer": "GraphRenderer", "type": "motion_graph"},
            "force": {"renderer": "GraphRenderer", "type": "force_diagram"},
            "energy": {"renderer": "FlowRenderer", "type": "energy_flow"},
        },
        "biology": {
            "cell": {"renderer": "BiologyDiagramRenderer", "type": "cell_structure"},
            "organ": {"renderer": "BiologyDiagramRenderer", "type": "organ_system"},
            "process": {"renderer": "FlowRenderer", "type": "biological_process"},
            "cycle": {"renderer": "FlowRenderer", "type": "life_cycle"},
            "system": {"renderer": "BiologyDiagramRenderer", "type": "body_system"},
        },
    }
    subject_anims = animations.get(subject, {})
    concept_lower = concept_name.lower()
    for key, config in subject_anims.items():
        if key in concept_lower:
            return config
    defaults = {
        "mathematics": {"renderer": "MathEquationRenderer", "type": "general"},
        "chemistry": {"renderer": "MoleculeRenderer", "type": "general"},
        "physics": {"renderer": "CircuitRenderer", "type": "general"},
        "biology": {"renderer": "BiologyDiagramRenderer", "type": "general"},
    }
    return defaults.get(subject, {"renderer": "FlowRenderer", "type": "general"})

def _parse_duration(duration_str: str) -> int:
    duration_str = duration_str.lower().strip()
    if 'h' in duration_str:
        return int(duration_str.replace('h', '').strip()) * 3600
    elif 'm' in duration_str:
        return int(duration_str.replace('m', '').strip()) * 60
    return 3600

def _get_animation_guide(subject: str) -> str:
    guides = {
        "mathematics": "- MathEquationRenderer: Step-by-step equation solving\n- GraphRenderer: Function plotting, derivatives, graphs",
        "chemistry": "- MoleculeRenderer: 3D molecular structures, bonds, reactions\n- FlowRenderer: Reaction mechanisms, process flows",
        "physics": "- CircuitRenderer: Electrical circuits, diagrams\n- GraphRenderer: Motion graphs, wave patterns\n- FlowRenderer: Energy flow, force diagrams",
        "biology": "- BiologyDiagramRenderer: Cell structures, organ systems, anatomy\n- FlowRenderer: Biological processes, life cycles",
        "engineering": "- CircuitRenderer: Circuit diagrams, schematics\n- FlowRenderer: System diagrams, process flows",
    }
    return guides.get(subject, "- FlowRenderer: General flow diagrams")

# ===================== LESSON GENERATOR =====================
@app.post("/lesson/generate-deep")
def generate_deep_lesson(data: LessonRequest):
    lesson_id = str(uuid.uuid4())
    lang = data.language.lower()
    lang_map = {
        "tamil": {"instruction": "Speak in TAMIL using English technical terms", "code": "ta-IN", "voice": "ta-IN-Wavenet-A"},
        "hindi": {"instruction": "Speak in HINDI using English technical terms", "code": "hi-IN", "voice": "hi-IN-Wavenet-A"},
        "english": {"instruction": "Clear simple English", "code": "en-IN", "voice": "en-IN-Wavenet-D"},
        "telugu": {"instruction": "Speak in TELUGU using English technical terms", "code": "te-IN", "voice": "te-IN-Wavenet-A"},
        "malayalam": {"instruction": "Speak in MALAYALAM using English technical terms", "code": "ml-IN", "voice": "ml-IN-Wavenet-A"},
        "kannada": {"instruction": "Speak in KANNADA using English technical terms", "code": "kn-IN", "voice": "kn-IN-Wavenet-A"},
        "marathi": {"instruction": "Speak in MARATHI using English technical terms", "code": "mr-IN", "voice": "mr-IN-Wavenet-A"},
        "bengali": {"instruction": "Speak in BENGALI using English technical terms", "code": "bn-IN", "voice": "bn-IN-Wavenet-A"},
        "gujarati": {"instruction": "Speak in GUJARATI using English technical terms", "code": "gu-IN", "voice": "gu-IN-Wavenet-A"},
    }
    lang_info = lang_map.get(lang, lang_map["english"])
    subject_config = detect_subject_category(data.topic)
    subject = subject_config["subject"]
    needs_examples = subject_config["needs_examples"]
    examples_per_concept = subject_config["examples_per_concept"]
    total_seconds = _parse_duration(data.duration)
    if needs_examples:
        num_concepts = max(3, total_seconds // 1800)
        concept_time = 600
        example_time = 480
    else:
        num_concepts = max(5, total_seconds // 900)
        concept_time = 900
        example_time = 0
    anim_guide = _get_animation_guide(subject)
    examples_text = str(examples_per_concept) if needs_examples else ""
    example_time_text = str(example_time) if needs_examples else ""
    prompt = f"""You are an EXPERT TEACHER creating a comprehensive lesson.
Topic: {data.topic}
Subject: {subject}
Duration: {data.duration} ({total_seconds} seconds)
Difficulty: {data.difficulty}
Language: {lang_info["instruction"]}
SUBJECT-SPECIFIC RULES:
Subject Type: {subject}
Needs Examples: {needs_examples}
""" + (f"Examples per concept: {examples_text}" if needs_examples else "NO EXAMPLES - Only detailed concept teaching") + f"""
CONTENT STRUCTURE:
Generate {num_concepts} comprehensive concepts.
For EACH concept:
1. Concept Teaching ({concept_time} seconds):
   - Clear, detailed explanation
   - 4-6 key points
   - Include formulas, definitions, diagrams
   - Natural handwriting style
   - Animation to visualize
""" + (f"""2. Worked Examples ({examples_text} problems per concept):
   - Complete step-by-step solutions
   - {example_time_text} seconds per problem
""" if needs_examples else "") + f"""
ANIMATION CONFIGURATION:
For {subject}, use these renderers:
{anim_guide}
OUTPUT FORMAT (STRICT JSON):
{{
  "subject": "{subject}",
  "language_code": "{lang_info['code']}",
  "voice_name": "{lang_info['voice']}",
  "total_duration_seconds": {total_seconds},
  "needs_examples": {str(needs_examples).lower()},
  "concepts": [
    {{
      "concept_number": 1,
      "concept_title": "Clear Title",
      "teaching_content": {{
        "heading": "Concept Name",
        "board_lines": ["Natural sentence about the concept"],
        "speech_text": "Detailed 250-word explanation...",
        "animation": {{
          "renderer": "BiologyDiagramRenderer",
          "type": "cell_structure",
          "data": {{}},
          "description": "Shows cell structure"
        }}
      }}
    }}
  ]
}}
Generate complete concepts with detailed content."""

    try:
        response = client.chat.completions.create(
            model="gpt-4o",
            messages=[{"role": "user", "content": prompt}],
            temperature=0.7,
            response_format={"type": "json_object"},
            max_tokens=16000
        )
    except Exception as e:
        raise HTTPException(500, f"AI generation failed: {e}")
    try:
        lesson_data = json.loads(response.choices[0].message.content)
    except Exception as e:
        raise HTTPException(500, f"Invalid JSON: {e}")
    if "concepts" not in lesson_data:
        raise HTTPException(500, "No concepts generated")
    return {
        "lesson_id": lesson_id,
        "topic": data.topic,
        "subject": subject,
        "language": data.language,
        "language_code": lang_info["code"],
        "voice_name": lang_info["voice"],
        "duration": data.duration,
        "total_concepts": len(lesson_data["concepts"]),
        "needs_examples": needs_examples,
        "concepts": lesson_data["concepts"]
    }

# ===================== GOOGLE TTS =====================
@app.post("/tts/google")
def google_tts(payload: dict):
    text = payload.get("text", "")
    language = payload.get("language", "en-IN")
    voice_name = payload.get("voice_name", "en-IN-Wavenet-D")
    if not text:
        raise HTTPException(400, "Text required")
    GOOGLE_API_KEY = os.getenv("GOOGLE_CLOUD_TTS_API_KEY")
    if not GOOGLE_API_KEY:
        raise HTTPException(500, "Google API key missing in .env file")
    url = f"https://texttospeech.googleapis.com/v1/text:synthesize?key={GOOGLE_API_KEY}"
    payload_data = {
        "input": {"text": text},
        "voice": {"languageCode": language, "name": voice_name, "ssmlGender": "FEMALE"},
        "audioConfig": {"audioEncoding": "MP3", "speakingRate": 0.85}
    }
    try:
        response = requests.post(url, json=payload_data, timeout=30)
        if response.status_code != 200:
            raise HTTPException(500, f"Google TTS error: {response.text}")
        audio_content = response.json().get("audioContent")
        if not audio_content:
            raise HTTPException(500, "No audio content received from Google TTS")
        audio_bytes = base64.b64decode(audio_content)
        audio_id = str(uuid.uuid4())
        audio_path = f"audio/{audio_id}.mp3"
        with open(audio_path, "wb") as f:
            f.write(audio_bytes)
        return {"audio_url": f"/audio/{audio_id}.mp3", "success": True}
    except requests.exceptions.ConnectionError:
        raise HTTPException(503, "Network connection error.")
    except requests.exceptions.Timeout:
        raise HTTPException(504, "Request timeout.")
    except Exception as e:
        raise HTTPException(500, f"TTS failed: {str(e)}")

# ===================== ANSWER QUESTION =====================
@app.post("/answer-question")
def answer_question(payload: dict):
    question = payload.get("question", "")
    context = payload.get("context", "")
    language = payload.get("language", "English")
    if not question:
        raise HTTPException(400, "Question required")
    prompt = f"""{context}
Answer the student's question clearly in {language} language.
Keep answer under 100 words.
Question: {question}"""
    try:
        response = client.chat.completions.create(
            model="gpt-4o-mini",
            messages=[{"role": "user", "content": prompt}],
            temperature=0.6
        )
        return {"answer": response.choices[0].message.content, "success": True}
    except Exception as e:
        raise HTTPException(500, f"Answer generation failed: {str(e)}")

# ===================== RESUME ANALYZER =====================
UPLOAD_DIR = "uploads"
GOOGLE_MAP_KEY = os.getenv("GOOGLE_MAPS_API_KEY", "")
limiter = Limiter(key_func=get_remote_address)
app.state.limiter = limiter

def extract_text(file_bytes, filename):
    ext = filename.split(".")[-1].lower()
    if ext == "pdf":
        text = ""
        with fitz.open(stream=file_bytes, filetype="pdf") as doc:
            for page in doc:
                text += page.get_text()
        return text
    if ext == "docx":
        document = docx.Document(io.BytesIO(file_bytes))
        return "\n".join(p.text for p in document.paragraphs)
    if ext in ["jpg", "jpeg", "png"]:
        image = Image.open(io.BytesIO(file_bytes))
        return pytesseract.image_to_string(image)
    return ""

@app.post("/resume/upload")
@limiter.limit("5/minute")
async def upload_resume(request: Request, file: UploadFile = File(...)):
    try:
        file_bytes = await file.read()
        if len(file_bytes) > 5 * 1024 * 1024:
            raise HTTPException(400, "File too large (max 5MB)")
        file_id = str(uuid.uuid4())
        save_path = os.path.join(UPLOAD_DIR, file_id + "_" + file.filename)
        with open(save_path, "wb") as f:
            f.write(file_bytes)
        resume_text = extract_text(file_bytes, file.filename)
        if not resume_text.strip():
            raise HTTPException(400, "Resume text not readable")
        prompt = f"""You are an expert HR recruiter analyzing a resume.
Analyze thoroughly and return ONLY a JSON object:
{{
  "name": "Candidate name",
  "rating": 7.5,
  "best_roles": ["Role 1", "Role 2", "Role 3"],
  "salary_range": "₹6 LPA - ₹12 LPA",
  "skills_to_improve": ["Skill 1", "Skill 2", "Skill 3"],
  "resume_suggestions": ["Suggestion 1", "Suggestion 2"],
  "improvement_details": ["Detail 1", "Detail 2"],
  "learning_skills": [{{"name": "Docker", "icon": "docker"}}, {{"name": "AWS", "icon": "aws"}}],
  "companies": [
    {{"name": "Company", "address": "Address", "salary": "₹8 LPA", "latitude": 12.9716, "longitude": 77.5946}}
  ]
}}
Resume:
{resume_text[:6000]}"""
        response = client.chat.completions.create(
            model="gpt-4o-mini",
            messages=[{"role": "user", "content": prompt}],
            temperature=0.3,
            response_format={"type": "json_object"}
        )
        result = json.loads(response.choices[0].message.content)
        result["file_id"] = file_id
        result["filename"] = file.filename
        result["maps_key"] = GOOGLE_MAP_KEY
        return result
    except HTTPException:
        raise
    except Exception as e:
        raise HTTPException(500, f"Resume analysis failed: {str(e)}")

# =====================================================================
#  INTERVIEW ENGINE
#  _interview_sessions is defined at the top of this file (line ~50)
#  so ALL functions below can access it without any NameError
# =====================================================================

@app.post("/interview/start")
def start_interview(data: InterviewStartRequest):
    """Create session, return opening question."""
    session_id = str(uuid.uuid4())

    system_prompt = f"""You are Alex, a professional AI interviewer conducting a {data.difficulty}-level
job interview for the role of {data.job_role}.

RULES:
- Be warm, professional, and encouraging.
- Ask ONE clear question at a time. Never ask multiple questions in one turn.
- Vary question types: behavioral (STAR), technical, situational, problem-solving.
- For technical roles, occasionally ask to write/explain code — but ONLY situationally.
  When you do, say: "Could you write a quick function for that? Use the notepad on your right."
- Keep responses under 60 words EXCEPT when explaining a coding task.
- Never break character.
- If the candidate is silent or unclear, gently rephrase or encourage.
{"- Resume context: " + data.resume_context if data.resume_context else ""}

Start by greeting the candidate warmly and asking them to introduce themselves."""

    try:
        opening = client.chat.completions.create(
            model="gpt-4o",
            messages=[
                {"role": "system", "content": system_prompt},
                {"role": "user", "content": "[SESSION START]"},
            ],
            temperature=0.75,
            max_tokens=200,
        )
        opening_text = opening.choices[0].message.content.strip()
    except Exception as e:
        opening_text = f"Welcome! I'm Alex, your AI interviewer today for the {data.job_role} role. Please tell me about yourself."

    # ── Store session ──────────────────────────────────────────────────
    _interview_sessions[session_id] = {
        "job_role": data.job_role,
        "difficulty": data.difficulty,
        "system_prompt": system_prompt,
        "history": [
            {"role": "system", "content": system_prompt},
            {"role": "assistant", "content": opening_text},
        ],
        "turn_count": 0,
        "code_requested": False,
    }

    return {"session_id": session_id, "question": opening_text, "success": True}


@app.post("/interview/message")
def interview_message(data: InterviewMessageRequest):
    """Receive user answer, return next question."""
    # ── This now correctly reads from the module-level dict ──
    session = _interview_sessions.get(data.session_id)
    if not session:
        raise HTTPException(404, "Session not found. Please restart the interview.")

    session["history"].append({"role": "user", "content": data.text})
    session["turn_count"] += 1

    try:
        response = client.chat.completions.create(
            model="gpt-4o",
            messages=session["history"],
            temperature=0.75,
            max_tokens=200,
        )
        reply = response.choices[0].message.content.strip()
    except Exception as e:
        raise HTTPException(500, f"GPT error: {str(e)}")

    session["history"].append({"role": "assistant", "content": reply})

    lower = reply.lower()
    code_keywords = ["write", "code", "syntax", "implement", "function",
                     "program", "notepad", "snippet", "script"]
    session["code_requested"] = any(k in lower for k in code_keywords)

    return {
        "reply": reply,
        "code_requested": session["code_requested"],
        "turn": session["turn_count"],
        "success": True,
    }


@app.post("/interview/evaluate-code")
def evaluate_code(data: CodeEvalRequest):
    """Evaluate code from notepad and return verbal feedback."""
    session = _interview_sessions.get(data.session_id)
    if not session:
        raise HTTPException(404, "Session not found.")

    eval_prompt = f"""The candidate wrote this code in response to: "{data.question}"

CODE SUBMITTED:
```
{data.code}
```

As the interviewer Alex, evaluate it conversationally in under 80 words.
- Mention 1 strength and 1 improvement if applicable.
- Be encouraging but honest.
- End with a natural transition to the next interview question (ask ONE new question).
- Do NOT use bullet points. Speak naturally."""

    session["history"].append({"role": "user", "content": f"[CODE SUBMITTED]\n{data.code}"})

    try:
        response = client.chat.completions.create(
            model="gpt-4o",
            messages=session["history"] + [{"role": "user", "content": eval_prompt}],
            temperature=0.7,
            max_tokens=250,
        )
        feedback = response.choices[0].message.content.strip()
    except Exception as e:
        raise HTTPException(500, f"GPT error: {str(e)}")

    session["history"].append({"role": "assistant", "content": feedback})
    session["code_requested"] = False

    return {"feedback": feedback, "success": True}


@app.post("/interview/tts")
def interview_tts(data: InterviewTTSRequest):
    """OpenAI TTS — returns MP3 URL."""
    if not data.text.strip():
        raise HTTPException(400, "Text is required.")
    try:
        speech = client.audio.speech.create(
            model="tts-1",
            voice=data.voice,
            input=data.text,
            speed=0.92,
        )
        audio_id = str(uuid.uuid4())
        audio_path = f"audio/{audio_id}.mp3"
        speech.stream_to_file(audio_path)
        return {"audio_url": f"/audio/{audio_id}.mp3", "success": True}
    except Exception as e:
        raise HTTPException(500, f"TTS failed: {str(e)}")


@app.post("/interview/stt")
async def interview_stt(file: UploadFile = File(...)):
    """OpenAI Whisper STT — returns transcribed text."""
    try:
        audio_bytes = await file.read()
        if len(audio_bytes) < 1000:
            return {"text": "", "success": True}

        ext = file.filename.split(".")[-1] if file.filename else "webm"
        tmp_path = f"audio/stt_{uuid.uuid4()}.{ext}"

        with open(tmp_path, "wb") as f:
            f.write(audio_bytes)

        with open(tmp_path, "rb") as f:
            transcript = client.audio.transcriptions.create(
                model="whisper-1",
                file=f,
                language="en",
            )

        try:
            os.remove(tmp_path)
        except Exception:
            pass

        return {"text": transcript.text.strip(), "success": True}
    except Exception as e:
        raise HTTPException(500, f"STT failed: {str(e)}")


@app.post("/interview/end")
def end_interview(payload: dict):
    """End session and return evaluation report."""
    session_id = payload.get("session_id", "")
    session = _interview_sessions.get(session_id)

    if not session:
        # Session may have already been cleaned up — return generic result
        return {
            "evaluation": {
                "overall_score": 7,
                "communication": 7,
                "technical": 7,
                "confidence": 7,
                "strengths": ["Good communication"],
                "improvements": ["Practice more technical questions"],
                "verdict": "Interview complete.",
                "summary": "The candidate completed the interview session."
            },
            "success": True
        }

    eval_prompt = """Based on the full interview conversation above, provide a JSON evaluation:
{
  "overall_score": 7.5,
  "communication": 8,
  "technical": 7,
  "confidence": 7,
  "strengths": ["strength 1", "strength 2"],
  "improvements": ["area 1", "area 2"],
  "verdict": "Strong candidate — recommended for next round.",
  "summary": "2-3 sentence overall summary."
}
Return ONLY valid JSON, no extra text."""

    try:
        response = client.chat.completions.create(
            model="gpt-4o",
            messages=session["history"] + [{"role": "user", "content": eval_prompt}],
            temperature=0.3,
            response_format={"type": "json_object"},
            max_tokens=500,
        )
        result = json.loads(response.choices[0].message.content)
    except Exception:
        result = {"verdict": "Interview complete.", "overall_score": 7}

    # Clean up session
    if session_id in _interview_sessions:
        del _interview_sessions[session_id]

    return {"evaluation": result, "success": True}


# ===================== RUN =====================
if __name__ == "__main__":
    import uvicorn
    print("\n" + "="*70)
    print("🚀 SKILL LIGHT AI - COMPLETE PLATFORM")
    print("="*70)
    print("✅ Premium Classroom Engine (All Subjects)")
    print("✅ 9 Languages Support")
    print("✅ Resume Analyzer")
    print("✅ AI Interview Engine (OpenAI TTS + Whisper)")
    print("="*70)
    print("⚠️  Required in .env:")
    print("   - OPENAI_API_KEY")
    print("   - GOOGLE_CLOUD_TTS_API_KEY")
    print("   - GOOGLE_MAPS_API_KEY (optional)")
    print("="*70 + "\n")
    uvicorn.run(app, host="0.0.0.0", port=8000)