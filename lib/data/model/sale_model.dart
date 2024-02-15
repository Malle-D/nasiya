class SaleModel {
  String name;
  String phone;
  String products;
  String comment;
  int factPrice;
  String monthCount;
  int monthPrice;
  int initialPayment;
  int left;
  bool isFavourite;
  bool isClosed;
  int saleTime;

  SaleModel(
      this.name,
      this.phone,
      this.products,
      this.comment,
      this.factPrice,
      this.monthCount,
      this.monthPrice,
      this.initialPayment,
      this.left,
      this.isFavourite,
      this.isClosed,
      this.saleTime);

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'phone': phone,
      'products': products,
      'comment': comment,
      'factPrice': factPrice,
      'monthCount': monthCount,
      'monthPrice': monthPrice,
      'initialPayment': initialPayment,
      'left': left,
      'isFavourite': isFavourite,
      'isClosed': isClosed,
      'saleTime': saleTime,
    };
  }

  factory SaleModel.fromMap(Map<String, dynamic> map) {
    return SaleModel(
      map['name'],
      map['phone'],
      map['products'],
      map['comment'],
      map['price'],
      map['monthCount'],
      map['monthPrice'],
      map['initialPayment'],
      map['left'],
      map['isFavourite'],
      map['isClosed'],
      map['saleTime'],
    );
  }
}
