class UserModel {
  String? name;
  String? avatar;
  String? email;
  String? phone;
  bool? chucVu;
  String? team;
  String? birthday;
  int? state;
  String? username;

  UserModel(
      {this.name, this.avatar, this.email, this.phone, this.chucVu, this.team, this.birthday,this.state,this.username});

  UserModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    avatar = json['avatar'];
    email = json['email'];
    phone = json['phone'];
    chucVu = json['chucVu'];
    team = json['team'];
    birthday = json['birthday'];
    state = json['state'];
    username = json['username'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['avatar'] = this.avatar;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['chucVu'] = this.chucVu;
    data['team'] = this.team;
    data['birthday'] = this.birthday;
    data['state'] = this.state;
    data['username'] = this.username;
    return data;
  }
}

class infoUser {
  String? name;
  String? avatar;
  String? email;
  String? phone;
  bool? chucVu;
  String? team;
  String? username;
  String? birthday;
  int? state;

  infoUser(
      {this.name,
        this.avatar,
        this.email,
        this.phone,
        this.chucVu,
        this.team,
        this.username,
        this.birthday,
        this.state});

  infoUser.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    avatar = json['avatar'];
    email = json['email'];
    phone = json['phone'];
    chucVu = json['chucVu'];
    team = json['team'];
    username = json['username'];
    birthday = json['birthday'];
    state = json['state'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['avatar'] = this.avatar;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['chucVu'] = this.chucVu;
    data['team'] = this.team;
    data['username'] = this.username;
    data['birthday'] = this.birthday;
    data['state'] = this.state;
    return data;
  }
}

