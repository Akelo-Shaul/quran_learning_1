import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran_learning_1/ui/quranLearning/utils/ColorsRes.dart';
import 'package:quran_learning_1/ui/theme/colors.dart';

class ThemeAndRTLState {
  final ThemeData theme;
  final TextDirection textDirection;

  ThemeAndRTLState(this.theme, this.textDirection);
}

class ThemeAndRTLCubit extends Cubit<ThemeAndRTLState> {
  ThemeAndRTLCubit()
      : super(
          ThemeAndRTLState(
            ThemeData(
              useMaterial3: false,
              colorScheme: ColorScheme.light(
                secondary: const Color(0xfff1f6fa),
                onSecondary: const Color(0xff7d8698),
                surface: Colors.white,
                onSurface: const Color(0xffF7F9FC),
                primary: colorThemes.first.primaryColor,
                primaryContainer: colorThemes.first.darkPrimaryColor,
              ),
              snackBarTheme: SnackBarThemeData(
                backgroundColor: Colors.grey[400],
                contentTextStyle: TextStyle(color: Colors.blue),
                elevation: 6.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15), // Rounded corners
                  // side: BorderSide(
                  //     // color: ColorsRes.appcolor,
                  //     width: 1
                  // ), // Blue border
                ),
                behavior: SnackBarBehavior.floating, // Makes the SnackBar float
              ),
            ),
            TextDirection.ltr,
          ),
        );

  void changeTheme(ColorTheme colorTheme) {
    final currentTheme = state.theme;
    final currentTextDirection = state.textDirection;
    emit(ThemeAndRTLState(
        currentTheme.copyWith(
            colorScheme: currentTheme.colorScheme.copyWith(
          primary: colorTheme.primaryColor,
          primaryContainer: colorTheme.darkPrimaryColor,
        )),
        currentTextDirection));
  }

  void changeTextDirection(TextDirection textDirection) {
    final currentTheme = state.theme;
    emit(ThemeAndRTLState(currentTheme, textDirection));
  }
}
