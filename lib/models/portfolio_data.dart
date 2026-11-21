class PortfolioData {
  final About about;
  final List<Skill> skills;
  final List<Project> projects;
  final List<Training> training;
  final List<Certificate> certificates;

  PortfolioData({
    required this.about,
    required this.skills,
    required this.projects,
    required this.training,
    required this.certificates,
  });

  factory PortfolioData.empty() {
    return PortfolioData(
      about: About(name: '', profession: '', summary: ''),
      skills: [],
      projects: [],
      training: [],
      certificates: [],
    );
  }

  factory PortfolioData.fromJson(Map<String, dynamic> json) {
    return PortfolioData(
      about: About.fromJson(json['about']),
      skills: (json['skills'] as List).map((i) => Skill.fromJson(i)).toList(),
      projects:
          (json['projects'] as List).map((i) => Project.fromJson(i)).toList(),
      training:
          (json['training'] as List).map((i) => Training.fromJson(i)).toList(),
      certificates: (json['certificates'] as List)
          .map((i) => Certificate.fromJson(i))
          .toList(),
    );
  }

  PortfolioData copyWith({
    About? about,
    List<Skill>? skills,
    List<Project>? projects,
    List<Training>? training,
    List<Certificate>? certificates,
  }) {
    return PortfolioData(
      about: about ?? this.about.copyWith(),
      skills: skills ?? this.skills.map((s) => s.copyWith()).toList(),
      projects: projects ?? this.projects.map((p) => p.copyWith()).toList(),
      training: training ?? this.training.map((t) => t.copyWith()).toList(),
      certificates: certificates ?? this.certificates.map((c) => c.copyWith()).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'about': about.toJson(),
      'skills': skills.map((i) => i.toJson()).toList(),
      'projects': projects.map((i) => i.toJson()).toList(),
      'training': training.map((i) => i.toJson()).toList(),
      'certificates': certificates.map((i) => i.toJson()).toList(),
    };
  }
}

class About {
  final String name;
  final String profession;
  final String summary;

  About({required this.name, required this.profession, required this.summary});

  About copyWith({
    String? name,
    String? profession,
    String? summary,
  }) {
    return About(
      name: name ?? this.name,
      profession: profession ?? this.profession,
      summary: summary ?? this.summary,
    );
  }

  factory About.fromJson(Map<String, dynamic> json) {
    return About(
      name: json['name'],
      profession: json['profession'],
      summary: json['summary'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'profession': profession,
      'summary': summary,
    };
  }
}

class Skill {
  String name;
  double level;

  Skill({required this.name, required this.level});

  Skill copyWith({
    String? name,
    double? level,
  }) {
    return Skill(
      name: name ?? this.name,
      level: level ?? this.level,
    );
  }

  factory Skill.fromJson(Map<String, dynamic> json) {
    return Skill(
      name: json['name'],
      level: (json['level'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'level': level,
    };
  }
}

class Project {
  String name;
  String description;
  String url;

  Project({required this.name, required this.description, required this.url});

  Project copyWith({
    String? name,
    String? description,
    String? url,
  }) {
    return Project(
      name: name ?? this.name,
      description: description ?? this.description,
      url: url ?? this.url,
    );
  }

  factory Project.fromJson(Map<String, dynamic> json) {
    return Project(
      name: json['name'],
      description: json['description'],
      url: json['url'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'url': url,
    };
  }
}

class Training {
  String name;
  String institution;
  String? year;

  Training({required this.name, required this.institution, this.year});

  Training copyWith({
    String? name,
    String? institution,
    String? year,
  }) {
    return Training(
      name: name ?? this.name,
      institution: institution ?? this.institution,
      year: year ?? this.year,
    );
  }

  factory Training.fromJson(Map<String, dynamic> json) {
    return Training(
      name: json['name'],
      institution: json['institution'],
      year: json['year'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'institution': institution,
      'year': year,
    };
  }
}

class Certificate {
  String name;
  String institution;
  String? year;
  String url;

  Certificate(
      {required this.name,
      required this.institution,
      this.year,
      required this.url});

  Certificate copyWith({
    String? name,
    String? institution,
    String? year,
    String? url,
  }) {
    return Certificate(
      name: name ?? this.name,
      institution: institution ?? this.institution,
      year: year ?? this.year,
      url: url ?? this.url,
    );
  }

  factory Certificate.fromJson(Map<String, dynamic> json) {
    return Certificate(
      name: json['name'],
      institution: json['institution'],
      year: json['year'],
      url: json['url'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'institution': institution,
      'year': year,
      'url': url,
    };
  }
}