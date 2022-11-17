import 'package:chat_app/presentation/services/app_state_provider/app_state_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'feature_setting.dart';

class ChangeLanguage extends StatelessWidget {
  final AppStateProvider app;
  const ChangeLanguage({super.key, required this.app});

  @override
  Widget build(BuildContext context) {
    return FeatureSetting(
      icon: CupertinoIcons.textformat,
      title: AppLocalizations.of(context)!.language,
      color: Colors.green[400]!,
      onTap: () {
        showModalBottomSheet<void>(
          context: context,
          backgroundColor: Colors.transparent,
          builder: (BuildContext context) {
            return Container(
              height: 180.h,
              padding: EdgeInsets.symmetric(
                vertical: 12.h,
                horizontal: 20.w,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12.h),
                  topRight: Radius.circular(12.h),
                ),
              ),
              child: Center(
                child: Column(
                  children: [
                    Text(
                      AppLocalizations.of(context)!.change_language,
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(color: Colors.black),
                    ),
                    SizedBox(height: 8.h),
                    ListTile(
                      onTap: () => _changeLocale(context, 'vi'),
                      leading: SizedBox(
                        width: 28.w,
                        child: Image.asset(
                          "assets/logos/vietname_icon.png",
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                      title: Text(
                        AppLocalizations.of(context)!.viet_nam,
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(color: Colors.black),
                      ),
                      trailing: app.currentLocal != null &&
                              app.currentLocal!.languageCode == 'vi'
                          ? const Icon(
                              CupertinoIcons.check_mark_circled,
                              color: Colors.blue,
                            )
                          : null,
                    ),
                    ListTile(
                        onTap: () => _changeLocale(context, 'en'),
                        leading: SizedBox(
                          width: 28.w,
                          child: Image.asset(
                            "assets/logos/english_icon.png",
                            fit: BoxFit.fitWidth,
                          ),
                        ),
                        title: Text(
                          AppLocalizations.of(context)!.english,
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(color: Colors.black),
                        ),
                        trailing: app.currentLocal != null &&
                                app.currentLocal!.languageCode == 'en'
                            ? const Icon(
                                CupertinoIcons.check_mark_circled,
                                color: Colors.blue,
                              )
                            : null),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  _changeLocale(BuildContext context, String locale) {
    app.changeLocal = locale;
  }
}
