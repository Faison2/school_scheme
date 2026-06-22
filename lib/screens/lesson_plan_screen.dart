import 'package:flutter/material.dart';
import '../widgets/reusable_widgets.dart';

class LessonPlanScreen extends StatelessWidget {
  const LessonPlanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PageShell(
      title: 'Lesson Plan Generator',
      children: [
        const HeroSection(
          badge: 'Built for Zimbabwean teachers',
          title: 'Lesson Plan Generator for Zimbabwean Teachers',
          subtitle: 'Generate daily lesson plans from saved scheme lessons and Zimbabwe syllabus context. Edit and save them for classroom use with AI assistance.',
        ),
        const InfoSection(
          title: 'Plan from your scheme of work',
          subtitle: 'Select a lesson from your saved scheme of work and generate a complete lesson plan with objectives, activities, resources, and assessment.',
          items: [
            'Generate from saved scheme lessons',
            'Add Zimbabwe syllabus context',
            'Edit and customize before class',
            'Save for later use',
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
          question: 'Can I generate a lesson plan from my scheme?',
          answer: 'Yes. Select any lesson from your saved scheme of work and generate a detailed lesson plan.',
        ),
        FaqItem(
          question: 'Can I edit the lesson plan?',
          answer: 'Yes. You can edit all parts of the lesson plan before saving or printing.',
        ),
      ],
    );
  }
}
