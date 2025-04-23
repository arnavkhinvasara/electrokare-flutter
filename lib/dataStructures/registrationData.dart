import "../utils/password_utils.dart";

class RegistrationData {
  String email;
  String password;
  String firstName;
  String lastName;
  int age;
  String gender;
  double weight;
  double height;
  String defaultUnit;
  List<String> exercisePreferences;
  String drinkPreference;
  List<String> permissions;

  RegistrationData({
    this.email = '',
    this.password = '',
    this.firstName = '',
    this.lastName = '',
    this.age = 0,
    this.gender = '',
    this.weight = 0,
    this.height = 0,
    this.defaultUnit = '',
    this.exercisePreferences = const [],
    this.drinkPreference = '',
    this.permissions = const [],
  });

  toJson() {
    return {
      'email': email,
      'password': PasswordUtils.encryptPassword(password),
      'firstName': firstName,
      'lastName': lastName,
      'age': age,
      'gender': gender,
      'weight': weight,
      'height': height,
      'defaultUnit': defaultUnit,
      'exercisePreferences': exercisePreferences,
      'drinkPreference': drinkPreference,
      'permissions': permissions,
    };
  }
}

class LoginData {
  String email;
  String password;

  LoginData({required this.email, required this.password});
}
