import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tareas/utils/formatters/formatter.dart';

class UserModel {
  final String id;
  String firstName;
  String lastName;
  String username;
  String email;
  String github;
  String phoneNumber;
  String? gender;
  String? birthdate;
  String profilePicture;

  // Constructor
  UserModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.username,
    required this.email,
    required this.github,
    required this.phoneNumber,
    this.gender,
    this.birthdate,
    required this.profilePicture,
  });

  /// Helper function to get the full name
  String get fullName => '$firstName $lastName';

  /// Helper function to format phone number.
  String get formattedPhoneNo => TFormatter.formatPhoneNumber(phoneNumber);

  /// Static function to split full name into first and last name.
  static List<String> nameParts(fullName) => fullName.split(" ");

  // Static function to generate a username from the full name
  static String generateUsername(String fullName) {
    List<String> nameParts = fullName.split(" ");
    String firstName = nameParts.isNotEmpty ? nameParts[0].toLowerCase() : "";
    String lastName = nameParts.length > 1 ? nameParts[1].toLowerCase() : "";

    String camelCaseUsername = "$firstName$lastName";
    String usernameWithPrefix = "cwt_$camelCaseUsername";
    return usernameWithPrefix;
  }

  static UserModel empty() => UserModel(
      id: '',
      firstName: '',
      lastName: '',
      username: '',
      email: '',
      phoneNumber: '',
      gender: '',
      birthdate: '',
      github: '',
      profilePicture: '');

  // Método para convertir un UserModel en un Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'FirstName': firstName,
      'LastName': lastName,
      'Username': username,
      'Email': email,
      'GitHub': github,
      'PhoneNumber': phoneNumber,
      'Gender': gender,
      'Birthdate': birthdate,
      'ProfilePicture': profilePicture,
    };
  }

  // Método para crear un UserModel a partir de un Map
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'],
      firstName: map['FirstName'],
      lastName: map['LastName'],
      username: map['Username'],
      email: map['Email'],
      github: map['GitHub'],
      phoneNumber: map['PhoneNumber'],
      gender: map['Gender'],
      birthdate: map['Birthdate'],
      profilePicture: map['ProfilePicture'],
    );
  }

  // Método para convertir un UserModel en un JSON
  Map<String, dynamic> toJson() {
    return {
      'FirstName': firstName,
      'LastName': lastName,
      'Username': username,
      'Email': email,
      'GitHub': github,
      'PhoneNumber': phoneNumber,
      'Gender': gender,
      'Birthdate': birthdate,
      'ProfilePicture': profilePicture,
    };
  }

  // Método para crear un UserModel a partir de un DocumentSnapshot
  factory UserModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data()!;
      return UserModel(
        id: document.id,
        firstName: data['FirstName'] ?? '',
        lastName: data['LastName'] ?? '',
        username: data['Username'] ?? '',
        email: data['Email'] ?? '',
        github: data['GitHub'] ?? '',
        phoneNumber: data['PhoneNumber'] ?? '',
        gender: data['Gender'] ?? '',
        birthdate: data['Birthdate'] ?? '',
        profilePicture: data['ProfilePicture'] ?? '',
      );
    }
    return empty();
  }

  // Método para crear un UserModel a partir de un JSON
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      firstName: json['FirstName'],
      lastName: json['LastName'],
      username: json['Username'],
      email: json['Email'],
      github: json['GitHub'],
      phoneNumber: json['PhoneNumber'],
      gender: json['Gender'],
      birthdate: json['Birthdate'],
      profilePicture: json['ProfilePicture'],
    );
  }
}
