class UserEntity {
  final String userName;
  final String email;
  final String password;
  final String? phoneNumber;
  final String? dateOfBirth;

  const UserEntity({
    required this.userName,
    required this.email,
    required this.password,
    this.phoneNumber,
    this.dateOfBirth,
  });
}
