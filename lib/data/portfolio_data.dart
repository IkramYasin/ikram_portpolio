import 'package:material_ui/material_ui.dart';

// ---------------------------------------------------------------------------
// All portfolio content lives here. Edit this file to update the website.
// ---------------------------------------------------------------------------

String kName = 'Ikram Yasin';

// TODO: replace with the email address you want visitors to use.
String kEmail = 'ikramyaseenbaloch64@gmail.com';

String kGithub = 'https://github.com/IkramYasinUot';
String kLinkedin = 'https://linkedin.com/in/ikram-yasin-7b5965363';

class Project {
  const Project({
    required this.title,
    required this.category,
    required this.symbol,
    required this.description,
    required this.technologies,
    required this.status,
    this.github = '',
    this.demo = '',
  });

  final String title;
  final String category;
  final String symbol;
  final String description;
  final List<String> technologies;
  final String status;
  final String github;
  final String demo;

  /// Demo link wins over the GitHub link. Empty string means "no link yet".
  String get link => demo.isNotEmpty ? demo : github;
}

List<Project> kProjects = [
  Project(
    title: 'Makran Cars',
    category: 'WEB DEVELOPMENT',
    symbol: 'MC',
    description: 'A car marketplace concept where users can explore vehicle listings and publish cars for sale.',
    technologies: ['HTML', 'CSS', 'JavaScript', 'Supabase'],
    status: 'In development',
    github: 'https://github.com/IkramYasinUot',
  ),
  Project(
    title: 'Sehat Balochistan',
    category: 'HEALTHCARE · UI/UX',
    symbol: 'SB',
    description: 'A healthcare app concept to help people explore hospitals, doctors, services and appointment options.',
    technologies: ['Figma', 'UI/UX', 'Mobile Design'],
    status: 'Design project',
  ),
  Project(
    title: 'ThreatLens',
    category: 'PYTHON · CYBERSECURITY',
    symbol: 'TL',
    description: 'A security analysis project concept for checking URLs, domains and IP addresses using threat intelligence sources.',
    technologies: ['Python', 'Streamlit', 'VirusTotal', 'WHOIS'],
    status: 'Learning project',
  ),
];

class SkillGroup {
  const SkillGroup(this.title, this.icon, this.tags);
  final String title;
  final IconData icon;
  final List<String> tags;
}

List<SkillGroup> kSkills = [
  SkillGroup('Programming', Icons.terminal, ['Python', 'Dart']),
  SkillGroup('Mobile Development', Icons.smartphone, [
    'Flutter',
    'Android basics',
  ]),
  SkillGroup('Web Development', Icons.language, ['HTML', 'CSS', 'JavaScript']),
  SkillGroup('Database', Icons.storage, ['PostgreSQL', 'SQL', 'Supabase']),
  SkillGroup('Python Tools', Icons.insights, [
    'NumPy',
    'Matplotlib',
    'Tkinter',
  ]),
  SkillGroup('Tools & Interests', Icons.auto_awesome, [
    'Git',
    'GitHub',
    'Figma',
    'AI / ML',
  ]),
];

class Stat {
  const Stat(this.value, this.label);
  final String value;
  final String label;
}

List<Stat> kStats = [
  Stat('BSCS', 'Computer Science'),
  Stat('Flutter', 'Mobile development focus'),
  Stat('AI / ML', 'Future learning direction'),
  Stat('Build', 'Learn through projects'),
];

class TimelineEntry {
  const TimelineEntry(this.tag, this.title, this.subtitle, this.description);
  final String tag;
  final String title;
  final String subtitle;
  final String description;
}

class TrainingRecord {
  const TrainingRecord({
    required this.provider,
    required this.title,
    required this.courseUrl,
    required this.certificateUrl,
  });

  final String provider;
  final String title;
  final String courseUrl;
  final String certificateUrl;
}

class CertificateRecord {
  const CertificateRecord({
    required this.title,
    required this.provider,
    required this.courseUrl,
    required this.verificationUrl,
  });

  final String title;
  final String provider;
  final String courseUrl;
  final String verificationUrl;
}

List<TimelineEntry> kTimeline = [
  TimelineEntry(
    'CURRENT',
    'BS Computer Science',
    'University of Turbat · Balochistan, Pakistan',
    'Building a foundation in programming, algorithms, databases, software development and computer science fundamentals.',
  ),
  TimelineEntry(
    'TRAINING',
    'IT & Technical Learning',
    'IBM, EC-Council, Google, Google Cloud and Coursera',
    '19 verified courses covering mobile development, software engineering, web development, cybersecurity, AI and cloud.',
  ),
  TimelineEntry(
    'CERTIFICATES',
    'Professional Development',
    'IBM, EC-Council, Google, Google Cloud and Coursera',
    '6 professional and course certificates with public verification links.',
  ),
];

List<TrainingRecord> kTraining = [
  TrainingRecord(
    provider: 'IBM',
    title: 'Introduction to Mobile App Development',
    courseUrl: 'https://www.coursera.org/learn/introduction-to-mobile-app-development/home/welcome',
    certificateUrl:
        'https://www.coursera.org/account/accomplishments/records/G0MYBVBIAPXC',
  ),
  TrainingRecord(
    provider: 'IBM',
    title: 'Introduction to Software Engineering',
    courseUrl: 'https://www.coursera.org/learn/introduction-to-software-engineering/home/welcome',
    certificateUrl:
        'https://www.coursera.org/account/accomplishments/records/5P39YH3LTFCO',
  ),
  TrainingRecord(
    provider: 'IBM',
    title: 'Get Started with Android App Development',
    courseUrl: 'https://www.coursera.org/learn/get-started-with-android-app-development/home/welcome',
    certificateUrl:
        'https://www.coursera.org/account/accomplishments/records/2EMYR6W2RA7N',
  ),
  TrainingRecord(
    provider: 'IBM',
    title: 'Designing User Interfaces and Experiences (UI/UX)',
    courseUrl: 'https://www.coursera.org/learn/designing-user-interfaces-and-experiences-uiux/home/welcome',
    certificateUrl:
        'https://www.coursera.org/account/accomplishments/records/NAGG5QZS1NAB',
  ),
  TrainingRecord(
    provider: 'IBM',
    title: 'Getting Started with Git and GitHub',
    courseUrl: 'https://www.coursera.org/learn/getting-started-with-git-and-github/home/welcome',
    certificateUrl:
        'https://www.coursera.org/account/accomplishments/records/D5UJNJAUFFCP',
  ),
  TrainingRecord(
    provider: 'IBM',
    title: 'Introduction to HTML, CSS, & JavaScript',
    courseUrl: 'https://www.coursera.org/learn/introduction-html-css-javascript/home/welcome',
    certificateUrl:
        'https://www.coursera.org/account/accomplishments/records/59NNW40Z2YNX',
  ),
  TrainingRecord(
    provider: 'IBM',
    title: 'Get Started with iOS App Development',
    courseUrl: 'https://www.coursera.org/learn/get-started-with-ios-app-development/home/welcome',
    certificateUrl:
        'https://www.coursera.org/account/accomplishments/records/ID5Q5YY81TGF',
  ),
  TrainingRecord(
    provider: 'IBM',
    title: 'Flutter and Dart: Developing iOS, Android, and Mobile Apps',
    courseUrl: 'https://www.coursera.org/learn/flutter-and-dart-developing-ios-android-mobile-apps/home/welcome',
    certificateUrl:
        'https://www.coursera.org/account/accomplishments/records/S0Z2BVECXI6R',
  ),
  TrainingRecord(
    provider: 'IBM',
    title: 'Developing Front-End Apps with React',
    courseUrl: 'https://www.coursera.org/learn/developing-frontend-apps-with-react/home/welcome',
    certificateUrl:
        'https://www.coursera.org/account/accomplishments/records/YV9GNY8TR6IO',
  ),
  TrainingRecord(
    provider: 'IBM',
    title: 'React Native: Developing Android and iOS Apps',
    courseUrl: 'https://www.coursera.org/learn/react-native-developing-android-and-ios-apps/home/welcome',
    certificateUrl:
        'https://www.coursera.org/account/accomplishments/records/M00UL0PH5ZPF',
  ),
  TrainingRecord(
    provider: 'IBM',
    title: 'Mobile App Notifications, Databases, & Publishing',
    courseUrl: 'https://www.coursera.org/learn/mobile-app-notifications-databases-publishing/home/welcome',
    certificateUrl:
        'https://www.coursera.org/account/accomplishments/records/9D9Y1UXMZDDT',
  ),
  TrainingRecord(
    provider: 'IBM',
    title: 'Mobile App Development Capstone Project',
    courseUrl: 'https://www.coursera.org/learn/mobile-app-development-capstone-project/home/welcome',
    certificateUrl:
        'https://www.coursera.org/account/accomplishments/records/6JU9X74QP0XQ',
  ),
  TrainingRecord(
    provider: 'IBM',
    title: 'Generative AI: Elevate your Software Development Career',
    courseUrl: 'https://www.coursera.org/learn/generative-ai-elevate-software-development-career/home/welcome',
    certificateUrl:
        'https://www.coursera.org/account/accomplishments/records/R7B9T696WOT6',
  ),
  TrainingRecord(
    provider: 'IBM',
    title: 'Generative AI: Turbocharge Mobile App Development',
    courseUrl: 'https://www.coursera.org/learn/generative-ai-for-mobile-development/home/welcome',
    certificateUrl:
        'https://www.coursera.org/account/accomplishments/records/IV64F8V2C5HQ',
  ),
  TrainingRecord(
    provider: 'EC-Council',
    title: 'Ethical Hacking Essentials (EHE)',
    courseUrl: 'https://www.coursera.org/learn/ethical-hacking-essentials-ehe/home/welcome',
    certificateUrl:
        'https://www.coursera.org/account/accomplishments/records/7GUG6ELSA64I',
  ),
  TrainingRecord(
    provider: 'Google',
    title: 'Crash Course on Python',
    courseUrl:
        'https://www.coursera.org/learn/python-crash-course/home/welcome',
    certificateUrl:
        'https://www.coursera.org/account/accomplishments/records/ZXTIOIW0VCH2',
  ),
  TrainingRecord(
    provider: 'Google Cloud',
    title: 'Introduction to Dart',
    courseUrl: 'https://www.coursera.org/learn/googlecloud-introduction-to-dart-z35cr/home/welcome',
    certificateUrl:
        'https://www.coursera.org/account/accomplishments/records/2CH5ET1AJ28G',
  ),
  TrainingRecord(
    provider: 'Google',
    title: 'Foundations of Cybersecurity',
    courseUrl: 'https://www.coursera.org/learn/foundations-of-cybersecurity/home/welcome',
    certificateUrl:
        'https://www.coursera.org/account/accomplishments/records/227JWXQRFSV1',
  ),
  TrainingRecord(
    provider: 'Coursera',
    title: 'Build a Full Website using WordPress',
    courseUrl: 'https://www.coursera.org/learn/build-a-full-website-using-wordpress/home/welcome',
    certificateUrl:
        'https://www.coursera.org/account/accomplishments/records/HH1CZPQXEBET',
  ),
];

List<CertificateRecord> kCertificates = [
  CertificateRecord(
    title: 'IBM iOS and Android Mobile App Developer Professional Certificate',
    provider: 'IBM',
    courseUrl: 'https://www.coursera.org/specializations/ibm-ios-android-mobile-app-developer-pc',
    verificationUrl: 'https://www.coursera.org/account/accomplishments/professional-cert/5IN6BPSTJP8E',
  ),
  CertificateRecord(
    title: 'Ethical Hacking Essentials (EHE)',
    provider: 'EC-Council',
    courseUrl: 'https://www.coursera.org/learn/ethical-hacking-essentials-ehe/home/welcome',
    verificationUrl:
        'https://www.coursera.org/account/accomplishments/records/7GUG6ELSA64I',
  ),
  CertificateRecord(
    title: 'Crash Course on Python',
    provider: 'Google',
    courseUrl:
        'https://www.coursera.org/learn/python-crash-course/home/welcome',
    verificationUrl:
        'https://www.coursera.org/account/accomplishments/records/ZXTIOIW0VCH2',
  ),
  CertificateRecord(
    title: 'Introduction to Dart',
    provider: 'Google Cloud',
    courseUrl: 'https://www.coursera.org/learn/googlecloud-introduction-to-dart-z35cr/home/welcome',
    verificationUrl:
        'https://www.coursera.org/account/accomplishments/records/2CH5ET1AJ28G',
  ),
  CertificateRecord(
    title: 'Foundations of Cybersecurity',
    provider: 'Google',
    courseUrl: 'https://www.coursera.org/learn/foundations-of-cybersecurity/home/welcome',
    verificationUrl:
        'https://www.coursera.org/account/accomplishments/records/227JWXQRFSV1',
  ),
  CertificateRecord(
    title: 'Build a Full Website using WordPress',
    provider: 'Coursera',
    courseUrl: 'https://www.coursera.org/learn/build-a-full-website-using-wordpress/home/welcome',
    verificationUrl:
        'https://www.coursera.org/account/accomplishments/records/HH1CZPQXEBET',
  ),
];
