class TokenModel {
  int? expiresIn;
  String? accessToken;

  TokenModel({this.expiresIn, this.accessToken});

  TokenModel.fromJson(Map<String, dynamic> json) {
    expiresIn = json['expiresIn'];
    accessToken = json['accessToken'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['expiresIn'] = this.expiresIn;
    data['accessToken'] = this.accessToken;
    return data;
  }
}
