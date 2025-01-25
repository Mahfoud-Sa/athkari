import 'package:athkari/app/core/widgets/add_button_widget.dart';
import 'package:athkari/app/core/widgets/cancel_button_widget.dart';
import 'package:athkari/app/core/widgets/custome_container.dart';
import 'package:athkari/app/features/esnaad/domain/entities/esnad_entity.dart';
import 'package:athkari/app/features/esnaad/presentation/cubit/Esnads_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:share_plus/share_plus.dart';

class EsnadCardWidget extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController esnadValueController;
  final int noOfRelatedDekres;
  final EsnadEntity esnad;
  final double fontSize;

  const EsnadCardWidget({
    Key? key,
    required this.formKey,
    required this.esnadValueController,
    required this.noOfRelatedDekres,
    required this.esnad,
    this.fontSize = 18.0,
  }) : super(key: key);
  @override
  @override
  Widget build(BuildContext context) {
    return CustomeContainer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Esnad text
          Text(
            esnad.name!,
            textAlign: TextAlign.center,
            maxLines: 6,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context)
                .textTheme
                .titleMedium!
                .copyWith(fontSize: fontSize),
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  InkWell(
                    child: PopupMenuButton(
                      menuPadding: EdgeInsets.zero,
                      color: Colors.white,
                      padding: EdgeInsets.zero,
                      icon: Icon(
                        Icons.more_vert,
                        color: Colors.blueGrey,
                      ),
                      itemBuilder: (BuildContext context) {
                        return [
                          _buildPopupMenuUpdateMethod(context),
                          _buildPopupMenuDeleteMethod(context),
                        ];
                      },
                    ),
                  ),
                  InkWell(
                    borderRadius: BorderRadius.circular(50),
                    onTap: () {
                      Share.share('Check out my website https://example.com');
                    },
                    child: Icon(
                      Icons.share,
                      color: Colors.blueGrey,
                    ),
                  ),
                  InkWell(
                    radius: 300,
                    borderRadius: BorderRadius.circular(150),
                    onTap: () {
                      // Add copy functionality
                    },
                    child: Icon(
                      Icons.copy,
                      color: Colors.blueGrey,
                    ),
                  ),
                ],
              ),

              // Related Dekres
              Text(
                "عدد الاذكار المرتيطة $noOfRelatedDekres ذكر",
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(fontSize: fontSize, color: Colors.black12),
              ),
            ],
          ),
        ],
      ),
    );
  }

  PopupMenuItem<dynamic> _buildPopupMenuDeleteMethod(BuildContext context) {
    return PopupMenuItem(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          InkWell(
            onTap: () {
              _buildShowDeleteDekreBottomSheet(context);
            },
            child: Text(
              "حذف",
              style: TextStyle(
                color: Color.fromARGB(255, 90, 202, 165),
              ),
            ),
          ),
          Icon(
            Icons.delete,
            color: Color.fromARGB(255, 90, 202, 165),
          ),
        ],
      ),
    );
  }

  PopupMenuItem<dynamic> _buildPopupMenuUpdateMethod(BuildContext context) {
    return PopupMenuItem(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          InkWell(
            onTap: () {
              _buildUpdateEsnadModalBottomSheet(context);
            },
            child: Text(
              "تعديل النص",
              style: TextStyle(
                color: Color.fromARGB(255, 90, 202, 165),
              ),
            ),
          ),
          Icon(
            Icons.update,
            color: Color.fromARGB(255, 90, 202, 165),
          ),
        ],
      ),
    );
  }

  Future<dynamic> _buildUpdateEsnadModalBottomSheet(BuildContext context) {
    return showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) => Form(
        key: formKey,
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            children: [
              SizedBox(height: 10),
              Container(
                height: 3,
                width: 80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.black,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 8, bottom: 12),
                child: Text(
                  "التعديل على الاسناد",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 24,
                      fontWeight: FontWeight.w600),
                ),
              ),
              Row(
                children: [
                  Expanded(child: SizedBox()),
                  Padding(
                    padding: EdgeInsets.only(right: 8.0),
                    child: Text(
                      'نص الإسناد',
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 22,
                          color: Color.fromARGB(255, 128, 188, 189)),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: TextFormField(
                  maxLines: 5,
                  controller: esnadValueController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'لايمكن اضافة سند فارغ, جرب كتابة نص الإسناد';
                    }
                    if (value.length == 150) {
                      return 'لا يجب ان يحتوي نص الاصناد على اكثر من 150حرف';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.text,
                  textAlign: TextAlign.right,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                      borderSide: BorderSide.none,
                    ),
                    hintText: '...ادخل النص هنا',
                    filled: true,
                    fillColor: Color.fromARGB(255, 214, 214, 213),
                    contentPadding: EdgeInsets.symmetric(horizontal: 20),
                  ),
                ),
              ),
              AddButtonWidget(
                buttonText: "حفظ",
                esnadValue: esnadValueController,
                onTap: () {
                  if (formKey.currentState!.validate()) {
                    context
                        .read<EsnadsCubit>()
                        .updateEsnad(esnad.id!, esnadValueController.text);
                  }
                },
                formKey: formKey,
              ),
              SizedBox(height: 10),
              CancelButtonWidget(),
              SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }

  Future<dynamic> _buildShowDeleteDekreBottomSheet(BuildContext context) {
    return showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) => SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 10),
            Container(
              height: 3,
              width: 80,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Colors.black,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 8, bottom: 12),
              child: Text(
                "حذف",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                    fontWeight: FontWeight.w600),
              ),
            ),
            Row(
              children: [
                Expanded(child: SizedBox()),
                Padding(
                  padding: EdgeInsets.only(right: 8.0),
                  child: Text(
                    'هل انت متاكد من حذف هذا الاسناد؟',
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 22,
                        color: Color.fromARGB(255, 128, 188, 189)),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            InkWell(
              onTap: () {
                context.read<EsnadsCubit>().deleteEsnad(
                      esnad.id!,
                    );
                Navigator.pop(context);
              },
              borderRadius: BorderRadius.circular(20),
              child: Container(
                width: 300,
                height: 50,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 128, 188, 189),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Center(
                  child: Text(
                    'موافق', // Use the provided button text
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
