class mAction {
  String? code;
  String? des;
  String? time;
  String? createTime;
  String? type;
  String? state;
  String? user;
  String? team;

  mAction(
      {this.code,
        this.des,
        this.time,
        this.createTime,
        this.type,
        this.state,
        this.team,
        this.user});

  mAction.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    des = json['des'];
    time = json['time'];
    createTime = json['createTime'];
    type = json['type'];
    state = json['state'];
    user = json['user'];
    team = json['team'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['des'] = this.des;
    data['time'] = this.time;
    data['createTime'] = this.createTime;
    data['type'] = this.type;
    data['state'] = this.state;
    data['user'] = this.user;
    data['team'] = this.team;
    return data;
  }
}
