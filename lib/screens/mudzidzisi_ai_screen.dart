import 'package:flutter/material.dart';
import '../app_theme.dart';

class MudzidzisiAiScreen extends StatefulWidget {
  const MudzidzisiAiScreen({super.key});

  @override
  State<MudzidzisiAiScreen> createState() => _MudzidzisiAiScreenState();
}

class _MudzidzisiAiScreenState extends State<MudzidzisiAiScreen>
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
    ).animate(CurvedAnimation(parent: _animController, curve: Curves.easeOut));
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
      appBar: AppBar(
        backgroundColor: bgColor,
        elevation: 0,
        scrolledUnderElevation: 0,
        titleSpacing: 20,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_rounded, color: primaryText, size: 20),
          onPressed: () => Navigator.maybePop(context),
        ),
        title: Row(
          children: [
            Container(
              width: 28,
              height: 28,
              decoration: BoxDecoration(
                color: AppTheme.accentColor.withOpacity(0.15),
                borderRadius: BorderRadius.circular(7),
              ),
              child: const Icon(Icons.psychology_rounded,
                  size: 15, color: AppTheme.accentColor),
            ),
            const SizedBox(width: 9),
            Text(
              'Mudzidzisi AI',
              style: TextStyle(
                color: primaryText,
                fontSize: 16,
                fontWeight: FontWeight.w700,
                letterSpacing: -0.3,
              ),
            ),
          ],
        ),
      ),
      body: FadeTransition(
        opacity: _fadeAnim,
        child: SlideTransition(
          position: _slideAnim,
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              // ── Hero ─────────────────────────────────────────────────
              _HeroSection(
                isDark: isDark,
                primaryText: primaryText,
                subtleText: subtleText,
                borderColor: borderColor,
              ),

              const SizedBox(height: 32),

              // ── Workflow steps ────────────────────────────────────────
              _WorkflowSection(
                isDark: isDark,
                primaryText: primaryText,
                subtleText: subtleText,
                borderColor: borderColor,
                cardColor: cardColor,
              ),

              const SizedBox(height: 32),

              // ── FAQ ───────────────────────────────────────────────────
              _FaqSection(
                isDark: isDark,
                primaryText: primaryText,
                subtleText: subtleText,
                borderColor: borderColor,
                cardColor: cardColor,
              ),

              const SizedBox(height: 40),

              // ── Footer CTA ────────────────────────────────────────────
              _FooterCta(
                isDark: isDark,
                primaryText: primaryText,
                subtleText: subtleText,
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
  });

  final bool isDark;
  final Color primaryText, subtleText, borderColor;

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
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
            decoration: BoxDecoration(
              color: AppTheme.accentColor.withOpacity(0.12),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                  color: AppTheme.accentColor.withOpacity(0.3), width: 1),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.flag_rounded, size: 12, color: AppTheme.accentColor),
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
            'Assign. Collect.\nMark with AI.',
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
            'Give learners practice work, collect answers, and mark with feedback — all in one simple online classroom built for Zimbabwean teachers.',
            style: TextStyle(fontSize: 14, color: subtleText, height: 1.6),
          ),

          const SizedBox(height: 28),

          // Stat chips row
          Row(
            children: [
              _StatChip(
                  value: 'AI marking',
                  label: 'with feedback',
                  subtleText: subtleText,
                  primaryText: primaryText),
              const SizedBox(width: 20),
              _StatChip(
                  value: 'Mobile',
                  label: 'accessible',
                  subtleText: subtleText,
                  primaryText: primaryText),
              const SizedBox(width: 20),
              _StatChip(
                  value: 'Free',
                  label: 'to start',
                  subtleText: subtleText,
                  primaryText: primaryText),
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
        Text(label, style: TextStyle(fontSize: 11, color: subtleText)),
      ],
    );
  }
}

// ────────────────────────────────────────────────────────────────────────────
// WORKFLOW STEPS
// ────────────────────────────────────────────────────────────────────────────

class _WorkflowSection extends StatelessWidget {
  const _WorkflowSection({
    required this.isDark,
    required this.primaryText,
    required this.subtleText,
    required this.borderColor,
    required this.cardColor,
  });

  final bool isDark;
  final Color primaryText, subtleText, borderColor, cardColor;

  static const _steps = [
    (
    Icons.post_add_rounded,
    'Assign practice work',
    'Create a task and share it with your class. Learners receive it directly on their devices.'
    ),
    (
    Icons.inbox_rounded,
    'Collect answers online',
    'Learners submit answers through the platform — no paper, no manual collection.'
    ),
    (
    Icons.auto_fix_high_rounded,
    'AI-powered marking',
    'The AI marks each submission and generates written feedback per learner.'
    ),
    (
    Icons.bar_chart_rounded,
    'Track learner progress',
    'See class performance at a glance and spot who needs more support.'
    ),
    (
    Icons.medical_services_rounded,
    'Identify remediation areas',
    'Pinpoint topics where learners are consistently struggling so you can act quickly.'
    ),
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
            'Digital classroom\nmade simple',
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
            'Mudzidzisi AI creates a streamlined workflow for assigning, collecting, and marking student work.',
            style: TextStyle(fontSize: 13, color: subtleText, height: 1.55),
          ),
          const SizedBox(height: 20),
          Container(
            decoration: BoxDecoration(
              color: cardColor,
              borderRadius: BorderRadius.circular(20),
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
                            width: 38,
                            height: 38,
                            decoration: BoxDecoration(
                              color: AppTheme.accentColor.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Icon(step.$1,
                                size: 19, color: AppTheme.accentColor),
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  step.$2,
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                    color: primaryText,
                                    letterSpacing: -0.2,
                                  ),
                                ),
                                const SizedBox(height: 3),
                                Text(
                                  step.$3,
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: subtleText,
                                    height: 1.5,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (!isLast)
                      Divider(height: 1, indent: 68, color: borderColor),
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
    'How does Mudzidzisi AI marking work?',
    'The AI marks learner responses and provides written feedback. Teachers review all marks before releasing them to learners.'
    ),
    (
    'Can learners access Mudzidzisi on their phones?',
    'Yes. Mudzidzisi AI is fully mobile-friendly, making it accessible for learners who only have a phone.'
    ),
    (
    'Do I need to mark everything myself?',
    'No. The AI handles first-pass marking. You review the results, make any adjustments, and then release grades to learners.'
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
  });

  final bool isDark;
  final Color primaryText, subtleText;

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
          const Icon(Icons.psychology_rounded, color: Colors.white70, size: 28),
          const SizedBox(height: 16),
          const Text(
            'Let AI handle\nthe marking.',
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
            'Assign your first task today and see Mudzidzisi AI mark it for you — free to start.',
            style: TextStyle(fontSize: 13, color: Colors.white70, height: 1.55),
          ),
          const SizedBox(height: 24),
          SizedBox(
            height: 48,
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, '/login'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: AppTheme.accentColor,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                'Get started — it\'s free',
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