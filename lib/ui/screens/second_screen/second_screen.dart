import 'package:flutter/material.dart';

import 'package:flutter_project_template/core/app_router/screen_args.dart';
import 'package:flutter_project_template/core/constants/strings.dart';
import 'package:flutter_project_template/ui/independent_widgets/general_app_bar.dart';

/// The second screen.
class SecondScreen extends StatelessWidget {
  /// Constructor.
  const SecondScreen({
    Key? key,
    required this.args,
  }) : super(key: key);

  /// Screen args.
  final SecondScreenArgs args;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const GeneralAppBar(title: Strings.secondScreenTitle),
      body: _buildBody(context, args.counterValue),
    );
  }
}

Column _buildBody(BuildContext context, int value) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text(
        Strings.secondScreenInfo,
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.titleLarge,
      ),
      const Padding(padding: EdgeInsets.only(top: 100)),
      Text(
        'Counter value: $value',
        style: Theme.of(context).textTheme.bodyLarge,
      )
    ],
  );
}
