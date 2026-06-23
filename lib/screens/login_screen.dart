import 'package:flutter/material.dart';
import '../app_theme.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;
  late AnimationController _animController;
  late Animation<double> _fadeAnim;
  late Animation<Offset> _slideAnim;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );
    _fadeAnim = CurvedAnimation(
      parent: _animController,
      curve: Curves.easeOut,
    );
    _slideAnim = Tween<Offset>(
      begin: const Offset(0, 0.08),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animController,
      curve: Curves.easeOut,
    ));
    _animController.forward();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _animController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    // Background and surface colours derived from the theme
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
          child: SlideTransition(
            position: _slideAnim,
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 56),

                  // ── Logo / brand mark ──────────────────────────────────
                  Center(
                    child: Container(
                      width: 72,
                      height: 72,
                      decoration: BoxDecoration(
                        color: AppTheme.accentColor.withOpacity(0.12),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: AppTheme.accentColor.withOpacity(0.3),
                          width: 1.5,
                        ),
                      ),
                      child: const Icon(
                        Icons.school_rounded,
                        size: 36,
                        color: AppTheme.accentColor,
                      ),
                    ),
                  ),

                  const SizedBox(height: 28),

                  // ── Headline ───────────────────────────────────────────
                  Text(
                    'Welcome back',
                    style: theme.textTheme.headlineLarge?.copyWith(
                      color: primaryText,
                      fontWeight: FontWeight.w700,
                      letterSpacing: -0.5,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Sign in to your Scheme Rangu account',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: subtleText,
                      height: 1.5,
                    ),
                    textAlign: TextAlign.center,
                  ),

                  const SizedBox(height: 40),

                  // ── Card container ─────────────────────────────────────
                  Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: cardColor,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: borderColor, width: 1),
                      boxShadow: isDark
                          ? [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.35),
                          blurRadius: 32,
                          offset: const Offset(0, 8),
                        ),
                      ]
                          : [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.06),
                          blurRadius: 24,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // Email field
                        _FieldLabel(label: 'Email address', textColor: subtleText),
                        const SizedBox(height: 8),
                        _StyledTextField(
                          controller: _emailController,
                          hint: 'you@example.com',
                          prefixIcon: Icons.alternate_email_rounded,
                          keyboardType: TextInputType.emailAddress,
                          borderColor: borderColor,
                          cardColor: cardColor,
                          primaryText: primaryText,
                          subtleText: subtleText,
                          isDark: isDark,
                        ),

                        const SizedBox(height: 20),

                        // Password field
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _FieldLabel(
                                label: 'Password', textColor: subtleText),
                            GestureDetector(
                              onTap: () {},
                              child: Text(
                                'Forgot password?',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: AppTheme.accentColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        _StyledTextField(
                          controller: _passwordController,
                          hint: '••••••••',
                          prefixIcon: Icons.lock_outline_rounded,
                          obscureText: _obscurePassword,
                          borderColor: borderColor,
                          cardColor: cardColor,
                          primaryText: primaryText,
                          subtleText: subtleText,
                          isDark: isDark,
                          suffixWidget: IconButton(
                            icon: Icon(
                              _obscurePassword
                                  ? Icons.visibility_off_outlined
                                  : Icons.visibility_outlined,
                              size: 18,
                              color: subtleText,
                            ),
                            onPressed: () => setState(
                                    () => _obscurePassword = !_obscurePassword),
                          ),
                        ),

                        const SizedBox(height: 28),

                        // Sign-in button
                        _PrimaryButton(
                          label: 'Sign in',
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  // ── Divider with OR ────────────────────────────────────
                  Row(
                    children: [
                      Expanded(
                          child: Divider(color: borderColor, thickness: 1)),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Text(
                          'or',
                          style: TextStyle(
                            fontSize: 12,
                            color: subtleText,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Expanded(
                          child: Divider(color: borderColor, thickness: 1)),
                    ],
                  ),

                  const SizedBox(height: 20),

                  // ── Google / Social stub ───────────────────────────────
                  _OutlineButton(
                    label: 'Continue with Google',
                    icon: Icons.g_mobiledata_rounded,
                    borderColor: borderColor,
                    primaryText: primaryText,
                    cardColor: cardColor,
                    isDark: isDark,
                    onPressed: () {},
                  ),

                  const SizedBox(height: 32),

                  // ── Sign-up link ───────────────────────────────────────
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an account?  ",
                        style: TextStyle(
                          color: subtleText,
                          fontSize: 14,
                        ),
                      ),
                      GestureDetector(
                        onTap: () => Navigator.pushNamed(context, '/sign-up'),
                        child: Text(
                          'Sign up',
                          style: TextStyle(
                            color: AppTheme.accentColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ── Small helpers ────────────────────────────────────────────────────────────

class _FieldLabel extends StatelessWidget {
  const _FieldLabel({required this.label, required this.textColor});
  final String label;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w600,
        color: textColor,
        letterSpacing: 0.4,
      ),
    );
  }
}

class _StyledTextField extends StatelessWidget {
  const _StyledTextField({
    required this.controller,
    required this.hint,
    required this.prefixIcon,
    required this.borderColor,
    required this.cardColor,
    required this.primaryText,
    required this.subtleText,
    required this.isDark,
    this.keyboardType,
    this.obscureText = false,
    this.suffixWidget,
  });

  final TextEditingController controller;
  final String hint;
  final IconData prefixIcon;
  final TextInputType? keyboardType;
  final bool obscureText;
  final Widget? suffixWidget;
  final Color borderColor;
  final Color cardColor;
  final Color primaryText;
  final Color subtleText;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    final Color fillColor =
    isDark ? const Color(0xFF0D0F14) : const Color(0xFFF6F8FC);

    return TextField(
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
        prefixIconConstraints: const BoxConstraints(minWidth: 0, minHeight: 0),
        suffixIcon: suffixWidget,
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
          borderSide:
          BorderSide(color: AppTheme.accentColor.withOpacity(0.7), width: 1.5),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: borderColor),
        ),
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
    required this.icon,
    required this.borderColor,
    required this.primaryText,
    required this.cardColor,
    required this.isDark,
    required this.onPressed,
  });

  final String label;
  final IconData icon;
  final Color borderColor;
  final Color primaryText;
  final Color cardColor;
  final bool isDark;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 52,
      child: OutlinedButton.icon(
        onPressed: onPressed,
        icon: Icon(icon, size: 22, color: primaryText),
        label: Text(
          label,
          style: TextStyle(
            color: primaryText,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
        style: OutlinedButton.styleFrom(
          backgroundColor: cardColor,
          side: BorderSide(color: borderColor, width: 1),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
      ),
    );
  }
}