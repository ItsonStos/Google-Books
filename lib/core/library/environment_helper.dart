
abstract class IEnvironmentHelper {
  String get urlBase;
  String get urlBookVolumes;
  String get keyAuthorization;
}

class EnvironmentHelper implements IEnvironmentHelper {
  @override
  String get urlBase => 'https://www.googleapis.com/books/v1';

  @override
  String get urlBookVolumes => '$urlBase/volumes';

  @override
  String get keyAuthorization => 'AIzaSyBTZGrjzjwa2CuYQz21Dc418TSeNym4aUY';
}
