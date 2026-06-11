from fastapi import FastAPI, HTTPException
from firebase_admin import credentials, auth, initialize_app

app = FastAPI()

# Initialize Firebase
cred = credentials.Certificate("firebase-key.json")  # your downloaded Firebase Admin key
initialize_app(cred)

@app.post("/signup")
async def signup(email: str, password: str):
    user = auth.create_user(email=email, password=password)
    return {"message": "Signup successful", "uid": user.uid}

@app.post("/login")
async def login(email: str, password: str):
    # Frontend Firebase Auth handles login; backend just verifies token
    return {"message": "Login handled by Firebase client"}

@app.post("/reset-password")
async def reset_password(email: str):
    link = auth.generate_password_reset_link(email)
    return {"reset_link": link}