import 'package:naqaa/domain/entities/gender.dart';

class Constants {
  static const String appName = 'Naqaa`';
  static const String appVersion = '0.1.0';
  static const String privacyPolicyUpdateDate = '2023/08/04';
  static const String termsOfUseUpdateDate = '2023/08/04';

  // DEVELOPERS CONTACTS
  static const String hussinGithubUrl = 'https://github.com/Aggir';
  static const String hussinLinkedinUrl =
      'https://www.linkedin.com/in/hussinsh/';
  static const String abdussalamGithubUrl = 'https://github.com/Tearfy';
  static const String abdussalamLinkedinUrl =
      'https://www.linkedin.com/in/abdulsalam-almajdoob/';

  static const String empty = "";

  static const Gender male = Gender(id: '1', name: 'male');
  static const Gender female = Gender(id: '2', name: 'female');
  static const List<Gender> genders = [male, female];
}
