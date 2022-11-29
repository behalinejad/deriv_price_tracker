class ForgetRm {
  ForgetRm({
    required this.echoReq,
    required this.forget,
    required this.msgType,
    required this.reqId,
  });
   EchoReq? echoReq;
   int? forget;
   String? msgType;
   int? reqId;

  ForgetRm.fromJson(Map<String, dynamic> json){
    echoReq = EchoReq.fromJson(json['echo_req']);
    forget = json['forget'];
    msgType = json['msg_type'];
    reqId = json['req_id'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['echo_req'] = echoReq?.toJson();
    _data['forget'] = forget;
    _data['msg_type'] = msgType;
    _data['req_id'] = reqId;
    return _data;
  }
}

class EchoReq {
  EchoReq({
    required this.forget,
    required this.reqId,
  });
   String? forget;
   int? reqId;

  EchoReq.fromJson(Map<String, dynamic> json){
    forget = json['forget'];
    reqId = json['req_id'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['forget'] = forget;
    _data['req_id'] = reqId;
    return _data;
  }
}