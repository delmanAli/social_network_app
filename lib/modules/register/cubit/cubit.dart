import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_network_app/models/user_modal.dart';
import 'package:social_network_app/modules/register/cubit/states.dart';

class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit() : super(RegisterInitialStates());

  static RegisterCubit get(context) => BlocProvider.of(context);

  void userRegister({
    @required String name,
    @required String email,
    @required String password,
    @required String phone,
  }) async {
    emit(RegisterLoadingStates());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(
      email: email,
      password: password,
    )
        .then((value) {
      // print(value.user.email);
      // print(value.user.uid);
      userCreating(
        name: name,
        email: email,
        phone: phone,
        uid: value.user.uid,
      );
      // emit(RegisterSuccessStates());
    }).catchError((e) {
      emit(RegisterErrorStates(e.toString()));
    });
  }

  void userCreating({
    @required String name,
    @required String email,
    @required String phone,
    @required String uid,
  }) {
    UserModels userModel = UserModels(
      uid: uid,
      name: name,
      email: email,
      phone: phone,
      bio: 'write your bio here',
      cover:
          'https://image.freepik.com/free-vector/man-shows-gesture-great-idea_10045-637.jpg',
      image:
          'https://image.freepik.com/free-vector/man-shows-gesture-great-idea_10045-637.jpg',
      isEmailVerified: false,
    );
    FirebaseFirestore.instance
        .collection('user')
        .doc(uid)
        .set(userModel.toMap())
        .then((value) {
      emit(RegisterCreateUserSuccessStates());
    }).catchError((e) {
      emit(RegisterCreateUserErrorStates(e.toString()));
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

    emit(RegisterChangePasswordStates());
  }
}
