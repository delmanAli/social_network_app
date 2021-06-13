import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_network_app/layouts/cubit/social_cubit.dart';
import 'package:social_network_app/layouts/cubit/social_states.dart';
import 'package:social_network_app/shared/components/app_bar.dart';
import 'package:social_network_app/shared/styles/icon_broken.dart';

class NewPostScreen extends StatelessWidget {
  final textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: appBar(
            context: context,
            title: 'New Post',
            actions: [
              TextButton(
                onPressed: () {
                  if (SocialCubit.get(context).postImage == null) {
                    SocialCubit.get(context).createPost(
                      dateTime: DateTime.now().toString(),
                      text: textController.text,
                    );
                  } else {
                    SocialCubit.get(context).uploadPostImage(
                      dateTime: DateTime.now().toString(),
                      text: textController.text,
                    );
                  }
                },
                child: Text('POST'),
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                if (State is SocialCreatPostLoadingState)
                  LinearProgressIndicator(),
                if (State is SocialCreatPostLoadingState)
                  SizedBox(
                    height: 5,
                  ),
                Row(
                  children: [
                    CircleAvatar(
                      radius: 25,
                      backgroundImage: NetworkImage(
                          'https://image.freepik.com/free-photo/islamic-new-year-decoration-with-lantern-quran_23-2148950335.jpg'),
                    ),
                    SizedBox(width: 15),
                    Expanded(
                      child: Text(
                        'Delman ali',
                        style: TextStyle(
                          height: 1.4,
                        ),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: TextFormField(
                    controller: textController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'whats in your mind',
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                if (SocialCubit.get(context).postImage != null)
                  Stack(
                    alignment: AlignmentDirectional.topEnd,
                    children: [
                      Container(
                        width: double.infinity,
                        height: 140,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          image: DecorationImage(
                            image:
                                FileImage(SocialCubit.get(context).postImage),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      IconButton(
                        icon: CircleAvatar(
                          radius: 20,
                          child: Icon(
                            Icons.close,
                            size: 16,
                          ),
                        ),
                        onPressed: () {
                          SocialCubit.get(context).removePostImage();
                        },
                      ),
                    ],
                  ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextButton(
                        onPressed: () {
                          SocialCubit.get(context).getPostImage();
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(IconBroken.Image),
                            SizedBox(
                              width: 5,
                            ),
                            Text('add photo'),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: TextButton(
                        onPressed: () {},
                        child: Text('# tags'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
