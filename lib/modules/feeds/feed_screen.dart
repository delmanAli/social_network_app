import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_network_app/layouts/cubit/social_cubit.dart';
import 'package:social_network_app/layouts/cubit/social_states.dart';
import 'package:social_network_app/models/post_model.dart';
import 'package:social_network_app/shared/styles/icon_broken.dart';

class FeedScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubits = SocialCubit.get(context);
        return ConditionalBuilder(
          condition: cubits.posts.length > 0 && cubits.userModel != null,
          fallback: (context) => Center(child: CircularProgressIndicator()),
          builder: (context) {
            return SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                children: [
                  Card(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    elevation: 5,
                    margin: EdgeInsets.all(8),
                    child: Stack(
                      alignment: AlignmentDirectional.bottomEnd,
                      children: [
                        Image(
                          image: NetworkImage(
                              'https://image.freepik.com/free-photo/islamic-new-year-decoration-with-lantern-quran_23-2148950335.jpg'),
                          fit: BoxFit.cover,
                          width: double.infinity,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Communicate With Friends',
                            style: Theme.of(context).textTheme.subtitle1,
                          ),
                        ),
                      ],
                    ),
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) =>
                        buildPostItem(cubits.posts[index], context, index),
                    itemCount: cubits.posts.length,
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Card buildPostItem(PostModel postModel, BuildContext context, index) {
    return Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      elevation: 5,
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 25,
                  backgroundImage: NetworkImage(
                    '${postModel.image}',
                  ),
                ),
                SizedBox(width: 15),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            '${postModel.name}',
                            style: TextStyle(
                              height: 1.4,
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Icon(
                            Icons.check_circle,
                            size: 16,
                            color: Colors.blue,
                          ),
                        ],
                      ),
                      Text(
                        '${postModel.dateTime}',
                        style: Theme.of(context)
                            .textTheme
                            .caption
                            .copyWith(height: 1.4),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 15,
                ),
                IconButton(
                  icon: Icon(
                    Icons.more_horiz,
                    size: 16,
                  ),
                  onPressed: () {},
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15),
              child: Container(
                height: 1,
                color: Colors.grey[300],
                width: double.infinity,
              ),
            ),
            Text(
              '${postModel.text}',
              style:
                  Theme.of(context).textTheme.subtitle1.copyWith(fontSize: 14),
            ),
            // Padding(
            //   padding: const EdgeInsets.only(
            //     bottom: 10,
            //     top: 5,
            //   ),
            //   child: Container(
            //     width: double.infinity,
            //     child: Wrap(
            //       children: [
            //         Padding(
            //           padding: const EdgeInsetsDirectional.only(end: 6),
            //           child: Container(
            //             height: 20,
            //             child: MaterialButton(
            //               minWidth: 1,
            //               // height: 25,
            //               padding: EdgeInsets.zero,
            //               onPressed: () {},
            //               child: Text(
            //                 '#Software',
            //                 style: Theme.of(context).textTheme.caption.copyWith(
            //                       color: Colors.blue,
            //                     ),
            //               ),
            //             ),
            //           ),
            //         ),
            //       ],
            //     ),
            //   ),
            // ),
            if (postModel.postImage != '')
              Padding(
                padding: const EdgeInsets.only(top: 15),
                child: Container(
                  height: 140,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    image: DecorationImage(
                        image: NetworkImage(
                          '${postModel.postImage}',
                        ),
                        fit: BoxFit.cover),
                  ),
                ),
              ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {},
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: Row(
                          children: [
                            Icon(
                              IconBroken.Heart,
                              size: 16,
                              color: Colors.red,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              '${SocialCubit.get(context).likes[index]}',
                              style: Theme.of(context).textTheme.caption,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {},
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Icon(
                              IconBroken.Chat,
                              size: 16,
                              color: Colors.amber,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              '0 comments',
                              style: Theme.of(context).textTheme.caption,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Container(
                height: 1,
                color: Colors.grey[300],
                width: double.infinity,
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {},
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 18,
                          backgroundImage: NetworkImage(
                              '${SocialCubit.get(context).userModel.image}'),
                        ),
                        SizedBox(width: 15),
                        Text(
                          'Write a Comment',
                          style: Theme.of(context)
                              .textTheme
                              .caption
                              .copyWith(height: 1.4),
                        ),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    SocialCubit.get(context)
                        .likePosts(SocialCubit.get(context).postsId[index]);
                  },
                  child: Row(
                    children: [
                      Icon(
                        IconBroken.Heart,
                        size: 16,
                        color: Colors.red,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        'Like',
                        style: Theme.of(context).textTheme.caption,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
