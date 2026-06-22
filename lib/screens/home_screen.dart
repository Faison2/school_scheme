import 'package:flutter/material.dart';
import '../app_theme.dart';
import '../widgets/reusable_widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scheme Rangu'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pushNamed(context, '/login'),
            child: const Text('Login'),
          ),
        ],
      ),
      body: ListView(
        children: [
          HeroSection(
            badge: 'Built for Zimbabwean teachers',
            title: 'AI Teacher Planning for Zimbabwe',
            subtitle: 'Scheme Rangu helps Zimbabwean teachers create schemes of work, lesson plans, exercises, tests, and classroom tasks from syllabus-based workflows.',
            onStartPlanning: () => Navigator.pushNamed(context, '/login'),
            onViewPlatform: () => Navigator.pushNamed(context, '/scheme-of-work'),
          ),
          const SizedBox(height: 8),
          _buildFeaturesSection(context),
          const SizedBox(height: 8),
          _buildInfoSection(context),
          const _SectionDivider(),
          _buildFaqSection(context),
          const SizedBox(height: 32),
        ],
      ),
    );
  }

  Widget _buildFeaturesSection(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const AppSectionHeader(
            title: 'Built around the Zimbabwe classroom workflow',
            subtitle: 'A useful scheme of work must fit the term, the class level, and the syllabus actually being taught.',
          ),
          const SizedBox(height: 8),
          FeatureCard(
            icon: Icons.school,
            title: 'Primary and secondary planning paths',
            description: 'Choose the appropriate planning path for your class level.',
          ),
          const SizedBox(height: 12),
          FeatureCard(
            icon: Icons.calendar_month,
            title: 'Term dates and lesson frequency',
            description: 'Set term dates and lesson frequency to match your school calendar.',
          ),
          const SizedBox(height: 12),
          FeatureCard(
            icon: Icons.assignment,
            title: 'Revision and assessment placement',
            description: 'Plan revision slots and assessments throughout the term.',
          ),
          const SizedBox(height: 12),
          FeatureCard(
            icon: Icons.file_present,
            title: 'Editable Word and PDF export',
            description: 'Export your schemes as editable Word documents or PDF files.',
          ),
        ],
      ),
    );
  }

  Widget _buildInfoSection(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: InfoSection(
        title: 'AI support without losing teacher control',
        subtitle: 'The platform can suggest a complete draft, but the teacher still reviews the content, adjusts wording, and chooses the final download format.',
        items: [
          'Quick AI planning for natural instructions',
          'Guided planning for step-by-step control',
          'Saved dashboard for later edits',
          'Teacher checks before printing or sharing',
        ],
      ),
    );
  }

  Widget _buildFaqSection(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const AppSectionHeader(title: 'Questions teachers ask'),
          FaqItem(
            question: 'Can Scheme Rangu create a Zimbabwe scheme of work?',
            answer: 'Yes. It is designed for Zimbabwean teachers using syllabus-based planning and can export the scheme as Word or PDF.',
          ),
          FaqItem(
            question: 'Can I edit the generated scheme?',
            answer: 'Yes. The scheme can be reviewed and edited before downloading, and saved schemes can be reopened from the dashboard.',
          ),
        ],
      ),
    );
  }
}

class _SectionDivider extends StatelessWidget {
  const _SectionDivider();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Divider(color: AppTheme.cardColor),
    );
  }
}
