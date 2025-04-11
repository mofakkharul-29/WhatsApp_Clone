import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_clone/data/logic/cubits/user_cubit.dart';
import 'package:my_clone/screens/home_screen.dart';
import 'package:my_clone/screens/individual_chat_screen.dart';
import 'package:my_clone/widgets/camera_screen.dart';
import 'package:my_clone/widgets/unread_page.dart';

late List<CameraDescription> _cameras;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  _cameras = await availableCameras();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserCubit(),
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: 'Roboto',
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const Home(),
        // home: const HostingUser(),
        // for popup menu options routing
        routes: {
          // '/NewGroup': (context) => const NewGroup(),
          // '/NewBroadcast': (context) => const NewBroadCast(),
          '/IndividualChatScreen': (context) => const IndividualChatScreen(),
          '/CameraScreen': (context) => CameraScreen(
                cameras: _cameras,
              ),
          '/UnreadPage': (context) => const UnreadPage(),
        },
      ),
    );
  }
}
