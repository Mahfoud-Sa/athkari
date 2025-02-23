import 'package:athkari/app/core/widgets/add_button_widget.dart';
import 'package:athkari/app/core/widgets/cancel_button_widget.dart';
import 'package:athkari/app/core/widgets/delete_button_widget.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:athkari/app/features/categories/presentation/cubit/catogery_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<dynamic> buildShowDeleteDekeerBottomSheet(
    BuildContext context, int categoryId) {
  return showModalBottomSheet(
    isScrollControlled: true,
    context: context,
    builder: (context) => SingleChildScrollView(
      //  width: double.infinity,
      child: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          Container(
            height: 3,
            width: 80,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: Colors.black,
            ),
          ),
          const Padding(
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
                padding: const EdgeInsets.only(right: 8.0),
                child: Text(
                  'هل انت متاكد من حذف هذا الصنف؟',
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: Theme.of(context).primaryColor),
                ),
              )
            ],
          ),
          SizedBox(
            height: 20,
          ),
          DeleteButtonWidget(
            onTap: () {
              context.read<CategoryCubit>().DeleteCategory(
                    categoryId,
                  );
              Navigator.pop(context);
            },
          ),
          const SizedBox(
            height: 10,
          ),
          CancelButtonWidget(),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    ),
  );
}
