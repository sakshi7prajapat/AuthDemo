part of 'login_bloc.dart';

sealed class LoginState extends Equatable {
  const LoginState();
   
  @override
  List<Object> get props => [];
 
}

 class LoginInitial extends LoginState {
 @override
  List<Object> get props => [];
}

class LoginLoading extends LoginState {
 @override
  List<Object> get props => [];
}

class LoginSuccess extends LoginState {
 @override
  List<Object> get props => [];
}

class LoginError extends LoginState {
  final String error;

  LoginError(this.error);
 @override
  List<Object> get props => [error];
}
