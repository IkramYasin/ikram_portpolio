import 'package:flutter/material.dart';
import 'package:ikram_portpolio/models/portfolio_data.dart';

class TrainingForm extends StatefulWidget {
  final List<Training> training;
  final ValueChanged<List<Training>> onChanged;

  const TrainingForm({super.key, required this.training, required this.onChanged});

  @override
  State<TrainingForm> createState() => _TrainingFormState();
}

class _TrainingFormState extends State<TrainingForm> {
  late List<Training> _training;

  @override
  void initState() {
    super.initState();
    _training = widget.training.map((t) => Training(name: t.name, institution: t.institution, year: t.year)).toList();
  }

  void _addTraining() {
    setState(() {
      _training.add(Training(name: '', institution: ''));
    });
    widget.onChanged(_training);
  }

  void _removeTraining(int index) {
    setState(() {
      _training.removeAt(index);
    });
    widget.onChanged(_training);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: _training.length,
            itemBuilder: (context, index) {
              final trainingItem = _training[index];
              return Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      initialValue: trainingItem.name,
                      decoration: const InputDecoration(labelText: 'Training Name'),
                      onChanged: (value) {
                        trainingItem.name = value;
                        widget.onChanged(_training);
                      },
                    ),
                  ),
                  Expanded(
                    child: TextFormField(
                      initialValue: trainingItem.institution,
                      decoration: const InputDecoration(labelText: 'Institution'),
                      onChanged: (value) {
                        trainingItem.institution = value;
                        widget.onChanged(_training);
                      },
                    ),
                  ),
                  Expanded(
                    child: TextFormField(
                      initialValue: trainingItem.year,
                      decoration: const InputDecoration(labelText: 'Year'),
                      onChanged: (value) {
                        trainingItem.year = value;
                        widget.onChanged(_training);
                      },
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.remove_circle_outline),
                    onPressed: () => _removeTraining(index),
                  ),
                ],
              );
            },
          ),
        ),
        const SizedBox(height: 16),
        ElevatedButton.icon(
          onPressed: _addTraining,
          icon: const Icon(Icons.add),
          label: const Text('Add Training'),
        ),
      ],
    );
  }
}