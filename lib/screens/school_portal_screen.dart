import 'package:flutter/material.dart';
import '../widgets/reusable_widgets.dart';

class SchoolPortalScreen extends StatelessWidget {
  const SchoolPortalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PageShell(
      title: 'School Portal',
      children: [
        const HeroSection(
          badge: 'Built for Zimbabwean schools',
          title: 'School Portal Zimbabwe',
          subtitle: 'Scheme Rangu School Portal helps Zimbabwean schools manage learners, parents, staff roles, fees, attendance, results, notices, reports, timetables, and AI teacher tools in one platform.',
        ),
        const InfoSection(
          title: 'All-in-one school management',
          subtitle: 'Manage every aspect of your school from a single platform.',
          items: [
            'Learner and parent management',
            'Staff roles and permissions',
            'Fee tracking and payments',
            'Attendance recording',
            'Results and report cards',
            'School notices and communication',
            'Timetable management',
            'AI teacher tool integration',
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
          question: 'Is the School Portal free?',
          answer: 'The School Portal is available as part of Scheme Rangu\'s school subscription plan.',
        ),
        FaqItem(
          question: 'Can parents access the portal?',
          answer: 'Yes. Parents can access learner progress, attendance, fees, and school notices through their own login.',
        ),
      ],
    );
  }
}
