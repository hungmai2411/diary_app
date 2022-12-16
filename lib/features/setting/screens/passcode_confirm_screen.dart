import 'package:diary_app/constants/app_colors.dart';
import 'package:diary_app/constants/app_styles.dart';
import 'package:diary_app/constants/utils.dart';
import 'package:diary_app/features/diary/widgets/pin_success_dialog.dart';
import 'package:diary_app/features/diary/widgets/success_dialog.dart';
import 'package:diary_app/features/setting/screens/setting_screen.dart';
import 'package:diary_app/my_app.dart';
import 'package:diary_app/providers/setting_provider.dart';
import 'package:diary_app/widgets/app_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../models/setting.dart';

class PasscodeConfirmScreen extends StatefulWidget {
  const PasscodeConfirmScreen({
    super.key,
    required this.passcode,
  });
  final String passcode;
  static const String routeName = '/passcode_confirm_screen';

  @override
  State<PasscodeConfirmScreen> createState() => _PasscodeConfirmScreenState();
}

class _PasscodeConfirmScreenState extends State<PasscodeConfirmScreen> {
  late List<String> input;
  int indexTmp = 0;
  List<String> passcodeConfirm = ['', '', '', ''];
  bool isWrong = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    input = [
      '1',
      '2',
      '3',
      '4',
      '5',
      '6',
      '7',
      '8',
      '9',
      AppLocalizations.of(context)!.exit,
      '0',
      AppLocalizations.of(context)!.delete,
    ];
  }

  void checkPasscode() async {
    if (passcodeConfirm.toString() == widget.passcode) {
      await showDialog(
        context: context,
        builder: (_) {
          return const AppDialog(
            child: PinSuccessDialog(),
          );
        },
      );
      SettingProvider settingProvider = context.read<SettingProvider>();
      Setting setting = settingProvider.setting;
      setting = setting.copyWith(
        hasPasscode: true,
        passcode: passcodeConfirm.toString(),
      );
      settingProvider.setSetting(setting);
      // ignore: use_build_context_synchronously
      Navigator.pushNamed(
        context,
        MyApp.routeName,
      );
    } else {
      setState(() {
        isWrong = true;
        passcodeConfirm = ['', '', '', ''];
        indexTmp = 0;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: size.width * 0.2,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: size.height * .1),
              Text(
                AppLocalizations.of(context)!.confirmYourPasscode,
                style: AppStyles.semibold,
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: passcodeConfirm.map((e) {
                  if (e.isEmpty) {
                    return _buildUnActiveBox();
                  }
                  return _buildActiveBox();
                }).toList(),
              ),
              if (isWrong) ...[
                const SizedBox(height: 10),
                Text(
                  AppLocalizations.of(context)!.pinNotMatch,
                  style: AppStyles.medium.copyWith(
                    color: AppColors.orange,
                  ),
                )
              ],
              SizedBox(height: size.height * .1),
              Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20,
                  ),
                  itemBuilder: (context, index) {
                    String s = input[index];

                    if (index == 9 || index == 11) {
                      return GestureDetector(
                          onTap: () {
                            if (index == 11) {
                              setState(() {
                                passcodeConfirm.removeAt(--indexTmp);
                                passcodeConfirm.add('');
                                //indexTmp--;
                              });
                            } else if (index == 9) {
                              Navigator.pop(context);
                            }
                          },
                          child: _buildInput(s, AppColors.primaryColor));
                    }
                    return GestureDetector(
                      onTap: () async {
                        setState(() {
                          passcodeConfirm[indexTmp++] = s;
                        });

                        if (indexTmp == 4) {
                          checkPasscode();
                        }
                      },
                      child: _buildInput(s, null),
                    );
                  },
                  itemCount: input.length,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container _buildInput(String s, Color? color) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.boxColor,
      ),
      child: Center(
        child: Text(
          s,
          style: color != null
              ? AppStyles.medium.copyWith(color: color)
              : AppStyles.bold.copyWith(
                  color: AppColors.textPrimaryColor,
                ),
        ),
      ),
    );
  }

  Container _buildActiveBox() {
    return Container(
      width: 20,
      height: 20,
      margin: const EdgeInsets.only(left: 10),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.selectedColor,
      ),
    );
  }

  Container _buildUnActiveBox() {
    return Container(
      width: 20,
      height: 20,
      margin: const EdgeInsets.only(left: 10),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.backgroundColor,
        border: Border.all(
          color: AppColors.textPrimaryColor,
        ),
      ),
    );
  }
}
