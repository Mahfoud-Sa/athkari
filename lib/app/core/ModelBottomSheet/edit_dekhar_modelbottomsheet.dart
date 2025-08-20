import 'package:athkari/app/core/widgets/minus_button_widget.dart';
import 'package:athkari/app/core/widgets/plus_button_widget%20copy.dart';
import 'package:athkari/app/features/daily_wered/presentation/block/local/cubit/daily_were_cubit_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> showEditRepetitionsBottomSheet(
    BuildContext context,
    GlobalKey<FormState> formKey,
    TextEditingController updateRepetationController,
    int id) {
  return showModalBottomSheet(
    isScrollControlled: true,
    context: context,
    builder: (context) => _EditRepetitionsContent(
      formKey: formKey,
      controller: updateRepetationController,
      id: id,
    ),
  );
}

class _EditRepetitionsContent extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController controller;
  final int id;

  const _EditRepetitionsContent({
    required this.formKey,
    required this.controller,
    required this.id,
  });

  @override
  State<_EditRepetitionsContent> createState() => _EditRepetitionsContentState();
}

class _EditRepetitionsContentState extends State<_EditRepetitionsContent> {
  int _counter = 1;

  @override
  void initState() {
    super.initState();
    // Initialize with existing value if controller has text
    _counter = int.tryParse(widget.controller.text) ?? 1;
    widget.controller.text = _counter.toString();
  }

  void _submitForm() {
    if (widget.formKey.currentState!.validate()) {
      context.read<DailyWereCubit>().updateRepetation(
          widget.id, int.parse(widget.controller.text));
      Navigator.pop(context);
    }
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
      widget.controller.text = _counter.toString();
    });
  }

  void _decrementCounter() {
    if (_counter > 1) {
      setState(() {
        _counter--;
        widget.controller.text = _counter.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16),
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
              padding: EdgeInsets.symmetric(vertical: 12),
              child: Text(
                'ضبط عدد مرات التكرار',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 24,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
            const Row(
              children: [
                Expanded(child: SizedBox()),
                Padding(
                  padding: EdgeInsets.only(right: 8),
                  child: Text(
                    'عدد مرات التكرار',
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 22,
                      color: Color.fromARGB(255, 128, 188, 189),
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
                  key: widget.formKey,
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
                      controller: widget.controller,
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontFamily: "IBMPlexSansArabic",
                        fontSize: 18,
                      ),
                      onChanged: (value) {
                        final newValue = int.tryParse(value) ?? 1;
                        setState(() {
                          _counter = newValue.clamp(1, 999);
                          widget.controller.text = _counter.toString();
                          widget.controller.selection = TextSelection.fromPosition(
                            TextPosition(offset: widget.controller.text.length),
                          );
                        });
                      },
                    ),
                  ),
                ),
                MinusButtonWidget(onPressMethod: _decrementCounter),
              ],
            ),
            const SizedBox(height: 10),
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
                  'تعديل مرات التكرار',
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
      ),
    );
  }
}