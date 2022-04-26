import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project_template/presentation/independent_widgets/custom_snackbar.dart';
import 'package:flutter_project_template/presentation/router/app_router.dart';
import 'package:flutter_project_template/presentation/router/screen_args.dart';
import 'package:has_wifi_rtt/has_wifi_rtt.dart';

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
  Future<bool> _hasWifiRtt = HasWifiRtt.checkRtt();

  return Column(
    children: [
      const Padding(padding: EdgeInsets.only(top: 50)),

      //! Internet connection type
      BlocBuilder<InternetConnectivityCubit, InternetConnectivityState>(
        builder: (context, state) {
          if (state is ConnectivityResultState) {
            return Text(
              "Connection Type: ${state.connectivityResult}",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleLarge,
            );
          } else {
            return Container();
          }
        },
      ),
      Text(
        "Using StreamSubsription",
        style: Theme.of(context).textTheme.bodySmall,
        textAlign: TextAlign.center,
      ),
      const Padding(padding: EdgeInsets.only(top: 50)),

      //! Wi-Fi Rtt support check
      FutureBuilder<bool>(
          future: _hasWifiRtt,
          builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
            if (snapshot.hasData) {
              return Column(
                children: [
                  Text(
                    "Wi-Fi Rtt support: ${snapshot.data}",
                    style: const TextStyle(fontSize: 20),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    "Using FutureBuilder",
                    style: Theme.of(context).textTheme.bodySmall,
                    textAlign: TextAlign.center,
                  ),
                ],
              );
            }
            return Container();
          }),

      const Padding(padding: EdgeInsets.only(top: 100)),

      //! Info about hydrated cubit
      const Text(
        Strings.counterValueInfo,
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 20),
      ),
      const Padding(padding: EdgeInsets.only(top: 50)),

      //! Value of counter
      BlocBuilder<CounterCubit, int>(
        builder: (context, state) {
          return Text(
            "$state",
            style: const TextStyle(fontSize: 20),
            textAlign: TextAlign.center,
          );
        },
      ),
      Text(
        "Using BlocBuilder",
        style: Theme.of(context).textTheme.bodySmall,
        textAlign: TextAlign.center,
      ),
      //! Increment and decrement buttons
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

      //! Go to second screen button
      TextButton(
          onPressed: () => AppRouter.pushWithArgument(
              context: context,
              pageName: AppRouter.secondScreen,
              args: SecondScreenArgs(
                  counterValue: context.read<CounterCubit>().state)),
          child: const Text(
            Strings.goToSecondScreenText,
            textAlign: TextAlign.center,
            //style: Theme.of(context).primaryTextTheme.titleSmall
          ),
          style: Theme.of(context).textButtonTheme.style),
      Text(
        "Using Router",
        style: Theme.of(context).textTheme.bodySmall,
        textAlign: TextAlign.center,
      ),
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
