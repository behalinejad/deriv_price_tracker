class TicksRm {
  TicksRm({
    required this.echoReq,
    required this.msgType,
    required this.error,
    required this.subscription,
    required this.tick,
  });
   EchoReq? echoReq;
   String? msgType;
   Error? error;
   Subscription? subscription;
   Tick? tick;

  TicksRm.fromJson(Map<String, dynamic> json){
    echoReq = json['echo_req'] != null ? EchoReq.fromJson(json['echo_req']) : null;
    msgType = json['msg_type'] ;
    error  = json['error'] != null ? Error.fromJson(json['error']) : null;
    subscription = json['subscription']!= null ?  Subscription.fromJson(json['subscription']) : null;
    tick = json['tick']  != null ? Tick.fromJson(json['tick']  ) : null;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['echo_req'] = echoReq?.toJson();
    _data['msg_type'] = msgType;
    _data['subscription'] = subscription?.toJson();
    _data['tick'] = tick?.toJson();
    return _data;
  }
}

class EchoReq {
  EchoReq({
    required this.subscribe,
    required this.ticks,
  });
   int? subscribe;
   String? ticks;

  EchoReq.fromJson(Map<String, dynamic> json){
    subscribe = json['subscribe'];
    ticks = json['ticks'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['subscribe'] = subscribe;
    _data['ticks'] = ticks;
    return _data;
  }
}

class Subscription {
  Subscription({
    required this.id,
  });
   String? id;

  Subscription.fromJson(Map<String, dynamic> json){
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    return _data;
  }
}

class Tick {
  Tick({
    required this.ask,
    required this.bid,
    required this.epoch,
    required this.id,
    required this.pipSize,
    required this.quote,
    required this.symbol,
  });
   double? ask;
   double? bid;
   int? epoch;
   String? id;
   int? pipSize;
   double? quote;
   String? symbol;

  Tick.fromJson(Map<String, dynamic> json){

    ask = json['ask'] != null ? double.parse(json['ask'].toString()) : null ;
    bid = json['bid'] != null ? double.parse(json['bid'].toString()) : null ;
    epoch = json['epoch'];
    id = json['id'];
    pipSize = json['pip_size'];
    quote = json['quote'] != null ? double.parse(json['quote'].toString()) : null ;
    symbol = json['symbol'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['ask'] = ask;
    _data['bid'] = bid;
    _data['epoch'] = epoch;
    _data['id'] = id;
    _data['pip_size'] = pipSize;
    _data['quote'] = quote;
    _data['symbol'] = symbol;
    return _data;
  }

}
class Error {
  Error({
    required this.code,
    required this.message,
  });
  late final String code;
  late final String message;

  Error.fromJson(Map<String, dynamic> json){
    code = json['code'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['code'] = code;
    _data['message'] = message;
    return _data;
  }
}