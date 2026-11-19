import 'package:material_ui/material_ui.dart';

// ---------------------------------------------------------------------------
// All portfolio content lives here. Edit this file to update the website.
// ---------------------------------------------------------------------------

const String kName = 'Ikram Yasin';

// TODO: replace with the email address you want visitors to use.
const String kEmail = 'ikramyaseenbaloch64@gmail.com';

const String kGithub = 'https://github.com/IkramYasinUot';
const String kLinkedin = 'https://linkedin.com/in/ikram-yasin-7b5965363';

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

const List<Project> kProjects = [
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

const List<SkillGroup> kSkills = [
  SkillGroup('Programming', Icons.terminal, ['Python', 'Dart', 'Java']),
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

const List<Stat> kStats = [
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

const List<TimelineEntry> kTimeline = [
  TimelineEntry(
    'CURRENT',
    'BS Computer Science',
    'University of Turbat · Balochistan, Pakistan',
    'Building a foundation in programming, algorithms, databases, software development and computer science fundamentals.',
  ),
  TimelineEntry(
    'TRAINING',
    'IT & Technical Learning',
    'Courses, workshops and practical learning',
    'Add your verified training provider, course title, date and certificate links here.',
  ),
  TimelineEntry(
    'CERTIFICATES',
    'Professional Development',
    'Certificates and achievements',
    'Add certificate names and public verification links when ready.',
  ),
];
