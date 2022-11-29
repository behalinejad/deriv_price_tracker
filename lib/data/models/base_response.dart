import 'package:deriv_price_tracker/utils/constants/enums.dart';

class BaseState {
  BaseState({this.responseModel,this.state,this.priceChangeState});

  dynamic responseModel ;
  WebSocketState? state;
  PriceChangeState? priceChangeState;

}