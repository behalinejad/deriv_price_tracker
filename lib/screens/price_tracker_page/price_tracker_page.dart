import 'package:deriv_price_tracker/cubit/active_symbols_cubit.dart';
import 'package:deriv_price_tracker/cubit/ticks_cubit.dart';
import 'package:deriv_price_tracker/data/models/active_symbols_rm.dart';
import 'package:deriv_price_tracker/data/models/base_response.dart';
import 'package:deriv_price_tracker/data/models/ticks_rm.dart';
import 'package:deriv_price_tracker/screens/components/loading_widget.dart';
import 'package:deriv_price_tracker/screens/components/price_text_widget.dart';
import 'package:deriv_price_tracker/utils/constants/enums.dart';
import 'package:deriv_price_tracker/utils/constants/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PriceTrackerPage extends StatefulWidget {
  const PriceTrackerPage({Key? key}) : super(key: key);

  @override
  State<PriceTrackerPage> createState() => _PriceTrackerPageState();
}

class _PriceTrackerPageState extends State<PriceTrackerPage> {
  String marketDropDownValue = '';
  String assetDropDownValue = '';

  @override
  void initState() {
    context.read<ActiveSymbolsCubit>().getActiveSymbolRequest();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: _buildAppBar(context),
        body: BlocBuilder<ActiveSymbolsCubit, BaseState>(
            builder: ((context, state) {
          if (state.state == WebSocketState.loading) {
            return Center(
              child: LoadingWidget(
                key: const Key('loadingWidget'),
                width: 60,
                height: 60,
              ),
            );
          } else if (state.state == WebSocketState.error) {
            /// To handle error State
            return const Center(child: Icon(Icons.error));
          } else {
            /// While the state is on loaded and data has received from the Socket
            return _buildBody(
              context,
            );
          }
        })));
  }

  AppBar _buildAppBar(
    BuildContext context,
  ) {
    return AppBar(
      title: const Text(Strings.appName),
      elevation: 1,
      centerTitle: true,
    );
  }

  Widget _buildBody(BuildContext context) {
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 30, right: 30, left: 30),
          child: _marketDropDown(context),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 30, right: 30, left: 30),
          child: _assetDropDown(context),
        ),
        Padding(
          padding: const EdgeInsets.only(
            top: 50,
          ),
          child: _buildPriceWidget(context),
        ),
      ],
    );
  }

  ///Shows the Market Symbols
  Widget _marketDropDown(BuildContext context) {
    final baseState = context.read<ActiveSymbolsCubit>().state;
    final activeSymbols = baseState.responseModel as ActiveSymbolRm;

    ///To Retrieve Markets from Active Symbols  list
    List<String> markets = [];
    activeSymbols.activeSymbols?.forEach((element) {
      if (!markets.contains(element.market)) {
        markets.add(element.market ?? Strings.unknown);
      }
    });

    return (activeSymbols.activeSymbols?.isNotEmpty ?? false)
        ? DecoratedBox(
            decoration: BoxDecoration(
                border: Border.all(width: 1),
                borderRadius: BorderRadius.all(Radius.circular(8))),
            child: Padding(
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: DropdownButton(
                  key: const Key('marketsDropDown'),
                  value: marketDropDownValue.isNotEmpty
                      ? marketDropDownValue
                      : null,
                  hint: const Text(Strings.marketHintText),
                  isExpanded: true,
                  underline: Container(),
                  items: markets.map((item) {
                    return DropdownMenuItem(
                      value: item.toString(),
                      child: Text(item),
                    );
                  }).toList(),
                  onChanged: (value) {
                    if (marketDropDownValue != value.toString()) {
                      final baseState = context.read<TicksCubit>().state;
                      if (baseState.responseModel != null) {
                        context.read<TicksCubit>().closeChannel();
                      }
                      setState(() {
                        marketDropDownValue = value.toString();
                        assetDropDownValue = '';
                      });
                    }
                  }),
            ),
          )
        : Container();
  }

  /// to shows the assets in specific Market
  Widget _assetDropDown(BuildContext context) {
    final baseState = context.read<ActiveSymbolsCubit>().state;
    final activeSymbols = baseState.responseModel as ActiveSymbolRm;

    ///To retrieve Assets from Active Symbols  list based on selected Market
    var filteredSymbols = activeSymbols.activeSymbols;
    if (marketDropDownValue.isNotEmpty) {
      filteredSymbols = activeSymbols.activeSymbols
          ?.where((element) => element.market == marketDropDownValue)
          .toList();
    }
    return (activeSymbols.activeSymbols?.isNotEmpty ?? false)
        ? DecoratedBox(
            decoration: BoxDecoration(
                border: Border.all(width: 1),
                borderRadius: BorderRadius.all(Radius.circular(8))),
            child: Padding(
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: DropdownButton(
                  key: const Key('assetsDropDown'),
                  value:
                      assetDropDownValue.isNotEmpty ? assetDropDownValue : null,
                  hint: const Text(Strings.assetHintText),
                  isExpanded: true,
                  underline: Container(),
                  items: filteredSymbols!.map((item) {
                    return DropdownMenuItem(
                      value: item.displayName.toString(),
                      child: Text(item.displayName ?? Strings.unknown),
                    );
                  }).toList(),
                  onChanged: marketDropDownValue.isEmpty
                      ? null
                      : (value) {
                          setState(() {
                            assetDropDownValue = value.toString();
                          });
                          var activeSymbol = activeSymbols.activeSymbols
                              ?.firstWhere(
                                  (element) => element.displayName == value);

                          /// To reset the state and forget the previous channel on changing the Market
                          context.read<TicksCubit>().closeChannel();
                          if (activeSymbol != null) {
                            context.read<TicksCubit>().getPriceRequest(
                                tickSymbols: activeSymbol.symbol!);
                          }
                        }),
            ),
          )
        : Container();
  }

  /// A widget to show the asset price and changing states
  Widget _buildPriceWidget(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return BlocBuilder<TicksCubit, BaseState>(builder: ((context, state) {
      dynamic ticks;
      String ticksError = '';
      if (state.responseModel != null) {
        ticks = state.responseModel as TicksRm;
      }
      if (state.responseModel != null) {
        ticksError = (state.responseModel as TicksRm).error?.message ?? '';
      }
      return SizedBox(
        height: height / 2,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ticksError.isNotEmpty
                ? Text(ticksError)
                : ticks != null
                    ? PriceTextWidget(
                        key: const Key('priceTextWidget'),
                        priceChangeState:
                            state.priceChangeState ?? PriceChangeState.noChange,
                        price: ticks.tick?.quote ?? 0,
                        webSocketState: state.state ?? WebSocketState.loading)
                    : state.state == WebSocketState.loading
                        ? LoadingWidget(
                            key: const Key('priceLoadingWidget'),
                            width: 30,
                            height: 30)
                        : Container(),
          ],
        ),
      );
    }));
  }
}
