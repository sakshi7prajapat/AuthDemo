import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<PerformLogin>((event, emit) async {
      emit(LoginLoading());
      try {
        UserCredential userCredential = await login(event.email, event.password);
        print("user");
       if(userCredential.user != null){
        print("user");
        emit(LoginSuccess());
       }
        
      } catch (e) {
        emit(LoginError(e.toString()));
      }
    });

    on<RegisterEvent>((event, emit) async {
      emit(LoginLoading());
      try {
       String result = await Register(email: event.email, password: event.password);
       if(result != null){
        emit(LoginSuccess());
       }
        
      } catch (e) {
        emit(LoginError(e.toString()));
      }
    });
  }

 Future login(email, password)  async 
 {
    try {
     UserCredential user = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
          return user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw Exception('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        throw Exception('Wrong password provided for that user.');
      }
      
    }catch (e) {
      throw Exception(e.toString());
    }
    
  }

  Future Register({required String email, required String password}) async {
    try {
     UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

          return userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw Exception('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        throw Exception('The account already exists for that email.');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
