import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _darkMode = false;
  int _selectedBottom = 0;

  final double _weekProgress = 0.62;
  final double _monthlyProgress = 0.38;

  final List<Map<String, dynamic>> _features = [
    {'title': 'AI Teaching', 'image': 'assets/images/ai_teaching.png', 'route': '/AiTeachingHome'},
    {'title': 'Resume Analyzer', 'image': 'assets/images/resume_analyzer.png', 'route': '/resume'},
    {'title': 'AI Interviewer', 'image': 'assets/images/ai_interviewer.png', 'route': '/instructions'},
    {'title': 'Mock Test', 'image': 'assets/images/mock_test.png', 'route': '/mock-test'},
    {'title': 'Skill Tests', 'image': 'assets/images/skill_tests.png', 'route': '/skill-test'},
    {'title': 'My Progress', 'image': 'assets/images/my_progress.png', 'route': '/progress'},
  ];

  Color get bgStart => _darkMode ? const Color(0xFF2A1A3D) : const Color(0xFF6A39FF);
  Color get bgEnd => _darkMode ? const Color(0xFF111018) : const Color(0xFFB25BFF);
  Color get panel => _darkMode ? const Color(0xFF1B1623) : Colors.white;
  Color get textPrimary => _darkMode ? Colors.white : Colors.grey[900]!;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: _buildDrawer(context),
      body: SafeArea(
        child: Container(
          color: _darkMode ? const Color(0xFF0D0812) : Colors.transparent,
          child: Column(
            children: [
              _buildHeader(),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildWelcome(),
                      const SizedBox(height: 18),
                      _buildProgressCard(),
                      const SizedBox(height: 18),
                      _buildFeaturesGrid(),
                      const SizedBox(height: 18),
                      _buildCTAs(),
                      const SizedBox(height: 40),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedBottom,
        onTap: (i) => setState(() => _selectedBottom = i),
        backgroundColor: panel,
        selectedItemColor: const Color(0xFF5E2BFF),
        unselectedItemColor: Colors.grey[600],
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Explore'),
          BottomNavigationBarItem(icon: Icon(Icons.notifications), label: 'Alerts'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [bgStart, bgEnd],
        ),
        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(18)),
      ),
      child: Row(
        children: [
          Builder(
            builder: (ctx) => GestureDetector(
              onTap: () => Scaffold.of(ctx).openDrawer(),
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: const BoxDecoration(
                  color: Colors.white24,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.menu, color: Colors.white),
              ),
            ),
          ),
          const SizedBox(width: 12),
          const Text(
            'Skill Light',
            style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w700),
          ),
          const Spacer(),
          IconButton(
            onPressed: () => setState(() => _darkMode = !_darkMode),
            icon: Icon(_darkMode ? Icons.dark_mode : Icons.light_mode, color: Colors.white),
          ),
        ],
      ),
    );
  }

  Widget _buildWelcome() {
    return Row(
      children: [
        Container(
          height: 72,
          width: 72,
          decoration: BoxDecoration(
            color: panel,
            borderRadius: BorderRadius.circular(14),
          ),
          child: const Icon(Icons.person, size: 36, color: Colors.deepPurple),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Welcome back,', style: TextStyle(color: textPrimary)),
              const SizedBox(height: 4),
              Text(
                'Sivanesh',
                style: TextStyle(color: textPrimary, fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildProgressCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: panel,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Weekly Progress', style: TextStyle(color: textPrimary)),
          const SizedBox(height: 8),
          LinearProgressIndicator(
            value: _weekProgress,
            backgroundColor: Colors.grey.withOpacity(0.2),
            color: const Color(0xFF5E2BFF),
          ),
          const SizedBox(height: 12),
          Text('Monthly Progress', style: TextStyle(color: textPrimary)),
          const SizedBox(height: 8),
          LinearProgressIndicator(
            value: _monthlyProgress,
            backgroundColor: Colors.grey.withOpacity(0.2),
            color: const Color(0xFF6A39FF),
          ),
        ],
      ),
    );
  }

  Widget _buildFeaturesGrid() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Quick Access',
            style: TextStyle(color: textPrimary, fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: _features.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            childAspectRatio: 0.95,
          ),
          itemBuilder: (context, i) {
            final f = _features[i];
            return GestureDetector(
              onTap: () => Navigator.pushNamed(context, f['route']),
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: panel,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundColor: const Color(0xFFEEF0FF),
                      child: ClipOval(
                        child: Image.asset(
                          f['image'],
                          width: 80,
                          height: 80,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      f['title'],
                      textAlign: TextAlign.center,
                      style: TextStyle(color: textPrimary, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildCTAs() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: panel,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Text('Upgrade to Pro',
              style: TextStyle(color: textPrimary, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: () => Navigator.pushNamed(context, '/subscription'),
            child: const Text('Upgrade'),
          )
        ],
      ),
    );
  }

  Drawer _buildDrawer(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Column(
          children: [
            const ListTile(
              leading: CircleAvatar(child: Icon(Icons.person)),
              title: Text('Sivanesh'),
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Logout'),
              onTap: () => Navigator.pushReplacementNamed(context, '/login'),
            ),
          ],
        ),
      ),
    );
  }
}