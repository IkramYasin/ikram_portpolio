import 'package:flutter/material.dart';
import 'package:ikram_portpolio/models/portfolio_data.dart';

class CertificatesForm extends StatelessWidget {
  final List<Certificate> certificates;

  const CertificatesForm({super.key, required this.certificates});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: certificates.length,
      itemBuilder: (context, index) {
        return Column(
          children: [
            TextFormField(
              initialValue: certificates[index].name,
              decoration: InputDecoration(labelText: 'Certificate Name'),
            ),
            TextFormField(
              initialValue: certificates[index].institution,
              decoration: InputDecoration(labelText: 'Institution'),
            ),
            TextFormField(
              initialValue: certificates[index].year,
              decoration: InputDecoration(labelText: 'Year'),
            ),
            TextFormField(
              initialValue: certificates[index].url,
              decoration: InputDecoration(labelText: 'URL'),
            ),
          ],
        );
      },
    );
  }
}