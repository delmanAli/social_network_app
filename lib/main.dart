import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_network_app/layouts/cubit/social_cubit.dart';
import 'package:social_network_app/layouts/social_layout_home.dart';
import 'package:social_network_app/modules/login/login_screen.dart';
import 'package:social_network_app/modules/register/register_screen.dart';
import 'package:social_network_app/shared/components/constant.dart';
import 'package:social_network_app/shared/network/local/cach_helper.dart';
import 'package:social_network_app/shared/styles/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await CacheHelper.init();
  Widget widget;
  uId = CacheHelper.getData(key: 'uid');
  if (uId != null) {
    widget = SocialHomeLayout();
  } else {
    widget = LoginScreen();
  }
  runApp(MyApp(widget));
}

class MyApp extends StatelessWidget {
  final Widget mainWidgets;

  MyApp(this.mainWidgets);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => SocialCubit()
            ..getUserData()
            ..getPosts(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Social App',
        // theme: ThemeData.light(),
        theme: lightThemes,
        home: mainWidgets,
        routes: {
          LoginScreen.routeName: (context) => LoginScreen(),
          RegisterScreen.routeName: (context) => RegisterScreen(),
          SocialHomeLayout.routeName: (context) => SocialHomeLayout(),
        },
      ),
    );
  }
}
