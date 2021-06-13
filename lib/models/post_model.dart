class PostModel {
  String uid;
  String name;
  String image;
  String dateTime;
  String text;
  String postImage;

  PostModel({
    this.uid,
    this.name,
    this.image,
    this.dateTime,
    this.text,
    this.postImage,
  });
  PostModel.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    name = json['name'];
    image = json['image'];
    postImage = json['postImage'];
    dateTime = json['dateTime'];
    text = json['text'];
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
      'image': image,
      'postImage': postImage,
      'dateTime': dateTime,
      'text': text,
    };
  }
}
