import 'package:form_validator/form_validator.dart';

final requiredValidator = ValidationBuilder(requiredMessage: 'Campo obbligatorio!').required().build();

final emailValidator = ValidationBuilder(requiredMessage: 'Campo obbligatorio!')
    .required()
    .regExp(
      RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$'),
      'Inserisci una email valida!',
    )
    .maxLength(50, 'Limite caratteri superato!')
    .build();

final passwordValidator = ValidationBuilder(requiredMessage: 'Campo obbligatorio!')
    .required()
    .regExp(
      RegExp("^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[@\$!%*?&])[A-Za-z\\d@\$!%*?&]{8,}\$"),
      'Inserisci una password robusta!',
    )
    .maxLength(50, 'Limite caratteri superato!')
    .build();

ValidationBuilder confirmPasswordValidator(String? password) {
  return ValidationBuilder(requiredMessage: 'Campo obblogatorio!')
      .required("Campo obbligatorio!")
      .add((value) => confirmPassword(password ?? '', value ?? ''));
}

String? confirmPassword(String password, String confirmPassword) {
  if (confirmPassword == '' || confirmPassword.isEmpty) {
    return 'Campo obbligatorio!';
  }
  if (confirmPassword != password) {
    return 'Le password non corrispondono!';
  }

  if (confirmPassword == password) {
    return null;
  }
  return null;
}
