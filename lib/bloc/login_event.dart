part of 'login_bloc.dart';

sealed class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}
class PerformLogin extends LoginEvent{
final String email;
  final String password;

  PerformLogin({required this.email,required this.password});

 
}

class RegisterEvent extends LoginEvent{
final String email;
  final String password;
  RegisterEvent({required this.email,required this.password});

}

class LogOutEvent extends LoginEvent{

}