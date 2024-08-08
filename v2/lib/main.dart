import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:todoapp_brainmentors/firebase_options.dart';
import 'package:todoapp_brainmentors/modules/user/cubit/user_cubit.dart';
import 'modules/splash/views/splash.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  await WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await EasyLocalization.ensureInitialized();
  runApp(EasyLocalization(
    path: 'assets/i18n',
    supportedLocales: [Locale('en'), Locale('hi')],
    child: App(),
  ));
  // runApp(MaterialApp(
  //   title: 'ToDo App',
  //   home: Splash(),
  // ));
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => UserCubit(),
      child: MaterialApp(
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        localizationsDelegates: context.localizationDelegates,
        home: Splash(),
        title: 'To Do App',
      ),
    );
  }
}
