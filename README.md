<div align="center">

<img src="https://img.shields.io/badge/version-1.0.0-blue?style=for-the-badge" />
<img src="https://img.shields.io/badge/status-active-success?style=for-the-badge" />
<img src="https://img.shields.io/badge/license-MIT-green?style=for-the-badge" />
<img src="https://img.shields.io/badge/PRs-welcome-brightgreen?style=for-the-badge" />

```
 ____  _    _ _ _   _     _ _   
/ ___|| | _(_) | | | |   (_) |_ 
\___ \| |/ / | | | | |   | | __|
 ___) |   <| | | | | |___| | |_ 
|____/|_|\_\_|_|_| |_____|_|\__|
```

### *From Resume to Ready — AI-Powered Interview & Learning Platform*

[🚀 Live Demo](#) • [📖 Docs](#) • [🐛 Report Bug](#) • [✨ Request Feature](#)

</div>

---

## 🤔 Why SkillLit?

> *"I know the concepts but freeze in interviews."*
> *"I don't know what I'm weak in until I fail."*
> *"I wish someone would just tell me exactly what to study."*

**That someone is SkillLit.**

Most students walk into placement interviews underprepared — not because they're incapable, but because they've never had a smart, personalized mirror that shows exactly where they stand and what to do next.

SkillLit is that mirror. It reads your resume, interviews you like an HR would, spots your weak zones, and then *teaches you* right there — no switching apps, no guessing what to study.

---

## ✨ What Makes SkillLit Different?

| Feature | Traditional Platforms | SkillLit |
|---|---|---|
| Interview Questions | Fixed bank | 🧠 Generated from *your* resume |
| Follow-ups | None | ✅ Context-aware follow-ups |
| HR Simulation | Generic chatbot | 🎭 Reacts to your answers live |
| Skill Gap | Self-assessment | 🔍 Auto-detected from performance |
| Learning | Pre-recorded videos | 📚 On-the-spot personalized modules |
| Quick Revision | Non-existent | ⚡ "Teach me X in 5 minutes" mode |
| Department Focus | Generic | 🎓 CSE / IT / ECE / Mech / AIDS |

---

## 🎯 Core Features

### 📄 1. Resume Intelligence
Upload your resume (PDF or DOCX) and SkillLit extracts:
- Skills, certifications, tools
- Education & GPA
- Projects with tech stack
- Work/internship experience
- Generates a complete profile summary
- Flags **missing industry skills** instantly

### 🎙️ 2. AI Mock Interview Engine
Not just random questions — questions *about you*:
- Technical questions based on your stack
- HR & behavioral questions
- Project-deep-dive questions
- Real-time follow-ups based on your answer quality

### 🤖 3. AI HR Simulation *(Signature Feature)*
The AI doesn't just ask questions — it *behaves* like a real HR:
- 😊 Appreciates strong answers: *"That's a great explanation!"*
- 🤨 Pushes back on weak ones: *"Can you be more specific about that?"*
- 🧐 Probes deeper: *"Interesting — how did you handle the edge cases?"*
- ⏱️ Simulates real interview pressure

### 📊 4. Smart Evaluation System
After each round, you get:
- **Technical Accuracy** score
- **Communication Quality** score
- **Confidence & Relevance** rating
- Detailed written feedback per answer

### 🔍 5. Skill Gap Detection
SkillLit cross-references:
- What's on your resume
- How you performed in the interview

Then it tells you: *"You mentioned React but couldn't explain hooks — here's what to study."*

### 📚 6. Personalized Learning Modules
Perform poorly on a topic? SkillLit teaches it on the spot:
- Concept notes (concise, interview-focused)
- Real examples
- Quick quizzes
- Re-test to confirm understanding

### ⚡ 7. 5-Minute Quick Learn
Type something like:
```
Teach me DBMS in 5 minutes
```
Get back:
- Core concepts explained simply
- Key terms for interviews
- Top 10 interview questions on the topic
- Revision checklist

### 🎓 8. Department-Based Learning Paths
Tailored content for:
- `CSE` — DSA, OS, DBMS, CN, OOP
- `IT` — Web Dev, Cloud, Networking
- `AIDS` — ML, Python, Statistics, Deep Learning
- `ECE` — Embedded, VLSI, Signals
- `Mechanical` — Thermodynamics, CAD, Manufacturing
- `Other` — Core aptitude + communication

### 📈 9. Progress Dashboard
Track your growth over time:
- Interview scores over sessions
- Weak areas heatmap
- Learning module completion
- Skill improvement timeline

---

## 🏗️ System Architecture

```
┌─────────────────────────────────────────────┐
│               User Interface                │
│         (Flutter / React Native)            │
└──────────────────┬──────────────────────────┘
                   │ REST / WebSocket
┌──────────────────▼──────────────────────────┐
│            FastAPI Backend                  │
│   ┌──────────┬──────────┬──────────────┐   │
│   │  Resume  │    AI    │   Learning   │   │
│   │  Parser  │  Engine  │    Module    │   │
│   └────┬─────┴────┬─────┴──────┬───────┘   │
└────────┼──────────┼────────────┼────────────┘
         │          │            │
    ┌────▼───┐  ┌───▼────┐  ┌───▼──────┐
    │MongoDB │  │Gemini/ │  │Content DB│
    │        │  │OpenAI  │  │(MongoDB) │
    └────────┘  └────────┘  └──────────┘
```

---

## 🛠️ Tech Stack

| Layer | Technology | Purpose |
|---|---|---|
| **Frontend** | React / Flutter | UI, interview interface |
| **Backend** | FastAPI (Python) | REST APIs, orchestration |
| **Database** | MongoDB | User data, sessions, progress |
| **AI Model** | Gemini API / GPT-4 | Question gen, evaluation, teaching |
| **Resume Parsing** | PyPDF2 + spaCy NLP | Skill & entity extraction |
| **Auth** | JWT | Secure session management |
| **Deployment** | Render / Railway / AWS | Cloud hosting |

---

## 🚀 Getting Started

### Prerequisites
```bash
Python 3.10+
Node.js 18+
MongoDB (local or Atlas)
Gemini API Key or OpenAI API Key
```

### 1. Clone the Repository
```bash
git clone https://github.com/yourusername/skilllit.git
cd skilllit
```

### 2. Backend Setup
```bash
cd backend
python -m venv venv
source venv/bin/activate  # Windows: venv\Scripts\activate
pip install -r requirements.txt
```

### 3. Configure Environment
```bash
cp .env.example .env
```
Edit `.env`:
```env
MONGO_URI=your_mongodb_connection_string
GEMINI_API_KEY=your_gemini_api_key
JWT_SECRET=your_super_secret_key
```

### 4. Run Backend
```bash
uvicorn main:app --reload
# API docs at http://localhost:8000/docs
```

### 5. Frontend Setup
```bash
cd ../frontend
npm install
npm run dev
# App at http://localhost:3000
```

---

## 📁 Project Structure

```
skilllit/
├── backend/
│   ├── main.py                  # FastAPI entry point
│   ├── routes/
│   │   ├── resume.py            # Resume upload & parsing
│   │   ├── interview.py         # Interview session management
│   │   ├── learning.py          # Learning module endpoints
│   │   └── dashboard.py         # Progress & analytics
│   ├── services/
│   │   ├── resume_parser.py     # NLP extraction logic
│   │   ├── ai_engine.py         # Gemini/GPT integration
│   │   ├── evaluator.py         # Answer scoring
│   │   └── skill_gap.py         # Gap detection logic
│   ├── models/                  # MongoDB schemas
│   └── requirements.txt
│
├── frontend/
│   ├── src/
│   │   ├── pages/
│   │   │   ├── Upload.jsx       # Resume upload page
│   │   │   ├── Interview.jsx    # Live interview screen
│   │   │   ├── Learn.jsx        # Learning module
│   │   │   └── Dashboard.jsx    # Progress dashboard
│   │   ├── components/
│   │   └── api/
│   └── package.json
│
├── docs/                        # Architecture diagrams & API docs
├── .env.example
└── README.md
```

---

## 🔗 API Overview

| Method | Endpoint | Description |
|---|---|---|
| `POST` | `/api/resume/upload` | Upload and parse resume |
| `GET` | `/api/resume/profile` | Get extracted profile |
| `POST` | `/api/interview/start` | Start an interview session |
| `POST` | `/api/interview/answer` | Submit answer, get next question |
| `GET` | `/api/interview/report` | Get session evaluation report |
| `POST` | `/api/learn/quick` | 5-minute quick learn on any topic |
| `GET` | `/api/learn/module/{topic}` | Get full learning module |
| `GET` | `/api/dashboard/progress` | User's progress over time |
| `GET` | `/api/skills/gaps` | Detected skill gaps |

Full API documentation available at `/docs` after running the backend.

---

## 🌱 Roadmap

- [x] Resume parsing & profile generation
- [x] AI-generated interview questions
- [x] Smart evaluation system
- [x] AI HR simulation
- [x] 5-minute quick learn mode
- [x] Department-wise learning paths
- [ ] Voice-based interview mode
- [ ] Resume builder / suggestion
- [ ] Company-specific interview tracks (Google, TCS, Infosys...)
- [ ] Peer mock interview matching
- [ ] Mobile app (Flutter)
- [ ] Multilingual support (Hindi, Tamil, Telugu...)

---

## 🤝 Contributing

Contributions are what make open source amazing. Here's how to join:

```bash
# 1. Fork the repo
# 2. Create your feature branch
git checkout -b feature/AmazingFeature

# 3. Commit your changes
git commit -m 'Add some AmazingFeature'

# 4. Push to the branch
git push origin feature/AmazingFeature

# 5. Open a Pull Request
```

Please read [CONTRIBUTING.md](CONTRIBUTING.md) before submitting.

---

## 👥 Team

> Built with ❤️ by students who once failed interviews and decided to build the tool they wished they had.

| Name | Role | GitHub |
|---|---|---|
| Your Name | Full Stack + AI | [@yourhandle](#) |
| Team Member 2 | Backend + ML | [@handle2](#) |
| Team Member 3 | Frontend + UI | [@handle3](#) |

---

## 📄 License

Distributed under the MIT License. See `LICENSE` for more information.

---

## 🙏 Acknowledgements

- [Google Gemini API](https://ai.google.dev/) for the AI backbone
- [FastAPI](https://fastapi.tiangolo.com/) for the blazing-fast backend
- [spaCy](https://spacy.io/) for NLP resume parsing
- [MongoDB Atlas](https://www.mongodb.com/atlas) for the database
- Every student who ever blanked in an interview and inspired this project

---

<div align="center">

**If SkillLit helped you prep better, give it a ⭐ — it means the world to us!**

*Made with 💻 + ☕ + a lot of failed interviews*

</div>
