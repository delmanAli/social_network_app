import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_network_app/layouts/cubit/social_cubit.dart';
import 'package:social_network_app/layouts/cubit/social_states.dart';
import 'package:social_network_app/models/masseges_model.dart';
import 'package:social_network_app/models/user_modal.dart';
import 'package:social_network_app/shared/styles/icon_broken.dart';

class ChatDetailsScreen extends StatelessWidget {
  final UserModels userModels;
  ChatDetailsScreen({
    this.userModels,
  });
  final messageController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        SocialCubit.get(context).getMessages(reciverId: userModels.uid);
        return BlocConsumer<SocialCubit, SocialStates>(
          listener: (context, state) {},
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(
                titleSpacing: 0,
                title: Row(
                  children: [
                    CircleAvatar(
                      radius: 20,
                      backgroundImage: NetworkImage('${userModels.image}'),
                    ),
                    SizedBox(width: 15),
                    Text('${userModels.name}'),
                  ],
                ),
              ),
              body: ConditionalBuilder(
                condition: SocialCubit.get(context).messages.length > 0,
                builder: (context) {
                  return Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        Expanded(
                          child: ListView.separated(
                            // padding: EdgeInsets.only(bottom: 16),
                            physics: BouncingScrollPhysics(),
                            itemBuilder: (context, index) {
                              var messages =
                                  SocialCubit.get(context).messages[index];
                              if (SocialCubit.get(context).userModel.uid ==
                                  messages.senderId)
                                return buildMyMessage(messages);
                              return buildMessage(messages);
                            },
                            separatorBuilder: (context, index) =>
                                SizedBox(height: 15),
                            itemCount: SocialCubit.get(context).messages.length,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 3),
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.grey,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                  controller: messageController,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'type your great message here...',
                                  ),
                                ),
                              ),
                              Container(
                                height: 50,
                                color: Colors.blue,
                                child: MaterialButton(
                                  onPressed: () {
                                    if (messageController.text != '') {
                                      SocialCubit.get(context).sendMessage(
                                        receiverId: userModels.uid,
                                        dataTime: DateTime.now().toString(),
                                        text: messageController.text,
                                      );
                                      messageController.clear();
                                    }
                                  },
                                  minWidth: 1,
                                  child: Icon(
                                    IconBroken.Send,
                                    size: 16,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
                fallback: (context) => Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            );
          },
        );
      },
    );
  }

  Align buildMyMessage(MessageModel model) {
    return Align(
      alignment: AlignmentDirectional.centerEnd,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.blueAccent.withOpacity(.4),
          borderRadius: BorderRadiusDirectional.only(
            bottomStart: Radius.circular(10),
            topEnd: Radius.circular(10),
            topStart: Radius.circular(10),
          ),
        ),
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        child: Text('${model.text}'),
      ),
    );
  }

  Align buildMessage(MessageModel model) {
    return Align(
      alignment: AlignmentDirectional.centerStart,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadiusDirectional.only(
            bottomEnd: Radius.circular(10),
            topEnd: Radius.circular(10),
            topStart: Radius.circular(10),
          ),
        ),
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        child: Text('${model.text}'),
      ),
    );
  }
}
