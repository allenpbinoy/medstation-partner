class vendorModel {
  String? username;
  String? shopName;
  String? sAddress;
  String? phoneNumber;
  String? whatsappNumber;
  String? sLocation;
  String? image;
  String? id;

  vendorModel(
      {this.username,
      this.shopName,
      this.sAddress,
      this.phoneNumber,
      this.whatsappNumber,
      this.sLocation,
      this.image,
      this.id});

  vendorModel.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    shopName = json['shopName'];
    sAddress = json['sAddress'];
    phoneNumber = json['phoneNumber'];
    whatsappNumber = json['whatsappNumber'];
    sLocation = json['sLocation'];
    image = json['image'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['username'] = this.username;
    data['shopName'] = this.shopName;
    data['sAddress'] = this.sAddress;
    data['phoneNumber'] = this.phoneNumber;
    data['whatsappNumber'] = this.whatsappNumber;
    data['sLocation'] = this.sLocation;
    data['image'] = this.image;
    data['id'] = this.id;
    return data;
  }
}