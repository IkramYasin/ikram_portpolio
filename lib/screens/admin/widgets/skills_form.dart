import 'package:flutter/material.dart';
import 'package:ikram_portpolio/models/portfolio_data.dart';

class SkillsForm extends StatelessWidget {
  final List<Skill> skills;

  const SkillsForm({super.key, required this.skills});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: skills.length,
      itemBuilder: (context, index) {
        return Row(
          children: [
            Expanded(
              child: TextFormField(
                initialValue: skills[index].name,
                decoration: InputDecoration(labelText: 'Skill Name'),
              ),
            ),
            Expanded(
              child: TextFormField(
                initialValue: skills[index].level.toString(),
                decoration: InputDecoration(labelText: 'Skill Level'),
              ),
            ),
          ],
        );
      },
    );
  }
}