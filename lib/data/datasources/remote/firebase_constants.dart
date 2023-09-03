class FirebaseConstants {
  //  ################## Firestore ##################

  // ---------- Collections -----------
  static const String user = 'user';
  static const String device = 'device';
  static const String notification = 'notification';
  // ------------ Fields ---------------
  static const String name = 'name';
  static const String id = 'id';
  static const String createdAt = 'created_at';
  static const String updatedAt = 'updated_at';
  // Notification:
  static const String isRead = 'is_read';
  static const String deviceName = 'device_name';
  static const String deviceId = 'device_id';
  // User:
  static const String email = 'email';
  static const String dateOfBirth = 'dateOfBirth';
  static const String genderId = 'genderId';
  static const String isSignedInWithGoogle = 'isSignedInWithGoogle';
  static const String profilePictureUrl = 'profilePictureUrl';
  // Device:
  static const String userId = 'user_id';
  static const String waterQualityName = 'water_quality_name';
  static const String waterQualityHex = 'water_quality_hex';
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
