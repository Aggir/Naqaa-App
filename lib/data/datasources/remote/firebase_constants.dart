class FirebaseConstants {
  // ############# Firebase Functions ##############
  static const String baseUrl =
      'https://europe-west1-naqaa-2023.cloudfunctions.net/expressFunction';
  static const String toggleIsRead = '/toggleIsSeen';
  static const String getStatistics = '/statistics';
  // ################## Firestore ##################

  // ---------- Collections -----------
  static const String user = 'user';
  static const String device = 'device';
  static const String notification = 'notification';
  static const String statistics = 'statistics';
  // ------------ Fields ---------------
  static const String name = 'name';
  static const String id = 'id';
  static const String createdAt = 'created_at';
  static const String updatedAt = 'updated_at';
  // Notification:
  static const String isRead = 'is_read';
  static const String isSeen = 'is_seen';
  static const String deviceName = 'device_name';
  static const String deviceId = 'device_id';
  // User:
  static const String email = 'email';
  static const String dateOfBirth = 'dateOfBirth';
  static const String genderId = 'genderId';
  static const String isSignedInWithGoogle = 'isSignedInWithGoogle';
  static const String profilePictureUrl = 'profilePictureUrl';
  static const String tokens = 'tokens';
  // Device:
  static const String userId = 'user_id';
  static const String waterQualityName = 'water_quality_name';
  static const String waterQualityHex = 'water_quality_hex';
  // Statistics:
  static const String statisticsDate = 'statistics_date';
  static const String tempHighest = 'temp_highest';
  static const String tempLowest = 'temp_lowest';
  static const String tempAverage = 'temp_average';
  static const String tdsHighest = 'tds_highest';
  static const String tdsLowest = 'tds_lowest';
  static const String tdsAverage = 'tds_average';
  static const String phHighest = 'ph_highest';
  static const String phLowest = 'ph_lowest';
  static const String phAverage = 'ph_average';
  static const String waterQuality = 'water_quality';
  // ################## Firestroage ##################
  static const String profilePictures = 'profilePictures';

  // ############### Realtime-database ###############

  // ------------ Fields ---------------
  static const String phValue = 'ph_value';
  static const String phMin = 'ph_min';
  static const String phMax = 'ph_max';
  static const String tdsValue = 'tds_value';
  static const String tdsMin = 'tds_min';
  static const String tdsMax = 'tds_max';
  static const String tempValue = 'temp_value';
  static const String tempMin = 'temp_min';
  static const String tempMax = 'temp_max';
}
