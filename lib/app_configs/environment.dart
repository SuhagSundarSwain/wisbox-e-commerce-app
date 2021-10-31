///
/// Created by Sunil Kumar from Boiler plate
///
mixin Environment {
  static const String environment =
      String.fromEnvironment("env", defaultValue: 'dev');

  static const String baseApiUrl = environment == 'prod'
      ? 'https://api.live.aplus.smarttersstudio.in'
      : 'https://api.aplus.smarttersstudio.in';

  static const googleClientId = environment == 'prod'
      ? '695067116129-0jc3p66l2f1p9u8rk1mrqi22mf9pbcdd.apps.googleusercontent.com'
      : '695067116129-0jc3p66l2f1p9u8rk1mrqi22mf9pbcdd.apps.googleusercontent.com';

  static const fontFamily = 'Roboto';

  static const mapBoxApiKey =
      "pk.eyJ1Ijoia3VtYXJzdW5pbDE3IiwiYSI6ImNrdmJ5c29kbjBidjUyeG1weXdtM3d0ejEifQ.BGk48tOeD49apF1THADCuw";
}
