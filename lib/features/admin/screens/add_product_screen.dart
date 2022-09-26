// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:amazin/common/widgets/custom_button.dart';
import 'package:amazin/common/widgets/custom_textfield.dart';
import 'package:amazin/constants/utils.dart';
import 'package:amazin/features/admin/services/admin_services.dart';
import 'package:badges/badges.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

import '../../../constants/global_variables.dart';

class AddProductScreen extends StatefulWidget {
  static const String routeName = '/add_product_screen';

  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final TextEditingController _productNameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  final AdminServices adminServices = AdminServices();
  final _adminProductFormKey = GlobalKey<FormState>();

  String category = 'Mobiles';
  List<File> images = [];

  List<String> categories = [
    'Mobiles',
    'Essentials',
    'Appliances',
    'Books',
    'Fashion',
  ];

  Widget displayImagesCount() {
    int count = images.length;
    String text = count > 0
        ? count > 1
            ? '$count images selected'
            : '$count image selected'
        : 'No image selected';
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 12,
          color: GlobalVariables.selectedNavBarColor,
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _productNameController.dispose();
    _descriptionController.dispose();
    _priceController.dispose();
    _quantityController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(
          50,
        ),
        child: AppBar(
          flexibleSpace: Container(
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              gradient: GlobalVariables.appBarGradient,
            ),
          ),
          title: const Text(
            'Add Product',
            style: TextStyle(
              color: Colors.black,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _adminProductFormKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
            ).copyWith(
              bottom: 20,
            ),
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                images.isNotEmpty
                    ? CarouselSlider(
                        items: images.map(
                          (i) {
                            return Stack(
                              children: [
                                Builder(
                                  builder: (BuildContext context) => Image.file(
                                    i,
                                    fit: BoxFit.contain,
                                    height: 200,
                                    width: double.infinity,
                                  ),
                                ),
                                Positioned(
                                  top: 0,
                                  left: 0,
                                  child: GestureDetector(
                                    onTap: () {
                                      deleteImage(i);
                                    },
                                    child: Badge(
                                      badgeColor: Colors.white,
                                      position: BadgePosition.topStart(),
                                      badgeContent: const Icon(
                                        Icons.delete_outline,
                                        size: 20,
                                        color: Colors.cyan,
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: 45,
                                  child: GestureDetector(
                                    onTap: () {
                                      getImages();
                                    },
                                    child: Badge(
                                      badgeColor: Colors.white,
                                      position: BadgePosition.topStart(),
                                      badgeContent: const Icon(
                                        Icons.add_a_photo_outlined,
                                        size: 20,
                                        color: Colors.cyan,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        ).toList(),
                        options: CarouselOptions(
                          viewportFraction: 1,
                          height: 200,
                        ),
                      )
                    : GestureDetector(
                        onTap: getImages,
                        child: DottedBorder(
                          borderType: BorderType.RRect,
                          radius: const Radius.circular(10),
                          dashPattern: const [10, 4],
                          strokeCap: StrokeCap.round,
                          color: Colors.grey,
                          child: Container(
                            width: double.infinity,
                            height: 150,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.folder_open,
                                  size: 40,
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                Text(
                                  'Select Product Images',
                                  style: TextStyle(
                                    color: Colors.grey[400],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                displayImagesCount(),
                const SizedBox(
                  height: 30,
                ),
                CustomTextField(
                  controller: _productNameController,
                  hintText: 'Product Name',
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomTextField(
                  controller: _descriptionController,
                  hintText: 'Description',
                  inputType: TextInputType.multiline,
                  maxLines: 7,
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomTextField(
                  controller: _priceController,
                  hintText: 'Price',
                  inputType: TextInputType.number,
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomTextField(
                  controller: _quantityController,
                  hintText: 'Quantity',
                  inputType: TextInputType.number,
                ),
                SizedBox(
                  width: double.infinity,
                  child: DropdownButton(
                    value: category,
                    icon: const Icon(Icons.keyboard_arrow_down),
                    onChanged: (String? newVal) {
                      setState(() {
                        category = newVal!;
                      });
                    },
                    items: categories
                        .map(
                          (String item) => DropdownMenuItem(
                            value: item,
                            child: Text(item),
                          ),
                        )
                        .toList(),
                  ),
                ),
                CustomButton(
                  onTap: sellProduct,
                  text: 'Add',
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void getImages() async {
    var result = await selectImages();
    if (result.length + images.length < 11) {
      images.addAll(result);

      setState(() {});
      return;
    }
    showSnackBar(
        context, "You can only add a maximum of 10 product pictures", "info");
  }

  void sellProduct() {
    if (_adminProductFormKey.currentState!.validate() && images.isNotEmpty) {
      //Because form validation does not cover our image selection, we also need to chack if selected images is not empty.
      try {
        adminServices.addNewProduct(
            context: context,
            name: _productNameController.text,
            description: _descriptionController.text,
            price: double.parse(
              _priceController.text.replaceAll(',', '').replaceAll(' ', ''),
            ),
            quantity: double.parse(
              _quantityController.text
                  .replaceAll(',', '')
                  .replaceAll(' ', '')
                  .replaceAll('.', ''),
            ),
            category: category,
            images: images,
            onSuccess: () {
              showSnackBar(context, 'Product Added Successfully', "success");
              Navigator.pop(context);
              adminServices.getAllProducts(context: context);
            });
      } catch (e) {
        showSnackBar(context, e.toString(), "error");
      }
    }
  }

  void deleteImage(File image) {
    if (images.isNotEmpty) {
      setState(() {
        images.remove(image);
      });
    }
  }
}
