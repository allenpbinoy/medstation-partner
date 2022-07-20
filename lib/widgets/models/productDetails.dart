class productDetails {
  Id? iId;
  String? productname;
  String? qty;
  String? price;
  String? composition;
  String? category;
  String? imgUrl;
  String? username;
  String? shopname;
  String? sAddress;
  String? whatsappNumber;
  String? sLocation;
  String? status;
  V? vV;

  productDetails(
      {this.iId,
      this.productname,
      this.qty,
      this.price,
      this.composition,
      this.category,
      this.imgUrl,
      this.username,
      this.shopname,
      this.sAddress,
      this.whatsappNumber,
      this.sLocation,
      this.status,
      this.vV});

  productDetails.fromJson(Map<String, dynamic> json) {
    iId = json['_id'] != null ? new Id.fromJson(json['_id']) : null;
    productname = json['productname'];
    qty = json['qty'];
    price = json['price'];
    composition = json['composition'];
    category = json['category'];
    imgUrl = json['imgUrl'];
    username = json['username'];
    shopname = json['shopname'];
    sAddress = json['sAddress'];
    whatsappNumber = json['whatsappNumber'];
    sLocation = json['sLocation'];
    status = json['status'];
    vV = json['__v'] != null ? new V.fromJson(json['__v']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.iId != null) {
      data['_id'] = this.iId!.toJson();
    }
    data['productname'] = this.productname;
    data['qty'] = this.qty;
    data['price'] = this.price;
    data['composition'] = this.composition;
    data['category'] = this.category;
    data['imgUrl'] = this.imgUrl;
    data['username'] = this.username;
    data['shopname'] = this.shopname;
    data['sAddress'] = this.sAddress;
    data['whatsappNumber'] = this.whatsappNumber;
    data['sLocation'] = this.sLocation;
    data['status'] = this.status;
    if (this.vV != null) {
      data['__v'] = this.vV!.toJson();
    }
    return data;
  }
}

class Id {
  String? oid;

  Id({this.oid});

  Id.fromJson(Map<String, dynamic> json) {
    oid = json['$oid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['$oid'] = this.oid;
    return data;
  }
}

class V {
  String? numberInt;

  V({this.numberInt});

  V.fromJson(Map<String, dynamic> json) {
    numberInt = json['$numberInt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['$numberInt'] = this.numberInt;
    return data;
  }
}
