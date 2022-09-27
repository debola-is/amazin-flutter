import 'package:amazin/common/widgets/custom_button.dart';
import 'package:amazin/common/widgets/custom_textfield.dart';
import 'package:amazin/constants/global_variables.dart';
import 'package:amazin/constants/utils.dart';
import 'package:amazin/features/address/services/address_services.dart';
import 'package:amazin/features/admin/widgets/loader.dart';
import 'package:amazin/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:pay/pay.dart';
import 'package:provider/provider.dart';

class AddressScreen extends StatefulWidget {
  static const String routeName = '/address';
  final String totalAmount;
  const AddressScreen({
    super.key,
    required this.totalAmount,
  }) : assert(
          routeName != '',
          totalAmount != '',
        );

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  final TextEditingController houseController = TextEditingController();
  final TextEditingController streetController = TextEditingController();
  final TextEditingController codeController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final _addressFormKey = GlobalKey<FormState>();
  final AddressServices addressServices = AddressServices();
  String shippingAddress = '';

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
    var userAddress = context.watch<UserProvider>().user.address;
    // var userAddress = '3, Fake address, Lagos';
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
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 15,
          ),
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
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                height: 30,
              ),

              CustomButton(onTap: onGooglePayResult, text: "Create Order"),
              // GooglePayButton(
              //   paymentConfigurationAsset: 'gpay.json',
              //   onPaymentResult: onGooglePayResult,
              //   paymentItems: paymentItems,
              //   width: double.infinity,
              //   height: 50,
              //   type: GooglePayButtonType.buy,
              //   loadingIndicator: const Loader(),
              //   onPressed: () => onMakePayment(userAddress),
              // ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void onGooglePayResult() {
    if (Provider.of<UserProvider>(context, listen: false)
        .user
        .address
        .isEmpty) {
      addressServices.saveUserAddress(
        context: context,
        userAddress: shippingAddress,
      );
    }

    addressServices.placeOrder(
        context: context,
        userAddress: shippingAddress,
        totalSum: widget.totalAmount);
  }

  void onApplePayResult(result) {}

  void onMakePayment(String userProviderAddress) {
    shippingAddress = '';
    bool isFormEmpty = streetController.text.isEmpty ||
        houseController.text.isEmpty ||
        codeController.text.isEmpty ||
        cityController.text.isEmpty;

    if (!isFormEmpty) {
      if (_addressFormKey.currentState!.validate()) {
        shippingAddress =
            '${houseController.text}, ${streetController.text}, ${cityController.text} - ${codeController.text}';
      } else {
        throw Exception('Please enter a valid address!');
      }
    } else if (userProviderAddress.isNotEmpty) {
      shippingAddress = userProviderAddress;
    } else {
      showSnackBar(
          context,
          'Please enter correct shipping details! \nAll fields are required.',
          "error");
      return;
    }
  }

  @override
  void dispose() {
    super.dispose();
    houseController.dispose();
    streetController.dispose();
    codeController.dispose();
    cityController.dispose();
  }
}
