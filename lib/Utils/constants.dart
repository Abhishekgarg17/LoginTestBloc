const String patternEmail =
    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
RegExp regexEmail = RegExp(patternEmail);

String patternMobile = r'^[6-9]\d{9}$';
RegExp regexMobile = RegExp(patternMobile);
