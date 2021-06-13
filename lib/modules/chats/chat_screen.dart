import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_network_app/layouts/cubit/social_cubit.dart';
import 'package:social_network_app/layouts/cubit/social_states.dart';
import 'package:social_network_app/models/user_modal.dart';
import 'package:social_network_app/modules/chat_details/chat_details_screen.dart';
import 'package:social_network_app/shared/components/custom_navigator.dart';

class ChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubits = SocialCubit.get(context);
        return ConditionalBuilder(
          condition: cubits.users.length > 0,
          builder: (context) {
            return ListView.separated(
              physics: BouncingScrollPhysics(),
              itemBuilder: (context, index) =>
                  buildChatItem(context, cubits.users[index]),
              separatorBuilder: (context, index) => Divider(
                height: 2,
              ),
              itemCount: cubits.users.length,
            );
          },
          fallback: (context) => Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

  Widget buildChatItem(BuildContext context, UserModels model) {
    return InkWell(
      onTap: () {
        navigateTo(
          context: context,
          widget: ChatDetailsScreen(
            userModels: model,
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            CircleAvatar(
              radius: 25,
              backgroundImage: NetworkImage(
                '${model.image}',
              ),
            ),
            SizedBox(width: 15),
            Text(
              '${model.name}',
              style: Theme.of(context).textTheme.caption.copyWith(height: 1.4),
            ),
          ],
        ),
      ),
    );
  }
}
