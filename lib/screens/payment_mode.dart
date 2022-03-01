import 'package:flutter/material.dart';
import 'package:store_app/widgets/payment_input_widget.dart';
import 'package:store_app/widgets/payment_mode_widget.dart';
class PaymentMode extends StatefulWidget {
  const PaymentMode({Key key}) : super(key: key);

  @override
  _PaymentModeState createState() => _PaymentModeState();
}

class _PaymentModeState extends State<PaymentMode> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('Payment Mode'),
      ),
      body: Column(
        children: [
          PaymentCardWidget(),
          PaymentInput(),
        ],
      ),

    );
  }
}
