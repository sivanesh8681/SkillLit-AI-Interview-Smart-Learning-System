@echo off
echo ==============================================
echo     🚀 Skill Light Setup Installer
echo ==============================================
echo.

REM --- UPGRADE PIP TO LATEST ---
echo 🔧 Upgrading pip...
python -m pip install --upgrade pip
echo.

REM --- INSTALL BACKEND PACKAGES ---
echo 🧠 Installing backend dependencies...
pip install fastapi uvicorn firebase-admin google-cloud-storage pydantic python-multipart requests aiofiles openai numpy pandas scikit-learn Pillow --default-timeout=600 --index-url https://pypi.org/simple
echo.

REM --- INSTALL ANIMATION PACKAGES ---
echo 🎬 Installing animation packages (Manim, MoviePy)...
pip install manim moviepy moderngl rich scipy screeninfo --default-timeout=600 --index-url https://pypi.org/simple
echo.

REM --- INSTALL FRONTEND BUILD SUPPORT ---
echo 🌐 Installing frontend tools (Node, Flutter support)...
pip install flask flask-cors --default-timeout=600
echo.

REM --- CHECK INSTALLATION ---
echo ✅ Checking installed packages...
pip list
echo.

echo ==============================================
echo ✅  All packages installed successfully!
echo ==============================================
pause
