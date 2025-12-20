import 'package:secure_email_viewer/app/app.dart';
import 'package:secure_email_viewer/bootstrap.dart';

Future<void> main() async {
  await bootstrap(() => const App());
}
