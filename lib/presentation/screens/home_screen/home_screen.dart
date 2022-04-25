import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project_template/presentation/independent_widgets/custom_snackbar.dart';
import 'package:flutter_project_template/presentation/router/app_router.dart';
import 'package:flutter_project_template/presentation/router/screen_args.dart';

import '../../../core/constants/icons.dart';
import '../../../core/constants/strings.dart';
import '../../../core/themes/app_theme.dart';
import '../../../logic/counter/cubit/counter_cubit.dart';
import '../../../logic/internet_connectivity/cubit/internet_connectivity_cubit.dart';
import '../../../logic/theme/cubit/theme_cubit.dart';
import '../../independent_widgets/custom_app_bar.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(
          title: Strings.homeScreenTitle,
          actions: _buildAppBarActions(context),
        ),
        body: _buildBody(context));
  }
}

Column _buildBody(BuildContext context) {
  return Column(
    children: [
      const Padding(padding: EdgeInsets.only(top: 50)),
      BlocBuilder<InternetConnectivityCubit, InternetConnectivityState>(
        builder: (context, state) {
          if (state is ConnectivityResultState) {
            return Text(
              "Connection Type: ${state.connectivityResult}",
              style: Theme.of(context).textTheme.titleLarge,
            );
          } else {
            return Container();
          }
        },
      ),
      const Padding(padding: EdgeInsets.only(top: 150)),
      const Text(
        Strings.counterValueInfo,
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 20),
      ),
      const Padding(padding: EdgeInsets.only(top: 50)),
      BlocBuilder<CounterCubit, int>(
        builder: (context, state) {
          return Text("$state", style: const TextStyle(fontSize: 20));
        },
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          FloatingActionButton(
              heroTag: "decrement",
              child: AppIcons.decrement,
              onPressed: () {
                context.read<CounterCubit>().decrement();
                CustomSnackbar.showSnackbarWithAction(
                    context: context, message: Strings.onDecrementedText);
              }),
          FloatingActionButton(
              heroTag: "increment",
              child: AppIcons.increment,
              onPressed: () {
                context.read<CounterCubit>().increment();
                CustomSnackbar.showSnackbarWithAction(
                    context: context, message: Strings.onIncrementedText);
              }),
        ],
      ),
      const Padding(padding: EdgeInsets.only(top: 100)),
      TextButton(
        onPressed: () => AppRouter.pushWithArgument(
            context: context,
            pageName: AppRouter.secondScreen,
            args: SecondScreenArgs(
                counterValue: context.read<CounterCubit>().state)),
        child: Text(Strings.goToSecondScreenText,
            style: Theme.of(context).primaryTextTheme.titleSmall),
        style: ButtonStyle(
            backgroundColor:
                MaterialStateProperty.all(Theme.of(context).primaryColor)),
      )
    ],
  );
}

List<Widget> _buildAppBarActions(BuildContext context) {
  return [
    context.read<ThemeCubit>().state == AppTheme.lightTheme
        ? AppIcons.darkMode
        : AppIcons.lightMode,
    Switch(
        activeColor: Colors.white,
        value: context.read<ThemeCubit>().state == AppTheme.lightTheme
            ? true
            : false,
        onChanged: (value) {
          context.read<ThemeCubit>().switchTheme();
        })
  ];
}
