abstract class SocialStates {}

class SocialInitialStates extends SocialStates {}

class SocialGetMessageSuccessStates extends SocialStates {}

class SocialGetMessageErrorStates extends SocialStates {}

//send massege
class SocialSendMessageSuccessStates extends SocialStates {}

class SocialSendMessageErrorStates extends SocialStates {}

//get massege
class SocialGetUserLoadingStates extends SocialStates {}

class SocialGetUserSuccessStates extends SocialStates {}

//
class SocialGetUserErrorStates extends SocialStates {
  final String error;

  SocialGetUserErrorStates(this.error);
}

//get all wsers
class SocialGetAllUserLoadingStates extends SocialStates {}

class SocialGetAllUserSuccessStates extends SocialStates {}

class SocialGetAllUserErrorStates extends SocialStates {
  final String error;

  SocialGetAllUserErrorStates(this.error);
}

class SocialChangeBottomNavState extends SocialStates {}

class SocialChangeBottomNavPostState extends SocialStates {}

class SocialProfileImagePickedSuccessState extends SocialStates {}

class SocialProfileImagePickedErrorState extends SocialStates {}

class SocialCoverImagePickedSuccessState extends SocialStates {}

class SocialCoverImagePickedErrorState extends SocialStates {}

class SocialUploadProfileImageSuccessState extends SocialStates {}

class SocialUploadProfileImageErrorState extends SocialStates {}

class SocialUploadCoverImageSuccessState extends SocialStates {}

class SocialUploadCoverImageErrorState extends SocialStates {}

class SocialUserUpdetedLoadingState extends SocialStates {}

class SocialUserUpdetedErrorState extends SocialStates {}

class SocialCreatPostLoadingState extends SocialStates {}

class SocialCreatPostSuccessState extends SocialStates {}

class SocialCreatPostErrorState extends SocialStates {}

class SocialPostsImagePickedSuccessState extends SocialStates {}

class SocialPostsImagePickedErrorState extends SocialStates {}

class SocialRemovePostImageState extends SocialStates {}

class SocialGetPostLoadingStates extends SocialStates {}

class SocialGetPostSuccessStates extends SocialStates {}

class SocialGetPostErrorStates extends SocialStates {
  final String error;

  SocialGetPostErrorStates(this.error);
}

class SocialLikePostSuccessStates extends SocialStates {}

class SocialLikePostErrorStates extends SocialStates {
  final String error;

  SocialLikePostErrorStates(this.error);
}
