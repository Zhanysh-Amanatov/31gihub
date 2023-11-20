/*External dependencies*/
import 'package:finik/bloc/bloc/auth_bloc.dart';
import 'package:finik/data/repositories/auth_repository.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
/*Local dependencies*/
import 'package:finik/view_routes/routes.dart';
import 'package:finik/firebase_options.dart';
import 'package:finik/views/home/carousel_view.dart';
import 'package:finik/views/home/home_view.dart';
import 'package:finik/views/forgotPassword/forgot_password_loading_view.dart';
import 'package:finik/views/forgotPassword/forgot_password_view.dart';
import 'package:finik/views/singup/sign_up_verify_email_view.dart';
import 'package:finik/views/initial_view.dart';
import 'package:finik/views/login/log_in_view.dart';
import 'package:finik/views/singup/sign_up_email_view.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    double width = 375;
    double height = 812;
    return RepositoryProvider(
      create: (context) => AuthRepository(),
      child: BlocProvider(
        create: (context) => AuthBloc(
            authRepository: RepositoryProvider.of<AuthRepository>(context)),
        child: ScreenUtilInit(
          builder: (BuildContext context, child) => MaterialApp(
            title: 'Flutter Demo',
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
              useMaterial3: true,
            ),
            home: const DefaultView(),
            routes: {
              logInRoute: (context) => const LogInView(),
              signUpEmailRoute: (context) => const SignUpEmailView(),
              signUpVerifyEmailRoute: (context) =>
                  const SignUpVerifyEmailView(),
              homeViewRoute: (context) => const HomeView(),
              initialViewRoute: (context) => const InitialView(),
              forgotPasswordRoute: (context) => const ForgotPasswordView(),
              forgotPasswordLoadingRoute: (context) =>
                  const ForgotPasswordLoadingView(),
              carouselRoute: (context) => const CarouselView(),
            },
          ),
          designSize: Size(width, height),
        ),
      ),
    );
  }
}

class DefaultView extends StatelessWidget {
  const DefaultView({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.done:
            return const CarouselView();
          default:
            return const InitialView();
        }
      },
    );
  }
}
// class DefaultView extends StatefulWidget { 
//   const DefaultView({super.key});

//   @override
//   State<DefaultView> createState() => _DefaultViewState();
// }

// class _DefaultViewState extends State<DefaultView> {
//   late final TextEditingController _controller;

//   @override
//   void initState() {
//     _controller = TextEditingController();
//     super.initState();
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) => CounterBloc(),
//       child: Scaffold(
//         appBar: AppBar(
//           title: const Text('bloc app'),
//           backgroundColor: Colors.blue,
//         ),
//         body: BlocConsumer<CounterBloc, CounterState>(
//           listener: (context, state) {
//             _controller.clear();
//           },
//           builder: (context, state) {
//             final invalidValue =
//                 (state is CounterStateInvalidNumber) ? state.invalidValue : '';
//             return Column(
//               children: [
//                 Text('Current value => ${state.value}'),
//                 Visibility(
//                   child: Text('Invalid input: $invalidValue'),
//                   visible: state is CounterStateInvalidNumber,
//                 ),
//                 TextField(
//                   controller: _controller,
//                   decoration:
//                       const InputDecoration(hintText: 'Enter a number here'),
//                   keyboardType: TextInputType.number,
//                 ),
//                 Row(
//                   children: [
//                     TextButton(
//                       onPressed: () {
//                         context
//                             .read<CounterBloc>()
//                             .add(DecrementEvent(_controller.text));
//                       },
//                       child: const Text('-'),
//                     ),
//                     TextButton(
//                       onPressed: () {
//                         context
//                             .read<CounterBloc>()
//                             .add(IncrementEvent(_controller.text));
//                       },
//                       child: const Text('+'),
//                     )
//                   ],
//                 )
//               ],
//             );
//           },
//         ),
//       ),
//     );
//   }
// }

// @immutable
// abstract class CounterState {
//   final int value;
//   const CounterState(this.value);
// }

// class CounterStateValid extends CounterState {
//   const CounterStateValid(int value) : super(value);
// }

// class CounterStateInvalidNumber extends CounterState {
//   final String invalidValue;
//   const CounterStateInvalidNumber({
//     required this.invalidValue,
//     required int previousValue,
//   }) : super(previousValue);
// }

// @immutable
// abstract class CounterEvent {
//   final String value;
//   const CounterEvent(this.value);
// }

// class IncrementEvent extends CounterEvent {
//   const IncrementEvent(String value) : super(value);
// }

// class DecrementEvent extends CounterEvent {
//   const DecrementEvent(String value) : super(value);
// }

// class CounterBloc extends Bloc<CounterEvent, CounterState> {
//   CounterBloc() : super(const CounterStateValid(0)) {
//     on<IncrementEvent>((event, emit) {
//       final integer = int.tryParse(event.value);
//       if (integer == null) {
//         emit(
//           CounterStateInvalidNumber(
//             invalidValue: event.value,
//             previousValue: state.value,
//           ),
//         );
//       } else {
//         emit(CounterStateValid(state.value + integer));
//       }
//     });
//     on<DecrementEvent>((event, emit) {
//       final integer = int.tryParse(event.value);
//       if (integer == null) {
//         emit(CounterStateInvalidNumber(
//           invalidValue: event.value,
//           previousValue: state.value,
//         ));
//       } else {
//         emit(CounterStateValid(state.value - integer));
//       }
//     });
//   }
// }
