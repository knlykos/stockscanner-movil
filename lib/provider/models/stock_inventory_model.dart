// To parse this JSON data, do
//
//     final stockInventory = stockInventoryFromJson(jsonString);

import 'dart:convert';

class StockInventory {
    List<int> moveIds;
    bool lotId;
    List<dynamic> companyId;
    DateTime writeDate;
    int totalQty;
    bool productId;
    List<int> lineIds;
    bool categoryId;
    DateTime date;
    String filter;
    DateTime lastUpdate;
    String state;
    DateTime createDate;
    bool packageId;
    bool exhausted;
    List<dynamic> locationId;
    String name;
    List<dynamic> createUid;
    bool partnerId;
    List<dynamic> writeUid;
    String displayName;
    int id;

    StockInventory({
        this.moveIds,
        this.lotId,
        this.companyId,
        this.writeDate,
        this.totalQty,
        this.productId,
        this.lineIds,
        this.categoryId,
        this.date,
        this.filter,
        this.lastUpdate,
        this.state,
        this.createDate,
        this.packageId,
        this.exhausted,
        this.locationId,
        this.name,
        this.createUid,
        this.partnerId,
        this.writeUid,
        this.displayName,
        this.id,
    });

    factory StockInventory.fromRawJson(String str) => StockInventory.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory StockInventory.fromJson(Map<String, dynamic> json) => StockInventory(
        moveIds: json["move_ids"] == null ? null : List<int>.from(json["move_ids"].map((x) => x)),
        lotId: json["lot_id"] == null ? null : json["lot_id"],
        companyId: json["company_id"] == null ? null : List<dynamic>.from(json["company_id"].map((x) => x)),
        writeDate: json["write_date"] == null ? null : DateTime.parse(json["write_date"]),
        totalQty: json["total_qty"] == null ? null : json["total_qty"],
        productId: json["product_id"] == null ? null : json["product_id"],
        lineIds: json["line_ids"] == null ? null : List<int>.from(json["line_ids"].map((x) => x)),
        categoryId: json["category_id"] == null ? null : json["category_id"],
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        filter: json["filter"] == null ? null : json["filter"],
        lastUpdate: json["__last_update"] == null ? null : DateTime.parse(json["__last_update"]),
        state: json["state"] == null ? null : json["state"],
        createDate: json["create_date"] == null ? null : DateTime.parse(json["create_date"]),
        packageId: json["package_id"] == null ? null : json["package_id"],
        exhausted: json["exhausted"] == null ? null : json["exhausted"],
        locationId: json["location_id"] == null ? null : List<dynamic>.from(json["location_id"].map((x) => x)),
        name: json["name"] == null ? null : json["name"],
        createUid: json["create_uid"] == null ? null : List<dynamic>.from(json["create_uid"].map((x) => x)),
        partnerId: json["partner_id"] == null ? null : json["partner_id"],
        writeUid: json["write_uid"] == null ? null : List<dynamic>.from(json["write_uid"].map((x) => x)),
        displayName: json["display_name"] == null ? null : json["display_name"],
        id: json["id"] == null ? null : json["id"],
    );

    Map<String, dynamic> toJson() => {
        "move_ids": moveIds == null ? null : List<dynamic>.from(moveIds.map((x) => x)),
        "lot_id": lotId == null ? null : lotId,
        "company_id": companyId == null ? null : List<dynamic>.from(companyId.map((x) => x)),
        "write_date": writeDate == null ? null : writeDate.toIso8601String(),
        "total_qty": totalQty == null ? null : totalQty,
        "product_id": productId == null ? null : productId,
        "line_ids": lineIds == null ? null : List<dynamic>.from(lineIds.map((x) => x)),
        "category_id": categoryId == null ? null : categoryId,
        "date": date == null ? null : date.toIso8601String(),
        "filter": filter == null ? null : filter,
        "__last_update": lastUpdate == null ? null : lastUpdate.toIso8601String(),
        "state": state == null ? null : state,
        "create_date": createDate == null ? null : createDate.toIso8601String(),
        "package_id": packageId == null ? null : packageId,
        "exhausted": exhausted == null ? null : exhausted,
        "location_id": locationId == null ? null : List<dynamic>.from(locationId.map((x) => x)),
        "name": name == null ? null : name,
        "create_uid": createUid == null ? null : List<dynamic>.from(createUid.map((x) => x)),
        "partner_id": partnerId == null ? null : partnerId,
        "write_uid": writeUid == null ? null : List<dynamic>.from(writeUid.map((x) => x)),
        "display_name": displayName == null ? null : displayName,
        "id": id == null ? null : id,
    };
}
