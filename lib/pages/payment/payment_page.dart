import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nexmat/app_configs/firebase_collections_refs.dart';
import 'package:nexmat/utils/shared_preference_helper.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

///
/// Created by Sunil Kumar on 11-05-2020 12:06 AM.
///
class PaymentPage extends StatefulWidget {
  final String storeId;
  final String userId;
  final String productId;
  final double total;
  final int quantity;

  const PaymentPage(
      {required this.storeId,
      required this.userId,
      required this.productId,
      required this.total,
      required this.quantity,
      Key? key})
      : super(key: key);

  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  Map<String, dynamic>? options;
  bool isLoading = false;
  String? loadingText = '', orderId;
  final Razorpay _razorpay = Razorpay();
  @override
  void initState() {
    super.initState();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    initPayment();
  }

  @override
  void dispose() {
    _razorpay.clear();
    super.dispose();
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    setState(() {
      loadingText = 'Validating payment.';
    });
    FirebaseCollectionRefs.ordersRef
        .doc(orderId)
        .update({'paymentId': response.paymentId, 'status': 2}).then((value) {
      setState(() {
        loadingText = 'Payment success.';
        isLoading = false;
      });
      Future.delayed(const Duration(seconds: 2)).then((value) {
        Navigator.pop(context, true);
      });
    });
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    final msg = jsonDecode(response.message ?? "{}");
    setState(() {
      isLoading = false;
      loadingText = msg["error"]!["description"] ?? "Some error occurred";
    });
    FirebaseCollectionRefs.ordersRef.doc(orderId).update({'status': -1});
  }

  initPayment() {
    setState(() {
      isLoading = true;
      loadingText = 'Initializing payment.';
    });
    final value = FirebaseAuth.instance.currentUser;
    if (value != null && value.uid != null) {
      FirebaseCollectionRefs.ordersRef.add({
        'amount': widget.total,
        'createdBy': value.uid,
        "date": DateTime.now(),
        'status': 1,
        'store': widget.storeId,
        'userId': widget.userId,
        'productId': widget.productId,
        'quantity': widget.quantity,
      }).then((DocumentReference doc) async {
        options = {
          'key': 'rzp_test_2Cu3uh5AUuqrDI',
          'amount': widget.total * 100,
          'name': 'NexMat',
          'description': 'Demo description',
          'prefill': {
            // 'contact': '91' + SharedPreferenceHelper.user..data['phone'],
            'email': value.email,
          },
          'notes': {
            'name': SharedPreferenceHelper.user?.name,
            'storeId': widget.storeId,
            'createdBy': value.uid,
          }
        };
        setState(() {
          loadingText = 'Processing payment';
        });
        orderId = doc.id;
        _razorpay.open(options!);
      });
    } else {
      setState(() {
        isLoading = false;
        loadingText = 'Authentication error.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return !isLoading;
      },
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (isLoading) const CircularProgressIndicator(),
            const SizedBox(height: 8),
            Center(
              child: Text(loadingText ?? 'Error',
                  style: Theme.of(context).textTheme.headline6),
            ),
            if (isLoading) const Text('Please do not back or close the app.')
          ],
        ),
      ),
    );
  }
}
