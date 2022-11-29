import 'dart:convert';
import 'package:deriv_price_tracker/data/models/active_symbols_rm.dart';
import 'package:deriv_price_tracker/data/models/base_response.dart';
import 'package:deriv_price_tracker/utils/constants/enums.dart';
import 'package:deriv_price_tracker/utils/constants/urls.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class ActiveSymbolsCubit extends Cubit<BaseState> {
  ActiveSymbolsCubit() : super(BaseState());

  late WebSocketChannel channel;

  /// To request for Active Symbols from Socket
  getActiveSymbolRequest() async {
    emit(BaseState(state: WebSocketState.loading));
    try {
      channel = WebSocketChannel.connect(
        Uri.parse('wss://ws.binaryws.com/websockets/v3?app_id=${Urls.appId}'),
      );
      channel.sink.add(
          jsonEncode({"active_symbols": "brief", "product_type": "basic"}));
      channel.stream.listen((event) {
        final activeSymbols = ActiveSymbolRm.fromJson(json.decode(event));
        emit(BaseState(
            responseModel: activeSymbols, state: WebSocketState.loaded));
        channel.sink.close();
      });
    } on WebSocketChannelException catch (e) {
      channel.sink.close();
      emit(BaseState(state: WebSocketState.error));
    }
  }
}
