import 'package:flutter/material.dart';
import '../app_theme.dart';
import '../widgets/reusable_widgets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animController;
  late Animation<double> _fadeAnim;
  late Animation<Offset> _slideAnim;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _fadeAnim =
        CurvedAnimation(parent: _animController, curve: Curves.easeOut);
    _slideAnim = Tween<Offset>(
      begin: const Offset(0, 0.06),
      end: Offset.zero,
    ).animate(
        CurvedAnimation(parent: _animController, curve: Curves.easeOut));
    _animController.forward();
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

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

    return Scaffold(
      backgroundColor: bgColor,
      // ── Top bar ──────────────────────────────────────────────────────────
      appBar: AppBar(
        backgroundColor: bgColor,
        elevation: 0,
        scrolledUnderElevation: 0,
        titleSpacing: 20,
        title: Row(
          children: [
            Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                color: AppTheme.accentColor.withOpacity(0.15),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(Icons.school_rounded,
                  size: 16, color: AppTheme.accentColor),
            ),
            const SizedBox(width: 10),
            Text(
              'Scheme Rangu',
              style: TextStyle(
                color: primaryText,
                fontSize: 16,
                fontWeight: FontWeight.w700,
                letterSpacing: -0.3,
              ),
            ),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: TextButton(
              onPressed: () => Navigator.pushNamed(context, '/login'),
              style: TextButton.styleFrom(
                foregroundColor: AppTheme.accentColor,
                padding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: BorderSide(
                      color: AppTheme.accentColor.withOpacity(0.4), width: 1),
                ),
              ),
              child: const Text(
                'Sign in',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
              ),
            ),
          ),
        ],
      ),

      body: FadeTransition(
        opacity: _fadeAnim,
        child: SlideTransition(
          position: _slideAnim,
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              // ── Hero ───────────────────────────────────────────────────
              _HeroSection(
                isDark: isDark,
                primaryText: primaryText,
                subtleText: subtleText,
                borderColor: borderColor,
                onStartPlanning: () =>
                    Navigator.pushNamed(context, '/login'),
                onViewPlatform: () =>
                    Navigator.pushNamed(context, '/scheme-of-work'),
              ),

              const SizedBox(height: 32),

              // ── Features ───────────────────────────────────────────────
              _FeaturesSection(
                isDark: isDark,
                primaryText: primaryText,
                subtleText: subtleText,
                borderColor: borderColor,
                cardColor: cardColor,
              ),

              const SizedBox(height: 32),

              // ── How it works ───────────────────────────────────────────
              _InfoSection(
                isDark: isDark,
                primaryText: primaryText,
                subtleText: subtleText,
                borderColor: borderColor,
                cardColor: cardColor,
              ),

              const SizedBox(height: 32),

              // ── FAQ ────────────────────────────────────────────────────
              _FaqSection(
                isDark: isDark,
                primaryText: primaryText,
                subtleText: subtleText,
                borderColor: borderColor,
                cardColor: cardColor,
              ),

              const SizedBox(height: 48),

              // ── Footer CTA ─────────────────────────────────────────────
              _FooterCta(
                isDark: isDark,
                primaryText: primaryText,
                subtleText: subtleText,
                borderColor: borderColor,
                onStartPlanning: () =>
                    Navigator.pushNamed(context, '/login'),
              ),

              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}

// ────────────────────────────────────────────────────────────────────────────
// HERO
// ────────────────────────────────────────────────────────────────────────────

class _HeroSection extends StatelessWidget {
  const _HeroSection({
    required this.isDark,
    required this.primaryText,
    required this.subtleText,
    required this.borderColor,
    required this.onStartPlanning,
    required this.onViewPlatform,
  });

  final bool isDark;
  final Color primaryText, subtleText, borderColor;
  final VoidCallback onStartPlanning, onViewPlatform;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 8, 16, 0),
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: isDark
              ? [
            AppTheme.accentColor.withOpacity(0.18),
            const Color(0xFF161B25),
          ]
              : [
            AppTheme.accentColor.withOpacity(0.07),
            const Color(0xFFF0F4FF),
          ],
        ),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: AppTheme.accentColor.withOpacity(isDark ? 0.25 : 0.18),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Badge
          Container(
            padding:
            const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
            decoration: BoxDecoration(
              color: AppTheme.accentColor.withOpacity(0.12),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                  color: AppTheme.accentColor.withOpacity(0.3), width: 1),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.flag_rounded,
                    size: 12, color: AppTheme.accentColor),
                const SizedBox(width: 6),
                Text(
                  'Built for Zimbabwean teachers',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.accentColor,
                    letterSpacing: 0.3,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          Text(
            'AI Teacher Planning\nfor Zimbabwe',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w800,
              color: primaryText,
              height: 1.15,
              letterSpacing: -0.8,
            ),
          ),

          const SizedBox(height: 14),

          Text(
            'Scheme Rangu helps Zimbabwean teachers create schemes of work, lesson plans, exercises, tests, and classroom tasks from syllabus-based workflows.',
            style: TextStyle(
              fontSize: 14,
              color: subtleText,
              height: 1.6,
            ),
          ),

          const SizedBox(height: 28),

          // Buttons
          Row(
            children: [
              Expanded(
                child: SizedBox(
                  height: 48,
                  child: ElevatedButton(
                    onPressed: onStartPlanning,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.accentColor,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      'Start planning',
                      style: TextStyle(
                          fontWeight: FontWeight.w700, fontSize: 14),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: SizedBox(
                  height: 48,
                  child: OutlinedButton(
                    onPressed: onViewPlatform,
                    style: OutlinedButton.styleFrom(
                      foregroundColor: primaryText,
                      side: BorderSide(color: borderColor, width: 1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      'View platform',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        color: primaryText,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          // Stats row
          Row(
            children: [
              _StatChip(value: 'Free', label: 'to start', subtleText: subtleText, primaryText: primaryText),
              const SizedBox(width: 16),
              _StatChip(value: 'ZIMSEC', label: 'aligned', subtleText: subtleText, primaryText: primaryText),
              const SizedBox(width: 16),
              _StatChip(value: 'Word + PDF', label: 'export', subtleText: subtleText, primaryText: primaryText),
            ],
          ),
        ],
      ),
    );
  }
}

class _StatChip extends StatelessWidget {
  const _StatChip({
    required this.value,
    required this.label,
    required this.subtleText,
    required this.primaryText,
  });
  final String value, label;
  final Color subtleText, primaryText;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(value,
            style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w800,
                color: primaryText,
                letterSpacing: -0.2)),
        Text(label,
            style: TextStyle(fontSize: 11, color: subtleText)),
      ],
    );
  }
}

// ────────────────────────────────────────────────────────────────────────────
// FEATURES
// ────────────────────────────────────────────────────────────────────────────

class _FeaturesSection extends StatelessWidget {
  const _FeaturesSection({
    required this.isDark,
    required this.primaryText,
    required this.subtleText,
    required this.borderColor,
    required this.cardColor,
  });

  final bool isDark;
  final Color primaryText, subtleText, borderColor, cardColor;

  static const _features = [
    (
    Icons.school_rounded,
    'Primary and secondary paths',
    'Choose the right planning structure for your class level — primary or O/A Level.'
    ),
    (
    Icons.calendar_month_rounded,
    'Term dates and lesson frequency',
    'Set term start and end dates, set lesson frequency, and let the planner do the rest.'
    ),
    (
    Icons.assignment_rounded,
    'Revision and assessment slots',
    'Automatically place revision and test weeks across the term in the right positions.'
    ),
    (
    Icons.file_present_rounded,
    'Word and PDF export',
    'Download your scheme as an editable Word document or print-ready PDF in one tap.'
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _SectionLabel(label: 'Features', subtleText: subtleText),
          const SizedBox(height: 10),
          Text(
            'Built around the Zimbabwe\nclassroom workflow',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w800,
              color: primaryText,
              letterSpacing: -0.5,
              height: 1.2,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            'A useful scheme of work must fit the term, the class level, and the syllabus actually being taught.',
            style: TextStyle(fontSize: 13, color: subtleText, height: 1.55),
          ),
          const SizedBox(height: 20),
          ..._features.map((f) => Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: _FeatureRow(
              icon: f.$1,
              title: f.$2,
              description: f.$3,
              isDark: isDark,
              primaryText: primaryText,
              subtleText: subtleText,
              borderColor: borderColor,
              cardColor: cardColor,
            ),
          )),
        ],
      ),
    );
  }
}

class _FeatureRow extends StatelessWidget {
  const _FeatureRow({
    required this.icon,
    required this.title,
    required this.description,
    required this.isDark,
    required this.primaryText,
    required this.subtleText,
    required this.borderColor,
    required this.cardColor,
  });

  final IconData icon;
  final String title, description;
  final bool isDark;
  final Color primaryText, subtleText, borderColor, cardColor;

  @override
  Widget build(BuildContext context) {
    return Container(
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
          )
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: AppTheme.accentColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, size: 20, color: AppTheme.accentColor),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: primaryText,
                    letterSpacing: -0.2,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 13,
                    color: subtleText,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ────────────────────────────────────────────────────────────────────────────
// INFO / HOW IT WORKS
// ────────────────────────────────────────────────────────────────────────────

class _InfoSection extends StatelessWidget {
  const _InfoSection({
    required this.isDark,
    required this.primaryText,
    required this.subtleText,
    required this.borderColor,
    required this.cardColor,
  });

  final bool isDark;
  final Color primaryText, subtleText, borderColor, cardColor;

  static const _steps = [
    (Icons.bolt_rounded, 'Quick AI planning', 'Describe what you need in plain language and get a full scheme in seconds.'),
    (Icons.tune_rounded, 'Guided planning', 'Walk through each step — class level, term dates, topics — at your own pace.'),
    (Icons.dashboard_rounded, 'Saved dashboard', 'All your schemes are saved. Reopen, edit, and re-export any time.'),
    (Icons.check_circle_outline_rounded, 'Review before printing', 'You check the content and choose the format. The teacher stays in control.'),
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _SectionLabel(label: 'How it works', subtleText: subtleText),
          const SizedBox(height: 10),
          Text(
            'AI support without losing\nteacher control',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w800,
              color: primaryText,
              letterSpacing: -0.5,
              height: 1.2,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            'The platform can suggest a complete draft, but the teacher still reviews the content, adjusts wording, and chooses the final download format.',
            style: TextStyle(fontSize: 13, color: subtleText, height: 1.55),
          ),
          const SizedBox(height: 20),
          Container(
            decoration: BoxDecoration(
              color: cardColor,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: borderColor, width: 1),
            ),
            child: Column(
              children: _steps.asMap().entries.map((e) {
                final isLast = e.key == _steps.length - 1;
                final step = e.value;
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 14),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 36,
                            height: 36,
                            decoration: BoxDecoration(
                              color:
                              AppTheme.accentColor.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Icon(step.$1,
                                size: 18, color: AppTheme.accentColor),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: [
                                Text(step.$2,
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700,
                                        color: primaryText,
                                        letterSpacing: -0.2)),
                                const SizedBox(height: 3),
                                Text(step.$3,
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: subtleText,
                                        height: 1.5)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (!isLast)
                      Divider(
                          height: 1,
                          indent: 64,
                          color: borderColor),
                  ],
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}

// ────────────────────────────────────────────────────────────────────────────
// FAQ
// ────────────────────────────────────────────────────────────────────────────

class _FaqSection extends StatelessWidget {
  const _FaqSection({
    required this.isDark,
    required this.primaryText,
    required this.subtleText,
    required this.borderColor,
    required this.cardColor,
  });

  final bool isDark;
  final Color primaryText, subtleText, borderColor, cardColor;

  static const _faqs = [
    (
    'Can Scheme Rangu create a Zimbabwe scheme of work?',
    'Yes. It is designed for Zimbabwean teachers using syllabus-based planning and can export the scheme as Word or PDF.'
    ),
    (
    'Can I edit the generated scheme?',
    'Yes. The scheme can be reviewed and edited before downloading, and saved schemes can be reopened from the dashboard.'
    ),
    (
    'Is it aligned to ZIMSEC syllabuses?',
    'Yes. Scheme Rangu uses ZIMSEC topic structures and terminology so your output matches what inspectors expect to see.'
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _SectionLabel(label: 'FAQ', subtleText: subtleText),
          const SizedBox(height: 10),
          Text(
            'Questions teachers ask',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w800,
              color: primaryText,
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: 20),
          ..._faqs.map((faq) => Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: _FaqTile(
              question: faq.$1,
              answer: faq.$2,
              isDark: isDark,
              primaryText: primaryText,
              subtleText: subtleText,
              borderColor: borderColor,
              cardColor: cardColor,
            ),
          )),
        ],
      ),
    );
  }
}

class _FaqTile extends StatefulWidget {
  const _FaqTile({
    required this.question,
    required this.answer,
    required this.isDark,
    required this.primaryText,
    required this.subtleText,
    required this.borderColor,
    required this.cardColor,
  });

  final String question, answer;
  final bool isDark;
  final Color primaryText, subtleText, borderColor, cardColor;

  @override
  State<_FaqTile> createState() => _FaqTileState();
}

class _FaqTileState extends State<_FaqTile> {
  bool _open = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeOut,
      decoration: BoxDecoration(
        color: widget.cardColor,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: _open
              ? AppTheme.accentColor.withOpacity(0.4)
              : widget.borderColor,
          width: 1,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(14),
          onTap: () => setState(() => _open = !_open),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        widget.question,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: widget.primaryText,
                          letterSpacing: -0.2,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    AnimatedRotation(
                      turns: _open ? 0.5 : 0,
                      duration: const Duration(milliseconds: 250),
                      child: Icon(Icons.keyboard_arrow_down_rounded,
                          color: widget.subtleText, size: 20),
                    ),
                  ],
                ),
                AnimatedCrossFade(
                  firstChild: const SizedBox.shrink(),
                  secondChild: Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Text(
                      widget.answer,
                      style: TextStyle(
                        fontSize: 13,
                        color: widget.subtleText,
                        height: 1.55,
                      ),
                    ),
                  ),
                  crossFadeState: _open
                      ? CrossFadeState.showSecond
                      : CrossFadeState.showFirst,
                  duration: const Duration(milliseconds: 250),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ────────────────────────────────────────────────────────────────────────────
// FOOTER CTA
// ────────────────────────────────────────────────────────────────────────────

class _FooterCta extends StatelessWidget {
  const _FooterCta({
    required this.isDark,
    required this.primaryText,
    required this.subtleText,
    required this.borderColor,
    required this.onStartPlanning,
  });

  final bool isDark;
  final Color primaryText, subtleText, borderColor;
  final VoidCallback onStartPlanning;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        color: AppTheme.accentColor,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.auto_awesome_rounded,
              color: Colors.white70, size: 28),
          const SizedBox(height: 16),
          const Text(
            'Ready to plan your\nnext term?',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w800,
              color: Colors.white,
              letterSpacing: -0.5,
              height: 1.2,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Create your first scheme of work in under five minutes — free to start.',
            style: TextStyle(
              fontSize: 13,
              color: Colors.white70,
              height: 1.55,
            ),
          ),
          const SizedBox(height: 24),
          SizedBox(
            height: 48,
            width: double.infinity,
            child: ElevatedButton(
              onPressed: onStartPlanning,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: AppTheme.accentColor,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                'Start planning — it\'s free',
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ────────────────────────────────────────────────────────────────────────────
// SHARED HELPERS
// ────────────────────────────────────────────────────────────────────────────

class _SectionLabel extends StatelessWidget {
  const _SectionLabel({required this.label, required this.subtleText});
  final String label;
  final Color subtleText;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: AppTheme.accentColor.withOpacity(0.08),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        label.toUpperCase(),
        style: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w700,
          color: AppTheme.accentColor,
          letterSpacing: 1.2,
        ),
      ),
    );
  }
}