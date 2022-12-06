import 'package:diary_app/constants/app_colors.dart';
import 'package:diary_app/constants/app_styles.dart';
import 'package:diary_app/my_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EnterPinScreen extends StatefulWidget {
  const EnterPinScreen({super.key, required this.passcode});
  final String passcode;

  static const String routeName = '/enter_pin_screen';
  @override
  State<EnterPinScreen> createState() => _EnterPinScreenState();
}

class _EnterPinScreenState extends State<EnterPinScreen> {
  late List<String> input;
  int indexTmp = 0;
  List<String> passcode = ['', '', '', ''];

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
      '',
      '0',
      AppLocalizations.of(context)!.delete,
    ];
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
                AppLocalizations.of(context)!.enterPin,
                style: AppStyles.semibold,
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: passcode.map((e) {
                  if (e.isEmpty) {
                    return _buildUnActiveBox();
                  }
                  return _buildActiveBox();
                }).toList(),
              ),
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
                                passcode.removeAt(--indexTmp);
                                passcode.add('');
                              });
                            } else if (index == 9) {
                              Navigator.pop(context);
                            }
                          },
                          child: _buildInput(s, AppColors.primaryColor));
                    }
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          passcode[indexTmp++] = s;
                        });
                        if (indexTmp == 4) {
                          if (passcode.toString() == widget.passcode) {
                            SchedulerBinding.instance.addPostFrameCallback((_) {
                              Navigator.pushNamed(
                                context,
                                MyApp.routeName,
                              );
                            });
                          }
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
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
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
