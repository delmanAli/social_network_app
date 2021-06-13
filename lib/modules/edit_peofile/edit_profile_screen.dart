import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_network_app/layouts/cubit/social_cubit.dart';
import 'package:social_network_app/layouts/cubit/social_states.dart';
import 'package:social_network_app/shared/components/app_bar.dart';
import 'package:social_network_app/shared/components/default_form_field.dart';
import 'package:social_network_app/shared/styles/icon_broken.dart';

class EditProfileScreen extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController bioController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var userModel = SocialCubit.get(context).userModel;
          var profileImage = SocialCubit.get(context).profileImage;
          var coverImage = SocialCubit.get(context).coverImage;

          nameController.text = userModel.name;
          bioController.text = userModel.bio;
          phoneController.text = userModel.phone;

          return Scaffold(
            appBar: appBar(
              context: context,
              title: 'New Post',
              actions: [
                TextButton(
                  onPressed: () {
                    SocialCubit.get(context).updateUser(
                      name: nameController.text,
                      phone: phoneController.text,
                      bio: bioController.text,
                    );
                  },
                  child: Text('UPDATE'),
                ),
                SizedBox(width: 16),
              ],
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    if (state is SocialUserUpdetedLoadingState)
                      LinearProgressIndicator(),
                    if (state is SocialUserUpdetedLoadingState)
                      SizedBox(height: 10),
                    Container(
                      height: 190,
                      child: Stack(
                        alignment: AlignmentDirectional.bottomCenter,
                        children: [
                          Align(
                            alignment: AlignmentDirectional.topCenter,
                            child: Stack(
                              alignment: AlignmentDirectional.topEnd,
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
                                      image: coverImage == null
                                          ? NetworkImage(
                                              '${userModel.cover}',
                                            )
                                          : FileImage(coverImage),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                IconButton(
                                  icon: CircleAvatar(
                                    radius: 20,
                                    child: Icon(
                                      IconBroken.Camera,
                                      size: 16,
                                    ),
                                  ),
                                  onPressed: () {
                                    SocialCubit.get(context).getCoverImage();
                                  },
                                ),
                              ],
                            ),
                          ),
                          Stack(
                            alignment: AlignmentDirectional.bottomEnd,
                            children: [
                              CircleAvatar(
                                radius: 64,
                                backgroundColor:
                                    Theme.of(context).scaffoldBackgroundColor,
                                child: CircleAvatar(
                                  radius: 60,
                                  backgroundImage: profileImage == null
                                      ? NetworkImage(
                                          '${userModel.image}',
                                        )
                                      : FileImage(profileImage),
                                ),
                              ),
                              IconButton(
                                icon: CircleAvatar(
                                  radius: 20,
                                  child: Icon(
                                    IconBroken.Camera,
                                    size: 16,
                                  ),
                                ),
                                onPressed: () {
                                  SocialCubit.get(context).getProfileImage();
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    if (SocialCubit.get(context).profileImage != null ||
                        SocialCubit.get(context).coverImage != null)
                      Row(
                        children: [
                          if (SocialCubit.get(context).profileImage != null)
                            Expanded(
                              child: Column(
                                children: [
                                  ElevatedButton(
                                    //changed here up user
                                    child: Text('upload profile'),
                                    onPressed: () {
                                      SocialCubit.get(context)
                                          .uploadProfileImage(
                                        name: nameController.text,
                                        phone: phoneController.text,
                                        bio: bioController.text,
                                      );
                                    },
                                  ),
                                  if (state is SocialUserUpdetedLoadingState)
                                    SizedBox(height: 5),
                                  if (state is SocialUserUpdetedLoadingState)
                                    LinearProgressIndicator(),
                                ],
                              ),
                            ),
                          SizedBox(width: 5),
                          if (SocialCubit.get(context).coverImage != null)
                            Expanded(
                              child: Column(
                                children: [
                                  ElevatedButton(
                                    child: Text('upload cover'),
                                    onPressed: () {
                                      SocialCubit.get(context).uploadCoverImage(
                                        name: nameController.text,
                                        phone: phoneController.text,
                                        bio: bioController.text,
                                      );
                                    },
                                  ),
                                  if (state is SocialUserUpdetedLoadingState)
                                    SizedBox(height: 5),
                                  if (state is SocialUserUpdetedLoadingState)
                                    LinearProgressIndicator(),
                                ],
                              ),
                            ),
                        ],
                      ),
                    if (SocialCubit.get(context).profileImage != null ||
                        SocialCubit.get(context).coverImage != null)
                      SizedBox(height: 20),
                    defaultFormField(
                      controller: nameController,
                      type: TextInputType.name,
                      validate: 'Name Must Not Be Empty',
                      label: 'Name',
                      prefix: IconBroken.Profile,
                    ),
                    SizedBox(height: 11),
                    defaultFormField(
                      controller: bioController,
                      type: TextInputType.name,
                      validate: 'Bio Must Not Be Empty',
                      label: 'Bio',
                      prefix: IconBroken.Info_Circle,
                    ),
                    SizedBox(height: 11),
                    defaultFormField(
                      controller: phoneController,
                      type: TextInputType.number,
                      validate: 'phone Must Not Be Empty',
                      label: 'Phone',
                      prefix: IconBroken.Call,
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
