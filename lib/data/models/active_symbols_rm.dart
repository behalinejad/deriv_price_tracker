class ActiveSymbolRm {
  ActiveSymbolRm({
    required this.activeSymbols,
    required this.echoReq,
    required this.msgType,
    required this.reqId,
  });
    List<ActiveSymbols>? activeSymbols;
    EchoReq? echoReq;
    String? msgType;
    int? reqId;

  ActiveSymbolRm.fromJson(Map<String, dynamic> json){
    activeSymbols = List.from(json['active_symbols']).map((e)=>ActiveSymbols.fromJson(e)).toList();
    echoReq = EchoReq.fromJson(json['echo_req']);
    msgType = json['msg_type'];
    reqId = json['req_id'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['active_symbols'] = activeSymbols?.map((e)=>e.toJson()).toList();
    _data['echo_req'] = echoReq?.toJson();
    _data['msg_type'] = msgType;
    _data['req_id'] = reqId;
    return _data;
  }
}

class ActiveSymbols {
  ActiveSymbols({
    required this.allowForwardStarting,
    required this.displayName,
    required this.displayOrder,
    required this.exchangeIsOpen,
    required this.isTradingSuspended,
    required this.market,
    required this.marketDisplayName,
    required this.pip,
    required this.subgroup,
    required this.subgroupDisplayName,
    required this.submarket,
    required this.submarketDisplayName,
    required this.symbol,
    required this.symbolType,
  });
   int? allowForwardStarting;
   String? displayName;
   int? displayOrder;
   int? exchangeIsOpen;
   int? isTradingSuspended;
   String? market;
   String? marketDisplayName;
   double? pip;
   String? subgroup;
   String? subgroupDisplayName;
   String? submarket;
   String? submarketDisplayName;
   String? symbol;
   String? symbolType;

  ActiveSymbols.fromJson(Map<String, dynamic> json){
    allowForwardStarting = json['allow_forward_starting'];
    displayName = json['display_name'];
    displayOrder = json['display_order'];
    exchangeIsOpen = json['exchange_is_open'];
    isTradingSuspended = json['is_trading_suspended'];
    market = json['market'];
    marketDisplayName = json['market_display_name'];
    pip = json['pip'];
    subgroup = json['subgroup'];
    subgroupDisplayName = json['subgroup_display_name'];
    submarket = json['submarket'];
    submarketDisplayName = json['submarket_display_name'];
    symbol = json['symbol'];
    symbolType = json['symbol_type'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['allow_forward_starting'] = allowForwardStarting;
    _data['display_name'] = displayName;
    _data['display_order'] = displayOrder;
    _data['exchange_is_open'] = exchangeIsOpen;
    _data['is_trading_suspended'] = isTradingSuspended;
    _data['market'] = market;
    _data['market_display_name'] = marketDisplayName;
    _data['pip'] = pip;
    _data['subgroup'] = subgroup;
    _data['subgroup_display_name'] = subgroupDisplayName;
    _data['submarket'] = submarket;
    _data['submarket_display_name'] = submarketDisplayName;
    _data['symbol'] = symbol;
    _data['symbol_type'] = symbolType;
    return _data;
  }
}

class EchoReq {
  EchoReq({
    required this.activeSymbols,
    required this.productType,
    required this.reqId,
  });
   String? activeSymbols;
   String? productType;
   int? reqId;

  EchoReq.fromJson(Map<String, dynamic> json){
    activeSymbols = json['active_symbols'];
    productType = json['product_type'];
    reqId = json['req_id'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['active_symbols'] = activeSymbols;
    _data['product_type'] = productType;
    _data['req_id'] = reqId;
    return _data;
  }
}