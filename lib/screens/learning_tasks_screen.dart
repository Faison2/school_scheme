import 'package:flutter/material.dart';
import '../widgets/reusable_widgets.dart';

class LearningTasksScreen extends StatelessWidget {
  const LearningTasksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PageShell(
      title: 'Learning Tasks',
      children: [
        const HeroSection(
          badge: 'Built for Zimbabwean teachers',
          title: 'Learning Tasks for Zimbabwean Teachers',
          subtitle: 'Create engaging classroom tasks aligned to your syllabus and lesson objectives. Generate activities that promote active learning and student participation.',
        ),
        const InfoSection(
          title: 'Task types for every lesson',
          subtitle: 'Choose from a variety of task formats to match your teaching goals.',
          items: [
            'Group discussion activities',
            'Individual research tasks',
            'Practical and hands-on activities',
            'Presentation and peer learning',
            'Problem-solving exercises',
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
          question: 'Can I align tasks to my syllabus?',
          answer: 'Yes. Tasks are generated based on your selected syllabus topics and lesson objectives.',
        ),
        FaqItem(
          question: 'Are tasks suitable for all class levels?',
          answer: 'Yes. You can choose the appropriate task type and difficulty for primary and secondary levels.',
        ),
      ],
    );
  }
}
