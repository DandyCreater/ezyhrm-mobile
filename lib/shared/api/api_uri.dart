import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiUri {
  static final baseUrl = dotenv.env['API_URL'].toString();
  static final baseEndpoint =
      dotenv.env['API_URL'].toString().replaceAll('/api', '');
}
