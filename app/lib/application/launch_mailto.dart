import 'package:mailto/mailto.dart';
import 'package:url_launcher/url_launcher.dart';

Future<bool> launchMailto(
    {required String subject, List<String>? bodyLines}) async {
  final uri = _createLink(subject: subject, bodyLines: bodyLines);
  return await launchUrl(uri);
}

// https://www.rfc-editor.org/rfc/rfc2368#section-5
const _lineBreak = '\r\n';

Uri _createLink({required String subject, List<String>? bodyLines}) {
  final mailto = Mailto(
    to: ['info@opencleanenergy.org'],
    subject: 'EMMA | $subject',
    body: bodyLines?.join(_lineBreak),
  );

  return Uri.parse(mailto.toString());
}
