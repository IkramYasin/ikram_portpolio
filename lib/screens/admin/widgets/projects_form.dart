import 'package:material_ui/material_ui.dart';
import 'package:ikram_portpolio/models/portfolio_data.dart';

class ProjectsForm extends StatelessWidget {
  final List<Project> projects;

  const ProjectsForm({super.key, required this.projects});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: projects.length,
      itemBuilder: (context, index) {
        return Column(
          children: [
            TextFormField(
              initialValue: projects[index].name,
              decoration: InputDecoration(labelText: 'Project Name'),
            ),
            TextFormField(
              initialValue: projects[index].description,
              decoration: InputDecoration(labelText: 'Project Description'),
              maxLines: 3,
            ),
            TextFormField(
              initialValue: projects[index].url,
              decoration: InputDecoration(labelText: 'Project URL'),
            ),
          ],
        );
      },
    );
  }
}