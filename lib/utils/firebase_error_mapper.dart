class FirebaseErrorMapper {
  static String getMessage(String code) {
    switch (code) {

      // 🔐 LOGIN ERRORS
      case 'user-not-found':
        return "No account found with this email";

      case 'wrong-password':
        return "Incorrect password. Please try again";

      case 'invalid-email':
        return "Invalid email format";

      case 'user-disabled':
        return "This account has been disabled. Contact support";

      case 'too-many-requests':
        return "Too many attempts. Try again later";

      case 'operation-not-allowed':
        return "Login is currently disabled";

      case 'invalid-credential':
        // return "Invalid email or password";
        return "Incorrect login details. Please check your email and password and try again";

      case 'network-request-failed':
        return "No internet connection";

      // 📝 REGISTER ERRORS
      case 'email-already-in-use':
        return "This email is already registered";

      case 'weak-password':
        return "Password is too weak";

      // 🔁 GENERAL FALLBACK
      default:
        return "Something went wrong. Please try again";
    }
  }
}