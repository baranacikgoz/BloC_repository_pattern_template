import 'package:crypto_repository/crypto_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project_template/ui/screens/home_screen/cubits/crypto/crypto_cubit.dart';

import '../../../core/app_router/app_router.dart';
import '../../../core/app_router/screen_args.dart';
import '../../../core/constants/icons.dart';
import '../../../core/constants/strings.dart';

import '../../independent_widgets/custom_snackbar.dart';
import '../../independent_widgets/general_app_bar.dart';
import 'cubits/counter/counter_cubit.dart';
import 'cubits/internet_connectivity/internet_connectivity_cubit.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => InternetConnectivityCubit()),
        BlocProvider(
            //! context.read<CounterRepository>()
            create: (context) => CounterCubit()),
        BlocProvider(create: (context) => CryptoCubit(context.read<CryptoRepository>()))
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
      const Padding(padding: EdgeInsets.only(top: 30)),

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
        Strings.usingStreamSubscription,
        style: Theme.of(context).textTheme.bodySmall,
        textAlign: TextAlign.center,
      ),
      const Padding(padding: EdgeInsets.only(top: 20)),

      //! Momentarily Crypto Data
      Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        elevation: 8,
        margin: const EdgeInsets.only(left: 7, top: 6, bottom: 12, right: 7),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(padding: EdgeInsets.all(5)),
            BlocConsumer<CryptoCubit, CryptoState>(
              listener: (context, state) {
                if (state is ErrorCryptoData) {
                  CustomSnackbar.showSnackbarWithTimedMessage(
                      context: context, message: state.message);
                }
              },
              builder: (context, state) {
                return BlocBuilder<CryptoCubit, CryptoState>(
                  builder: (context, state) {
                    if (state is ReceivedCryptoData) {
                      final price = state.cryptoData.price;
                      final isIncreased = state.isIncreased;

                      return ListTile(
                        title: const Text(Strings.btcUsdt,
                            maxLines: 1, style: TextStyle(fontSize: 25)),
                        subtitle: Text("$price",
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                color:
                                    isIncreased ? Colors.greenAccent : Colors.redAccent,
                                fontSize: 50,
                                fontWeight: FontWeight.w300)),
                      );
                    } else if (state is FetchingCryptoData) {
                      return const ListTile(
                          title: Text(Strings.btcUsdt,
                              maxLines: 1, style: TextStyle(fontSize: 25)),
                          subtitle: Center(
                            child: CircularProgressIndicator(),
                          ));
                    }

                    return const ListTile(
                        title: Text(Strings.btcUsdt,
                            maxLines: 1, style: TextStyle(fontSize: 25)),
                        subtitle: Text(
                          Strings.refreshToSeeThePrice,
                          overflow: TextOverflow.ellipsis,
                        ));
                  },
                );
              },
            ),
            Container(
              margin: const EdgeInsets.only(top: 10),
              color: Theme.of(context).dividerColor,
              height: 1,
              width: double.infinity,
            ),
            Center(
                child: IconButton(
                    onPressed: () => context.read<CryptoCubit>().onRefreshRequest(),
                    icon: const Icon(Icons.change_circle_outlined)))
          ],
        ),
      ),
      Text(
        Strings.usingRepositoryAndBloc,
        style: Theme.of(context).textTheme.bodySmall,
        textAlign: TextAlign.center,
      ),
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
        "Using Repository Pattern & BlocBuilder",
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
                  context: context,
                  message: Strings.onDecrementedText,
                  actionMessage: "UNDO",
                  function: context.read<CounterCubit>().undo,
                );
              }),
          FloatingActionButton(
              heroTag: "increment",
              child: AppIcons.increment,
              onPressed: () {
                context.read<CounterCubit>().onIncrement();

                CustomSnackbar.showSnackbarWithAction(
                  context: context,
                  message: Strings.onIncrementedText,
                  actionMessage: "UNDO",
                  function: context.read<CounterCubit>().undo,
                );
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
