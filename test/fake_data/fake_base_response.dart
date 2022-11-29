import 'package:deriv_price_tracker/data/models/active_symbols_rm.dart';
import 'package:deriv_price_tracker/data/models/base_response.dart';
import 'package:deriv_price_tracker/data/models/ticks_rm.dart';
import 'package:deriv_price_tracker/utils/constants/enums.dart';


/// Fake data models to use in tests
class FakeBaseResponse {

  /// Fake data for Active Symbols response model to simulate loaded state
  static BaseState activeSymbolBaseResponseLoaded = BaseState(
      state: WebSocketState.loaded,
      responseModel: ActiveSymbolRm(
          activeSymbols: [
            ActiveSymbols(allowForwardStarting: 0, displayName: 'testName', displayOrder: 1, exchangeIsOpen: 0,
                isTradingSuspended: 0, market: 'testMarket', marketDisplayName: 'testMarketDisplayName', pip: 1.1,
                subgroup: '', subgroupDisplayName: '', submarket: '', submarketDisplayName: '',
                symbol: 'symbol', symbolType: 'symbolType')
          ], echoReq: null, msgType: null, reqId: null)
  );

  /// Fake data for Ticks response model to simulate loaded state
  static BaseState ticksResponseLoaded = BaseState(
      state: WebSocketState.loaded,
      responseModel: TicksRm(echoReq: null, msgType: null,error: null, subscription: null,
          tick: Tick(ask: 1.1, bid: 1.1, epoch: 1, id: 'id', pipSize: 1, quote: 1.1, symbol: 'symbol'))
  );


  /// Fake data for Ticks response model to simulate Loading state
  static BaseState ticksResponseLoading = BaseState(
      state: WebSocketState.loading,);

  /// Fake data for Active Symbols response model to simulate loading state
  static BaseState activeSymbolBaseResponseLoading = BaseState(
      state: WebSocketState.loading,

  );


}