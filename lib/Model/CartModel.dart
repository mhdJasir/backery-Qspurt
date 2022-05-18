

class CartModel{
  String varient_id;
  String varient_image;
  String product_id;
  String unit;
  String base_mrp;
  String base_price;
  String product_varient_name;

  CartModel(this.varient_id, this.varient_image, this.product_id, this.unit,
      this.base_mrp, this.base_price, this.product_varient_name);

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'varient_id': varient_id,
      'varient_image': varient_image,
      'product_id': product_id,
      'unit': unit,
      'base_mrp': base_mrp,
      'base_price': base_price,
      'product_varient_name': product_varient_name,
    };
    return map;
  }

  CartModel.fromMap(Map<String, dynamic> map) {
    varient_id = map['varient_id'];
    varient_image = map['varient_image'];
    product_id = map['product_id'];
    unit = map['unit'];
    base_mrp = map['base_mrp'];
    base_price = map['base_price'];
    product_varient_name = map['product_varient_name'];
  }
}