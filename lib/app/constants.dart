import 'package:naqaa/domain/entities/gender.dart';

class Constants {
  static const String appName = "Naqaa`";
  static const String appVersion = "0.1.0";

  static const String empty = "";

  static const Gender male = Gender(id: '1', name: 'male');
  static const Gender female = Gender(id: '2', name: 'female');
  static const List<Gender> genders = [male, female];
}
