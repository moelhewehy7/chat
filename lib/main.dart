import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scholar_chat/cubits/login_cubit/login_cubit.dart';
import 'package:scholar_chat/firebase_options.dart';
import 'cubits/Signup_cubit/signup_cubit.dart';
import 'cubits/chat_cubit/chat_cubit.dart';
import 'views/chat_page.dart';
import 'views/login_page.dart';
import 'views/resgister_page.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
        systemNavigationBarColor:
            Color(0xFF3B1B1B) // Set your desired color here
        ),
  );
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const ScholarChat());
}

class ScholarChat extends StatelessWidget {
  const ScholarChat({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => LoginCubit(),
        ),
        BlocProvider(
          create: (context) => SignupCubit(),
        ),
        BlocProvider(
          create: (context) => ChatCubit(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          Register.id: (context) => const Register(),
          LoginPage.id: (context) => const LoginPage(),
          ChatPage.id: (context) => const ChatPage()
        },
        initialRoute: LoginPage.id,
      ),
    );
  }
}
