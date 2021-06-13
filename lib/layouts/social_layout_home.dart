import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_network_app/layouts/cubit/social_cubit.dart';
import 'package:social_network_app/layouts/cubit/social_states.dart';
import 'package:social_network_app/modules/new_posts/new_post_screen.dart';
import 'package:social_network_app/shared/components/custom_navigator.dart';
import 'package:social_network_app/shared/styles/icon_broken.dart';

class SocialHomeLayout extends StatelessWidget {
  static const String routeName = 'SocialHomeLayout';
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {
        if (state is SocialChangeBottomNavPostState) {
          navigateTo(
            context: context,
            widget: NewPostScreen(),
          );
        }
      },
      builder: (context, state) {
        var cubits = SocialCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            actions: [
              IconButton(icon: Icon(IconBroken.Notification), onPressed: () {}),
              IconButton(icon: Icon(IconBroken.Search), onPressed: () {}),
            ],
            title: Text(
              cubits.titels[cubits.cureentIndex],
            ),
          ),
          body: cubits.screens[cubits.cureentIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubits.cureentIndex,
            onTap: (value) {
              cubits.changeBottumNav(value);
            },
            items: [
              BottomNavigationBarItem(
                icon: Icon(IconBroken.Home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(IconBroken.Chat),
                label: 'Chats',
              ),
              BottomNavigationBarItem(
                icon: Icon(IconBroken.Paper_Upload),
                label: 'Post',
              ),
              BottomNavigationBarItem(
                icon: Icon(IconBroken.Location),
                label: 'Users',
              ),
              BottomNavigationBarItem(
                icon: Icon(IconBroken.Setting),
                label: 'Setting',
              ),
            ],
          ),
        );
      },
    );
  }
}
