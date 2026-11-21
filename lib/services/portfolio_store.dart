import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ikram_portpolio/models/portfolio_data.dart';

class PortfolioStore with ChangeNotifier {
  static final PortfolioStore _instance = PortfolioStore._();
  factory PortfolioStore() => _instance;
  PortfolioStore._();

  DocumentReference<Map<String, dynamic>> get _document =>
      FirebaseFirestore.instance.collection('portfolio').doc('data');

  PortfolioData _portfolioData = PortfolioData.empty();
  PortfolioData get portfolioData => _portfolioData;

  bool _isLoading = true;
  bool get isLoading => _isLoading;

  Future<void> load() async {
    _isLoading = true;
    notifyListeners();
    try {
      final snapshot = await _document.get().timeout(
        const Duration(seconds: 5),
      );
      if (snapshot.exists && snapshot.data() != null) {
        _portfolioData = PortfolioData.fromJson(snapshot.data()!);
      } else {
        // If no data, create and save default data
        _portfolioData = _createDefaultData();
        await _document.set(_portfolioData.toJson());
      }
    } catch (e) {
      debugPrint('Error loading portfolio data: $e');
      // If there's an error (like timeout), create default data locally
      _portfolioData = _createDefaultData();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> save(PortfolioData data) async {
    await _document.set(data.toJson());
    _portfolioData = data;
    notifyListeners();
  }

  PortfolioData _createDefaultData() {
    return PortfolioData(
      about: About(
        name: 'Ikram Yasin',
        profession: 'Flutter Developer',
        summary: 'Building digital experiences with code and curiosity. I\'m a Computer Science student at the University of Turbat, passionate about turning ideas into useful digital products. My current focus is mobile application development with Flutter and Dart, alongside Python programming and web technologies. I enjoy learning by building projects, solving problems, and exploring how technology can make everyday tasks easier. I\'m also growing my knowledge of Artificial Intelligence and Machine Learning, with the goal of combining intelligent systems with practical work.',
      ),
      skills: [
        Skill(name: 'Python', level: 0.9),
        Skill(name: 'Dart', level: 0.9),
        Skill(name: 'Flutter', level: 0.9),
        Skill(name: 'Android basics', level: 0.7),
        Skill(name: 'HTML', level: 0.8),
        Skill(name: 'CSS', level: 0.8),
        Skill(name: 'Javascript', level: 0.7),
        Skill(name: 'PostgreSQL', level: 0.6),
        Skill(name: 'SQL', level: 0.7),
        Skill(name: 'Supabase', level: 0.8),
        Skill(name: 'NumPy', level: 0.6),
        Skill(name: 'Matplotlib', level: 0.6),
        Skill(name: 'Tkinter', level: 0.5),
        Skill(name: 'Git', level: 0.8),
        Skill(name: 'Github', level: 0.8),
        Skill(name: 'Figma', level: 0.7),
        Skill(name: 'AI / ML', level: 0.6),
      ],
      projects: [
        Project(
          name: 'Makran Cars',
          description: 'A car marketplace concept where users can explore vehicle listings and publish cars for sale. Technologies: HTML, CSS, Javascript, Supabase.',
          url: 'https://github.com/ikram-yasin/makran-cars',
        ),
        Project(
          name: 'Sehat Balochistan',
          description: 'A healthcare app concept to help people explore hospitals, doctors, services and appointment options. Technologies: Figma, UI/UX, Mobile Design.',
          url: '',
        ),
        Project(
          name: 'ThreatLens',
          description: 'A security analysis project concept for checking URLs, domains and IP addresses using threat intelligence sources. Technologies: Python, Streamlit, VirusTotal, WHOIS.',
          url: '',
        ),
      ],
      training: [
        Training(
          name: 'BS Computer Science',
          institution: 'University of Turbat, Balochistan, Pakistan',
        ),
        Training(
          name: 'IT & Technical Learning',
          institution: 'IBM, EC-Council, Google, Google Cloud and Coursera',
        ),
        Training(
          name: 'IBM: Introduction to Mobile App Development',
          institution: 'IBM',
        ),
        Training(
          name: 'IBM: Introduction to Software Engineering',
          institution: 'IBM',
        ),
        Training(
          name: 'IBM: Get Started with Android App Development',
          institution: 'IBM',
        ),
      ],
      certificates: [
        Certificate(
          name: 'IBM iOS and Android Mobile App Developer Professional Certificate',
          institution: 'IBM',
          url: 'https://www.coursera.org/account/accomplishments/professional-cert/5IN6BPSTJP8E',
        ),
        Certificate(
          name: 'Ethical Hacking Essentials (EHE)',
          institution: 'EC-Council',
          url: 'https://www.coursera.org/account/accomplishments/records/7GUG6ELSA64I',
        ),
        Certificate(
          name: 'Crash Course on Python',
          institution: 'Google',
          url: 'https://www.coursera.org/account/accomplishments/records/ZXTIOIW0VCH2',
        ),
        Certificate(
          name: 'Introduction to Dart',
          institution: 'Google Cloud',
          url: 'https://www.coursera.org/account/accomplishments/records/2CH5ET1AJ28G',
        ),
        Certificate(
          name: 'Foundations of Cybersecurity',
          institution: 'Google',
          url: 'https://www.coursera.org/account/accomplishments/records/227JWXQRFSV1',
        ),
        Certificate(
          name: 'Build a Full Website using WordPress',
          institution: 'Coursera',
          url: 'https://www.coursera.org/account/accomplishments/records/HH1CZPQXEBET',
        ),
      ],
    );
  }
}