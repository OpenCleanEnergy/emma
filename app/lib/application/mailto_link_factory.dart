import 'package:mailto/mailto.dart';

abstract final class MailtoLinkFactory {
  // https://www.rfc-editor.org/rfc/rfc2368#section-5
  static const _lineBreak = '\r\n';

  static Uri createLink({required String subject, List<String>? bodyLines}) {
    final mailto = Mailto(
      to: ['service@opencleanenergy.org'],
      subject: subject,
      body: bodyLines?.join(_lineBreak),
    );

    return Uri.parse(mailto.toString());
  }
}
