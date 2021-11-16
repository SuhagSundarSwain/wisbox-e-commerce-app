import 'dart:developer';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:nexmat/app_configs/app_assets.dart';
import 'package:nexmat/app_configs/firebase_collections_refs.dart';
import 'package:nexmat/data_models/rest_error.dart';
import 'package:nexmat/pages/product/product_details_page.dart';
import 'package:nexmat/utils/snackbar_helper.dart';
import 'package:nexmat/widgets/app_buttons/app_primary_button.dart';
import 'package:nexmat/widgets/photo_chooser.dart';

///
/// Created by Sunil Kumar (sunil@smarttersstudio.com)
/// On 10-11-2021 12:49 PM
///
class AddProductPage extends StatefulWidget {
  static const routeName = "/AddProductPage";
  const AddProductPage({Key? key}) : super(key: key);

  @override
  State<AddProductPage> createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final GlobalKey<AppPrimaryButtonState> _btnKey = GlobalKey();

  String? _name, _type, _brand, _price, _quantity;
  AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;
  File? _image;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: _formKey,
          autovalidateMode: _autovalidateMode,
          child: ListView(
            padding: const EdgeInsets.all(22),
            children: [
              const Text(
                "Add Product",
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.w800),
              ),
              const SizedBox(height: 12),
              TextFormField(
                keyboardType: TextInputType.name,
                textCapitalization: TextCapitalization.words,
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (s) => Get.focusScope?.nextFocus(),
                onSaved: (s) {
                  _name = s?.trim();
                },
                validator: (s) {
                  if (s == null || s.trim().isEmpty) {
                    return '*required';
                  }
                },
                decoration: const InputDecoration(labelText: 'Product Name'),
              ),
              const SizedBox(height: 12),
              TextFormField(
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (s) => Get.focusScope?.nextFocus(),
                onSaved: (s) {
                  _type = s?.trim();
                },
                validator: (s) {
                  if (s == null || s.trim().isEmpty) {
                    return '*required';
                  }
                },
                decoration: const InputDecoration(labelText: 'Product Type'),
              ),
              const SizedBox(height: 12),
              TextFormField(
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (s) => Get.focusScope?.nextFocus(),
                onSaved: (s) {
                  _brand = s?.trim();
                },
                validator: (s) {
                  if (s == null || s.trim().isEmpty) {
                    return '*required';
                  }
                },
                decoration: const InputDecoration(labelText: 'Brand'),
              ),
              const SizedBox(height: 12),
              TextFormField(
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (s) => Get.focusScope?.nextFocus(),
                onSaved: (s) {
                  _price = s?.trim();
                },
                validator: (s) {
                  if (s == null || s.trim().isEmpty) {
                    return '*required';
                  }
                },
                decoration: const InputDecoration(labelText: 'Price'),
              ),
              const SizedBox(height: 12),
              TextFormField(
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.done,
                onFieldSubmitted: (s) => Get.focusScope?.unfocus(),
                onSaved: (s) {
                  _quantity = s?.trim();
                },
                validator: (s) {
                  if (s == null || s.trim().isEmpty) {
                    return '*required';
                  }
                },
                decoration: const InputDecoration(labelText: 'Quantity'),
              ),
              const SizedBox(height: 12),
              GestureDetector(
                onTap: () {
                  Get.bottomSheet(
                          const PhotoChooser(
                            cropStyle: CropStyle.rectangle,
                          ),
                          backgroundColor: Colors.white)
                      .then((value) {
                    if (value != null) {
                      _image = value;
                      setState(() {});
                    }
                  });
                },
                child: Container(
                  height: 200,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: Colors.grey,
                      )),
                  child: _image == null
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(AppAssets.addImage),
                            const SizedBox(height: 8),
                            const Text("Upload Product Image")
                          ],
                        )
                      : Image.file(
                          _image!,
                          fit: BoxFit.cover,
                        ),
                ),
              ),
              const SizedBox(height: 32),
              AppPrimaryButton(
                child: const Text("Submit"),
                onPressed: _addProduct,
                key: _btnKey,
              ),
              const SizedBox(height: 38),
            ],
          ),
        ),
      ),
    );
  }

  void _addProduct() async {
    final state = _formKey.currentState;
    if (state == null) return;
    if (state.validate()) {
      if (_image == null) {
        SnackBarHelper.show("Please select a product image.");
        return;
      }
      state.save();
      _btnKey.currentState?.showLoader();
      try {
        Reference storageReference = FirebaseStorage.instance.ref().child(
            "items/${FirebaseAuth.instance.currentUser?.uid}/${DateTime.now().millisecondsSinceEpoch}.jpg");
        final UploadTask uploadTask = storageReference.putFile(_image!);
        final TaskSnapshot downloadUrl = uploadTask.snapshot;

        String url = "";
        uploadTask.snapshotEvents.listen((event) async {
          if (event.state == TaskState.success) {
            url = await downloadUrl.ref.getDownloadURL();

            final storeRes = await FirebaseCollectionRefs.storesRef
                .doc(FirebaseAuth.instance.currentUser?.email)
                .get();

            final res = await FirebaseCollectionRefs.storeItemsRef.add({
              "name": _name,
              "type": _type,
              "brand": _brand,
              "price": _price,
              "quantity": _quantity,
              "store": FirebaseAuth.instance.currentUser?.uid,
              "storeName": storeRes.data()?["storeName"],
              "image": url
            });
            _btnKey.currentState?.hideLoader();
            Get.offNamed(ProductDetailsPage.routeName,
                arguments: {"id": res.id});
          }
        });
      } catch (e, s) {
        SnackBarHelper.show(parseFirebaseError(e));
        log("ERROR", stackTrace: s, error: e);
        _btnKey.currentState?.hideLoader();
      }
    } else {
      setState(() {
        _autovalidateMode = AutovalidateMode.always;
      });
    }
  }
}
