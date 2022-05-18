class CheckList {
  String status;
  String message;
  Data data;

  CheckList({this.status, this.message, this.data});

  CheckList.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class Data {
  int orderId;
  int userId;
  int storeId;
  int addressId;
  String cartId;
  int totalPrice;
  int priceWithoutDelivery;
  int totalProductsMrp;
  String paymentMethod;
  int paidByWallet;
  int remPrice;
  String orderDate;
  String deliveryDate;
  int deliveryCharge;
  String timeSlot;
  int dboyId;
  String orderStatus;
  String userSignature;
  Null cancellingReason;
  int couponId;
  int couponDiscount;
  String paymentStatus;
  int cancelByStore;
  Null updatedAt;

  Data(
      {this.orderId,
        this.userId,
        this.storeId,
        this.addressId,
        this.cartId,
        this.totalPrice,
        this.priceWithoutDelivery,
        this.totalProductsMrp,
        this.paymentMethod,
        this.paidByWallet,
        this.remPrice,
        this.orderDate,
        this.deliveryDate,
        this.deliveryCharge,
        this.timeSlot,
        this.dboyId,
        this.orderStatus,
        this.userSignature,
        this.cancellingReason,
        this.couponId,
        this.couponDiscount,
        this.paymentStatus,
        this.cancelByStore,
        this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    orderId = json['order_id'];
    userId = json['user_id'];
    storeId = json['store_id'];
    addressId = json['address_id'];
    cartId = json['cart_id'];
    totalPrice = json['total_price'];
    priceWithoutDelivery = json['price_without_delivery'];
    totalProductsMrp = json['total_products_mrp'];
    paymentMethod = json['payment_method'];
    paidByWallet = json['paid_by_wallet'];
    remPrice = json['rem_price'];
    orderDate = json['order_date'];
    deliveryDate = json['delivery_date'];
    deliveryCharge = json['delivery_charge'];
    timeSlot = json['time_slot'];
    dboyId = json['dboy_id'];
    orderStatus = json['order_status'];
    userSignature = json['user_signature'];
    cancellingReason = json['cancelling_reason'];
    couponId = json['coupon_id'];
    couponDiscount = json['coupon_discount'];
    paymentStatus = json['payment_status'];
    cancelByStore = json['cancel_by_store'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['order_id'] = this.orderId;
    data['user_id'] = this.userId;
    data['store_id'] = this.storeId;
    data['address_id'] = this.addressId;
    data['cart_id'] = this.cartId;
    data['total_price'] = this.totalPrice;
    data['price_without_delivery'] = this.priceWithoutDelivery;
    data['total_products_mrp'] = this.totalProductsMrp;
    data['payment_method'] = this.paymentMethod;
    data['paid_by_wallet'] = this.paidByWallet;
    data['rem_price'] = this.remPrice;
    data['order_date'] = this.orderDate;
    data['delivery_date'] = this.deliveryDate;
    data['delivery_charge'] = this.deliveryCharge;
    data['time_slot'] = this.timeSlot;
    data['dboy_id'] = this.dboyId;
    data['order_status'] = this.orderStatus;
    data['user_signature'] = this.userSignature;
    data['cancelling_reason'] = this.cancellingReason;
    data['coupon_id'] = this.couponId;
    data['coupon_discount'] = this.couponDiscount;
    data['payment_status'] = this.paymentStatus;
    data['cancel_by_store'] = this.cancelByStore;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}