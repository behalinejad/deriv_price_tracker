import 'package:deriv_price_tracker/screens/components/loading_widget.dart';
import 'package:deriv_price_tracker/utils/constants/enums.dart';
import 'package:deriv_price_tracker/utils/constants/strings.dart';
import 'package:flutter/material.dart';

class PriceTextWidget extends StatelessWidget {
   const PriceTextWidget({Key? key, required this.priceChangeState, required this.price, required this.webSocketState}) : super(key: key);
   final  PriceChangeState priceChangeState;
   final double price;
   final WebSocketState webSocketState;
  @override
  Widget build(BuildContext context) {
    return
        Center(
            child:
            webSocketState == WebSocketState.loading ?
            LoadingWidget(width: 30, height: 30)
        : webSocketState == WebSocketState.error ?
        const Icon(Icons.error_outline)
        :
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(Strings.price,style: TextStyle(fontSize: 20),),
            const SizedBox(width: 10,),
            Text(price.toString(),style: TextStyle(color: priceChangeState == PriceChangeState.noChange ? Colors.grey :
            priceChangeState == PriceChangeState.down ? Colors.red : Colors.green,fontSize: 25),)
          ],
        )
        );
  }
}
