import 'package:flutter/material.dart';
import '../widgets/reusable_widgets.dart';

class AiForTeachersScreen extends StatelessWidget {
  const AiForTeachersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PageShell(
      title: 'AI for Teachers',
      children: [
        const HeroSection(
          badge: 'Built for Zimbabwean teachers',
          title: 'AI Tools for Teachers in Zimbabwe',
          subtitle: 'Scheme Rangu uses AI to support practical teacher planning in Zimbabwe. The goal is not to replace the teacher, but to reduce repetitive drafting so teachers can spend more time reviewing, adapting, and teaching.',
        ),
        const InfoSection(
          title: 'Teacher-first AI planning',
          subtitle: 'Teachers can describe what they need in normal classroom language, then use the generated draft as a starting point for school-ready work.',
          items: [
            'Term schemes from syllabus context',
            'Daily lesson plans from saved schemes',
            'Exercises and tests from lesson focus',
            'School timetable and Mudzidzisi AI support',
          ],
        ),
        const InfoSection(
          title: 'Designed for local school routines',
          subtitle: 'The app supports planning habits familiar to Zimbabwean teachers.',
          items: [
            'Works on phone or computer',
            'Exports files for school records',
            'Keeps work saved by account',
            'Supports repeated planning across classes',
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
          question: 'Is Scheme Rangu an AI education platform?',
          answer: 'Yes. It uses AI to help teachers prepare schemes, lesson plans, classroom tasks, school timetables, and Mudzidzisi AI assignments, while keeping the teacher in control of final edits.',
        ),
        FaqItem(
          question: 'Does it work for Zimbabwean teachers?',
          answer: 'Yes. The platform is built around Zimbabwe classroom planning language, syllabus workflows, and teacher file formats.',
        ),
      ],
    );
  }
}
