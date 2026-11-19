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
  final String name;
  final double level;

  Skill({required this.name, required this.level});

  factory Skill.fromJson(Map<String, dynamic> json) {
    return Skill(
      name: json['name'],
      level: json['level'],
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
  final String name;
  final String description;
  final String url;

  Project({required this.name, required this.description, required this.url});

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
  final String name;
  final String institution;
  final String year;

  Training({required this.name, required this.institution, required this.year});

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
  final String name;
  final String institution;
  final String year;
  final String url;

  Certificate(
      {required this.name,
      required this.institution,
      required this.year,
      required this.url});

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