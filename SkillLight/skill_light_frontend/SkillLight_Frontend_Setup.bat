@echo off
echo ==============================================
echo     🎨 Skill Light Frontend Setup
echo ==============================================
echo.

REM --- CHECK FLUTTER PATH ---
echo 🔍 Checking Flutter installation...
where flutter
if %errorlevel% neq 0 (
    echo ❌ Flutter not found! Please install it first from https://flutter.dev/docs/get-started/install
    pause
    exit /b
)
echo ✅ Flutter found!
echo.

REM --- UPGRADE FLUTTER ---
echo 🔧 Upgrading Flutter SDK...
flutter upgrade
echo.

REM --- ENABLE WEB AND ANDROID TARGETS ---
echo 🌐 Enabling web and Android targets...
flutter config --enable-web
flutter config --enable-android
echo.

REM --- GET PUB PACKAGES ---
echo 📦 Getting dependencies from pubspec.yaml...
flutter pub get
echo.

REM --- INSTALL COMMON FRONTEND PACKAGES ---
echo 💡 Installing core UI and Firebase dependencies...
flutter pub add firebase_core firebase_auth cloud_firestore firebase_storage
flutter pub add http provider shared_preferences
flutter pub add lottie animations flutter_animate
flutter pub add google_fonts font_awesome_flutter
flutter pub add intl url_launcher
flutter pub add get get_it
flutter pub add fluttertoast
flutter pub add flutter_dotenv
flutter pub add video_player chewie
echo.

REM --- OPTIONAL AI/ANIMATION TOOLS ---
echo 🧠 Adding AI-related and advanced animation packages...
flutter pub add rive flame animated_text_kit
echo.

REM --- CLEAN AND GET PACKAGES AGAIN ---
flutter clean
flutter pub get
echo.

echo ==============================================
echo ✅  Frontend setup completed successfully!
echo ==============================================
pause
