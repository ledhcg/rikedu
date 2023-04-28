

class SignUpFailure {
  final String message;
  const SignUpFailure([this.message = "An Unknown error occurred."]);

  factory SignUpFailure.code(String code) {
    switch(code){
      case 'weak-password': return const SignUpFailure('Please enter a stronger password');
      case 'invalid-email': return const SignUpFailure('Please enter a valid email address');
      case 'email-already-in-use': return const SignUpFailure('This email is already in use');
      case 'operation-not-allowed': return const SignUpFailure('Operation not allowed. Please try again later');
      case 'user-disabled': return const SignUpFailure('This user account has been disabled');
      default: return const SignUpFailure();
    }
  }
}