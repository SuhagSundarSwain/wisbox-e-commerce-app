///
/// Created by Sunil Kumar from Boiler plate
///
mixin Environment {
  static const String environment =
      String.fromEnvironment("env", defaultValue: 'dev');

  static const String baseApiUrl = environment == 'prod'
      ? 'https://api.live.aplus.smarttersstudio.in'
      : 'https://api.aplus.smarttersstudio.in';

  static const googleClientId = environment == 'prod' ? '' : '';

  static const fontFamily = 'Roboto';
}
