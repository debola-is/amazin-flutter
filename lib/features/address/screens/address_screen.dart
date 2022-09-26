import 'package:amazin/common/widgets/custom_textfield.dart';
import 'package:amazin/constants/global_variables.dart';
import 'package:amazin/features/admin/widgets/loader.dart';
import 'package:amazin/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:pay/pay.dart';
import 'package:provider/provider.dart';

class AddressScreen extends StatefulWidget {
  static const String routeName = '/address';
  final String totalAmount;
  const AddressScreen({super.key, required this.totalAmount});

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  final TextEditingController houseController = TextEditingController();
  final TextEditingController streetController = TextEditingController();
  final TextEditingController codeController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final _addressFormKey = GlobalKey<FormState>();

  List<PaymentItem> paymentItems = [];

  @override
  void initState() {
    super.initState();
    paymentItems.add(
      PaymentItem(
        amount: widget.totalAmount,
        label: 'Total Amount',
        status: PaymentItemStatus.final_price,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // var userAddress = context.watch<UserProvider>().user.address;
    var userAddress = '3, Fake address, Mainland, Lagos';
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(
          60,
        ),
        child: AppBar(
          title: const Text(
            'Shipping details',
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: GlobalVariables.appBarGradient,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              if (userAddress.isNotEmpty)
                Column(
                  children: [
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black12,
                          width: 1,
                        ),
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.location_city_outlined,
                            color: Colors.black45,
                            size: 18,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            userAddress,
                            style: const TextStyle(
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      'OR',
                      style: TextStyle(
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              Form(
                key: _addressFormKey,
                child: Column(
                  children: [
                    CustomTextField(
                        controller: houseController,
                        hintText: 'Flat/ House no/ Building'),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomTextField(
                        controller: streetController, hintText: 'Area/Street'),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomTextField(
                        controller: codeController, hintText: 'Zip code'),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomTextField(
                        controller: cityController, hintText: 'Town/City'),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              GooglePayButton(
                paymentConfigurationAsset: 'gpay.json',
                onPaymentResult: onGooglePayResult,
                paymentItems: paymentItems,
                width: double.infinity,
                height: 50,
                type: GooglePayButtonType.buy,
                loadingIndicator: const Loader(),
              ),
              const SizedBox(
                height: 10,
              ),
              ApplePayButton(
                paymentConfigurationAsset: 'applepay.json',
                onPaymentResult: onApplePayResult,
                paymentItems: paymentItems,
                width: double.infinity,
                height: 50,
                type: ApplePayButtonType.buy,
              )
            ],
          ),
        ),
      ),
    );
  }

  void onGooglePayResult(result) {}
  void onApplePayResult(result) {}

  @override
  void dispose() {
    super.dispose();
    houseController.dispose();
    streetController.dispose();
    codeController.dispose();
    cityController.dispose();
  }
}
