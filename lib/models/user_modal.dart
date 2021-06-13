class UserModels {
  String uid;
  String name;
  String email;
  String phone;
  String bio;
  String cover;
  String image;
  bool isEmailVerified;

  UserModels({
    this.uid,
    this.name,
    this.email,
    this.phone,
    this.bio,
    this.cover,
    this.image,
    this.isEmailVerified,
  });
  UserModels.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    bio = json['bio'];
    cover = json['cover'];
    image = json['image'];
    isEmailVerified = json['isEmailVerified'];
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
      'phone': phone,
      'image': image,
      'cover': cover,
      'bio': bio,
      'isEmailVerified': isEmailVerified,
    };
  }
}
