import 'package:diary_app/constants/app_assets.dart';
import 'package:diary_app/constants/app_colors.dart';
import 'package:diary_app/constants/app_styles.dart';
import 'package:diary_app/constants/bean.dart';
import 'package:diary_app/constants/utils.dart';
import 'package:diary_app/features/setting/models/setting.dart';
import 'package:diary_app/features/setting/widgets/buy_success_dialog.dart';
import 'package:diary_app/providers/setting_provider.dart';
import 'package:diary_app/widgets/app_dialog.dart';
import 'package:diary_app/widgets/box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class ItemThemeStore extends StatelessWidget {
  final Bean bean;
  final int coin;

  const ItemThemeStore({
    super.key,
    required this.bean,
    required this.coin,
  });

  void buyBean(BuildContext context) async {
    final SettingProvider settingProvider = context.read<SettingProvider>();
    Setting setting = settingProvider.setting;
    List<Bean> myBeans = setting.myBeans;

    if (setting.point >= coin) {
      myBeans.add(bean);

      setting = setting.copyWith(
        point: setting.point - coin,
        myBeans: myBeans,
      );
      settingProvider.setSetting(setting);
      await showDialog(
        context: context,
        builder: (_) {
          return const AppDialog(
            child: BuySuccessDialog(),
          );
        },
      );
      Navigator.pop(context);
    } else {
      int pointNeed = coin - setting.point;

      showSnackBar(
        context,
        AppLocalizations.of(context)!.buyFailed(pointNeed.toString()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20.0,
        vertical: 10,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Box(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: bean.beans
                  .map(
                    (e) => Image.asset(
                      e,
                      width: 60,
                      height: 60,
                    ),
                  )
                  .toList(),
            ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                bean.nameBean,
                style: AppStyles.semibold,
              ),
              !checkBean(context, bean)
                  ? GestureDetector(
                      onTap: () => buyBean(context),
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: AppColors.textPrimaryColor,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          children: [
                            Image.asset(
                              AppAssets.iconCoin,
                              width: 15,
                              height: 15,
                            ),
                            const SizedBox(width: 5),
                            Text(
                              '$coin ${AppLocalizations.of(context)!.coin}',
                              style: AppStyles.medium.copyWith(
                                fontSize: 15,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  : Text(
                      AppLocalizations.of(context)!.owned,
                      style: AppStyles.medium.copyWith(
                        fontSize: 15,
                      ),
                    ),
            ],
          ),
        ],
      ),
    );
  }

  bool checkBean(BuildContext context, Bean bean) {
    final settingProvider = context.read<SettingProvider>();
    Setting setting = settingProvider.setting;

    for (var b in setting.myBeans) {
      if (b.nameBean == bean.nameBean) {
        return true;
      }
    }
    return false;
  }
}
