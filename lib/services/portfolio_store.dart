import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:material_ui/material_ui.dart';

import '../data/portfolio_data.dart';

class PortfolioStore {
  static DocumentReference<Map<String, dynamic>> get _document =>
      FirebaseFirestore.instance.collection('portfolio').doc('content');

  static Future<void> load() async {
    try {
      final snapshot = await _document.get();
      if (!snapshot.exists) return;
      apply(snapshot.data() ?? {});
    } catch (_) {
      // Keep the verified built-in portfolio data if Firestore is unavailable.
    }
  }

  static void apply(Map<String, dynamic> data) {
    kName = data['name'] is String ? data['name'] as String : kName;
    kEmail = data['email'] is String ? data['email'] as String : kEmail;
    kGithub = data['github'] is String ? data['github'] as String : kGithub;
    kLinkedin = data['linkedin'] is String
        ? data['linkedin'] as String
        : kLinkedin;

    final projects = data['projects'];
    if (projects is List) {
      kProjects = projects.whereType<Map>().map((item) {
        final map = Map<String, dynamic>.from(item);
        return Project(
          title: map['title']?.toString() ?? '',
          category: map['category']?.toString() ?? '',
          symbol: map['symbol']?.toString() ?? '',
          description: map['description']?.toString() ?? '',
          technologies: (map['technologies'] is List)
              ? (map['technologies'] as List).map((e) => e.toString()).toList()
              : <String>[],
          status: map['status']?.toString() ?? '',
          github: map['github']?.toString() ?? '',
          demo: map['demo']?.toString() ?? '',
        );
      }).toList();
    }

    final skills = data['skills'];
    if (skills is List) {
      kSkills = skills.whereType<Map>().map((item) {
        final map = Map<String, dynamic>.from(item);
        final title = map['title']?.toString() ?? '';
        return SkillGroup(
          title,
          _skillIcon(title),
          (map['tags'] is List)
              ? (map['tags'] as List).map((e) => e.toString()).toList()
              : <String>[],
        );
      }).toList();
    }

    final training = data['training'];
    if (training is List) {
      kTraining = training.whereType<Map>().map((item) {
        final map = Map<String, dynamic>.from(item);
        return TrainingRecord(
          provider: map['provider']?.toString() ?? '',
          title: map['title']?.toString() ?? '',
          courseUrl: map['courseUrl']?.toString() ?? '',
          certificateUrl: map['certificateUrl']?.toString() ?? '',
        );
      }).toList();
    }

    final certificates = data['certificates'];
    if (certificates is List) {
      kCertificates = certificates.whereType<Map>().map((item) {
        final map = Map<String, dynamic>.from(item);
        return CertificateRecord(
          title: map['title']?.toString() ?? '',
          provider: map['provider']?.toString() ?? '',
          courseUrl: map['courseUrl']?.toString() ?? '',
          verificationUrl: map['verificationUrl']?.toString() ?? '',
        );
      }).toList();
    }
  }

  static Future<void> save(Map<String, dynamic> data) async {
    await _document.set({
      ...data,
      'updatedAt': FieldValue.serverTimestamp(),
    }, SetOptions(merge: true));
  }

  static dynamic _skillIcon(String title) {
    final normalized = title.toLowerCase();
    if (normalized.contains('mobile')) {
      return const IconData(0xe1b1, fontFamily: 'MaterialIcons');
    }
    if (normalized.contains('web')) {
      return const IconData(0xe80b, fontFamily: 'MaterialIcons');
    }
    if (normalized.contains('database')) {
      return const IconData(0xe1db, fontFamily: 'MaterialIcons');
    }
    if (normalized.contains('python')) {
      return const IconData(0xe6a1, fontFamily: 'MaterialIcons');
    }
    return const IconData(0xe86f, fontFamily: 'MaterialIcons');
  }
}
