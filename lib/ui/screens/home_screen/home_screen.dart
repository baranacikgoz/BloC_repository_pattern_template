import 'package:counter_repository/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/app_router/app_router.dart';
import '../../../core/app_router/screen_args.dart';
import '../../../core/constants/icons.dart';
import '../../../core/constants/strings.dart';

import 'cubits/counter_cubit/counter_cubit.dart';

import '../../independent_widgets/custom_snackbar.dart';
import '../../independent_widgets/general_app_bar.dart';
import 'cubits/internet_connectivity/internet_connectivity_cubit.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => InternetConnectivityCubit()),
        BlocProvider(
            //! context.read<CounterRepository>()
            create: (context) => CounterCubit(context.read<CounterRepository>())),
      ],
      child: Builder(builder: (context) {
        return Scaffold(
            appBar: const GeneralAppBar(title: Strings.homeScreenTitle),
            body: _buildBody(context));
      }),
    );
  }
}

Widget _buildBody(BuildContext context) {
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
      const Padding(padding: EdgeInsets.only(top: 20)),

      // //! Wi-Fi Rtt support check
      // FutureBuilder<bool>(
      //     future: _hasWifiRtt,
      //     builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
      //       if (snapshot.hasData) {
      //         return Column(
      //           children: [
      //             Text(
      //               "Wi-Fi Rtt support: ${snapshot.data}",
      //               style: const TextStyle(fontSize: 20),
      //               textAlign: TextAlign.center,
      //             ),
      //             Text(
      //               "Using FutureBuilder",
      //               style: Theme.of(context).textTheme.bodySmall,
      //               textAlign: TextAlign.center,
      //             ),
      //           ],
      //         );
      //       }
      //       return Container();
      //     }),

      const Padding(padding: EdgeInsets.only(top: 50)),

      //! Info about hydrated cubit
      const Text(
        Strings.counterValueInfo,
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 20),
      ),
      const Padding(padding: EdgeInsets.only(top: 20)),

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
                context.read<CounterCubit>().onDecrement();
                CustomSnackbar.showSnackbarWithAction(
                    context: context, message: Strings.onDecrementedText);
              }),
          FloatingActionButton(
              heroTag: "increment",
              child: AppIcons.increment,
              onPressed: () {
                context.read<CounterCubit>().onIncrement();
                CustomSnackbar.showSnackbarWithAction(
                    context: context, message: Strings.onIncrementedText);
              }),
        ],
      ),
      const Padding(padding: EdgeInsets.only(top: 50)),

      //! Go to second screen button
      TextButton(
          onPressed: () => AppRouter.pushWithArgument(
              context: context,
              pageName: AppRouter.secondScreen,
              args: SecondScreenArgs(counterValue: context.read<CounterCubit>().state)),
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
