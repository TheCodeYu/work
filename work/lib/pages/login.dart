// Copyright 2019 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:work/blocs/detail/detail_bloc.dart';
import 'package:work/components/image_placeholder.dart';

import 'package:work/utils/adaptive.dart';

const defaultLetterSpacing = 0.03;
const mediumLetterSpacing = 0.04;
const largeLetterSpacing = 1.0;
const _horizontalPadding = 24.0;

double desktopLoginScreenMainAreaWidth(BuildContext context) {
  return min(
    360 * reducedTextScale(context),
    MediaQuery.of(context).size.width - 2 * _horizontalPadding,
  );
}

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);
  static const String defaultRoute = '/login_page';
  @override
  Widget build(BuildContext context) {
    final isDesktop = isDisplayDesktop(context);

    return isDesktop
        ? LayoutBuilder(
            builder: (context, constraints) => Scaffold(
              body: SafeArea(
                child: Center(
                  child: SizedBox(
                    width: desktopLoginScreenMainAreaWidth(context),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        _ShrineLogo(),
                        SizedBox(height: 40),
                        _UsernameTextField(),
                        SizedBox(height: 16),
                        _PasswordTextField(),
                        SizedBox(height: 24),
                        _CancelAndNextButtons(),
                        SizedBox(height: 62),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          )
        : Scaffold(
            appBar: AppBar(backgroundColor: Colors.white),
            body: SafeArea(
              child: ListView(
                restorationId: 'login_list_view',
                physics: const ClampingScrollPhysics(),
                padding: const EdgeInsets.symmetric(
                  horizontal: _horizontalPadding,
                ),
                children: const [
                  SizedBox(height: 80),
                  _ShrineLogo(),
                  SizedBox(height: 120),
                  _UsernameTextField(),
                  SizedBox(height: 12),
                  _PasswordTextField(),
                  _CancelAndNextButtons(),
                ],
              ),
            ),
          );
  }
}

class _ShrineLogo extends StatelessWidget {
  const _ShrineLogo();

  @override
  Widget build(BuildContext context) {
    return ExcludeSemantics(
      child: Column(
        children: [
          const FadeInImagePlaceholder(
            image: AssetImage('images/logo.png'),
            placeholder: SizedBox(
              width: 34,
              height: 34,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'SHRINE',
            style: Theme.of(context).textTheme.headline5,
          ),
        ],
      ),
    );
  }
}

class _UsernameTextField extends StatelessWidget {
  const _UsernameTextField();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return PrimaryColorOverride(
      child: TextField(
        textInputAction: TextInputAction.next,
        restorationId: 'username_text_field',
        cursorColor: colorScheme.onSurface,
        decoration: InputDecoration(
          labelText: 'shrineLoginUsernameLabel',
          labelStyle: TextStyle(
              letterSpacing: letterSpacingOrNone(mediumLetterSpacing)),
        ),
      ),
    );
  }
}

class _PasswordTextField extends StatelessWidget {
  const _PasswordTextField();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return PrimaryColorOverride(
      child: TextField(
        restorationId: 'password_text_field',
        cursorColor: colorScheme.onSurface,
        obscureText: true,
        decoration: InputDecoration(
          labelText: 'shrineLoginPasswordLabel',
          labelStyle: TextStyle(
              letterSpacing: letterSpacingOrNone(mediumLetterSpacing)),
        ),
      ),
    );
  }
}

class _CancelAndNextButtons extends StatelessWidget {
  const _CancelAndNextButtons();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    final isDesktop = isDisplayDesktop(context);

    final buttonTextPadding = isDesktop
        ? const EdgeInsets.symmetric(horizontal: 24, vertical: 16)
        : EdgeInsets.zero;

    return Padding(
      padding: isDesktop ? EdgeInsets.zero : const EdgeInsets.all(8),
      child: OverflowBar(
        spacing: isDesktop ? 0 : 8,
        children: [
          TextButton(
            style: TextButton.styleFrom(
              shape: const BeveledRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(7)),
              ),
            ),
            onPressed: () {
              // The login screen is immediately displayed on top of
              // the Shrine home screen using onGenerateRoute and so
              // rootNavigator must be set to true in order to get out
              // of Shrine completely.
              Navigator.of(context, rootNavigator: true).pop();
            },
            child: Padding(
              padding: buttonTextPadding,
              child: Text(
                'shrineCancelButtonCaption',
                style: TextStyle(color: colorScheme.onSurface),
              ),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              elevation: 8,
              shape: const BeveledRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(7)),
              ),
            ),
            onPressed: () {
              BlocProvider.of<DetailBloc>(context)
                ..add(DetailUpdateApp('wqerwqewqewqewqewer'));
              Navigator.of(context).pop();
            },
            child: Padding(
              padding: buttonTextPadding,
              child: Text(
                'shrineNextButtonCaption',
                style: TextStyle(
                    letterSpacing: letterSpacingOrNone(largeLetterSpacing)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class PrimaryColorOverride extends StatelessWidget {
  const PrimaryColorOverride({Key? key, this.color, required this.child})
      : super(key: key);

  final Color? color;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data:
          Theme.of(context).copyWith(primaryColor: color ?? Colors.transparent),
      child: child,
    );
  }
}
