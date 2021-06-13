import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_network_app/layouts/cubit/social_cubit.dart';
import 'package:social_network_app/layouts/cubit/social_states.dart';
import 'package:social_network_app/modules/edit_peofile/edit_profile_screen.dart';
import 'package:social_network_app/shared/components/custom_navigator.dart';
import 'package:social_network_app/shared/styles/icon_broken.dart';

class SettingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      builder: (context, state) {
        var userModel = SocialCubit.get(context).userModel;
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Container(
                height: 190,
                child: Stack(
                  alignment: AlignmentDirectional.bottomCenter,
                  children: [
                    Align(
                      alignment: AlignmentDirectional.topCenter,
                      child: Stack(
                        children: [
                          Container(
                            width: double.infinity,
                            height: 140,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(4),
                                topRight: Radius.circular(4),
                              ),
                              image: DecorationImage(
                                image: NetworkImage(
                                  '${userModel.cover}',
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    CircleAvatar(
                      radius: 64,
                      backgroundColor:
                          Theme.of(context).scaffoldBackgroundColor,
                      child: CircleAvatar(
                        radius: 60,
                        backgroundImage: NetworkImage(
                          '${userModel.image}',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 5),
              Text(
                '${userModel.name}',
                style: Theme.of(context).textTheme.bodyText1,
              ),
              Text(
                '${userModel.bio}',
                style: Theme.of(context).textTheme.caption,
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {},
                        child: Column(
                          children: [
                            Text(
                              '100',
                              style: Theme.of(context).textTheme.subtitle1,
                            ),
                            Text(
                              'Post',
                              style: Theme.of(context).textTheme.caption,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {},
                        child: Column(
                          children: [
                            Text(
                              '15',
                              style: Theme.of(context).textTheme.subtitle1,
                            ),
                            Text(
                              'Photo',
                              style: Theme.of(context).textTheme.caption,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {},
                        child: Column(
                          children: [
                            Text(
                              '1M',
                              style: Theme.of(context).textTheme.subtitle1,
                            ),
                            Text(
                              'Followers',
                              style: Theme.of(context).textTheme.caption,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {},
                        child: Column(
                          children: [
                            Text(
                              '104',
                              style: Theme.of(context).textTheme.subtitle1,
                            ),
                            Text(
                              'Followings',
                              style: Theme.of(context).textTheme.caption,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      child: Text('edit Profile'),
                      onPressed: () {
                        navigateTo(
                          context: context,
                          widget: EditProfileScreen(),
                        );
                      },
                    ),
                  ),
                  SizedBox(width: 10),
                  OutlinedButton(
                    child: Icon(
                      IconBroken.Edit,
                      size: 14,
                    ),
                    onPressed: () {},
                  ),
                ],
              ),
            ],
          ),
        );
      },
      listener: (context, state) {},
    );
  }
}
