import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../app_theme.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen>
    with SingleTickerProviderStateMixin {
  final _pageController = PageController();
  int _currentStep = 0;
  late AnimationController _animController;
  late Animation<double> _fadeAnim;

  final _emailCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();
  final _confirmPasswordCtrl = TextEditingController();
  final _fullNameCtrl = TextEditingController();
  final _phoneCtrl = TextEditingController();
  final _dobCtrl = TextEditingController();
  final _schoolNameCtrl = TextEditingController();
  final _schoolLocationCtrl = TextEditingController();
  String _schoolType = 'Primary';
  String _role = 'Teacher';
  bool _obscurePassword = true;
  bool _obscureConfirm = true;

  final _stepLabels = [
    'Account',
    'Personal',
    'School',
    'KYC',
    'Done',
  ];

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _fadeAnim = CurvedAnimation(
      parent: _animController,
      curve: Curves.easeOut,
    );
    _animController.forward();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _animController.dispose();
    _emailCtrl.dispose();
    _passwordCtrl.dispose();
    _confirmPasswordCtrl.dispose();
    _fullNameCtrl.dispose();
    _phoneCtrl.dispose();
    _dobCtrl.dispose();
    _schoolNameCtrl.dispose();
    _schoolLocationCtrl.dispose();
    super.dispose();
  }

  void _nextStep() {
    if (_currentStep < 4) {
      HapticFeedback.lightImpact();
      _pageController.nextPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
      setState(() => _currentStep++);
      _animController.forward(from: 0);
    }
  }

  void _prevStep() {
    if (_currentStep > 0) {
      HapticFeedback.lightImpact();
      _pageController.previousPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
      setState(() => _currentStep--);
      _animController.forward(from: 0);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final Color bgColor =
        isDark ? const Color(0xFF0D0F14) : const Color(0xFFF6F8FC);
    final Color cardColor =
        isDark ? const Color(0xFF161B25) : Colors.white;
    final Color borderColor =
        isDark ? const Color(0xFF252D3D) : const Color(0xFFE4E9F2);
    final Color subtleText =
        isDark ? const Color(0xFF6B7A99) : const Color(0xFF8A96B0);
    final Color primaryText =
        isDark ? Colors.white : const Color(0xFF0D0F14);

    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: FadeTransition(
          opacity: _fadeAnim,
          child: Column(
            children: [
              _buildHeader(primaryText, subtleText),
              _StepIndicator(
                currentStep: _currentStep,
                labels: _stepLabels,
                accentColor: AppTheme.accentColor,
                subtleText: subtleText,
              ),
              Expanded(
                child: PageView(
                  controller: _pageController,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    _AccountStep(
                      emailCtrl: _emailCtrl,
                      passwordCtrl: _passwordCtrl,
                      confirmPasswordCtrl: _confirmPasswordCtrl,
                      obscurePassword: _obscurePassword,
                      obscureConfirm: _obscureConfirm,
                      onTogglePassword: () =>
                          setState(() => _obscurePassword = !_obscurePassword),
                      onToggleConfirm: () =>
                          setState(() => _obscureConfirm = !_obscureConfirm),
                      borderColor: borderColor,
                      cardColor: cardColor,
                      primaryText: primaryText,
                      subtleText: subtleText,
                      isDark: isDark,
                    ),
                    _PersonalStep(
                      fullNameCtrl: _fullNameCtrl,
                      phoneCtrl: _phoneCtrl,
                      dobCtrl: _dobCtrl,
                      borderColor: borderColor,
                      cardColor: cardColor,
                      primaryText: primaryText,
                      subtleText: subtleText,
                      isDark: isDark,
                    ),
                    _SchoolStep(
                      schoolNameCtrl: _schoolNameCtrl,
                      schoolLocationCtrl: _schoolLocationCtrl,
                      schoolType: _schoolType,
                      role: _role,
                      onSchoolTypeChanged: (v) =>
                          setState(() => _schoolType = v),
                      onRoleChanged: (v) => setState(() => _role = v),
                      borderColor: borderColor,
                      cardColor: cardColor,
                      primaryText: primaryText,
                      subtleText: subtleText,
                      isDark: isDark,
                    ),
                    _KycStep(
                      borderColor: borderColor,
                      cardColor: cardColor,
                      primaryText: primaryText,
                      subtleText: subtleText,
                      isDark: isDark,
                    ),
                    _SuccessStep(
                      primaryText: primaryText,
                      subtleText: subtleText,
                    ),
                  ],
                ),
              ),
              _buildBottomBar(cardColor, borderColor, isDark),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(Color primaryText, Color subtleText) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 24, 24, 8),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: AppTheme.accentColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(Icons.arrow_back_rounded,
                  size: 20, color: AppTheme.accentColor),
            ),
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Create Account',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                  color: primaryText,
                  letterSpacing: -0.4,
                ),
              ),
              Text(
                'Step ${_currentStep + 1} of 5',
                style: TextStyle(fontSize: 13, color: subtleText),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBottomBar(Color cardColor, Color borderColor, bool isDark) {
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 12, 24, 24),
      decoration: BoxDecoration(
        color: cardColor,
        border: Border(top: BorderSide(color: borderColor, width: 1)),
      ),
      child: Row(
        children: [
          if (_currentStep > 0 && _currentStep < 4)
            Expanded(
              child: _OutlineButton(
                label: 'Back',
                onPressed: _prevStep,
                borderColor: borderColor,
                primaryText: primaryText(
                    isDark ? Colors.white : const Color(0xFF0D0F14)),
                cardColor: cardColor,
              ),
            ),
          if (_currentStep > 0 && _currentStep < 4) const SizedBox(width: 12),
          Expanded(
            flex: _currentStep == 0 ? 1 : 2,
            child: _PrimaryButton(
              label: _currentStep == 4
                  ? 'Go to Home'
                  : (_currentStep == 3
                      ? 'Complete'
                      : (_currentStep == 0 ? 'Create Account' : 'Continue')),
              onPressed: () {
                if (_currentStep == 4) {
                  Navigator.pop(context);
                } else {
                  _nextStep();
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

Color primaryText(Color c) => c;

// ─────────────────────────────────────────────────────────────────────────────
// STEP INDICATOR
// ─────────────────────────────────────────────────────────────────────────────

class _StepIndicator extends StatelessWidget {
  const _StepIndicator({
    required this.currentStep,
    required this.labels,
    required this.accentColor,
    required this.subtleText,
  });

  final int currentStep;
  final List<String> labels;
  final Color accentColor, subtleText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      child: Row(
        children: List.generate(labels.length, (i) {
          final isActive = i <= currentStep;
          return Expanded(
            child: Row(
              children: [
                Container(
                  height: 4,
                  decoration: BoxDecoration(
                    color: isActive ? accentColor : subtleText.withOpacity(0.25),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                if (i < labels.length - 1) const SizedBox(width: 4),
              ],
            ),
          );
        }),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// STEP 1: ACCOUNT DETAILS
// ─────────────────────────────────────────────────────────────────────────────

class _AccountStep extends StatelessWidget {
  const _AccountStep({
    required this.emailCtrl,
    required this.passwordCtrl,
    required this.confirmPasswordCtrl,
    required this.obscurePassword,
    required this.obscureConfirm,
    required this.onTogglePassword,
    required this.onToggleConfirm,
    required this.borderColor,
    required this.cardColor,
    required this.primaryText,
    required this.subtleText,
    required this.isDark,
  });

  final TextEditingController emailCtrl, passwordCtrl, confirmPasswordCtrl;
  final bool obscurePassword, obscureConfirm;
  final VoidCallback onTogglePassword, onToggleConfirm;
  final Color borderColor, cardColor, primaryText, subtleText;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 8),
          Text(
            'Account Details',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: primaryText,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Create your login credentials',
            style: TextStyle(fontSize: 13, color: subtleText),
          ),
          const SizedBox(height: 20),
          _KycField(
            label: 'Email address',
            hint: 'you@example.com',
            controller: emailCtrl,
            prefixIcon: Icons.alternate_email_rounded,
            borderColor: borderColor,
            cardColor: cardColor,
            primaryText: primaryText,
            subtleText: subtleText,
            isDark: isDark,
          ),
          const SizedBox(height: 16),
          _KycField(
            label: 'Password',
            hint: '••••••••',
            controller: passwordCtrl,
            prefixIcon: Icons.lock_outline_rounded,
            obscureText: obscurePassword,
            borderColor: borderColor,
            cardColor: cardColor,
            primaryText: primaryText,
            subtleText: subtleText,
            isDark: isDark,
            suffix: IconButton(
              icon: Icon(
                obscurePassword
                    ? Icons.visibility_off_outlined
                    : Icons.visibility_outlined,
                size: 18,
                color: subtleText,
              ),
              onPressed: onTogglePassword,
            ),
          ),
          const SizedBox(height: 16),
          _KycField(
            label: 'Confirm password',
            hint: '••••••••',
            controller: confirmPasswordCtrl,
            prefixIcon: Icons.lock_outline_rounded,
            obscureText: obscureConfirm,
            borderColor: borderColor,
            cardColor: cardColor,
            primaryText: primaryText,
            subtleText: subtleText,
            isDark: isDark,
            suffix: IconButton(
              icon: Icon(
                obscureConfirm
                    ? Icons.visibility_off_outlined
                    : Icons.visibility_outlined,
                size: 18,
                color: subtleText,
              ),
              onPressed: onToggleConfirm,
            ),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// STEP 2: PERSONAL INFO
// ─────────────────────────────────────────────────────────────────────────────

class _PersonalStep extends StatelessWidget {
  const _PersonalStep({
    required this.fullNameCtrl,
    required this.phoneCtrl,
    required this.dobCtrl,
    required this.borderColor,
    required this.cardColor,
    required this.primaryText,
    required this.subtleText,
    required this.isDark,
  });

  final TextEditingController fullNameCtrl, phoneCtrl, dobCtrl;
  final Color borderColor, cardColor, primaryText, subtleText;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 8),
          Text(
            'Personal Information',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: primaryText,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Tell us about yourself',
            style: TextStyle(fontSize: 13, color: subtleText),
          ),
          const SizedBox(height: 20),
          _KycField(
            label: 'Full name',
            hint: 'John Doe',
            controller: fullNameCtrl,
            prefixIcon: Icons.person_outline_rounded,
            borderColor: borderColor,
            cardColor: cardColor,
            primaryText: primaryText,
            subtleText: subtleText,
            isDark: isDark,
          ),
          const SizedBox(height: 16),
          _KycField(
            label: 'Phone number',
            hint: '+263 7XX XXX XXX',
            controller: phoneCtrl,
            prefixIcon: Icons.phone_outlined,
            keyboardType: TextInputType.phone,
            borderColor: borderColor,
            cardColor: cardColor,
            primaryText: primaryText,
            subtleText: subtleText,
            isDark: isDark,
          ),
          const SizedBox(height: 16),
          _KycField(
            label: 'Date of birth',
            hint: 'DD/MM/YYYY',
            controller: dobCtrl,
            prefixIcon: Icons.calendar_today_outlined,
            borderColor: borderColor,
            cardColor: cardColor,
            primaryText: primaryText,
            subtleText: subtleText,
            isDark: isDark,
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// STEP 3: SCHOOL INFO
// ─────────────────────────────────────────────────────────────────────────────

class _SchoolStep extends StatelessWidget {
  const _SchoolStep({
    required this.schoolNameCtrl,
    required this.schoolLocationCtrl,
    required this.schoolType,
    required this.role,
    required this.onSchoolTypeChanged,
    required this.onRoleChanged,
    required this.borderColor,
    required this.cardColor,
    required this.primaryText,
    required this.subtleText,
    required this.isDark,
  });

  final TextEditingController schoolNameCtrl, schoolLocationCtrl;
  final String schoolType, role;
  final ValueChanged<String> onSchoolTypeChanged, onRoleChanged;
  final Color borderColor, cardColor, primaryText, subtleText;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 8),
          Text(
            'School Information',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: primaryText,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Where do you teach?',
            style: TextStyle(fontSize: 13, color: subtleText),
          ),
          const SizedBox(height: 20),
          _KycField(
            label: 'School name',
            hint: 'e.g. Kennedy High School',
            controller: schoolNameCtrl,
            prefixIcon: Icons.school_outlined,
            borderColor: borderColor,
            cardColor: cardColor,
            primaryText: primaryText,
            subtleText: subtleText,
            isDark: isDark,
          ),
          const SizedBox(height: 16),
          _KycField(
            label: 'School location',
            hint: 'e.g. Harare, Zimbabwe',
            controller: schoolLocationCtrl,
            prefixIcon: Icons.location_on_outlined,
            borderColor: borderColor,
            cardColor: cardColor,
            primaryText: primaryText,
            subtleText: subtleText,
            isDark: isDark,
          ),
          const SizedBox(height: 16),
          _DropdownField(
            label: 'School type',
            value: schoolType,
            items: const ['Primary', 'Secondary', 'Combined', 'College'],
            onChanged: onSchoolTypeChanged,
            borderColor: borderColor,
            primaryText: primaryText,
            subtleText: subtleText,
          ),
          const SizedBox(height: 16),
          _DropdownField(
            label: 'Your role',
            value: role,
            items: const [
              'Teacher',
              'Head of Department',
              'Deputy Head',
              'Headmaster',
              'Administrator',
            ],
            onChanged: onRoleChanged,
            borderColor: borderColor,
            primaryText: primaryText,
            subtleText: subtleText,
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// STEP 4: KYC VERIFICATION
// ─────────────────────────────────────────────────────────────────────────────

class _KycStep extends StatelessWidget {
  const _KycStep({
    required this.borderColor,
    required this.cardColor,
    required this.primaryText,
    required this.subtleText,
    required this.isDark,
  });

  final Color borderColor, cardColor, primaryText, subtleText;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 8),
          Text(
            'Identity Verification (KYC)',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: primaryText,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Upload documents to verify your identity',
            style: TextStyle(fontSize: 13, color: subtleText),
          ),
          const SizedBox(height: 20),
          _UploadCard(
            icon: Icons.badge_outlined,
            title: 'National ID / Passport',
            subtitle: 'Upload a clear photo of your ID',
            borderColor: borderColor,
            cardColor: cardColor,
            primaryText: primaryText,
            subtleText: subtleText,
          ),
          const SizedBox(height: 12),
          _UploadCard(
            icon: Icons.face_outlined,
            title: 'Selfie Photo',
            subtitle: 'Take a selfie holding your ID',
            borderColor: borderColor,
            cardColor: cardColor,
            primaryText: primaryText,
            subtleText: subtleText,
          ),
          const SizedBox(height: 12),
          _UploadCard(
            icon: Icons.work_outline,
            title: 'Teaching Certificate',
            subtitle: 'Optional — helps verify your credentials',
            borderColor: borderColor,
            cardColor: cardColor,
            primaryText: primaryText,
            subtleText: subtleText,
            optional: true,
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: AppTheme.accentColor.withOpacity(0.08),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: AppTheme.accentColor.withOpacity(0.2),
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.info_outline_rounded,
                    size: 18, color: AppTheme.accentColor),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    'Your documents are encrypted and only used for verification purposes.',
                    style: TextStyle(fontSize: 12, color: subtleText, height: 1.4),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// STEP 5: SUCCESS
// ─────────────────────────────────────────────────────────────────────────────

class _SuccessStep extends StatelessWidget {
  const _SuccessStep({
    required this.primaryText,
    required this.subtleText,
  });

  final Color primaryText, subtleText;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          const SizedBox(height: 48),
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              color: AppTheme.accentColor.withOpacity(0.12),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.check_circle_rounded,
              size: 56,
              color: AppTheme.accentColor,
            ),
          ),
          const SizedBox(height: 24),
          Text(
            'Account Created!',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w800,
              color: primaryText,
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Your KYC documents are being reviewed.\nYou will be notified once verified.',
            style: TextStyle(fontSize: 14, color: subtleText, height: 1.5),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 32),
          _KycFeatureRow(
            icon: Icons.verified_outlined,
            text: 'Identity verification pending',
            color: subtleText,
          ),
          const SizedBox(height: 12),
          _KycFeatureRow(
            icon: Icons.email_outlined,
            text: 'Verification email sent',
            color: subtleText,
          ),
          const SizedBox(height: 12),
          _KycFeatureRow(
            icon: Icons.school_outlined,
            text: 'School profile created',
            color: subtleText,
          ),
          const SizedBox(height: 48),
        ],
      ),
    );
  }
}

class _KycFeatureRow extends StatelessWidget {
  const _KycFeatureRow({
    required this.icon,
    required this.text,
    required this.color,
  });

  final IconData icon;
  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, size: 18, color: AppTheme.accentColor),
        const SizedBox(width: 10),
        Text(text, style: TextStyle(fontSize: 14, color: color)),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// SHARED COMPONENTS
// ─────────────────────────────────────────────────────────────────────────────

class _FieldLbl extends StatelessWidget {
  const _FieldLbl({required this.label, required this.textColor});
  final String label;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: textColor,
          letterSpacing: 0.4,
        ),
      ),
    );
  }
}

class _KycField extends StatelessWidget {
  const _KycField({
    required this.label,
    required this.hint,
    required this.controller,
    required this.prefixIcon,
    required this.borderColor,
    required this.cardColor,
    required this.primaryText,
    required this.subtleText,
    required this.isDark,
    this.keyboardType,
    this.obscureText = false,
    this.suffix,
  });

  final String label, hint;
  final TextEditingController controller;
  final IconData prefixIcon;
  final TextInputType? keyboardType;
  final bool obscureText;
  final Widget? suffix;
  final Color borderColor, cardColor, primaryText, subtleText;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    final Color fillColor =
        isDark ? const Color(0xFF0D0F14) : const Color(0xFFF6F8FC);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _FieldLbl(label: label, textColor: subtleText),
        TextField(
          controller: controller,
          obscureText: obscureText,
          keyboardType: keyboardType,
          style: TextStyle(color: primaryText, fontSize: 15),
          cursorColor: AppTheme.accentColor,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(color: subtleText, fontSize: 14),
            prefixIcon: Padding(
              padding: const EdgeInsets.only(left: 14, right: 10),
              child: Icon(prefixIcon, size: 18, color: subtleText),
            ),
            prefixIconConstraints:
                const BoxConstraints(minWidth: 0, minHeight: 0),
            suffixIcon: suffix,
            filled: true,
            fillColor: fillColor,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: borderColor, width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                  color: AppTheme.accentColor.withOpacity(0.7), width: 1.5),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: borderColor),
            ),
          ),
        ),
      ],
    );
  }
}

class _DropdownField extends StatelessWidget {
  const _DropdownField({
    required this.label,
    required this.value,
    required this.items,
    required this.onChanged,
    required this.borderColor,
    required this.primaryText,
    required this.subtleText,
  });

  final String label, value;
  final List<String> items;
  final ValueChanged<String> onChanged;
  final Color borderColor, primaryText, subtleText;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _FieldLbl(label: label, textColor: subtleText),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: borderColor, width: 1),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 14),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: value,
              isExpanded: true,
              dropdownColor:
                  Theme.of(context).brightness == Brightness.dark
                      ? const Color(0xFF161B25)
                      : Colors.white,
              icon: Icon(Icons.keyboard_arrow_down_rounded,
                  size: 20, color: subtleText),
              style: TextStyle(color: primaryText, fontSize: 15),
              items: items.map((item) {
                return DropdownMenuItem(
                  value: item,
                  child: Text(item),
                );
              }).toList(),
              onChanged: (v) {
                if (v != null) onChanged(v);
              },
            ),
          ),
        ),
      ],
    );
  }
}

class _UploadCard extends StatelessWidget {
  const _UploadCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.borderColor,
    required this.cardColor,
    required this.primaryText,
    required this.subtleText,
    this.optional = false,
  });

  final IconData icon;
  final String title, subtitle;
  final Color borderColor, cardColor, primaryText, subtleText;
  final bool optional;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: borderColor, width: 1),
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
            child: Icon(icon, size: 22, color: AppTheme.accentColor),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: primaryText,
                      ),
                    ),
                    if (optional) ...[
                      const SizedBox(width: 6),
                      Text(
                        'Optional',
                        style: TextStyle(
                          fontSize: 10,
                          color: subtleText,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ],
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: TextStyle(fontSize: 12, color: subtleText),
                ),
              ],
            ),
          ),
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: AppTheme.accentColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(Icons.upload_rounded,
                size: 18, color: AppTheme.accentColor),
          ),
        ],
      ),
    );
  }
}

class _PrimaryButton extends StatelessWidget {
  const _PrimaryButton({required this.label, required this.onPressed});
  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 52,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppTheme.accentColor,
          foregroundColor: Colors.white,
          elevation: 0,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
        child: Text(
          label,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.3,
          ),
        ),
      ),
    );
  }
}

class _OutlineButton extends StatelessWidget {
  const _OutlineButton({
    required this.label,
    required this.onPressed,
    required this.borderColor,
    required this.primaryText,
    required this.cardColor,
  });

  final String label;
  final VoidCallback onPressed;
  final Color borderColor, primaryText, cardColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 52,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          backgroundColor: cardColor,
          side: BorderSide(color: borderColor, width: 1),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: primaryText,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
