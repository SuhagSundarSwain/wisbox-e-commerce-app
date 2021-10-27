import 'environment.dart';

///
/// Created by Sunil Kumar from Boiler plate
///
mixin ApiRoutes {
  static const baseUrl = Environment.baseApiUrl;
  static const v1 = 'v1';
  static const upload = '$v1/upload';

  // static const String geoCoderApi =
  //     'https://maps.googleapis.com/maps/api/geocode/json';

  static const String phoneAuthentication = "$v1/phone-authentication";
  static const String user = '$v1/users';
  static String authenticateJwt = 'authentication';

  static String studentClass = '$v1/class';
  static String studentSubject = '$v1/subject';

  static String transaction = '$v1/transaction';
  static String chapter = '$v1/chapter';
  static String questionSet = '$v1/question-set';
  static String question = '$v1/question';
  static String exam = '$v1/exam';
  static String studentExam = '$v1/student-exam';
  static String studentAnswer = '$v1/student-answer';
  static String favourite = '$v1/favourite';
  static String report = '$v1/report';
}
