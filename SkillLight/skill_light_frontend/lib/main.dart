import 'package:flutter/material.dart';

// Core Screens
import 'screens/splash_screen.dart';
import 'screens/login_screen.dart';
import 'screens/register_screen.dart';
import 'screens/otp_screen.dart';
import 'screens/basic_details_screen.dart';
import 'screens/program_selection_screen.dart';
import 'screens/analysis_screen.dart';
import 'screens/feature_intro_screen.dart';
import 'screens/home_screen.dart';

// 🔹 AI Interviewer Screens
import 'screens/instructions_screen.dart';
import 'screens/select_interviewer_screen.dart';
import 'screens/interviewer_landscape_screen.dart';
import 'screens/result_screen.dart';

// 🔹 AI Teaching (NEW Screens)
import 'screens/ai_teaching_home_screen.dart';
import 'screens/courses_screen.dart';
import 'screens/competitive_exams_screen.dart';
import 'screens/classroom_screen.dart';
import 'screens/lesson_generate_screen.dart';
//Resume
import 'screens/resume_upload_screen.dart';
//Mock test
import 'screens/mock_test_screen.dart';
//Skill test
import 'screens/skill_tests_screen.dart';


void main() {
  runApp(const SkillLightApp());
}

class SkillLightApp extends StatelessWidget {
  const SkillLightApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Skill Light AI',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        scaffoldBackgroundColor: Colors.white,
        useMaterial3: true,
      ),

      home: const SplashScreen(),

      routes: {
        // 🔹 Existing App Routes
        '/login': (context) => const LoginScreen(),
        '/register': (context) => const RegisterScreen(),
        '/otp': (context) => const OtpScreen(),
        '/basic-details': (context) => const BasicDetailsScreen(),
        '/program-selection': (context) => const ProgramSelectionScreen(),
        '/analysis': (context) => const AnalysisScreen(),
        '/feature-intro': (context) => const FeatureIntroScreen(),
        '/home': (context) => const HomeScreen(),

        // 🔹 AI Interviewer Routes
        '/instructions': (context) => InstructionsScreen(),
        '/selectInterviewer': (context) => SelectInterviewerScreen(),
        '/interviewerLandscapeScreen': (context) => InterviewerLandscapeScreen(),
        '/interviewResult': (context) => InterviewResultScreen(),

        // ⭐ AI TEACHING NEW ROUTES
        '/AiTeachingHome': (context) =>  AiTeachingHomeScreen(),
        '/lesson': (context) => const LessonGenerateScreen(),
        '/Courses': (context) =>  CoursesScreen(),
        '/CompetitiveExams': (context) =>  CompetitiveExamsScreen(),
        '/Classroom': (context) =>  ClassroomScreen(),
        // Resume
        '/resume': (context) =>  ResumeUploadScreen(),
        //Mock test
        '/mock-test': (context) => MockTestScreen(),
        //Skill test
        '/skill-test': (context) => SkillTestsScreen(),


      },
    );
  }
}
