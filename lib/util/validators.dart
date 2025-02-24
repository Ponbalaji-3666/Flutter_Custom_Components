class Validators{

  String? nonEmpty(String? value, String fieldName) {
    if (value!.isEmpty) {
      return "Please enter $fieldName";
    }
    return null;
  }

  String? email(String? value, String fieldName) {
    if (value!.isEmpty) {
      return "Please enter $fieldName";
    }
    final emailPattern = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    if (!emailPattern.hasMatch(value)) {
      return "Please enter a valid email";
    }
    return null;
  }

}