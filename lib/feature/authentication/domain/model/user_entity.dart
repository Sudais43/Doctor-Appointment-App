class UserEntity {
  final String fullName;
  final String email;
  final String password;
  final String? phoneNumber;
  final String? dateOfBirth;

  const UserEntity({
    required this.fullName,
    required this.email,
    required this.password,
    this.phoneNumber,
    this.dateOfBirth,
  });
}
