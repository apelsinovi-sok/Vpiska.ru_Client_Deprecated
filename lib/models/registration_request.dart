class RegisterRequest {
  String? phoneNumber;
  String? password;

  RegisterRequest(this.phoneNumber, this.password);

  RegisterRequest.fromJson(Map<String, dynamic> json) {
    phoneNumber = json['number_phone'];
    password = json['password'];
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['number_phone'] = phoneNumber;
    data['password'] = password;
    return data;
  }
}