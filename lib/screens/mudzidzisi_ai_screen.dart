import 'package:flutter/material.dart';
import '../widgets/reusable_widgets.dart';

class MudzidzisiAiScreen extends StatelessWidget {
  const MudzidzisiAiScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PageShell(
      title: 'Mudzidzisi AI',
      children: [
        const HeroSection(
          badge: 'Built for Zimbabwean teachers',
          title: 'Mudzidzisi AI',
          subtitle: 'Give learners practice work, collect answers, and mark with feedback in one simple online classroom for Zimbabwean teachers.',
        ),
        const InfoSection(
          title: 'Digital classroom made simple',
          subtitle: 'Mudzidzisi AI creates a streamlined workflow for assigning, collecting, and marking student work.',
          items: [
            'Assign practice work to learners',
            'Collect answers online',
            'AI-powered marking and feedback',
            'Track learner progress',
            'Identify areas for remediation',
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
          question: 'How does Mudzidzisi AI marking work?',
          answer: 'The AI marks learner responses and provides feedback. Teachers can review all marks before releasing them to learners.',
        ),
        FaqItem(
          question: 'Can learners access Mudzidzisi on their phones?',
          answer: 'Yes. Mudzidzisi AI works on mobile phones, making it accessible for learners.',
        ),
      ],
    );
  }
}
