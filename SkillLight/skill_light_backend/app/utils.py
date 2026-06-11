import os
from dotenv import load_dotenv
load_dotenv()

DEV_PREMIUM_KEY = os.getenv("DEV_PREMIUM_KEY", "premium-user-access")
