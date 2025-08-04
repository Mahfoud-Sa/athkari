import 'package:athkari/app/core/widgets/minus_button_widget.dart';
import 'package:athkari/app/core/widgets/plus_button_widget%20copy.dart';
import 'package:athkari/app/features/categories/presentation/cubit/category_details_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

/// ✅ Bottom sheet for editing repetitions
Future<dynamic> buildAddtoDailyweredModalBottomSheet(BuildContext context,
GlobalKey<FormState> formKey,
  int dekharId) {
  return showModalBottomSheet(
    isScrollControlled: true,
    
    context: context,
    builder: (context) => _AddToDailyWeredContent(formKey: formKey, id: dekharId),
  );
}

class _AddToDailyWeredContent extends StatefulWidget {
   final GlobalKey<FormState> formKey;
   final int id;

  const _AddToDailyWeredContent({required this.formKey,required this.id});
  @override
  State<_AddToDailyWeredContent> createState() => _AddToDailyWeredContentState();
}

class _AddToDailyWeredContentState extends State<_AddToDailyWeredContent> {
  int _counter = 1; // Initial counter value
  final TextEditingController _counterController = TextEditingController();
  

  _AddToDailyWeredContentState();
  void _submitForm() {
    if (widget.formKey.currentState!.validate()) {
       context.read<CategoryDetailsCubit>()
                        .addToDailyWered(widget.id,int.parse(_counterController.text));
      Navigator.pop(context, _counter);
    }
  }
  @override
  void initState() {
    super.initState();
    _counterController.text = _counter.toString();
  }

  @override
  void dispose() {
    _counterController.dispose();
    super.dispose();
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
      _counterController.text = _counter.toString();
    });
  }

  void _decrementCounter() {
    if (_counter > 1) { // Prevent going below 1
      setState(() {
        _counter--;
        _counterController.text = _counter.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 10),
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
              'اضافه الى الورد اليومي',
              style: TextStyle(
                color: Color(0xff3a3a3a),
                fontWeight: FontWeight.w600,
                fontFamily: "IBMPlexSansArabic",
                fontStyle: FontStyle.normal,
                fontSize: 20.0
              ),
            ),
          ),
          const Row(
            children: [
              Expanded(child: SizedBox()),
              Padding(
                padding: EdgeInsets.only(right: 8.0),
                child: Text(
                  'ضبط عدد مرات الذكر',
                  style: TextStyle(
                    color: Color(0xFF80BCBD),
                    fontWeight: FontWeight.w400,
                    fontFamily: "IBMPlexSansArabic",
                    fontStyle: FontStyle.normal,
                    fontSize: 16.0
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              PlusButtonWidget(onPressMethod: _incrementCounter),
              Form(
                key:widget.formKey ,
                child: SizedBox(
                  width: 70,
                  child: TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'الرجاء إدخال عدد';
                      }
                      final num = int.tryParse(value);
                      if (num == null || num < 1) {
                        return 'يجب أن يكون العدد أكبر من 0';
                      }
                      return null;
                    },
                    controller: _counterController,
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: "IBMPlexSansArabic",
                      fontSize: 18,
                    ),
                    onChanged: (value) {
                      final newValue = int.tryParse(value) ?? 1;
                      setState(() {
                        _counter = newValue.clamp(1, 999); // Limit between 1-999
                        _counterController.text = _counter.toString();
                        _counterController.selection = TextSelection.fromPosition(
                          TextPosition(offset: _counterController.text.length),
                        );
                      });
                    },
                  ),
                ),
              ),
              MinusButtonWidget(
                
                onPressMethod: _decrementCounter),
            ],
          ),
          SizedBox(height: 10),
          InkWell(
            onTap: _submitForm,
            borderRadius: BorderRadius.circular(20),
            child: Container(
              width: 300,
              height: 50,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: const Color(0xFF80BCBD),
                borderRadius: BorderRadius.circular(30),
              ),
              child: const Text(
                'اضافه',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w400,
                  fontFamily: "IBMPlexSansArabic",
                  fontStyle: FontStyle.normal,
                  fontSize: 16.0
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          InkWell(
            borderRadius: BorderRadius.circular(20),
            onTap: () => Navigator.pop(context),
            child: Container(
              width: 300,
              height: 50,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                border: Border.all(
                  color: const Color(0xFF80BCBD),
                  width: 3,
                ),
                borderRadius: BorderRadius.circular(30),
              ),
              child: const Text(
                'الغاء',
                style: TextStyle(
                  color: Color(0xff3a3a3a),
                  fontWeight: FontWeight.w400,
                  fontFamily: "IBMPlexSansArabic",
                  fontStyle: FontStyle.normal,
                  fontSize: 16.0
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}

