import 'package:flutter/material.dart';
import 'package:ikram_portpolio/models/portfolio_data.dart';

class AboutForm extends StatefulWidget {
  final About about;
  final ValueChanged<About> onChanged;

  const AboutForm({super.key, required this.about, required this.onChanged});

  @override
  State<AboutForm> createState() => _AboutFormState();
}

class _AboutFormState extends State<AboutForm> {
  late About _about;

  @override
  void initState() {
    super.initState();
    _about = widget.about;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          initialValue: _about.name,
          decoration: const InputDecoration(labelText: 'Name'),
          onChanged: (value) {
            _about = About(name: value, profession: _about.profession, summary: _about.summary);
            widget.onChanged(_about);
          },
        ),
        TextFormField(
          initialValue: _about.profession,
          decoration: const InputDecoration(labelText: 'Profession'),
          onChanged: (value) {
            _about = About(name: _about.name, profession: value, summary: _about.summary);
            widget.onChanged(_about);
          },
        ),
        TextFormField(
          initialValue: _about.summary,
          decoration: const InputDecoration(labelText: 'Summary'),
          maxLines: 5,
          onChanged: (value) {
            _about = About(name: _about.name, profession: _about.profession, summary: value);
            widget.onChanged(_about);
          },
        ),
      ],
    );
  }
}