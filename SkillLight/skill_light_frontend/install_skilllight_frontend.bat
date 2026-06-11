@echo off
:: =============================================
:: 🚀 Skill Light Frontend Setup (Full Version)
:: =============================================

echo ============================================
echo ⚙️ Installing All Flutter Frontend Packages
echo ============================================

set LOGFILE=skilllight_frontend_install_log.txt
echo Installation started at %DATE% %TIME% > %LOGFILE%

:: STEP 1: Check if Flutter exists
where flutter >nul 2>nul
if %errorlevel% neq 0 (
    echo ❌ Flutter not found in PATH. Please install Flutter first!
    echo Flutter not found. Install Flutter SDK before running this script.
    pause
    exit /b
)

:: STEP 2: Upgrade Flutter & Dart
echo --------------------------------------------
echo 🔄 Upgrading Flutter SDK and Dart...
echo --------------------------------------------
flutter upgrade >> %LOGFILE% 2>&1

:: STEP 3: Doctor check
echo --------------------------------------------
echo 🩺 Checking Flutter installation health...
echo --------------------------------------------
flutter doctor >> %LOGFILE% 2>&1

:: STEP 4: Cleaning project cache
echo --------------------------------------------
echo 🧹 Cleaning old cache...
echo --------------------------------------------
flutter clean >> %LOGFILE% 2>&1

:: STEP 5: Initialize Firebase setup
echo --------------------------------------------
echo 🔥 Adding Firebase dependencies...
echo --------------------------------------------
flutter pub add firebase_core >> %LOGFILE% 2>&1
flutter pub add firebase_auth >> %LOGFILE% 2>&1
flutter pub add cloud_firestore >> %LOGFILE% 2>&1
flutter pub add firebase_storage >> %LOGFILE% 2>&1
flutter pub add firebase_messaging >> %LOGFILE% 2>&1

:: STEP 6: Core App Utilities
echo --------------------------------------------
echo ⚡ Adding core utility packages...
echo --------------------------------------------
flutter pub add http >> %LOGFILE% 2>&1
flutter pub add provider >> %LOGFILE% 2>&1
flutter pub add get >> %LOGFILE% 2>&1
flutter pub add shared_preferences >> %LOGFILE% 2>&1
flutter pub add intl >> %LOGFILE% 2>&1

:: STEP 7: UI & Animation
echo --------------------------------------------
echo 🎨 Adding UI and animation packages...
echo --------------------------------------------
flutter pub add lottie >> %LOGFILE% 2>&1
flutter pub add animations >> %LOGFILE% 2>&1
flutter pub add flutter_animate >> %LOGFILE% 2>&1
flutter pub add rive >> %LOGFILE% 2>&1
flutter pub add flutter_spinkit >> %LOGFILE% 2>&1
flutter pub add google_fonts >> %LOGFILE% 2>&1

:: STEP 8: Video and Audio
echo --------------------------------------------
echo 🎥 Adding media (video/audio) support...
echo --------------------------------------------
flutter pub add video_player >> %LOGFILE% 2>&1
flutter pub add chewie >> %LOGFILE% 2>&1
flutter pub add just_audio >> %LOGFILE% 2>&1

:: STEP 9: AI, Avatar, and Interaction
echo --------------------------------------------
echo 🤖 Adding AI/Avatar integration packages...
echo --------------------------------------------
flutter pub add webview_flutter >> %LOGFILE% 2>&1
flutter pub add flutter_tts >> %LOGFILE% 2>&1
flutter pub add speech_to_text >> %LOGFILE% 2>&1
flutter pub add url_launcher >> %LOGFILE% 2>&1
flutter pub add flutter_chat_ui >> %LOGFILE% 2>&1
flutter pub add flutter_chat_types >> %LOGFILE% 2>&1

:: STEP 10: UI Components (Material + Charts)
echo --------------------------------------------
echo 🧩 Adding advanced UI widgets...
echo --------------------------------------------
flutter pub add flutter_staggered_grid_view >> %LOGFILE% 2>&1
flutter pub add carousel_slider >> %LOGFILE% 2>&1
flutter pub add fl_chart >> %LOGFILE% 2>&1
flutter pub add percent_indicator >> %LOGFILE% 2>&1

:: STEP 11: Other helpful packages
echo --------------------------------------------
echo 🧠 Adding other helpful packages...
echo --------------------------------------------
flutter pub add connectivity_plus >> %LOGFILE% 2>&1
flutter pub add package_info_plus >> %LOGFILE% 2>&1
flutter pub add path_provider >> %LOGFILE% 2>&1
flutter pub add file_picker >> %LOGFILE% 2>&1

:: STEP 12: Run pub get
echo --------------------------------------------
echo 📦 Fetching all dependencies...
echo --------------------------------------------
flutter pub get >> %LOGFILE% 2>&1

:: STEP 13: Final verification
echo --------------------------------------------
echo ✅ Flutter version:
flutter --version >> %LOGFILE% 2>&1

echo ============================================
echo ✅ Skill Light Frontend Installation Complete!
echo 🔍 Check the log file for any issues:
echo     %LOGFILE%
echo ============================================

pause
exit
