abstract class LoginStates {}

class LoginInitialStates extends LoginStates {}

class LoginLoadingStates extends LoginStates {}

class LoginSuccessStates extends LoginStates {
  final String uid;

  LoginSuccessStates(this.uid);
}

class LoginErrorStates extends LoginStates {
  final String error;

  LoginErrorStates(this.error);
}

class LoginChangePasswordStates extends LoginStates {}
