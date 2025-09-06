import 'package:athkari/app/core/services/app_database_services.dart';
import 'package:athkari/app/core/showDialog/show_aboutus_dialog.dart';
import 'package:athkari/app/core/showDialog/show_okay_dialog.dart';
import 'package:athkari/app/core/showDialog/show_warning_dialog.dart';
import 'package:athkari/app/core/widgets/waiting_animated_widget.dart';
import 'package:athkari/app/features/categories/presentation/cubit/catogery_cubit.dart';
import 'package:athkari/app/features/home/data/model/release_model.dart';
import 'package:athkari/app/features/home/presentation/cubit/app_update_drawer_cubit_status.dart';
import 'package:athkari/app/features/home/presentation/cubit/reset_cubit.dart';
import 'package:athkari/app/features/home/presentation/cubit/reset_cubit_states.dart';
import 'package:athkari/app/features/home/presentation/widgets/DrawerTitleWidet.dart';
import 'package:athkari/app/features/home/presentation/widgets/ForwardedTitleWidget.dart';
import 'package:athkari/app/features/home/presentation/widgets/expandable_radio_group_widget.dart';
import 'package:athkari/app/features/home/presentation/widgets/drawer_app_bar_widget.dart';
import 'package:athkari/app/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:athkari/app/features/home/presentation/cubit/app_update_cubit.dart';
import 'package:http/http.dart';
import 'dart:ui' as ui;
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:intl/intl.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';
class DrawerWidget extends StatelessWidget {
  const DrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<AppUpdateCubit, AppUpdateCubitState>(
          listener: (context, state) {
            if (state is UpdateWaitingState) {
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context) =>
                    const Center(child: AnimatedDots()),
              );
            } else if (state is UpdateAvailableState) {
              Navigator.pop(context);
              _showUpdateDialog(context, state.releaseModel);
            } else if (state is NoUpdateState) {
              
               Navigator.pop(context);
              showOkayAlert(context, state.message);
              
            } else if (state is CheckUpdateErrorState) {
              Navigator.pop(context);
                    
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.errorMessage)),
              );
            }
          },
      
      
        ),
        //reset cubit
         BlocListener<ResetCubit, ResetCubitState>(
          listener: (context, state) {
            if (state is WaitingState) {
              
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context) =>
                    const Center(child: AnimatedDots()),
              );
            } else if (state is DoneState) {
              Navigator.pop(context);
              showOkayAlert(context, 'تم اعادة ضبط الاذكار');}
            
          },
      
      
        ),
      ],
      child: Drawer(
        width: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
             const  DrawerAppBar(),
           //   _buildAppSettingsSection(context),
              _buildReminderSettingsSection(context),
              _buildOtherOptionsSection(context),
              _buildVersionInfo(context),
            ],
          ),
        ),
      ),
    );
  }
}
  Widget _buildAppSettingsSection(BuildContext context) {
    return Column(
      children: [
        const DrawerTitleWidet(title: 'إعدادات التطبيق'),
        _buildDarkModeSwitch(context),
         ExpandableRadioGroup(
          title: 'ضبط الوقت والتاريخ',
          initialSelected: true,
          options: ['تلقائي', 'مخصص'],
        ),
         ExpandableRadioGroup(
          title: 'لغة التطبيق',
          initialSelected: true,
          options: ['إنجليزي', 'عربي'],
          
        ),
      ],
    );
  }

  Widget _buildDarkModeSwitch(BuildContext context) {
    return BlocBuilder<AppUpdateCubit, AppUpdateCubitState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Switch(
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                activeColor: const Color.fromARGB(255, 157, 199, 168),
                value: false,
                onChanged: (value) {
                  value=!value;
                // context.read<AppUpdateCubit>().toggleDarkMode(value);
                },
              ),
              Text(
                'الوضع الليلي',
                  style: const TextStyle(
                          color:   Color(0xff3a3a3a),
                          fontWeight: FontWeight.w400,
                          fontFamily: "IBMPlexSansArabic",
                          fontStyle:  FontStyle.normal,
                          fontSize: 16.0
                      ),
                      textAlign: TextAlign.right 
              )
            ],
          ),
        );
      },
    );
  }

  Widget _buildReminderSettingsSection(BuildContext context) {
    return Column(
      children: [
        const DrawerTitleWidet(title: 'إعدادات الإذكار'),
        //  ExpandableRadioGroup(
        //   title: 'ضبط الورد اليومي',
        //   initialSelected: true,
        //   options: ['غير مفعل', 'مفعل'],
        // ),
        // ForwardedTitleWidget(
        //   title: 'ضبط الاشعارات',
        //   onPressed: () => _showNotificationSettings(context),
        // ),
        ForwardedTitleWidget(
          title: 'إعاده ضبط الاذكار',
          onPressed: () => _showResetConfirmationDialog(context),
        ),
      ],
    );
  }

  Widget _buildOtherOptionsSection(BuildContext context) {
    return Column(
      children: [
        const DrawerTitleWidet(title: 'أخرى'),
        ForwardedTitleWidget(
          title: 'مشاركة التطبيق',
          onPressed: () => Share.share('check out my website https://example.com'),
        ),
        ForwardedTitleWidget(
        title: 'تحقق من التحديثات',
        onPressed: () => context.read<AppUpdateCubit>().checkUpdate(),
      ),
       // _buildUpdateCheckTile(context),
        // ForwardedTitleWidget(
        //   title: 'تقييم التطبيق',
        //   onPressed: () {
        //     // Implement rating functionality
        //   },
        // ),
        ForwardedTitleWidget(
          title: 'تواصل معنا',
          onPressed: () => showAboutUsDialog(context),
        ),
      ],
    );
  }

  Widget _buildVersionInfo(BuildContext context) {
    return BlocBuilder<AppUpdateCubit, AppUpdateCubitState>(
      builder: (context, state) {
        final appVersion = context.read<AppUpdateCubit>().appVersion;
        return Padding(
          padding: const EdgeInsets.only(bottom: 30),
          child: Center(
            child: Text(
              appVersion != null ? 'v$appVersion الإصدار' : 'جاري التحميل...',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Colors.grey,
                  ),
              textAlign: TextAlign.center,
            ),
          ),
        );
      },
    );
  }

  void _showNotificationSettings(BuildContext context) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) => SingleChildScrollView(
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
                'ضبط الاشعارات',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                    fontWeight: FontWeight.w900),
              ),
            ),
            const Row(
              children: [
                Expanded(child: SizedBox()),
                Padding(
                  padding: EdgeInsets.only(right: 8.0),
                  child: Text(
                    'حدد موعد ظهور اشعارات الورد اليومي',
                    style: TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 22,
                        color: Color.fromARGB(255, 128, 188, 189)),
                  ),
                )
              ],
            ),
            TimePickerSpinner(
              is24HourMode: false,
              alignment: Alignment.centerRight,
              normalTextStyle: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 32,
                  color: Color.fromARGB(255, 213, 240, 193)),
              highlightedTextStyle: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 32,
                  color: Color.fromARGB(255, 128, 188, 189)),
              isForce2Digits: true,
              onTimeChange: (time) {},
            ),
            const Row(
              children: [
                Expanded(child: SizedBox()),
                Padding(
                  padding: EdgeInsets.only(right: 8.0),
                  child: Text(
                    'حدد موعد ظهور اشعارات ورد اليوم',
                    style: TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 22,
                        color: Color.fromARGB(255, 128, 188, 189)),
                  ),
                )
              ],
            ),
            TimePickerSpinner(
              is24HourMode: false,
              normalTextStyle: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 32,
                  color: Color.fromARGB(255, 213, 240, 193)),
              highlightedTextStyle: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 32,
                  color: Color.fromARGB(255, 128, 188, 189)),
              isForce2Digits: true,
              onTimeChange: (time) {},
            ),
            InkWell(
              onTap: () {},
              borderRadius: BorderRadius.circular(20),
              child: Container(
                width: 300,
                height: 50,
                decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 128, 188, 189),
                    borderRadius: BorderRadius.circular(30)),
                child: const Center(
                  child: Text(
                    'ضبط الاشعارات',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w600),
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
                decoration: BoxDecoration(
                    border: Border.all(
                        color: const Color.fromARGB(255, 128, 188, 189),
                        width: 3),
                    borderRadius: BorderRadius.circular(30)),
                child: const Center(
                  child: Text(
                    'الغاء',
                    style: TextStyle(
                        color: Color.fromARGB(255, 128, 188, 189),
                        fontWeight: FontWeight.w600),
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

  void _showResetConfirmationDialog(BuildContext context) {
    final resetCubit = context.read<ResetCubit>();

    showWarningDialog(
      context: context,
      message: "سيتم اعادة ضبط الاذكار في التطبيق الى الاعدادات الافتراضية",
    // title: "إعادة ضبط الاذكار",
      okButtonText: "موافق",
      cancelButtonText: "الغاء",
      onOkPressed: () async {        
        Navigator.pop(context);
        await resetCubit.clearAllTables();
      },
    );
}

  void _showUpdateDialog(BuildContext context, ReleaseModel release) {
    final dateFormat = DateFormat('yyyy/MM/dd');
    final size = MediaQuery.of(context).size;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Directionality(
          textDirection: ui.TextDirection.rtl,
          child: AlertDialog(
            title: const Text(
              'تحديث جديد متاح',
              textAlign: TextAlign.right,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            content: SizedBox(
              width: size.width * 0.8,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'الإصدار: ${release.tagName}',
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'تاريخ النشر: ${dateFormat.format(release.publishedAt)}',
                    style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                  ),
                  if (release.body.isNotEmpty) ...[
                    const SizedBox(height: 12),
                    const Text(
                      'ملاحظات الإصدار:',
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      release.body,
                      textAlign: TextAlign.right,
                      style: const TextStyle(fontSize: 14),
                    ),
                    const SizedBox(height: 16),
                  ],
                  Text(
                    "اضغط على زر التحديث لبدء تنزيل الإصدار الجديد",
                    style: TextStyle(
                      fontSize: 14,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                child: const Text('الغاء'),
                onPressed: () => Navigator.of(context).pop(),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).primaryColor,
                ),
                child: const Text('تحديث الآن'),
                onPressed: () async {
                  if (release.assets.isNotEmpty) {
                    final url = release.assets.first.browserDownloadUrl;
                    if (!await launchUrl(Uri.parse(url))) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('فشل فتح رابط التحديث')),
                      );
                    }
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }

  