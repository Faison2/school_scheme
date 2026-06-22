import 'package:flutter/material.dart';
import 'app_theme.dart';
import 'screens/home_screen.dart';
import 'screens/scheme_of_work_screen.dart';
import 'screens/lesson_plan_screen.dart';
import 'screens/exercises_tests_screen.dart';
import 'screens/ai_for_teachers_screen.dart';
import 'screens/learning_tasks_screen.dart';
import 'screens/school_portal_screen.dart';
import 'screens/timetabling_screen.dart';
import 'screens/mudzidzisi_ai_screen.dart';
import 'screens/teacher_planning_screen.dart';
import 'screens/login_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Scheme Rangu',
      theme: AppTheme.darkTheme,
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      onGenerateRoute: (settings) {
        Widget page;
        switch (settings.name) {
          case '/':
            page = const MainShell();
          case '/scheme-of-work':
            page = const SchemeOfWorkScreen();
          case '/lesson-plan':
            page = const LessonPlanScreen();
          case '/exercises-tests':
            page = const ExercisesTestsScreen();
          case '/ai-for-teachers':
            page = const AiForTeachersScreen();
          case '/learning-tasks':
            page = const LearningTasksScreen();
          case '/school-portal':
            page = const SchoolPortalScreen();
          case '/timetabling':
            page = const TimetablingScreen();
          case '/mudzidzisi-ai':
            page = const MudzidzisiAiScreen();
          case '/teacher-planning':
            page = const TeacherPlanningScreen();
          case '/login':
            page = const LoginScreen();
          default:
            page = const MainShell();
        }
        return MaterialPageRoute(builder: (_) => page);
      },
    );
  }
}

class MainShell extends StatefulWidget {
  const MainShell({super.key});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int _currentIndex = 0;

  final _screens = const [
    HomeScreen(),
    _SchemesTab(),
    _AiToolsTab(),
    _MoreTab(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (i) => setState(() => _currentIndex = i),
        type: BottomNavigationBarType.fixed,
        backgroundColor: AppTheme.primaryColor,
        selectedItemColor: AppTheme.accentColor,
        unselectedItemColor: AppTheme.textSecondary,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.menu_book), label: 'Schemes'),
          BottomNavigationBarItem(icon: Icon(Icons.auto_awesome), label: 'AI Tools'),
          BottomNavigationBarItem(icon: Icon(Icons.grid_view), label: 'More'),
        ],
      ),
    );
  }
}

class _SchemesTab extends StatelessWidget {
  const _SchemesTab();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Schemes & Planning')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            'Plan your curriculum with syllabus-based tools',
            style: TextStyle(color: AppTheme.textSecondary, fontSize: 16),
          ),
          const SizedBox(height: 20),
          _TabCard(
            icon: Icons.auto_stories,
            title: 'Scheme of Work Generator',
            subtitle: 'Create term schemes from syllabus content',
            onTap: () => Navigator.pushNamed(context, '/scheme-of-work'),
          ),
          const SizedBox(height: 12),
          _TabCard(
            icon: Icons.edit_note,
            title: 'Lesson Plan Generator',
            subtitle: 'Generate daily lesson plans from saved schemes',
            onTap: () => Navigator.pushNamed(context, '/lesson-plan'),
          ),
          const SizedBox(height: 12),
          _TabCard(
            icon: Icons.assignment,
            title: 'Exercises & Tests',
            subtitle: 'Create syllabus-based assessments',
            onTap: () => Navigator.pushNamed(context, '/exercises-tests'),
          ),
          const SizedBox(height: 12),
          _TabCard(
            icon: Icons.task_alt,
            title: 'Learning Tasks',
            subtitle: 'Generate classroom activities',
            onTap: () => Navigator.pushNamed(context, '/learning-tasks'),
          ),
        ],
      ),
    );
  }
}

class _AiToolsTab extends StatelessWidget {
  const _AiToolsTab();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('AI Tools')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            'AI-powered tools designed for Zimbabwean teachers',
            style: TextStyle(color: AppTheme.textSecondary, fontSize: 16),
          ),
          const SizedBox(height: 20),
          _TabCard(
            icon: Icons.auto_awesome,
            title: 'AI for Teachers',
            subtitle: 'Reduce repetitive drafting with AI assistance',
            onTap: () => Navigator.pushNamed(context, '/ai-for-teachers'),
          ),
          const SizedBox(height: 12),
          _TabCard(
            icon: Icons.smart_toy,
            title: 'Mudzidzisi AI',
            subtitle: 'Assign, collect, and mark learner work',
            onTap: () => Navigator.pushNamed(context, '/mudzidzisi-ai'),
          ),
          const SizedBox(height: 12),
          _TabCard(
            icon: Icons.edit_calendar,
            title: 'AI School Timetabling',
            subtitle: 'Generate timetables with conflict detection',
            onTap: () => Navigator.pushNamed(context, '/timetabling'),
          ),
        ],
      ),
    );
  }
}

class _MoreTab extends StatelessWidget {
  const _MoreTab();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('More')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _TabCard(
            icon: Icons.school,
            title: 'School Portal',
            subtitle: 'Manage learners, staff, fees, attendance & more',
            onTap: () => Navigator.pushNamed(context, '/school-portal'),
          ),
          const SizedBox(height: 12),
          _TabCard(
            icon: Icons.auto_stories,
            title: 'Teacher Planning',
            subtitle: 'All planning tools in one place',
            onTap: () => Navigator.pushNamed(context, '/teacher-planning'),
          ),
        ],
      ),
    );
  }
}

class _TabCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _TabCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: AppTheme.accentColor.withValues(alpha: 0.15),
          child: Icon(icon, color: AppTheme.accentColor),
        ),
        title: Text(title, style: Theme.of(context).textTheme.titleMedium),
        subtitle: Text(subtitle, style: Theme.of(context).textTheme.bodyMedium),
        trailing: const Icon(Icons.chevron_right, color: AppTheme.textSecondary),
        onTap: onTap,
      ),
    );
  }
}
