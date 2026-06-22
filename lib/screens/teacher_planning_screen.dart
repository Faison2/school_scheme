import 'package:flutter/material.dart';
import '../widgets/reusable_widgets.dart';

class TeacherPlanningScreen extends StatelessWidget {
  const TeacherPlanningScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PageShell(
      title: 'Teacher Planning',
      children: [
        const HeroSection(
          badge: 'Built for Zimbabwean teachers',
          title: 'Teacher Planning Zimbabwe',
          subtitle: 'A Zimbabwe teacher planning platform for schemes of work, lesson plans, classroom tasks, school timetables, Mudzidzisi AI, saved work, and exportable school files.',
        ),
        const InfoSection(
          title: 'Everything you need in one place',
          subtitle: 'Plan, create, save, and export all your teacher documents from a single platform.',
          items: [
            'Schemes of work from syllabus',
            'Daily lesson plans',
            'Classroom tasks and activities',
            'School timetable management',
            'Mudzidzisi AI classroom',
            'Saved work dashboard',
            'Export to Word and PDF',
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
          question: 'Is this available for all Zimbabwean teachers?',
          answer: 'Yes. Teacher Planning is available to all registered Scheme Rangu users in Zimbabwe.',
        ),
        FaqItem(
          question: 'Can I export my work?',
          answer: 'Yes. All documents can be exported as Word documents or PDF files for school records.',
        ),
      ],
    );
  }
}
