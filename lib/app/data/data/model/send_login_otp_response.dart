class SendLoginOtpResponse {
  SendLoginOtpResponse({
    String? msg,
    num? status,
    VerificationData? data,
  }) {
    _msg = msg;
    _status = status;
    _data = data;
  }

  SendLoginOtpResponse.fromJson(dynamic json) {
    _msg = json['msg'];
    _status = json['status'];
    _data =
        json['data'] != null ? VerificationData.fromJson(json['data']) : null;
  }

  String? _msg;
  num? _status;
  VerificationData? _data;

  String? get msg => _msg;

  num? get status => _status;

  VerificationData? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['msg'] = _msg;
    map['status'] = _status;
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    return map;
  }
}

class VerificationData {
  VerificationData({
    num? verificationId,
  }) {
    _verificationId = verificationId;
  }

  VerificationData.fromJson(dynamic json) {
    _verificationId = json['verificationId'];
  }

  num? _verificationId;

  num? get verificationId => _verificationId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['verificationId'] = _verificationId;
    return map;
  }
}
