
import 'mock_client_implementation.dart'
  if (dart.library.html) 'web_client_implementation.dart';

FiClient getClient() => FiClient();