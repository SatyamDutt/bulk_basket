class AppValidators {

  // ✅ Gmail only
  static String? gmail(String? value) {
    if (value == null || value.isEmpty) {
      return "Email is required";
    }

    final gmailRegex = RegExp(r'^[a-zA-Z0-9._%+-]+@gmail\.com$');

    if (!gmailRegex.hasMatch(value)) {
      return "Only Gmail addresses allowed";
    }

    return null;
  }

  // ✅ Indian Phone Number (10 digits, starts with 6-9)
  static String? indianPhone(String? value) {
    if (value == null || value.isEmpty) {
      return "Phone number is required";
    }

    final phoneRegex = RegExp(r'^[6-9]\d{9}$');

    if (!phoneRegex.hasMatch(value)) {
      return "Enter valid Indian phone number";
    }

    return null;
  }

  // ✅ Indian PIN Code (6 digits)
  static String? pinCode(String? value) {
    if (value == null || value.isEmpty) {
      return "PIN code is required";
    }

    final pinRegex = RegExp(r'^[1-9][0-9]{5}$');

    if (!pinRegex.hasMatch(value)) {
      return "Enter valid PIN code";
    }

    return null;
  }

  static String? password(String? value) {
  if (value == null || value.isEmpty) {
    return "Password is required";
  }

  if (value.length < 6) {
    return "Minimum 6 characters required";
  }

  final regex = RegExp(r'^(?=.*[A-Za-z])(?=.*\d).+$');

  if (!regex.hasMatch(value)) {
    return "Must include letters and numbers";
  }

  return null;
}

static String? name(String? value) {
  if (value == null || value.trim().isEmpty) {
    return "Name is required";
  }

  if (value.trim().length < 2) {
    return "Name must be at least 2 characters";
  }

  // Only letters and spaces
  final regex = RegExp(r'^[a-zA-Z ]+$');

  if (!regex.hasMatch(value)) {
    return "Only letters are allowed";
  }

  return null;
}

static String? address(String? value) {
  if (value == null || value.trim().isEmpty) {
    return "Please enter your full address (house no, area, landmark)";
  }

  if (value.trim().length < 10) {
    return "Enter a complete address with landmark or nearby location";
  }

  return null;
}

static String? houseNo(String? value) {
  if (value == null || value.trim().isEmpty) {
    return "House/Flat number is required";
  }

  if (value.trim().length < 2) {
    return "Enter a valid house/flat number";
  }

  return null;
}

static String? landmark(String? value) {
  if (value == null || value.trim().isEmpty) {
    return "Landmark is required";
  }

  if (value.trim().length < 3) {
    return "Enter a proper landmark";
  }

  return null;
}

static String? city(String? value) {
  if (value == null || value.trim().isEmpty) {
    return "City is required";
  }

  final regex = RegExp(r'^[a-zA-Z ]+$');

  if (!regex.hasMatch(value)) {
    return "Enter a valid city name";
  }

  return null;
}

static String? state(String? value) {
  if (value == null || value.trim().isEmpty) {
    return "State is required";
  }

  final regex = RegExp(r'^[a-zA-Z ]+$');

  if (!regex.hasMatch(value)) {
    return "Enter a valid state name";
  }

  return null;
}
}