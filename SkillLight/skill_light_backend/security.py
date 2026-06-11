import os
from fastapi import HTTPException

PREMIUM_KEY = "your_premium_key_here"

def verify_premium(client_key: str):
    if client_key != PREMIUM_KEY:
        raise HTTPException(status_code=403, detail="Premium Access Required")
