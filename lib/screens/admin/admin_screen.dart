import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ikram_portpolio/models/portfolio_data.dart';
import 'package:ikram_portpolio/screens/admin/widgets/about_form.dart';
import 'package:ikram_portpolio/screens/admin/widgets/skills_form.dart';
import 'package:ikram_portpolio/screens/admin/widgets/projects_form.dart';
import 'package:ikram_portpolio/screens/admin/widgets/training_form.dart';
import 'package:ikram_portpolio/screens/admin/widgets/certificates_form.dart';

class AdminScreen extends StatefulWidget {
  @override
  _AdminScreenState createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late PortfolioData _portfolioData;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
    _fetchPortfolioData();
  }

  Future<void> _fetchPortfolioData() async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('portfolio')
          .doc('data')
          .get();
      setState(() {
        _portfolioData = PortfolioData.fromJson(snapshot.data()!);
        _isLoading = false;
      });
    } catch (e) {
      // Handle error
      print(e);
    }
  }

  Future<void> _savePortfolioData() async {
    try {
      await FirebaseFirestore.instance
          .collection('portfolio')
          .doc('data')
          .set(_portfolioData.toJson());
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Portfolio data saved successfully!')),
      );
    } catch (e) {
      // Handle error
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ikram Portfolio Admin'),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: _savePortfolioData,
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(text: 'About'),
            Tab(text: 'Skills'),
            Tab(text: 'Projects'),
            Tab(text: 'Training'),
            Tab(text: 'Certificates'),
          ],
        ),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : TabBarView(
              controller: _tabController,
              children: [
                AboutForm(about: _portfolioData.about),
                SkillsForm(skills: _portfolioData.skills),
                ProjectsForm(projects: _portfolioData.projects),
                TrainingForm(training: _portfolioData.training),
                CertificatesForm(certificates: _portfolioData.certificates),
              ],
            ),
    );
  }
}