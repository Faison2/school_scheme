import 'package:flutter/material.dart';
import '../widgets/reusable_widgets.dart';

class TimetablingScreen extends StatelessWidget {
  const TimetablingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PageShell(
      title: 'AI Timetabling',
      children: [
        const HeroSection(
          badge: 'Built for Zimbabwean schools',
          title: 'AI School Timetabling',
          subtitle: 'Create school timetable workspaces, collect teacher loads, generate draft timetables, and review AI conflict suggestions for Zimbabwean schools.',
        ),
        const InfoSection(
          title: 'Smart timetable generation',
          subtitle: 'Save time with AI-assisted timetable creation that respects teacher loads and classroom availability.',
          items: [
            'Create timetable workspaces',
            'Collect teacher workload data',
            'Generate draft timetables',
            'AI conflict detection and suggestions',
            'Manual adjustments and fine-tuning',
            'Export and share timetables',
          ],
        ),
        _buildFaq(context),
      ],
    );
  }

  Widget _buildFaq(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const AppSectionHeader(title: 'Questions teachers ask'),
        FaqItem(
          question: 'Can the AI handle complex timetables?',
          answer: 'Yes. The AI assists with conflict resolution and suggests optimal arrangements based on your inputs.',
        ),
        FaqItem(
          question: 'Can I edit the timetable manually?',
          answer: 'Yes. The generated timetable is fully editable before finalizing.',
        ),
      ],
    );
  }
}
