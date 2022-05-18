class Validations {

  String validateName(String value) {
    if (value.isEmpty) return 'Name is required!!!';
    return null;
  }



  String validateField(String value) {
    if (value.isEmpty) return 'Field is required!!!';
    return null;
  }

  String validatePassword(String value) {
    if (value.isEmpty) return 'Password is required!!!';
    if (value.length <=5)
      return 'Minimum 6 characters needed !!!';
    else
      return null;

  }

  String validateEmail(String value) {
    if(value.isEmpty) return "Email is required !!!";
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    if (!regex.hasMatch(value))
      return 'please Enter Valid Email !!!';
    else
      return null;
  }

  String validateMobile(String value) {
    if (value.isEmpty) return 'Mobile Number is required!!!';
    if (value.length != 10)
      return 'Mobile Number must be of 10 digit !!!';
    else
      return null;
  }

  String validateOtp(String value) {
    if (value.isEmpty) return 'OTP is required!!!';
    if (value.length != 5)
      return 'OTP must be of 5 digit !!!';
    else
      return null;
  }

}
