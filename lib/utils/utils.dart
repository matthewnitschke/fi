import 'package:uuid/uuid.dart';
import 'package:uuid/uuid_util.dart';

const _uuidGenerator = Uuid();
String newUuid() => _uuidGenerator.v4(options: {'rng': UuidUtil.cryptoRNG}).toString();