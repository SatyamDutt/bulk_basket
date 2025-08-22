abstract class RegisterEvent {}

class RegisterButtonPresssed extends RegisterEvent {
  final String email;
  final String password;

  final String name;
  final String address;

  RegisterButtonPresssed(
      {required this.email,
      required this.password,
      required this.name,
      required this.address});
}
