import 'package:flutter/material.dart';
import 'package:ikram_portpolio/models/portfolio_data.dart';

class CertificatesForm extends StatefulWidget {
  final List<Certificate> certificates;
  final ValueChanged<List<Certificate>> onChanged;

  const CertificatesForm({super.key, required this.certificates, required this.onChanged});

  @override
  State<CertificatesForm> createState() => _CertificatesFormState();
}

class _CertificatesFormState extends State<CertificatesForm> {
  late List<Certificate> _certificates;

  @override
  void initState() {
    super.initState();
    _certificates = widget.certificates.map((c) => Certificate(name: c.name, institution: c.institution, year: c.year, url: c.url)).toList();
  }

  void _addCertificate() {
    setState(() {
      _certificates.add(Certificate(name: '', institution: '', url: ''));
    });
    widget.onChanged(_certificates);
  }

  void _removeCertificate(int index) {
    setState(() {
      _certificates.removeAt(index);
    });
    widget.onChanged(_certificates);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: _certificates.length,
            itemBuilder: (context, index) {
              final certificate = _certificates[index];
              return Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      initialValue: certificate.name,
                      decoration: const InputDecoration(labelText: 'Certificate Name'),
                      onChanged: (value) {
                        certificate.name = value;
                        widget.onChanged(_certificates);
                      },
                    ),
                  ),
                  Expanded(
                    child: TextFormField(
                      initialValue: certificate.institution,
                      decoration: const InputDecoration(labelText: 'Institution'),
                      onChanged: (value) {
                        certificate.institution = value;
                        widget.onChanged(_certificates);
                      },
                    ),
                  ),
                  Expanded(
                    child: TextFormField(
                      initialValue: certificate.year,
                      decoration: const InputDecoration(labelText: 'Year'),
                      onChanged: (value) {
                        certificate.year = value;
                        widget.onChanged(_certificates);
                      },
                    ),
                  ),
                  Expanded(
                    child: TextFormField(
                      initialValue: certificate.url,
                      decoration: const InputDecoration(labelText: 'URL'),
                      onChanged: (value) {
                        certificate.url = value;
                        widget.onChanged(_certificates);
                      },
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.remove_circle_outline),
                    onPressed: () => _removeCertificate(index),
                  ),
                ],
              );
            },
          ),
        ),
        const SizedBox(height: 16),
        ElevatedButton.icon(
          onPressed: _addCertificate,
          icon: const Icon(Icons.add),
          label: const Text('Add Certificate'),
        ),
      ],
    );
  }
}