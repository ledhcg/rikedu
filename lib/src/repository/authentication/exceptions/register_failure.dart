class RegisterFailure {
  final String message;
  const RegisterFailure([this.message = "An Unknown error occurred."]);

  factory RegisterFailure.code(String code) {
    switch (code) {
      case 'weak-password':
        return const RegisterFailure('Please enter a stronger password');
      case 'invalid-email':
        return const RegisterFailure('Please enter a valid email address');
      case 'email-already-in-use':
        return const RegisterFailure('This email is already in use');
      case 'operation-not-allowed':
        return const RegisterFailure(
            'Operation not allowed. Please try again later');
      case 'user-disabled':
        return const RegisterFailure('This user account has been disabled');
      default:
        return const RegisterFailure();
    }
  }
}
