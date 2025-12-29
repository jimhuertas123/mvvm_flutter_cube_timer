import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// Pair of colors for gradient backgrounds
class ColorBackgroundPair {
  final Color primaryColor;
  final Color secondaryColor;

  const ColorBackgroundPair({
    required this.primaryColor,
    required this.secondaryColor,
  });
}

/// Complete color theme definition
class ColorAppTheme {
  final ColorBackgroundPair bgPatternColor;
  final bool isDarkmode;
  final Color appBarColor;
  final Color bottomBarColor;
  final String name;

  const ColorAppTheme({
    required this.bgPatternColor,
    required this.appBarColor,
    required this.bottomBarColor,
    required this.isDarkmode,
    required this.name,
  });
}

/// Text color theme definition
class AppTextTheme {
  final Color? colorText;
  final String name;

  const AppTextTheme({this.colorText, required this.name});
}

/// 24 preset color themes
const appColorTheme = <ColorAppTheme>[
  // 1 - Hazy Blues
  ColorAppTheme(
    isDarkmode: true,
    bgPatternColor: ColorBackgroundPair(
      primaryColor: Color(0xFF1959FF),
      secondaryColor: Color(0xFF3b12ff),
    ),
    appBarColor: Color(0xff0045f6),
    bottomBarColor: Color(0xff2900ef),
    name: 'Hazy\nBlues',
  ),
  // 2 - Spotty Guy
  ColorAppTheme(
    isDarkmode: true,
    bgPatternColor: ColorBackgroundPair(
      primaryColor: Color(0xFF0D0D0D),
      secondaryColor: Color(0xFF0D0D0D),
    ),
    appBarColor: Color(0xFF171717),
    bottomBarColor: Color(0xFF171717),
    name: 'Spotty\nGuy',
  ),
  // 3 - Simply White
  ColorAppTheme(
    isDarkmode: false,
    bgPatternColor: ColorBackgroundPair(
      primaryColor: Color(0xFFFFFFFF),
      secondaryColor: Color(0xFFFFFFFF),
    ),
    appBarColor: Color(0xFFFFFEFF),
    bottomBarColor: Color(0xFFffffff),
    name: 'Simply\nWhite',
  ),
  // 4 - Bluy Gray
  ColorAppTheme(
    isDarkmode: true,
    bgPatternColor: ColorBackgroundPair(
      primaryColor: Color(0xFF607D8B),
      secondaryColor: Color(0xFF455A64),
    ),
    appBarColor: Color(0xFF678695),
    bottomBarColor: Color(0xFF3e515a),
    name: 'Bluy\nGray',
  ),
  // 5 - Pixie Falls
  ColorAppTheme(
    isDarkmode: false,
    bgPatternColor: ColorBackgroundPair(
      primaryColor: Color(0xFFfcd6e3),
      secondaryColor: Color(0xFFaaf0ed),
    ),
    appBarColor: Color(0xFFfde6ee),
    bottomBarColor: Color(0xFF8debe7),
    name: 'Pixie\nFalls',
  ),
  // 6 - Wandy Dusk
  ColorAppTheme(
    isDarkmode: true,
    bgPatternColor: ColorBackgroundPair(
      primaryColor: Color(0xFF8e78ff),
      secondaryColor: Color(0xFFfc7d7b),
    ),
    appBarColor: Color(0xFF8067ff),
    bottomBarColor: Color(0xFFfb5c5a),
    name: 'Wandy\nDusk',
  ),
  // 7 - Quite Purply
  ColorAppTheme(
    isDarkmode: true,
    bgPatternColor: ColorBackgroundPair(
      primaryColor: Color(0xFFED1E79),
      secondaryColor: Color(0xFF662D8C),
    ),
    appBarColor: Color(0xFFd81169),
    bottomBarColor: Color(0xFF5d297f),
    name: 'Quite\nPurply',
  ),
  // 8 - Definitely Purple
  ColorAppTheme(
    isDarkmode: true,
    bgPatternColor: ColorBackgroundPair(
      primaryColor: Color(0xFF673AB7),
      secondaryColor: Color(0xff512DA8),
    ),
    appBarColor: Color(0XFF6e40c2),
    bottomBarColor: Color(0xFF4b299b),
    name: 'Definitely\nPurple',
  ),
  // 9 - Pinky Promises
  ColorAppTheme(
    isDarkmode: true,
    bgPatternColor: ColorBackgroundPair(
      primaryColor: Color(0xffFF577E),
      secondaryColor: Color(0xFFFD61C0),
    ),
    appBarColor: Color(0xffFF678A),
    bottomBarColor: Color(0xfffd50b9),
    name: 'Pinky\nPromises',
  ),
  // 10 - Earthy Teal
  ColorAppTheme(
    isDarkmode: false,
    bgPatternColor: ColorBackgroundPair(
      primaryColor: Color(0xFF18ff97),
      secondaryColor: Color(0xFF24f594),
    ),
    appBarColor: Color(0xff29ff9f),
    bottomBarColor: Color(0xff0bec84),
    name: 'Earthy\nTeal',
  ),
  // 11 - Lightly Skyish
  ColorAppTheme(
    isDarkmode: false,
    bgPatternColor: ColorBackgroundPair(
      primaryColor: Color(0xFF3AFAFA),
      secondaryColor: Color(0xFF42F7CD),
    ),
    appBarColor: Color(0xFF5bfbfb),
    bottomBarColor: Color(0xFF31F7C9),
    name: 'Lightly\nSkyish',
  ),
  // 12 - Icy Hills
  ColorAppTheme(
    isDarkmode: false,
    bgPatternColor: ColorBackgroundPair(
      primaryColor: Color(0xFFFFFEFF),
      secondaryColor: Color(0xFFD7FFFE),
    ),
    appBarColor: Color(0xFFFFFEFF),
    bottomBarColor: Color(0xFFe8fffe),
    name: 'Icy Hills',
  ),
  // 13 - What Green
  ColorAppTheme(
    isDarkmode: false,
    bgPatternColor: ColorBackgroundPair(
      primaryColor: Color(0xFF6cf63e),
      secondaryColor: Color(0xFF15ff8e),
    ),
    appBarColor: Color(0xFF78f74e),
    bottomBarColor: Color(0xFF00f27d),
    name: 'What...\nGreen?',
  ),
  // 14 - Simply Black
  ColorAppTheme(
    isDarkmode: true,
    bgPatternColor: ColorBackgroundPair(
      primaryColor: Color(0xFF000000),
      secondaryColor: Color(0xFF000000),
    ),
    appBarColor: Color(0xFF000000),
    bottomBarColor: Color(0xFF000000),
    name: 'Simply\nBlack',
  ),
  // 15 - Notably Yellow
  ColorAppTheme(
    isDarkmode: false,
    bgPatternColor: ColorBackgroundPair(
      primaryColor: Color(0xFFFFEB7E),
      secondaryColor: Color(0xFFFFFD69),
    ),
    appBarColor: Color(0xFFffee8f),
    bottomBarColor: Color(0xFFfffd7a),
    name: 'Notably\nYellow',
  ),
  // 16 - Turtly Sea
  ColorAppTheme(
    isDarkmode: false,
    bgPatternColor: ColorBackgroundPair(
      primaryColor: Color(0xFFb2f9ff),
      secondaryColor: Color(0xFFefebbe),
    ),
    appBarColor: Color(0xFFd4fcff),
    bottomBarColor: Color(0xFFe8e3a3),
    name: 'Turtly\nSea',
  ),
  // 17 - Oof Hot
  ColorAppTheme(
    isDarkmode: false,
    bgPatternColor: ColorBackgroundPair(
      primaryColor: Color(0xFFfbb74c),
      secondaryColor: Color(0xFFFF5656),
    ),
    appBarColor: Color(0xFFfcc46d),
    bottomBarColor: Color(0xFFFF5656),
    name: 'Oof Hot',
  ),
  // 18 - Relaxing Dawn
  ColorAppTheme(
    isDarkmode: false,
    bgPatternColor: ColorBackgroundPair(
      primaryColor: Color(0xFFfccb90),
      secondaryColor: Color(0xFFd57eeb),
    ),
    appBarColor: Color(0xFFfddab1),
    bottomBarColor: Color(0xFFd06fe9),
    name: 'Relaxing\nDawn',
  ),
  // 19 - Even Purplier
  ColorAppTheme(
    isDarkmode: true,
    bgPatternColor: ColorBackgroundPair(
      primaryColor: Color(0xFF920EE6),
      secondaryColor: Color(0xFF6304E9),
    ),
    appBarColor: Color(0xFF9b14f1),
    bottomBarColor: Color(0xFF5503c8),
    name: 'Even\nPurplier',
  ),
  // 20 - Tantalizing
  ColorAppTheme(
    isDarkmode: true,
    bgPatternColor: ColorBackgroundPair(
      primaryColor: Color(0xFFED1C24),
      secondaryColor: Color(0xFFFF6219),
    ),
    appBarColor: Color(0xFFd61119),
    bottomBarColor: Color(0xFFe54900),
    name: 'Tantali\nzing',
  ),
  // 21 - Delicious Brownie
  ColorAppTheme(
    isDarkmode: true,
    bgPatternColor: ColorBackgroundPair(
      primaryColor: Color(0xFF5C3C30),
      secondaryColor: Color(0xFF422A24),
    ),
    appBarColor: Color(0xFF724b3c),
    bottomBarColor: Color(0xFF37231e),
    name: 'Delicious\nBrownie',
  ),
  // 22 - Greeny Gorilla
  ColorAppTheme(
    isDarkmode: false,
    bgPatternColor: ColorBackgroundPair(
      primaryColor: Color(0xFFa8ff78),
      secondaryColor: Color(0xFF78ffd6),
    ),
    appBarColor: Color(0xFFBBFF96),
    bottomBarColor: Color(0xFF93FFB9),
    name: 'Greeny\nGorilla',
  ),
  // 23 - Cyanic Teal
  ColorAppTheme(
    isDarkmode: false,
    bgPatternColor: ColorBackgroundPair(
      primaryColor: Color(0xFF00FFA1),
      secondaryColor: Color(0xFF00FFFF),
    ),
    appBarColor: Color(0xFF55FFC0),
    bottomBarColor: Color(0xFF6FF6FF),
    name: 'Cyanic\nTeal',
  ),
  // 24 - Greeny Everest
  ColorAppTheme(
    isDarkmode: false,
    bgPatternColor: ColorBackgroundPair(
      primaryColor: Color(0xFFc6ffbd),
      secondaryColor: Color(0xFFffffff),
    ),
    appBarColor: Color(0xFFd5ffce),
    bottomBarColor: Color(0xFFf2fff0),
    name: 'Greeny\nEverest',
  ),
];

/// 15 preset text themes
const appTextTheme = <AppTextTheme>[
  AppTextTheme(name: "Default"),
  AppTextTheme(colorText: Color(0xFFFF1744), name: "Pessoa"),
  AppTextTheme(colorText: Color(0xFFFF2A9F), name: "Lou"),
  AppTextTheme(colorText: Color(0xFFFF4500), name: "Burgess"),
  AppTextTheme(colorText: Color(0xFFE86E60), name: "Bowie"),
  AppTextTheme(colorText: Color(0xFFFFD4F9), name: "Brie"),
  AppTextTheme(colorText: Color(0xFF651FFF), name: "Matsson"),
  AppTextTheme(colorText: Color(0xFF2962FF), name: "Isakov"),
  AppTextTheme(colorText: Color(0xFF54FFFF), name: "Adams"),
  AppTextTheme(colorText: Color(0xFF006B21), name: "Irwin"),
  AppTextTheme(colorText: Color(0xFF00E676), name: "Tarkovsky"),
  AppTextTheme(colorText: Color(0xFF82FFB3), name: "Ebert"),
  AppTextTheme(colorText: Color(0xFFFFFF4C), name: "Tolkien"),
  AppTextTheme(colorText: Color(0xFFFFFDBB), name: "Asimov"),
  AppTextTheme(colorText: Color(0xFFBDBDBD), name: "Kubrick"),
];

/// Main app theme state class
class AppTheme {
  final Brightness statusBarTextColor;
  final int actualThemeIndex;
  final int actualTextThemeIndex;
  final bool isDarkmode;

  AppTheme({
    required this.actualThemeIndex,
    required this.actualTextThemeIndex,
    required this.statusBarTextColor,
    required this.isDarkmode,
  })  : assert(actualThemeIndex >= 0, 'Selected color must be >= 0'),
        assert(
          actualThemeIndex < appColorTheme.length,
          'Selected color must be < ${appColorTheme.length}',
        ),
        assert(actualTextThemeIndex >= 0, 'Selected text theme must be >= 0'),
        assert(
          actualTextThemeIndex < appTextTheme.length,
          'Selected text theme must be < ${appTextTheme.length}',
        );

  /// Get current color theme
  ColorAppTheme get colorTheme => appColorTheme[actualThemeIndex];

  /// Get current text theme
  AppTextTheme get textTheme => appTextTheme[actualTextThemeIndex];

  /// Generate Material ThemeData
  ThemeData getTheme() => ThemeData(
        useMaterial3: true,
        brightness: isDarkmode ? Brightness.dark : Brightness.light,
        fontFamily: 'Quicksand',
        primaryColorLight: Colors.white,
        primaryColorDark: Colors.black,
        scaffoldBackgroundColor: colorTheme.bgPatternColor.primaryColor,
        appBarTheme: AppBarTheme(
          centerTitle: true,
          backgroundColor: colorTheme.appBarColor,
          foregroundColor: isDarkmode ? Colors.white : Colors.black,
          elevation: 0,
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: colorTheme.bottomBarColor,
          selectedItemColor: isDarkmode ? Colors.white : Colors.black,
          unselectedItemColor:
              (isDarkmode ? Colors.white : Colors.black).withValues(alpha: 0.5),
        ),
        cupertinoOverrideTheme: CupertinoThemeData(
          brightness: isDarkmode ? Brightness.dark : Brightness.light,
          primaryColor: colorTheme.appBarColor,
        ),
      );

  /// Generate CupertinoThemeData
  CupertinoThemeData getCupertinoTheme() => CupertinoThemeData(
        brightness: isDarkmode ? Brightness.dark : Brightness.light,
        primaryColor: colorTheme.appBarColor,
        scaffoldBackgroundColor: colorTheme.bgPatternColor.primaryColor,
        barBackgroundColor: colorTheme.bottomBarColor,
        textTheme: CupertinoTextThemeData(
          primaryColor: isDarkmode ? Colors.white : Colors.black,
        ),
      );

  /// Copy with new values
  AppTheme copyWith({
    Brightness? statusBarTextColor,
    int? actualThemeIndex,
    int? actualTextThemeIndex,
    bool? isDarkmode,
  }) =>
      AppTheme(
        statusBarTextColor: statusBarTextColor ?? this.statusBarTextColor,
        actualTextThemeIndex: actualTextThemeIndex ?? this.actualTextThemeIndex,
        actualThemeIndex: actualThemeIndex ?? this.actualThemeIndex,
        isDarkmode: isDarkmode ?? this.isDarkmode,
      );

  /// Create default theme
  factory AppTheme.defaultTheme() => AppTheme(
        actualThemeIndex: 0, // Hazy Blues
        actualTextThemeIndex: 0, // Default (auto-contrast)
        statusBarTextColor: Brightness.light,
        isDarkmode: true,
      );
}
