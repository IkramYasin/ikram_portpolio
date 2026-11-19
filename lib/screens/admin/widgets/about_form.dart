import 'package:flutter/material.dart';
import 'package:ikram_portpolio/models/portfolio_data.dart';

class AboutForm extends StatelessWidget {
  final About about;

  const AboutForm({super.key, required this.about});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          initialValue: about.name,
          decoration: InputDecoration(labelText: 'Name'),
        ),
        TextFormField(
          initialValue: about.profession,
          decoration: InputDecoration(labelText: 'Profession'),
        ),
        TextFormField(
          initialValue: about.summary,
          decoration: InputDecoration(labelText: 'Summary'),
          maxLines: 5,
        ),
      ],
    );
  }
}