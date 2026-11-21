import 'package:flutter/material.dart';
import 'package:ikram_portpolio/models/portfolio_data.dart';

class ProjectsForm extends StatefulWidget {
  final List<Project> projects;
  final ValueChanged<List<Project>> onProjectsChanged;

  const ProjectsForm({
    super.key,
    required this.projects,
    required this.onProjectsChanged,
  });

  @override
  State<ProjectsForm> createState() => _ProjectsFormState();
}

class _ProjectsFormState extends State<ProjectsForm> {
  late List<Project> _projects;

  @override
  void initState() {
    super.initState();
    _projects = widget.projects.map((p) => Project(name: p.name, description: p.description, url: p.url)).toList();
  }

  void _addProject() {
    setState(() {
      _projects.add(Project(name: '', description: '', url: ''));
    });
    widget.onProjectsChanged(_projects);
  }

  void _removeProject(int index) {
    setState(() {
      _projects.removeAt(index);
    });
    widget.onProjectsChanged(_projects);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: _projects.length,
            itemBuilder: (context, index) {
              final project = _projects[index];
              return Card(
                margin: const EdgeInsets.all(8.0),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      TextFormField(
                        initialValue: project.name,
                        decoration: const InputDecoration(labelText: 'Project Name'),
                        onChanged: (value) {
                          project.name = value;
                          widget.onProjectsChanged(_projects);
                        },
                      ),
                      TextFormField(
                        initialValue: project.description,
                        decoration: const InputDecoration(labelText: 'Project Description'),
                        maxLines: 3,
                        onChanged: (value) {
                          project.description = value;
                          widget.onProjectsChanged(_projects);
                        },
                      ),
                      TextFormField(
                        initialValue: project.url,
                        decoration: const InputDecoration(labelText: 'Project URL'),
                        onChanged: (value) {
                          project.url = value;
                          widget.onProjectsChanged(_projects);
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () => _removeProject(index),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        ElevatedButton(
          onPressed: _addProject,
          child: const Text('Add Project'),
        ),
      ],
    );
  }
}