class listComments {
  String? time;
  String? comment;
  String? userComment;
  String? avatarUser;

  listComments({this.time, this.comment, this.userComment, this.avatarUser});

  listComments.fromJson(Map<String, dynamic> json) {
    time = json['time'];
    comment = json['comment'];
    userComment = json['userComment'];
    avatarUser = json['avatarUser'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['time'] = this.time;
    data['comment'] = this.comment;
    data['userComment'] = this.userComment;
    data['avatarUser'] = this.avatarUser;
    return data;
  }
}
