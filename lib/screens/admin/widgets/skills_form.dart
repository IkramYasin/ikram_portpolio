import 'package:flutter/material.dart';
import 'package:ikram_portpolio/models/portfolio_data.dart';

class SkillsForm extends StatefulWidget {
  final List<Skill> skills;
  final ValueChanged<List<Skill>> onChanged;

  const SkillsForm({super.key, required this.skills, required this.onChanged});

  @override
  State<SkillsForm> createState() => _SkillsFormState();
}

class _SkillsFormState extends State<SkillsForm> {
  late List<Skill> _skills;

  @override
  void initState() {
    super.initState();
    _skills = widget.skills.map((s) => Skill(name: s.name, level: s.level)).toList();
  }

  void _addSkill() {
    setState(() {
      _skills.add(Skill(name: '', level: 0.0));
    });
    widget.onChanged(_skills);
  }

  void _removeSkill(int index) {
    setState(() {
      _skills.removeAt(index);
    });
    widget.onChanged(_skills);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: _skills.length,
            itemBuilder: (context, index) {
              final skill = _skills[index];
              return Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      initialValue: skill.name,
                      decoration: const InputDecoration(labelText: 'Skill Name'),
                      onChanged: (value) {
                        skill.name = value;
                        widget.onChanged(_skills);
                      },
                    ),
                  ),
                  Expanded(
                    child: TextFormField(
                      initialValue: skill.level.toString(),
                      decoration: const InputDecoration(labelText: 'Skill Level (0.0 - 1.0)'),
                      onChanged: (value) {
                        skill.level = double.tryParse(value) ?? 0.0;
                        widget.onChanged(_skills);
                      },
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.remove_circle_outline),
                    onPressed: () => _removeSkill(index),
                  ),
                ],
              );
            },
          ),
        ),
        const SizedBox(height: 16),
        ElevatedButton.icon(
          onPressed: _addSkill,
          icon: const Icon(Icons.add),
          label: const Text('Add Skill'),
        ),
      ],
    );
  }
}