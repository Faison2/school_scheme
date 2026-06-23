import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
import 'screens/sign_up_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Scheme Rangu',
      theme: AppTheme.theme,
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
          case '/sign-up':
            page = const SignUpScreen();
          default:
            page = const MainShell();
        }
        return MaterialPageRoute(builder: (_) => page);
      },
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// MAIN SHELL
// ─────────────────────────────────────────────────────────────────────────────

class MainShell extends StatefulWidget {
  const MainShell({super.key});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell>
    with SingleTickerProviderStateMixin {
  int _currentIndex = 0;
  late AnimationController _navAnim;

  final _screens = const [
    HomeScreen(),
    _SchemesTab(),
    _AiToolsTab(),
    _MoreTab(),
  ];

  static const _navItems = [
    _NavItem(icon: Icons.home_rounded, label: 'Home'),
    _NavItem(icon: Icons.menu_book_rounded, label: 'Schemes'),
    _NavItem(icon: Icons.auto_awesome_rounded, label: 'AI Tools'),
    _NavItem(icon: Icons.grid_view_rounded, label: 'More'),
  ];

  @override
  void initState() {
    super.initState();
    _navAnim = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
  }

  @override
  void dispose() {
    _navAnim.dispose();
    super.dispose();
  }

  void _onTap(int i) {
    if (i == _currentIndex) return;
    HapticFeedback.lightImpact();
    setState(() => _currentIndex = i);
    _navAnim.forward(from: 0);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final Color bgColor =
    isDark ? const Color(0xFF0D0F14) : const Color(0xFFF6F8FC);
    final Color navBg =
    isDark ? const Color(0xFF161B25) : Colors.white;
    final Color borderColor =
    isDark ? const Color(0xFF252D3D) : const Color(0xFFE4E9F2);

    return Scaffold(
      backgroundColor: bgColor,
      extendBody: true,
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: _FloatingNavBar(
        currentIndex: _currentIndex,
        onTap: _onTap,
        items: _navItems,
        navBg: navBg,
        borderColor: borderColor,
        isDark: isDark,
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// FLOATING NAV BAR
// ─────────────────────────────────────────────────────────────────────────────

class _NavItem {
  const _NavItem({required this.icon, required this.label});
  final IconData icon;
  final String label;
}

class _FloatingNavBar extends StatelessWidget {
  const _FloatingNavBar({
    required this.currentIndex,
    required this.onTap,
    required this.items,
    required this.navBg,
    required this.borderColor,
    required this.isDark,
  });

  final int currentIndex;
  final ValueChanged<int> onTap;
  final List<_NavItem> items;
  final Color navBg, borderColor;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    final bottom = MediaQuery.of(context).padding.bottom;

    return Padding(
      padding: EdgeInsets.fromLTRB(20, 0, 20, bottom + 16),
      child: Container(
        height: 64,
        decoration: BoxDecoration(
          color: navBg,
          borderRadius: BorderRadius.circular(32),
          border: Border.all(color: borderColor, width: 1),
          boxShadow: isDark
              ? [
            BoxShadow(
              color: Colors.black.withOpacity(0.5),
              blurRadius: 32,
              offset: const Offset(0, 8),
            ),
          ]
              : [
            BoxShadow(
              color: Colors.black.withOpacity(0.10),
              blurRadius: 24,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: List.generate(items.length, (i) {
            final selected = i == currentIndex;
            return Expanded(
              child: GestureDetector(
                onTap: () => onTap(i),
                behavior: HitTestBehavior.opaque,
                child: _NavBarItem(
                  item: items[i],
                  selected: selected,
                  isDark: isDark,
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}

class _NavBarItem extends StatelessWidget {
  const _NavBarItem({
    required this.item,
    required this.selected,
    required this.isDark,
  });

  final _NavItem item;
  final bool selected;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    final Color unselected =
    isDark ? const Color(0xFF4A5568) : const Color(0xFFB0BAD0);

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 220),
      child: selected
          ? _SelectedNavItem(item: item, key: ValueKey('sel_${item.label}'))
          : _UnselectedNavItem(
        item: item,
        color: unselected,
        key: ValueKey('unsel_${item.label}'),
      ),
    );
  }
}

class _SelectedNavItem extends StatelessWidget {
  const _SelectedNavItem({required this.item, super.key});
  final _NavItem item;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
          decoration: BoxDecoration(
            color: AppTheme.accentColor.withOpacity(0.12),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(item.icon, size: 18, color: AppTheme.accentColor),
              const SizedBox(width: 6),
              Text(
                item.label,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: AppTheme.accentColor,
                  letterSpacing: -0.2,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _UnselectedNavItem extends StatelessWidget {
  const _UnselectedNavItem({required this.item, required this.color, super.key});
  final _NavItem item;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(item.icon, size: 22, color: color),
        const SizedBox(height: 2),
        Text(
          item.label,
          style: TextStyle(
            fontSize: 10,
            color: color,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// SCHEMES TAB
// ─────────────────────────────────────────────────────────────────────────────

class _SchemesTab extends StatelessWidget {
  const _SchemesTab();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final Color bgColor =
    isDark ? const Color(0xFF0D0F14) : const Color(0xFFF6F8FC);
    final Color primaryText =
    isDark ? Colors.white : const Color(0xFF0D0F14);
    final Color subtleText =
    isDark ? const Color(0xFF6B7A99) : const Color(0xFF8A96B0);
    final Color borderColor =
    isDark ? const Color(0xFF252D3D) : const Color(0xFFE4E9F2);
    final Color cardColor =
    isDark ? const Color(0xFF161B25) : Colors.white;

    final items = [
      _TabCardData(
        icon: Icons.auto_stories_rounded,
        title: 'Scheme of Work',
        subtitle: 'Create term schemes from syllabus content',
        route: '/scheme-of-work',
      ),
      _TabCardData(
        icon: Icons.edit_note_rounded,
        title: 'Lesson Plan',
        subtitle: 'Generate daily lesson plans from saved schemes',
        route: '/lesson-plan',
      ),
      _TabCardData(
        icon: Icons.assignment_rounded,
        title: 'Exercises & Tests',
        subtitle: 'Create syllabus-based assessments',
        route: '/exercises-tests',
      ),
      _TabCardData(
        icon: Icons.task_alt_rounded,
        title: 'Learning Tasks',
        subtitle: 'Generate classroom activities',
        route: '/learning-tasks',
      ),
    ];

    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        bottom: false,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 100),
          children: [
            const SizedBox(height: 12),
            _TabHeader(
              icon: Icons.menu_book_rounded,
              title: 'Schemes & Planning',
              subtitle: 'Plan your curriculum with syllabus-based tools',
              primaryText: primaryText,
              subtleText: subtleText,
            ),
            const SizedBox(height: 24),
            ...items.map((item) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: _ModernTabCard(
                data: item,
                isDark: isDark,
                primaryText: primaryText,
                subtleText: subtleText,
                borderColor: borderColor,
                cardColor: cardColor,
              ),
            )),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// AI TOOLS TAB
// ─────────────────────────────────────────────────────────────────────────────

class _AiToolsTab extends StatelessWidget {
  const _AiToolsTab();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final Color bgColor =
    isDark ? const Color(0xFF0D0F14) : const Color(0xFFF6F8FC);
    final Color primaryText =
    isDark ? Colors.white : const Color(0xFF0D0F14);
    final Color subtleText =
    isDark ? const Color(0xFF6B7A99) : const Color(0xFF8A96B0);
    final Color borderColor =
    isDark ? const Color(0xFF252D3D) : const Color(0xFFE4E9F2);
    final Color cardColor =
    isDark ? const Color(0xFF161B25) : Colors.white;

    final items = [
      _TabCardData(
        icon: Icons.auto_awesome_rounded,
        title: 'AI for Teachers',
        subtitle: 'Reduce repetitive drafting with AI assistance',
        route: '/ai-for-teachers',
        badge: 'Popular',
      ),
      _TabCardData(
        icon: Icons.smart_toy_rounded,
        title: 'Mudzidzisi AI',
        subtitle: 'Assign, collect, and mark learner work',
        route: '/mudzidzisi-ai',
      ),
      _TabCardData(
        icon: Icons.edit_calendar_rounded,
        title: 'AI School Timetabling',
        subtitle: 'Generate timetables with conflict detection',
        route: '/timetabling',
      ),
    ];

    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        bottom: false,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 100),
          children: [
            const SizedBox(height: 12),
            _TabHeader(
              icon: Icons.auto_awesome_rounded,
              title: 'AI Tools',
              subtitle: 'AI-powered tools designed for Zimbabwean teachers',
              primaryText: primaryText,
              subtleText: subtleText,
            ),
            const SizedBox(height: 24),
            // Featured highlight card
            _FeaturedCard(
              isDark: isDark,
              primaryText: primaryText,
              subtleText: subtleText,
              borderColor: borderColor,
              onTap: () => Navigator.pushNamed(context, '/ai-for-teachers'),
            ),
            const SizedBox(height: 12),
            ...items.skip(1).map((item) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: _ModernTabCard(
                data: item,
                isDark: isDark,
                primaryText: primaryText,
                subtleText: subtleText,
                borderColor: borderColor,
                cardColor: cardColor,
              ),
            )),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// MORE TAB
// ─────────────────────────────────────────────────────────────────────────────

class _MoreTab extends StatelessWidget {
  const _MoreTab();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final Color bgColor =
    isDark ? const Color(0xFF0D0F14) : const Color(0xFFF6F8FC);
    final Color primaryText =
    isDark ? Colors.white : const Color(0xFF0D0F14);
    final Color subtleText =
    isDark ? const Color(0xFF6B7A99) : const Color(0xFF8A96B0);
    final Color borderColor =
    isDark ? const Color(0xFF252D3D) : const Color(0xFFE4E9F2);
    final Color cardColor =
    isDark ? const Color(0xFF161B25) : Colors.white;

    final items = [
      _TabCardData(
        icon: Icons.school_rounded,
        title: 'School Portal',
        subtitle: 'Manage learners, staff, fees, attendance & more',
        route: '/school-portal',
      ),
      _TabCardData(
        icon: Icons.auto_stories_rounded,
        title: 'Teacher Planning',
        subtitle: 'All planning tools in one place',
        route: '/teacher-planning',
      ),
    ];

    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        bottom: false,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 100),
          children: [
            const SizedBox(height: 12),
            _TabHeader(
              icon: Icons.grid_view_rounded,
              title: 'More',
              subtitle: 'Additional tools and school management features',
              primaryText: primaryText,
              subtleText: subtleText,
            ),
            const SizedBox(height: 24),
            ...items.map((item) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: _ModernTabCard(
                data: item,
                isDark: isDark,
                primaryText: primaryText,
                subtleText: subtleText,
                borderColor: borderColor,
                cardColor: cardColor,
              ),
            )),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// SHARED COMPONENTS
// ─────────────────────────────────────────────────────────────────────────────

class _TabCardData {
  const _TabCardData({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.route,
    this.badge,
  });
  final IconData icon;
  final String title, subtitle, route;
  final String? badge;
}

class _TabHeader extends StatelessWidget {
  const _TabHeader({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.primaryText,
    required this.subtleText,
  });

  final IconData icon;
  final String title, subtitle;
  final Color primaryText, subtleText;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: AppTheme.accentColor.withOpacity(0.12),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, size: 22, color: AppTheme.accentColor),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                  color: primaryText,
                  letterSpacing: -0.4,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                subtitle,
                style: TextStyle(fontSize: 13, color: subtleText, height: 1.4),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _ModernTabCard extends StatelessWidget {
  const _ModernTabCard({
    required this.data,
    required this.isDark,
    required this.primaryText,
    required this.subtleText,
    required this.borderColor,
    required this.cardColor,
  });

  final _TabCardData data;
  final bool isDark;
  final Color primaryText, subtleText, borderColor, cardColor;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => Navigator.pushNamed(context, data.route),
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: cardColor,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: borderColor, width: 1),
            boxShadow: isDark
                ? []
                : [
              BoxShadow(
                color: Colors.black.withOpacity(0.04),
                blurRadius: 12,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: AppTheme.accentColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(data.icon, size: 22, color: AppTheme.accentColor),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          data.title,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: primaryText,
                            letterSpacing: -0.2,
                          ),
                        ),
                        if (data.badge != null) ...[
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 7, vertical: 2),
                            decoration: BoxDecoration(
                              color: AppTheme.accentColor.withOpacity(0.12),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              data.badge!,
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w700,
                                color: AppTheme.accentColor,
                                letterSpacing: 0.2,
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                    const SizedBox(height: 3),
                    Text(
                      data.subtitle,
                      style: TextStyle(
                          fontSize: 12, color: subtleText, height: 1.4),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Icon(Icons.arrow_forward_ios_rounded,
                  size: 14, color: subtleText),
            ],
          ),
        ),
      ),
    );
  }
}

class _FeaturedCard extends StatelessWidget {
  const _FeaturedCard({
    required this.isDark,
    required this.primaryText,
    required this.subtleText,
    required this.borderColor,
    required this.onTap,
  });

  final bool isDark;
  final Color primaryText, subtleText, borderColor;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: isDark
                  ? [
                AppTheme.accentColor.withOpacity(0.22),
                const Color(0xFF161B25),
              ]
                  : [
                AppTheme.accentColor.withOpacity(0.08),
                const Color(0xFFF0F4FF),
              ],
            ),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: AppTheme.accentColor.withOpacity(isDark ? 0.3 : 0.2),
              width: 1,
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: AppTheme.accentColor.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: const Icon(Icons.auto_awesome_rounded,
                    size: 24, color: AppTheme.accentColor),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          'AI for Teachers',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w800,
                            color: primaryText,
                            letterSpacing: -0.3,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 7, vertical: 2),
                          decoration: BoxDecoration(
                            color: AppTheme.accentColor,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: const Text(
                            'Popular',
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                              letterSpacing: 0.2,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Reduce repetitive drafting with AI assistance',
                      style: TextStyle(
                          fontSize: 12, color: subtleText, height: 1.4),
                    ),
                  ],
                ),
              ),
              Icon(Icons.arrow_forward_ios_rounded,
                  size: 14, color: subtleText),
            ],
          ),
        ),
      ),
    );
  }
}