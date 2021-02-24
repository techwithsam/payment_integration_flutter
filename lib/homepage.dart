import 'package:flutter/material.dart';
import 'package:paystack_manager/paystack_pay_manager.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Tech With Sam - Payment Integration',
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 10, left: 8, right: 8, bottom: 12),
              child: ListView.builder(
                itemCount: 5,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  int count = index + 1;
                  return Container(
                    width: MediaQuery.of(context).size.width,
                    height: 290,
                    margin: EdgeInsets.only(bottom: 14),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                          color: Colors.grey[500].withOpacity(1.0),
                          offset: Offset(1.1, 1.1),
                          blurRadius: 10.0,
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: 200,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10),
                            ),
                            image: DecorationImage(
                              fit: BoxFit.fill,
                              image: NetworkImage(
                                  'https://res.cloudinary.com/acctgen1/image/upload/v1612393902/TECH2-01_vw1fvg.png'),
                            ),
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(left: 8, right: 8, top: 4),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text('Tech With Sam',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700,
                                  )),
                              SizedBox(height: 8),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    'Flutter Tutorial - #$count',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                      letterSpacing: 0.7,
                                    ),
                                  ),
                                  OutlineButton(
                                    onPressed: () => _checkPayment(),
                                    child: Text(
                                      'Pay N$count,000',
                                      style: TextStyle(
                                        color: Colors.green,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16,
                                      ),
                                    ),
                                    highlightedBorderColor: Colors.green,
                                    padding: EdgeInsets.only(
                                        left: 14, right: 14, top: 6, bottom: 6),
                                    borderSide: BorderSide(color: Colors.green),
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8)),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _checkPayment() {
    try {
      PaystackPayManager(context: context)
        ..setSecretKey("sk_test_d33410b6eef5834ffbbfe2001100cb3465d04b65")
        ..setCompanyAssetImage(Image(
          image: NetworkImage(
              "https://res.cloudinary.com/acctgen1/image/upload/v1612393902/TECH2-01_vw1fvg.png"),
        ))
        ..setAmount(100000)
        ..setReference(DateTime.now().millisecondsSinceEpoch.toString())
        ..setCurrency("NGN")
        ..setEmail("samuelbeebest@gmail.com")
        ..setFirstName("Samuel")
        ..setLastName("Adekunle")
        ..setMetadata(
          {
            "custom_fields": [
              {
                "value": "TechWithSam",
                "display_name": "Payment_to",
                "variable_name": "Payment_to"
              }
            ]
          },
        )
        ..onSuccesful(_onPaymentSuccessful)
        ..onPending(_onPaymentPending)
        ..onFailed(_onPaymentFailed)
        ..onCancel(_onCancel)
        ..initialize();
    } catch (error) {
      print('Payment Error ==> $error');
    }
  }

  void _onPaymentSuccessful(Transaction transaction) {
    print('Transaction succesful');
    print(
        "Transaction message ==> ${transaction.message}, Ref ${transaction.refrenceNumber}");
  }

  void _onPaymentPending(Transaction transaction) {
    print('Transaction Pending');
    print("Transaction Ref ${transaction.refrenceNumber}");
  }

  void _onPaymentFailed(Transaction transaction) {
    print('Transaction Failed');
    print("Transaction message ==> ${transaction.message}");
  }

  void _onCancel(Transaction transaction) {
    print('Transaction Cancelled');
  }
}
