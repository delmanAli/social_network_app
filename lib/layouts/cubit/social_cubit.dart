import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_network_app/layouts/cubit/social_states.dart';
import 'package:social_network_app/models/masseges_model.dart';
import 'package:social_network_app/models/post_model.dart';
import 'package:social_network_app/models/user_modal.dart';
import 'package:social_network_app/modules/chats/chat_screen.dart';
import 'package:social_network_app/modules/feeds/feed_screen.dart';
import 'package:social_network_app/modules/new_posts/new_post_screen.dart';
import 'package:social_network_app/modules/settings/settings_screen.dart';
import 'package:social_network_app/modules/users/user_screen.dart';
import 'package:social_network_app/shared/components/constant.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class SocialCubit extends Cubit<SocialStates> {
  SocialCubit() : super(SocialInitialStates());

  static SocialCubit get(context) => BlocProvider.of(context);

  UserModels userModel;
  getUserData() {
    // emit(SocialGetUserLoadingStates());
    // FirebaseFirestore.instance
    //     .collection('user')
    //     .doc(uId)
    //     .snapshots()
    //     .listen((event) {
    //   userModel = UserModel.fromJson(event.data());
    //   emit(SocialGetUserSuccessStates());
    // });

    emit(SocialGetUserLoadingStates());
    FirebaseFirestore.instance.collection('user').doc(uId).get().then((value) {
      userModel = UserModels.fromJson(value.data());
      emit(SocialGetUserSuccessStates());
    }).catchError((err) {
      print(err.toString());
      emit(SocialGetUserErrorStates(err));
    });
  }

  // List<UserModel> userList = [];
  // getProfile() {
  //   emit(SocialGetUserLoadingStates());
  //   FirebaseFirestore.instance.collection('user').snapshots().listen((event) {
  //     event.docs.forEach((element) {
  //       userList.add(UserModel.fromJson(element.data()));
  //     });
  //     emit(SocialGetUserSuccessStates());
  //   });

  //   //   emit(SocialGetUserLoadingStates());
  //   //   FirebaseFirestore.instance.collection('user').get().then((value) {
  //   //   userList = [];
  //   //     value.docs.forEach((element) {

  //   //       userList.add(UserModel.fromJson(element.data()));
  //   //     });
  //   //     emit(SocialGetUserSuccessStates());
  //   //   }).catchError((err) {
  //   //     print(err.toString());
  //   //     emit(SocialGetUserErrorStates(err));
  //   //   });
  // }

  int cureentIndex = 0;
  List<Widget> screens = [
    FeedScreen(),
    ChatScreen(),
    NewPostScreen(),
    UserScreen(),
    SettingScreen(),
  ];
  List<String> titels = [
    'Home',
    'Chats',
    'Post',
    'Users',
    'Setting',
  ];
  void changeBottumNav(int index) {
    if (index == 1) getAllUsers();

    if (index == 2)
      emit(SocialChangeBottomNavPostState());
    else {
      cureentIndex = index;
      emit(SocialChangeBottomNavState());
    }
  }

  File profileImage;
  var picker = ImagePicker();

  Future<void> getProfileImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      emit(SocialProfileImagePickedSuccessState());
    } else {
      print('no image selected');
      emit(SocialProfileImagePickedErrorState());
    }
  }

  File coverImage;

  Future<void> getCoverImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      coverImage = File(pickedFile.path);
      emit(SocialCoverImagePickedSuccessState());
    } else {
      print('no image selected');
      emit(SocialCoverImagePickedErrorState());
    }
  }

  void uploadProfileImage({
    @required String name,
    @required String phone,
    @required String bio,
  }) {
    emit(SocialUserUpdetedLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(profileImage.path).pathSegments.last}')
        .putFile(profileImage)
        .then((res) {
      res.ref.getDownloadURL().then((value) {
        // emit(SocialUploadProfileImageSuccessState());
        print(value);
        updateUser(
          name: name,
          phone: phone,
          bio: bio,
          image: value,
        );
      }).catchError((err) {
        emit(SocialUploadProfileImageErrorState());
      });
    }).catchError((err) {
      emit(SocialUploadProfileImageErrorState());
    });
  }

  void uploadCoverImage({
    @required String name,
    @required String phone,
    @required String bio,
  }) {
    emit(SocialUserUpdetedLoadingState());

    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(coverImage.path).pathSegments.last}')
        .putFile(coverImage)
        .then((res) {
      res.ref.getDownloadURL().then((value) {
        // emit(SocialUploadCoverImageSuccessState());
        print(value);
        updateUser(
          name: name,
          phone: phone,
          bio: bio,
          cover: value,
        );
      }).catchError((err) {
        emit(SocialUploadCoverImageErrorState());
      });
    }).catchError((err) {
      emit(SocialUploadCoverImageErrorState());
    });
  }

  // void updateUserImages({
  //   @required String name,
  //   @required String phone,
  //   @required String bio,
  // }) {
  //   emit(SocialUserUpdetedLoadingState());
  //   if (coverImage != null) {
  //     uploadCoverImage();
  //   } else if (profileImage != null) {
  //     uploadProfileImage();
  //   } else if (coverImage != null && profileImage != null) {
  //     //...
  //   } else {
  //     updateUser(
  //       name: name,
  //       phone: phone,
  //       bio: bio,
  //     );
  //   }
  // }

  void updateUser({
    @required String name,
    @required String phone,
    @required String bio,
    String cover,
    String image,
  }) {
    UserModels model = UserModels(
      name: name,
      phone: phone,
      bio: bio,
      cover: cover ?? userModel.cover,
      image: image ?? userModel.image,
      email: userModel.email,
      uid: userModel.uid,
      isEmailVerified: false,
    );

    FirebaseFirestore.instance
        .collection('user')
        .doc(userModel.uid)
        .update(model.toMap())
        .then((value) {
      getUserData();
    }).catchError((err) {
      emit(SocialUserUpdetedErrorState());
    });
  }

  File postImage;

  Future<void> getPostImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      postImage = File(pickedFile.path);
      emit(SocialPostsImagePickedSuccessState());
    } else {
      print('no image selected');
      emit(SocialPostsImagePickedErrorState());
    }
  }

  void removePostImage() {
    postImage = null;
    emit(SocialRemovePostImageState());
  }

  void uploadPostImage({
    @required String dateTime,
    @required String text,
  }) {
    emit(SocialCreatPostLoadingState());

    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('posts/${Uri.file(postImage.path).pathSegments.last}')
        .putFile(postImage)
        .then((res) {
      res.ref.getDownloadURL().then((value) {
        print(value);
        createPost(
          text: text,
          dateTime: dateTime,
          postImage: value,
        );
      }).catchError((err) {
        emit(SocialCreatPostErrorState());
      });
    }).catchError((err) {
      emit(SocialCreatPostErrorState());
    });
  }

  void createPost({
    @required String dateTime,
    @required String text,
    String postImage,
  }) {
    emit(SocialCreatPostLoadingState());

    PostModel model = PostModel(
      name: userModel.name,
      image: userModel.image,
      uid: userModel.uid,
      dateTime: dateTime,
      text: text,
      postImage: postImage ?? '',
    );

    FirebaseFirestore.instance
        .collection('posts')
        .add(model.toMap())
        .then((value) {
      emit(SocialCreatPostSuccessState());
    }).catchError((err) {
      emit(SocialCreatPostErrorState());
    });
  }

  List<PostModel> posts = [];
  List<String> postsId = [];
  List<int> likes = [];

  void getPosts() {
    FirebaseFirestore.instance.collection('posts').get().then((value) {
      value.docs.forEach((element) {
        element.reference.collection('likes').get().then((value) {
          likes.add(value.docs.length);
          postsId.add(element.id);
          posts.add(PostModel.fromJson(element.data()));
        }).catchError((err) {});
      });
      emit(SocialGetPostSuccessStates());
    }).catchError((err) {
      emit(SocialGetPostErrorStates(err.toString()));
    });
  }

  void likePosts(String postId) {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('likes')
        .doc(userModel.uid)
        .set({
      'like': true,
    }).then((value) {
      emit(SocialLikePostSuccessStates());
    }).catchError((err) {
      emit(SocialLikePostErrorStates(err.toString()));
    });
  }

  List<UserModels> users = [];
  void getAllUsers() {
    emit(SocialGetAllUserLoadingStates());
    if (users.length == 0)
      FirebaseFirestore.instance.collection('user').get().then((value) {
        value.docs.forEach((element) {
          if (element.data()['uid'] != userModel.uid)
            users.add(UserModels.fromJson(element.data()));
        });
        emit(SocialGetAllUserSuccessStates());
      }).catchError((err) {
        emit(SocialGetAllUserErrorStates(err.toString()));
      });
  }

  void sendMessage({
    @required String receiverId,
    @required String dataTime,
    @required String text,
  }) {
    MessageModel messageModel = MessageModel(
      senderId: userModel.uid,
      receiverId: receiverId,
      dateTime: dataTime,
      text: text,
    );
    // set my  Chats
    FirebaseFirestore.instance
        .collection('user')
        .doc(userModel.uid)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .add(messageModel.toMap())
        .then((value) {
      emit(SocialSendMessageSuccessStates());
    }).catchError((err) {
      emit(SocialSendMessageErrorStates());
    });

    // set reciver Chats
    FirebaseFirestore.instance
        .collection('user')
        .doc(receiverId)
        .collection('chats')
        .doc(userModel.uid)
        .collection('messages')
        .add(messageModel.toMap())
        .then((value) {
      emit(SocialSendMessageSuccessStates());
    }).catchError((err) {
      emit(SocialSendMessageErrorStates());
    });
  }

  List<MessageModel> messages = [];
  void getMessages({@required String reciverId}) {
    FirebaseFirestore.instance
        .collection('user')
        .doc(userModel.uid)
        .collection('chats')
        .doc(reciverId)
        .collection('messages')
        .orderBy('dateTime')
        .snapshots()
        .listen((event) {
      messages = [];
      event.docs.forEach((element) {
        messages.add(MessageModel.fromJson(element.data()));
      });
    });
  }
}
