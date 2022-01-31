import '../utils/configuration.dart';

class LocalDataRepository {
  const LocalDataRepository({required Configuration configuration})
      : _configuration = configuration;

  final Configuration _configuration;
}
