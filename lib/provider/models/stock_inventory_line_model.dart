// To parse this JSON data, do
//
//     final stockInventory = stockInventoryFromJson(jsonString);

import 'dart:convert';

import 'package:stockscanner/provider/models/product_product_model.dart';

class StockInventoryLine {
  String state;
  bool packageId;
  bool prodLotId;
  List<dynamic> productUomCategoryId;
  List<dynamic> companyId;
  int theoreticalQty;
  String productTracking;
  String displayName;
  List<dynamic> createUid;
  List<dynamic> productId;
  bool partnerId;
  List<dynamic> writeUid;
  List<dynamic> productUomId;
  int id;
  DateTime writeDate;
  int productQty;
  DateTime lastUpdate;
  List<dynamic> inventoryLocationId;
  List<dynamic> locationId;
  List<dynamic> inventoryId;
  DateTime createDate;
  List<Product> products;

  StockInventoryLine({
    this.state,
    this.packageId,
    this.prodLotId,
    this.productUomCategoryId,
    this.companyId,
    this.theoreticalQty,
    this.productTracking,
    this.displayName,
    this.createUid,
    this.productId,
    this.partnerId,
    this.writeUid,
    this.productUomId,
    this.id,
    this.writeDate,
    this.productQty,
    this.lastUpdate,
    this.inventoryLocationId,
    this.locationId,
    this.inventoryId,
    this.createDate,
    this.products,
  });

  factory StockInventoryLine.fromRawJson(String str) =>
      StockInventoryLine.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory StockInventoryLine.fromJson(Map<String, dynamic> json) => StockInventoryLine(
        state: json["state"] == null ? null : json["state"],
        packageId: json["package_id"] == null ? null : json["package_id"],
        prodLotId: json["prod_lot_id"] == null ? null : json["prod_lot_id"],
        productUomCategoryId: json["product_uom_category_id"] == null
            ? null
            : List<dynamic>.from(json["product_uom_category_id"].map((x) => x)),
        companyId: json["company_id"] == null
            ? null
            : List<dynamic>.from(json["company_id"].map((x) => x)),
        theoreticalQty:
            json["theoretical_qty"] == null ? null : json["theoretical_qty"],
        productTracking:
            json["product_tracking"] == null ? null : json["product_tracking"],
        displayName: json["display_name"] == null ? null : json["display_name"],
        createUid: json["create_uid"] == null
            ? null
            : List<dynamic>.from(json["create_uid"].map((x) => x)),
        productId: json["product_id"] == null
            ? null
            : List<dynamic>.from(json["product_id"].map((x) => x)),
        partnerId: json["partner_id"] == null ? null : json["partner_id"],
        writeUid: json["write_uid"] == null
            ? null
            : List<dynamic>.from(json["write_uid"].map((x) => x)),
        productUomId: json["product_uom_id"] == null
            ? null
            : List<dynamic>.from(json["product_uom_id"].map((x) => x)),
        id: json["id"] == null ? null : json["id"],
        writeDate: json["write_date"] == null
            ? null
            : DateTime.parse(json["write_date"]),
        productQty: json["product_qty"] == null ? null : json["product_qty"],
        lastUpdate: json["__last_update"] == null
            ? null
            : DateTime.parse(json["__last_update"]),
        inventoryLocationId: json["inventory_location_id"] == null
            ? null
            : List<dynamic>.from(json["inventory_location_id"].map((x) => x)),
        locationId: json["location_id"] == null
            ? null
            : List<dynamic>.from(json["location_id"].map((x) => x)),
        inventoryId: json["inventory_id"] == null
            ? null
            : List<dynamic>.from(json["inventory_id"].map((x) => x)),
        createDate: json["create_date"] == null
            ? null
            : DateTime.parse(json["create_date"]),
        products: json["products"] == null
            ? null
            : List<Product>.from(
                json["products"].map((x) => Product.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "state": state == null ? null : state,
        "package_id": packageId == null ? null : packageId,
        "prod_lot_id": prodLotId == null ? null : prodLotId,
        "product_uom_category_id": productUomCategoryId == null
            ? null
            : List<dynamic>.from(productUomCategoryId.map((x) => x)),
        "company_id": companyId == null
            ? null
            : List<dynamic>.from(companyId.map((x) => x)),
        "theoretical_qty": theoreticalQty == null ? null : theoreticalQty,
        "product_tracking": productTracking == null ? null : productTracking,
        "display_name": displayName == null ? null : displayName,
        "create_uid": createUid == null
            ? null
            : List<dynamic>.from(createUid.map((x) => x)),
        "product_id": productId == null
            ? null
            : List<dynamic>.from(productId.map((x) => x)),
        "partner_id": partnerId == null ? null : partnerId,
        "write_uid": writeUid == null
            ? null
            : List<dynamic>.from(writeUid.map((x) => x)),
        "product_uom_id": productUomId == null
            ? null
            : List<dynamic>.from(productUomId.map((x) => x)),
        "id": id == null ? null : id,
        "write_date": writeDate == null ? null : writeDate.toIso8601String(),
        "product_qty": productQty == null ? null : productQty,
        "__last_update":
            lastUpdate == null ? null : lastUpdate.toIso8601String(),
        "inventory_location_id": inventoryLocationId == null
            ? null
            : List<dynamic>.from(inventoryLocationId.map((x) => x)),
        "location_id": locationId == null
            ? null
            : List<dynamic>.from(locationId.map((x) => x)),
        "inventory_id": inventoryId == null
            ? null
            : List<dynamic>.from(inventoryId.map((x) => x)),
        "create_date": createDate == null ? null : createDate.toIso8601String(),
        "products": products == null
            ? null
            : List<dynamic>.from(products.map((x) => x.toJson())),
      };
}
