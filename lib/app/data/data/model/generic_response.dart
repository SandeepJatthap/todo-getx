class GenericResponse {
  GenericResponse({
    String? msg,
    num? status,
  }) {
    _msg = msg;
    _status = status;
  }

  GenericResponse.fromJson(dynamic json) {
    _msg = json['msg'];
    _status = json['status'];
  }

  String? _msg;
  num? _status;

  String? get msg => _msg;

  num? get status => _status;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['msg'] = _msg;
    map['status'] = _status;

    return map;
  }
}
