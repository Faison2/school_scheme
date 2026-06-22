import 'package:flutter/material.dart';
import '../widgets/reusable_widgets.dart';

class SchemeOfWorkScreen extends StatelessWidget {
  const SchemeOfWorkScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PageShell(
      title: 'Scheme of Work Generator',
      children: [
        const HeroSection(
          badge: 'Built for Zimbabwean teachers',
          title: 'Scheme of Work Generator for Zimbabwean Teachers',
          subtitle: 'Scheme Rangu helps teachers move from Zimbabwe syllabus content into a term scheme of work without starting from a blank document. Teachers choose the class, term, syllabus, timing, revision, and assessment flow, then review the generated plan before export.',
        ),
        const InfoSection(
          title: 'Built around the Zimbabwe classroom workflow',
          subtitle: 'A useful scheme of work must fit the term, the class level, and the syllabus actually being taught. Scheme Rangu keeps those details together so the final document is easier to file, edit, and use in class.',
          items: [
            'Primary and secondary planning paths',
            'Term dates and lesson frequency',
            'Revision and assessment placement',
            'Editable Word and PDF export',
          ],
        ),
        const InfoSection(
          title: 'AI support without losing teacher control',
          subtitle: 'The platform can suggest a complete draft, but the teacher still reviews the content, adjusts wording, and chooses the final download format.',
          items: [
            'Quick AI planning for natural instructions',
            'Guided planning for step-by-step control',
            'Saved dashboard for later edits',
            'Teacher checks before printing or sharing',
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
          question: 'Can Scheme Rangu create a Zimbabwe scheme of work?',
          answer: 'Yes. It is designed for Zimbabwean teachers using syllabus-based planning and can export the scheme as Word or PDF.',
        ),
        FaqItem(
          question: 'Can I edit the generated scheme?',
          answer: 'Yes. The scheme can be reviewed and edited before downloading, and saved schemes can be reopened from the dashboard.',
        ),
      ],
    );
  }
}
