import 'dart:convert';
import 'package:deriv_price_tracker/data/models/base_response.dart';
import 'package:deriv_price_tracker/data/models/forget_rm.dart';
import 'package:deriv_price_tracker/utils/constants/enums.dart';
import 'package:deriv_price_tracker/utils/constants/urls.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import '../data/models/ticks_rm.dart';

class TicksCubit extends Cubit<BaseState> {
  TicksCubit() : super(BaseState());

  WebSocketChannel? _ticksChannel;
  WebSocketChannel? _forgetChannel;
  double currentPrice = 0;

  getPriceRequest({required String tickSymbols})  async {
    emit(BaseState(state: WebSocketState.loading));
    try {
       _ticksChannel = WebSocketChannel.connect(
        Uri.parse('${Urls.baseUrl}v3?app_id=${Urls.appId}'),
      );

      _ticksChannel?.sink.add(jsonEncode( {
        "ticks": tickSymbols,
        "subscribe": 1
      }));
      _ticksChannel?.stream.listen((event) {
      final ticks = TicksRm.fromJson(json.decode(event));
      if (ticks.error != null){
        emit(BaseState(
            responseModel: ticks,
            state: WebSocketState.error,));
      }else {
        PriceChangeState priceChangeState;
        double price = ticks.tick?.quote ?? 0;
        if (price > currentPrice) {
          priceChangeState = PriceChangeState.up;
        } else if (price < currentPrice) {
          priceChangeState = PriceChangeState.down;
        } else {
          priceChangeState = PriceChangeState.noChange;
        }
        currentPrice = price;
        emit(BaseState(responseModel: ticks,
            state: WebSocketState.loaded,
            priceChangeState: priceChangeState));
      }
      });
    } on WebSocketChannelException catch (e) {
      _ticksChannel?.sink.close();
      emit(BaseState(state: WebSocketState.error));
    }
  }
  @override
  Future<void> close() {
    _ticksChannel?.sink.close();
    return super.close();
  }

  /// To close channel and reset the state
  closeChannel (){
    if (state.responseModel != null){
      if ((state.responseModel as TicksRm).tick?.id != null) {
        forgetTicks(ticksId: (state.responseModel as TicksRm).tick!.id.toString());
      }
    }
    emit(BaseState());
    _ticksChannel?.sink.close();
    _forgetChannel?.sink.close();


  }
  forgetTicks({required String  ticksId }){
    try {
      _forgetChannel = WebSocketChannel.connect(
        Uri.parse('${Urls.baseUrl}v3?app_id=${Urls.appId}'),
      );
      _forgetChannel?.sink.add(jsonEncode( {
        "forget": ticksId
      }));
      _forgetChannel?.stream.listen((event) {
        final forget = ForgetRm.fromJson(json.decode(event));
        emit(BaseState());
        _forgetChannel?.sink.close();

      });
    } on WebSocketChannelException  catch (e) {
      emit(BaseState(state: WebSocketState.error));
      _forgetChannel?.sink.close();
    }
  }

}