import 'package:basic_utils/basic_utils.dart';
import 'package:domain/styles.dart';
import 'package:flutter/material.dart';

class CertificateInformation extends StatelessWidget {
  final X509CertificateData e;
  const CertificateInformation({super.key, required this.e});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: ThemeStyles.width,
          padding: const EdgeInsets.all(12),
          margin: const EdgeInsets.fromLTRB(16, 16, 16, 0),
          decoration: BoxDecoration(
            color: ThemeStyles.theme.background200,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Column(
            children: [
              Text(
                "Subject Details",
                style: ThemeStyles.regularHeading,
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Name",
                    style: ThemeStyles.regularParagraph,
                  ),
                  Text(
                    e.tbsCertificate!.subject.values.elementAt(5).toString(),
                    style: ThemeStyles.regularParagraphOv(
                      color: ThemeStyles.theme.primary300,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Organization Unit",
                    style: ThemeStyles.regularParagraph,
                  ),
                  Text(
                    e.tbsCertificate!.subject.values.elementAt(4).toString(),
                    style: ThemeStyles.regularParagraphOv(
                      color: ThemeStyles.theme.primary300,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Organization",
                    style: ThemeStyles.regularParagraph,
                  ),
                  Text(
                    e.tbsCertificate!.subject.values.elementAt(3).toString(),
                    style: ThemeStyles.regularParagraphOv(
                      color: ThemeStyles.theme.primary300,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Region",
                    style: ThemeStyles.regularParagraph,
                  ),
                  Text(
                    e.tbsCertificate!.subject.values.elementAt(2).toString(),
                    style: ThemeStyles.regularParagraphOv(
                      color: ThemeStyles.theme.primary300,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Country",
                    style: ThemeStyles.regularParagraph,
                  ),
                  Text(
                    e.tbsCertificate!.subject.values.elementAt(0).toString(),
                    style: ThemeStyles.regularParagraphOv(
                      color: ThemeStyles.theme.primary300,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Container(
          width: ThemeStyles.width,
          padding: const EdgeInsets.all(12),
          margin: const EdgeInsets.fromLTRB(16, 16, 16, 0),
          decoration: BoxDecoration(
            color: ThemeStyles.theme.background200,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Column(
            children: [
              Text(
                "Issuer Details",
                style: ThemeStyles.regularHeading,
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Name",
                    style: ThemeStyles.regularParagraph,
                  ),
                  Text(
                    e.tbsCertificate!.issuer.values.elementAt(5).toString(),
                    style: ThemeStyles.regularParagraphOv(
                      color: ThemeStyles.theme.primary300,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Organization Unit",
                    style: ThemeStyles.regularParagraph,
                  ),
                  Text(
                    e.tbsCertificate!.issuer.values.elementAt(4).toString(),
                    style: ThemeStyles.regularParagraphOv(
                      color: ThemeStyles.theme.primary300,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Organization",
                    style: ThemeStyles.regularParagraph,
                  ),
                  Text(
                    e.tbsCertificate!.issuer.values.elementAt(3).toString(),
                    style: ThemeStyles.regularParagraphOv(
                      color: ThemeStyles.theme.primary300,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Region",
                    style: ThemeStyles.regularParagraph,
                  ),
                  Text(
                    e.tbsCertificate!.issuer.values.elementAt(2).toString(),
                    style: ThemeStyles.regularParagraphOv(
                      color: ThemeStyles.theme.primary300,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Country",
                    style: ThemeStyles.regularParagraph,
                  ),
                  Text(
                    e.tbsCertificate!.issuer.values.elementAt(0).toString(),
                    style: ThemeStyles.regularParagraphOv(
                      color: ThemeStyles.theme.primary300,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Container(
          width: ThemeStyles.width,
          padding: const EdgeInsets.all(12),
          margin: const EdgeInsets.fromLTRB(16, 16, 16, 0),
          decoration: BoxDecoration(
            color: ThemeStyles.theme.background200,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Column(
            children: [
              Text(
                "Serial Number",
                style: ThemeStyles.regularHeading,
              ),
              const SizedBox(height: 16),
              Text(
                e.tbsCertificate!.serialNumber.toString(),
                style: ThemeStyles.regularParagraphOv(
                  color: ThemeStyles.theme.primary300,
                ),
              )
            ],
          ),
        ),
        Container(
          width: ThemeStyles.width,
          padding: const EdgeInsets.all(12),
          margin: const EdgeInsets.fromLTRB(16, 16, 16, 0),
          decoration: BoxDecoration(
            color: ThemeStyles.theme.background200,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Column(
            children: [
              Text(
                "Validity Period",
                style: ThemeStyles.regularHeading,
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Not Valid Before",
                    style: ThemeStyles.regularParagraph,
                  ),
                  Text(
                    "${e.tbsCertificate!.validity.notBefore.day}/${e.tbsCertificate!.validity.notBefore.month}/${e.tbsCertificate!.validity.notBefore.year} ${e.tbsCertificate!.validity.notBefore.hour}:${e.tbsCertificate!.validity.notBefore.minute}",
                    style: ThemeStyles.regularParagraphOv(
                      color: ThemeStyles.theme.primary300,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Not Valid After",
                    style: ThemeStyles.regularParagraph,
                  ),
                  Text(
                    "${e.tbsCertificate!.validity.notAfter.day}/${e.tbsCertificate!.validity.notAfter.month}/${e.tbsCertificate!.validity.notAfter.year} ${e.tbsCertificate!.validity.notAfter.hour}:${e.tbsCertificate!.validity.notAfter.minute}",
                    style: ThemeStyles.regularParagraphOv(
                      color: ThemeStyles.theme.primary300,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
        Container(
          width: ThemeStyles.width,
          padding: const EdgeInsets.all(12),
          margin: const EdgeInsets.fromLTRB(16, 16, 16, 0),
          decoration: BoxDecoration(
            color: ThemeStyles.theme.background200,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Column(
            children: [
              Text(
                "Public Key Information",
                style: ThemeStyles.regularHeading,
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Algorithm",
                    style: ThemeStyles.regularParagraph,
                  ),
                  Text(
                    e.tbsCertificate!.subjectPublicKeyInfo.algorithmReadableName
                        .toString(),
                    style: ThemeStyles.regularParagraphOv(
                      color: ThemeStyles.theme.primary300,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Parameter",
                    style: ThemeStyles.regularParagraph,
                  ),
                  Text(
                    e.tbsCertificate!.subjectPublicKeyInfo.parameter ?? "none",
                    style: ThemeStyles.regularParagraphOv(
                      color: ThemeStyles.theme.primary300,
                    ),
                  )
                ],
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Size",
                    style: ThemeStyles.regularParagraph,
                  ),
                  Text(
                    e.tbsCertificate!.subjectPublicKeyInfo.length.toString(),
                    style: ThemeStyles.regularParagraphOv(
                      color: ThemeStyles.theme.primary300,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Text(
                "Key Data",
                style: ThemeStyles.regularParagraph,
              ),
              Divider(
                thickness: 1,
                color: ThemeStyles.theme.primary300,
              ),
              Text(
                e.tbsCertificate!.subjectPublicKeyInfo.bytes ?? "",
                style: ThemeStyles.regularParagraphOv(
                  color: ThemeStyles.theme.primary300,
                ),
              ),
            ],
          ),
        ),
        Container(
          width: ThemeStyles.width,
          padding: const EdgeInsets.all(12),
          margin: const EdgeInsets.fromLTRB(16, 16, 16, 0),
          decoration: BoxDecoration(
            color: ThemeStyles.theme.background200,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Column(
            children: [
              Text(
                "Version",
                style: ThemeStyles.regularHeading,
              ),
              Text(
                e.tbsCertificate!.version.toString(),
                style: ThemeStyles.regularParagraphOv(
                  color: ThemeStyles.theme.primary300,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
