import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_network_app/modules/login/cubit/states.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginInitialStates());

  static LoginCubit get(context) => BlocProvider.of(context);

  userSignIn({
    @required email,
    @required password,
  }) async {
    emit(LoginLoadingStates());
    FirebaseAuth.instance
        .signInWithEmailAndPassword(
      email: email,
      password: password,
    )
        .then((value) {
      // print(value.user.email);
      // print(value.user.uid);
      emit(LoginSuccessStates(value.user.uid));
    }).catchError((error) {
      // print(error.toString());
      emit(LoginErrorStates(error.toString()));
    });
  }

  IconData suffix = Icons.visibility_outlined;
  bool isPasswordHidden = true;

  void changePasswordVisibility() {
    suffix = Icons.visibility_off_outlined;
    isPasswordHidden = !isPasswordHidden;
    suffix = isPasswordHidden
        ? Icons.visibility_outlined
        : Icons.visibility_off_outlined;

    emit(LoginChangePasswordStates());
  }
}
