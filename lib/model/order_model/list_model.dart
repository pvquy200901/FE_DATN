class listOrder {
  String? code;
  String? date;
  String? time;
  String? nameStadium;

  listOrder({this.code, this.date, this.time, this.nameStadium});

  listOrder.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    date = json['date'];
    time = json['time'];
    nameStadium = json['nameStadium'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['date'] = this.date;
    data['time'] = this.time;
    data['nameStadium'] = this.nameStadium;
    return data;
  }
}

class infoOrder {
  String? nameStadium;
  String? code;
  int? priceStadium;
  String? date;
  double? orderTime;
  String? startTime;
  String? endTime;
  int? price;
  String? state;
  String? address;

  infoOrder(
      {this.nameStadium,
        this.code,
        this.priceStadium,
        this.date,
        this.orderTime,
        this.startTime,
        this.endTime,
        this.price,
        this.state,
        this.address});

  infoOrder.fromJson(Map<String, dynamic> json) {
    nameStadium = json['nameStadium'];
    code = json['code'];
    priceStadium = json['priceStadium'];
    date = json['date'];
    orderTime = json['orderTime'];
    startTime = json['startTime'];
    endTime = json['endTime'];
    price = json['price'];
    state = json['state'];
    address = json['address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nameStadium'] = this.nameStadium;
    data['code'] = this.code;
    data['priceStadium'] = this.priceStadium;
    data['date'] = this.date;
    data['orderTime'] = this.orderTime;
    data['startTime'] = this.startTime;
    data['endTime'] = this.endTime;
    data['price'] = this.price;
    data['state'] = this.state;
    data['address'] = this.address;
    return data;
  }
}

class myOrder {
  String? code;
  String? date;
  String? startTime;
  String? endTime;
  String? price;
  String? state;
  String? nameStadium;
  String? address;

  myOrder(
      {this.code,
        this.date,
        this.startTime,
        this.endTime,
        this.price,
        this.state,
        this.nameStadium,
        this.address});

  myOrder.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    date = json['date'];
    startTime = json['startTime'];
    endTime = json['endTime'];
    price = json['price'];
    state = json['state'];
    nameStadium = json['nameStadium'];
    address = json['address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['date'] = this.date;
    data['startTime'] = this.startTime;
    data['endTime'] = this.endTime;
    data['price'] = this.price;
    data['state'] = this.state;
    data['nameStadium'] = this.nameStadium;
    data['address'] = this.address;
    return data;
  }
}


