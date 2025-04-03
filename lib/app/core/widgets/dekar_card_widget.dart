import 'package:athkari/app/core/ModelBottomSheet/delete_dhkar_bottomsheet.dart';
import 'package:athkari/app/core/ModelBottomSheet/edit_repetitions_modelbottomsheet.dart';
import 'package:athkari/app/core/ModelBottomSheet/update_esnad_modelbottomsheet.dart';
import 'package:athkari/app/features/daily_wered/data/modules/daily_werel_model.dart';
import 'package:athkari/app/features/daily_wered/domain/entities/dhkar_entity.dart';
import 'package:athkari/app/features/daily_wered/presentation/block/local/cubit/daily_were_cubit_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:share_plus/share_plus.dart';

class DekarDailyWereCardWidget extends StatefulWidget {
  DekarDailyWereCardWidget({
    super.key,
    required this.dhkar,
  });

  final DailyWeredModel dhkar;
  final double _fontSize = 18;
//GlobalKey<FormState> formKey;

  @override
  State<DekarDailyWereCardWidget> createState() =>
      _DekarDailyWereCardWidgetState();
}

class _DekarDailyWereCardWidgetState extends State<DekarDailyWereCardWidget> {
  final ExpansionTileController _controller = ExpansionTileController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController deleteDailywered = TextEditingController();
  final TextEditingController updateRepetation = TextEditingController();
  int _noOfRepeating = 0;

  @override
  void initState() {
    super.initState();
    _noOfRepeating =
        widget.dhkar.repetitions ?? 0; // Initialize repetition count
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          if (_noOfRepeating != 0) {
            _noOfRepeating -= 1;
          }
          if (_noOfRepeating == 0) {
            context.read<DailyWereCubit>().doneDekher(widget.dhkar.id!);
          }
        });
      },
      borderRadius: BorderRadius.circular(15),
      child: Form(
        key: formKey,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(25)),
            border: GradientBoxBorder(
              width: 1,
              gradient: LinearGradient(colors: [
                Color.fromARGB(255, 90, 202, 165),
                Color.fromARGB(255, 178, 231, 93),
              ]),
            ),
          ),
          child: Column(
            children: [
              ExpansionTile(
                onExpansionChanged: (isExpanded) {
                  // No need for setState here unless you have specific logic
                },
                controller: _controller,
                title: Text(
                  textAlign: TextAlign.center,
                  widget.dhkar.dhkar!,
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(fontSize: widget._fontSize),
                ),
                showTrailingIcon: false,
                children: [
                  Text(
                    textAlign: TextAlign.center,
                    widget.dhkar.esnad?.name ?? "لا يوجد",
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          fontSize: widget._fontSize,
                          color: Colors.black12,
                        ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  // Action Icons (More, Share, Copy)
                  Flexible(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        PopupMenuButton(
                          color: Colors.white,
                          padding: EdgeInsets.zero,
                          icon: const Icon(
                            Icons.more_vert,
                            color: Colors.blueGrey,
                          ),
                          itemBuilder: (BuildContext context) {
                            return [
                              PopupMenuItem(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        // buildUpdateEsnadModalBottomSheet(
                                        //     context,
                                        //     formKey,
                                        //     updateRepetation,
                                        //     0);
                                        showEditRepetitionsBottomSheet(
                                            context,
                                            formKey,
                                            updateRepetation,
                                            widget.dhkar.id!);
                                      },
                                      child: const Text(
                                        "تعديل مرات التكرار",
                                        style: TextStyle(
                                          color:
                                              Color.fromARGB(255, 90, 202, 165),
                                        ),
                                      ),
                                    ),
                                    const Icon(
                                      Icons.add,
                                      color: Color.fromARGB(255, 90, 202, 165),
                                    ),
                                  ],
                                ),
                              ),
                              PopupMenuItem(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        // showDeleteDhkarBottomSheet(
                                        //     context, widget.dhkar.id!);
                                      },
                                      child: const Text(
                                        "حذف من الورد اليومي",
                                        style: TextStyle(
                                          color:
                                              Color.fromARGB(255, 90, 202, 165),
                                        ),
                                      ),
                                    ),
                                    const Icon(
                                      Icons.delete,
                                      color: Color.fromARGB(255, 90, 202, 165),
                                    ),
                                  ],
                                ),
                              ),
                            ];
                          },
                        ),
                        IconButton(
                          padding: EdgeInsets.zero,
                          onPressed: () {
                            Share.share(
                                'check out my website https://example.com');
                          },
                          icon: const Icon(
                            Icons.share,
                            color: Colors.blueGrey,
                          ),
                        ),
                        IconButton(
                          padding: EdgeInsets.zero,
                          onPressed: () {
                            // Implement copy functionality
                          },
                          icon: const Icon(
                            Icons.copy,
                            color: Colors.blueGrey,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Repetition Count
                  Container(
                    width: 100,
                    decoration: const BoxDecoration(
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(25)),
                      color: Color.fromARGB(255, 90, 202, 165),
                    ),
                    child: Center(
                      child: Text(
                        _noOfRepeating.toString(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                        ),
                      ),
                    ),
                  ),
                  // Expand/Collapse Button
                  Flexible(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          onPressed: () {
                            setState(() {
                              _controller.isExpanded
                                  ? _controller.collapse()
                                  : _controller.expand();
                            });
                          },
                          icon: const Icon(Icons.arrow_drop_up_sharp),
                        ),
                        Text(
                          'عرض السند',
                          style: TextStyle(fontSize: widget._fontSize - 5),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Bottom Sheet for Editing Repetitions
}
