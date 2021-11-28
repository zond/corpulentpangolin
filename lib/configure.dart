import 'configure_non_html.dart' if (dart.library.html) 'configure_html.dart';

Future<void> configure() async {
  await configureConditional();
}
