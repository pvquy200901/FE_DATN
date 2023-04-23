class News {
  String? code;
  String? user;
  String? title;
  String? shortDes;
  String? createdTime;
  String? reputation;
  String? time;

  News(
      {this.code,
        this.user,
        this.title,
        this.shortDes,
        this.createdTime,
        this.reputation,
        this.time});

  News.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    user = json['user'];
    title = json['title'];
    shortDes = json['shortDes'];
    createdTime = json['createdTime'];
    reputation = json['reputation'];
    time = json['time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['user'] = this.user;
    data['title'] = this.title;
    data['shortDes'] = this.shortDes;
    data['createdTime'] = this.createdTime;
    data['reputation'] = this.reputation;
    data['time'] = this.time;
    return data;
  }
}

class infoNews {
  String? title;
  String? description;
  String? user;
  String? username;
  String? shortDes;
  String? createdTime;
  List<String>? imagesNews;

  infoNews(
      {this.title,
        this.description,
        this.user,
        this.username,
        this.shortDes,
        this.createdTime,
        this.imagesNews});

  infoNews.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    description = json['description'];
    user = json['user'];
    username = json['username'];
    shortDes = json['shortDes'];
    createdTime = json['createdTime'];
    imagesNews = json['imagesNews'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['description'] = this.description;
    data['user'] = this.user;
    data['username'] = this.username;
    data['shortDes'] = this.shortDes;
    data['createdTime'] = this.createdTime;
    data['imagesNews'] = this.imagesNews;
    return data;
  }
}

