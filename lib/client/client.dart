
import 'package:fi/client/client_interface.dart';

import 'ios_client_implementation.dart'
  if (dart.library.html) 'web_client_implementation.dart';

FiClientInterface getClient() => FiClient();