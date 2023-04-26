class Chat {
  String? time;
  String? chat;
  String? userComment;

  Chat({this.time, this.chat, this.userComment});

  Chat.fromJson(Map<String, dynamic> json) {
    time = json['time'];
    chat = json['chat'];
    userComment = json['userComment'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['time'] = this.time;
    data['chat'] = this.chat;
    data['userComment'] = this.userComment;
    return data;
  }
}