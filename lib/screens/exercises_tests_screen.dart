import 'package:flutter/material.dart';
import '../widgets/reusable_widgets.dart';

class ExercisesTestsScreen extends StatelessWidget {
  const ExercisesTestsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PageShell(
      title: 'Exercises & Tests',
      children: [
        const HeroSection(
          badge: 'Built for Zimbabwean teachers',
          title: 'Exercises and Tests for Zimbabwean Teachers',
          subtitle: 'Create syllabus-based exercises, homework, tests, remedial work, and teacher copies for Zimbabwean classroom use.',
        ),
        const InfoSection(
          title: 'Comprehensive assessment tools',
          subtitle: 'Create varied assessments that match your syllabus and lesson objectives.',
          items: [
            'Syllabus-based exercises',
            'Homework assignments',
            'Class tests and exams',
            'Remedial work for struggling learners',
            'Teacher copies with answers',
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
          question: 'Can I create tests from my syllabus?',
          answer: 'Yes. Generate tests based on your syllabus topics and lesson objectives.',
        ),
        FaqItem(
          question: 'Is there a teacher copy?',
          answer: 'Yes. Each assessment comes with a teacher copy that includes answers and marking guidelines.',
        ),
      ],
    );
  }
}
