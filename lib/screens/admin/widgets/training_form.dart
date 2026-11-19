import 'package:flutter/material.dart';
import 'package:ikram_portpolio/models/portfolio_data.dart';

class TrainingForm extends StatelessWidget {
  final List<Training> training;

  const TrainingForm({super.key, required this.training});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: training.length,
      itemBuilder: (context, index) {
        return Column(
          children: [
            TextFormField(
              initialValue: training[index].name,
              decoration: InputDecoration(labelText: 'Training Name'),
            ),
            TextFormField(
              initialValue: training[index].institution,
              decoration: InputDecoration(labelText: 'Institution'),
            ),
            TextFormField(
              initialValue: training[index].year,
              decoration: InputDecoration(labelText: 'Year'),
            ),
          ],
        );
      },
    );
  }
}