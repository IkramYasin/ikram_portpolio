import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:ikram_portpolio/models/portfolio_data.dart';
import 'package:ikram_portpolio/screens/admin/widgets/about_form.dart';
import 'package:ikram_portpolio/screens/admin/widgets/certificates_form.dart';
import 'package:ikram_portpolio/screens/admin/widgets/projects_form.dart';
import 'package:ikram_portpolio/screens/admin/widgets/skills_form.dart';
import 'package:ikram_portpolio/screens/admin/widgets/training_form.dart';
import 'package:ikram_portpolio/services/portfolio_store.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({super.key});

  @override
  AdminScreenState createState() => AdminScreenState();
}

class AdminScreenState extends State<AdminScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  PortfolioData? _editableData;
  PortfolioData? _originalData;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
    context.read<PortfolioStore>().load();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Only initialize the editable copy once, the first time dependencies
    // are resolved. Subsequent store notifications (e.g. after load/save)
    // must not overwrite the user's unsaved edits.
    if (_editableData == null) {
      final store = context.read<PortfolioStore>();
      _originalData = store.portfolioData;
      _editableData = _originalData?.copyWith();
    }
  }

  Future<void> _savePortfolioData() async {
    if (_editableData == null) return;
    try {
      await context.read<PortfolioStore>().save(_editableData!);
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Portfolio data saved successfully!')),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to save: $e'),
          backgroundColor: Theme.of(context).colorScheme.error,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PortfolioStore>(
      builder: (context, store, child) {
        if (store.isLoading && _editableData == null) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (_editableData == null) {
          return const Scaffold(
            body: Center(child: Text('No data available')),
          );
        }

        return Scaffold(
          appBar: AppBar(
            title: const Text('Ikram Portfolio Admin'),
            actions: [
              IconButton(
                icon: const Icon(Icons.save),
                onPressed: _savePortfolioData,
              ),
            ],
            bottom: TabBar(
              controller: _tabController,
              tabs: const [
                Tab(text: 'About'),
                Tab(text: 'Skills'),
                Tab(text: 'Projects'),
                Tab(text: 'Training'),
                Tab(text: 'Certificates'),
              ],
            ),
          ),
          body: TabBarView(
            controller: _tabController,
            children: [
              AboutForm(
                about: _editableData!.about,
                onChanged: (updatedAbout) {
                  setState(() {
                    _editableData = _editableData!.copyWith(about: updatedAbout);
                  });
                },
              ),
              SkillsForm(
                skills: _editableData!.skills,
                onChanged: (updatedSkills) {
                  setState(() {
                    _editableData = _editableData!.copyWith(skills: updatedSkills);
                  });
                },
              ),
              ProjectsForm(
                projects: _editableData!.projects,
                onProjectsChanged: (updatedProjects) {
                  setState(() {
                    _editableData = _editableData!.copyWith(projects: updatedProjects);
                  });
                },
              ),
              TrainingForm(
                training: _editableData!.training,
                onChanged: (updatedTraining) {
                  setState(() {
                    _editableData = _editableData!.copyWith(training: updatedTraining);
                  });
                },
              ),
              CertificatesForm(
                certificates: _editableData!.certificates,
                onChanged: (updatedCertificates) {
                  setState(() {
                    _editableData = _editableData!.copyWith(certificates: updatedCertificates);
                  });
                },
              ),
            ],
          ),
        );
      },
    );
  }
}