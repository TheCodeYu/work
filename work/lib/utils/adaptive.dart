// Copyright 2019 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:math';

import 'package:adaptive_breakpoints/adaptive_breakpoints.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:work/blocs/global/global_bloc.dart';

// height of the 'Gallery' header
const double HeaderHeight = 64;

// The font size delta for headline4 font.
const double desktopDisplay1FontDelta = 16;

// The width of the settingsDesktop.
const double desktopSettingsWidth = 520;

// Sentinel value for the system text scale factor option.
const double systemTextScaleFactorOption = -1;

// The splash page animation duration.
const splashPageAnimationDurationInMilliseconds = 300;

// The desktop top padding for a page's first header (e.g. Gallery, Settings)
const firstHeaderDesktopTopPadding = 5.0;

/// Returns a boolean value whether the window is considered medium or large size.
///
/// Used to build adaptive and responsive layouts.
bool isDisplayDesktop(BuildContext context) =>
    getWindowType(context) >= AdaptiveWindowType.medium;

/// Returns boolean value whether the window is considered medium size.
///
/// Used to build adaptive and responsive layouts.
bool isDisplaySmallDesktop(BuildContext context) {
  return getWindowType(context) == AdaptiveWindowType.medium;
}

/// A constant that is true if the application was compiled to run on the web.
///
/// This implementation takes advantage of the fact that JavaScript does not
/// support integers. In this environment, Dart's doubles and ints are
/// backed by the same kind of object. Thus a double `0.0` is identical
/// to an integer `0`. This is not true for Dart code running in AOT or on the
/// VM.
const bool kIsWeb = identical(0, 0.0);

///字体大小设计
double _textScaleFactor(BuildContext context, {bool useSentinel = false}) {
  var temp = BlocProvider.of<GlobalBloc>(context).state;
  if (temp.textScaleFactor == systemTextScaleFactorOption) {
    return useSentinel
        ? systemTextScaleFactorOption
        : MediaQuery.of(context).textScaleFactor;
  } else {
    return temp.textScaleFactor;
  }
}

// When text is larger, this factor becomes larger, but at half the rate.
//
// | Text scaling | Text scale factor | reducedTextScale(context) |
// |--------------|-------------------|---------------------------|
// | Small        |               0.8 |                       1.0 |
// | Normal       |               1.0 |                       1.0 |
// | Large        |               2.0 |                       1.5 |
// | Huge         |               3.0 |                       2.0 |

double reducedTextScale(BuildContext context) {
  final textScaleFactor = _textScaleFactor(context);
  return textScaleFactor >= 1 ? (1 + textScaleFactor) / 2 : 1;
}

// When text is larger, this factor becomes larger at the same rate.
// But when text is smaller, this factor stays at 1.
//
// | Text scaling | Text scale factor |  cappedTextScale(context) |
// |--------------|-------------------|---------------------------|
// | Small        |               0.8 |                       1.0 |
// | Normal       |               1.0 |                       1.0 |
// | Large        |               2.0 |                       2.0 |
// | Huge         |               3.0 |                       3.0 |

double cappedTextScale(BuildContext context) {
  final textScaleFactor = _textScaleFactor(context);
  return max(textScaleFactor, 1);
}

double letterSpacingOrNone(double letterSpacing) =>
    kIsWeb ? 0.0 : letterSpacing;
