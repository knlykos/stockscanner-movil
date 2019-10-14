import 'dart:convert';

class Product {
  String name;
  String code;
  bool purchaseOk;
  String imageSmall;
  bool activityTypeId;
  bool descriptionPickingout;
  int sequence;
  String description;
  int id;
  List<dynamic> responsibleId;
  double weight;
  List<dynamic> orderpointIds;
  bool messageUnread;
  String type;
  List<dynamic> propertyStockProduction;
  List<int> validProductTemplateAttributeLineWnvaIds;
  bool activityDateDeadline;
  int messageNeedactionCounter;
  List<int> stockQuantIds;
  int saleDelay;
  List<dynamic> activityIds;
  List<dynamic> costCurrencyId;
  bool descriptionPurchase;
  List<dynamic> uomPoId;
  bool activityState;
  int messageAttachmentCount;
  List<dynamic> variantSellerIds;
  int virtualAvailable;
  List<dynamic> routeIds;
  List<dynamic> packagingIds;
  bool descriptionPickingin;
  double priceExtra;
  List<int> messageIds;
  List<int> validExistingVariantIds;
  List<dynamic> companyId;
  dynamic descriptionSale;
  List<int> validProductAttributeWnvaIds;
  List<dynamic> itemIds;
  List<dynamic> propertyStockInventory;
  List<dynamic> routeFromCategIds;
  List<dynamic> productTmplId;
  List<int> validProductAttributeValueIds;
  int price;
  bool locationId;
  String defaultCode;
  int incomingQty;
  int volume;
  List<int> validProductTemplateAttributeLineIds;
  List<dynamic> uomId;
  String image;
  bool pricelistId;
  bool activityUserId;
  List<int> messagePartnerIds;
  List<int> productTemplateAttributeValueIds;
  bool messageMainAttachmentId;
  String displayName;
  int color;
  List<dynamic> currencyId;
  int messageHasErrorCounter;
  List<dynamic> categId;
  List<int> stockMoveIds;
  List<dynamic> productVariantId;
  String tracking;
  String weightUomName;
  bool saleOk;
  List<int> attributeValueIds;
  dynamic imageVariant;
  List<dynamic> sellerIds;
  List<int> productVariantIds;
  DateTime lastUpdate;
  int reorderingMaxQty;
  DateTime createDate;
  List<dynamic> writeUid;
  int nbrReorderingRules;
  int outgoingQty;
  List<int> attributeLineIds;
  bool messageNeedaction;
  String imageMedium;
  String uomName;
  int reorderingMinQty;
  List<dynamic> validArchivedVariantIds;
  int messageUnreadCounter;
  List<int> validProductAttributeValueWnvaIds;
  bool active;
  bool warehouseId;
  bool isProductVariant;
  double listPrice;
  DateTime writeDate;
  double lstPrice;
  String partnerRef;
  double standardPrice;
  bool messageHasError;
  List<dynamic> messageChannelIds;
  bool descriptionPicking;
  List<dynamic> weightUomId;
  List<dynamic> pricelistItemIds;
  int productVariantCount;
  List<dynamic> createUid;
  String barcode;
  List<int> validProductAttributeIds;
  List<int> messageFollowerIds;
  bool messageIsFollower;
  bool activitySummary;
  int qtyAvailable;
  bool rental;

  Product({
    this.name,
    this.code,
    this.purchaseOk,
    this.imageSmall,
    this.activityTypeId,
    this.descriptionPickingout,
    this.sequence,
    this.description,
    this.id,
    this.responsibleId,
    this.weight,
    this.orderpointIds,
    this.messageUnread,
    this.type,
    this.propertyStockProduction,
    this.validProductTemplateAttributeLineWnvaIds,
    this.activityDateDeadline,
    this.messageNeedactionCounter,
    this.stockQuantIds,
    this.saleDelay,
    this.activityIds,
    this.costCurrencyId,
    this.descriptionPurchase,
    this.uomPoId,
    this.activityState,
    this.messageAttachmentCount,
    this.variantSellerIds,
    this.virtualAvailable,
    this.routeIds,
    this.packagingIds,
    this.descriptionPickingin,
    this.priceExtra,
    this.messageIds,
    this.validExistingVariantIds,
    this.companyId,
    this.descriptionSale,
    this.validProductAttributeWnvaIds,
    this.itemIds,
    this.propertyStockInventory,
    this.routeFromCategIds,
    this.productTmplId,
    this.validProductAttributeValueIds,
    this.price,
    this.locationId,
    this.defaultCode,
    this.incomingQty,
    this.volume,
    this.validProductTemplateAttributeLineIds,
    this.uomId,
    this.image,
    this.pricelistId,
    this.activityUserId,
    this.messagePartnerIds,
    this.productTemplateAttributeValueIds,
    this.messageMainAttachmentId,
    this.displayName,
    this.color,
    this.currencyId,
    this.messageHasErrorCounter,
    this.categId,
    this.stockMoveIds,
    this.productVariantId,
    this.tracking,
    this.weightUomName,
    this.saleOk,
    this.attributeValueIds,
    this.imageVariant,
    this.sellerIds,
    this.productVariantIds,
    this.lastUpdate,
    this.reorderingMaxQty,
    this.createDate,
    this.writeUid,
    this.nbrReorderingRules,
    this.outgoingQty,
    this.attributeLineIds,
    this.messageNeedaction,
    this.imageMedium,
    this.uomName,
    this.reorderingMinQty,
    this.validArchivedVariantIds,
    this.messageUnreadCounter,
    this.validProductAttributeValueWnvaIds,
    this.active,
    this.warehouseId,
    this.isProductVariant,
    this.listPrice,
    this.writeDate,
    this.lstPrice,
    this.partnerRef,
    this.standardPrice,
    this.messageHasError,
    this.messageChannelIds,
    this.descriptionPicking,
    this.weightUomId,
    this.pricelistItemIds,
    this.productVariantCount,
    this.createUid,
    this.barcode,
    this.validProductAttributeIds,
    this.messageFollowerIds,
    this.messageIsFollower,
    this.activitySummary,
    this.qtyAvailable,
    this.rental,
  });

  factory Product.fromRawJson(String str) => Product.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        name: json["name"] == null ? null : json["name"],
        code: json["code"] == null ? null : json["code"],
        purchaseOk: json["purchase_ok"] == null ? null : json["purchase_ok"],
        imageSmall: json["image_small"] == null ? null : json["image_small"],
        activityTypeId:
            json["activity_type_id"] == null ? null : json["activity_type_id"],
        descriptionPickingout: json["description_pickingout"] == null
            ? null
            : json["description_pickingout"],
        sequence: json["sequence"] == null ? null : json["sequence"],
        description: json["description"].toString() == null
            ? null
            : json["description"].toString(),
        id: json["id"] == null ? null : json["id"],
        responsibleId: json["responsible_id"] == null
            ? null
            : List<dynamic>.from(json["responsible_id"].map((x) => x)),
        weight: json["weight"].toDouble() == null
            ? null
            : json["weight"].toDouble(),
        orderpointIds: json["orderpoint_ids"] == null
            ? null
            : List<dynamic>.from(json["orderpoint_ids"].map((x) => x)),
        messageUnread:
            json["message_unread"] == null ? null : json["message_unread"],
        type: json["type"] == null ? null : json["type"],
        propertyStockProduction: json["property_stock_production"] == null
            ? null
            : List<dynamic>.from(
                json["property_stock_production"].map((x) => x)),
        validProductTemplateAttributeLineWnvaIds:
            json["valid_product_template_attribute_line_wnva_ids"] == null
                ? null
                : List<int>.from(
                    json["valid_product_template_attribute_line_wnva_ids"]
                        .map((x) => x)),
        activityDateDeadline: json["activity_date_deadline"] == null
            ? null
            : json["activity_date_deadline"],
        messageNeedactionCounter: json["message_needaction_counter"] == null
            ? null
            : json["message_needaction_counter"],
        stockQuantIds: json["stock_quant_ids"] == null
            ? null
            : List<int>.from(json["stock_quant_ids"].map((x) => x)),
        saleDelay: json["sale_delay"] == null ? null : json["sale_delay"],
        activityIds: json["activity_ids"] == null
            ? null
            : List<dynamic>.from(json["activity_ids"].map((x) => x)),
        costCurrencyId: json["cost_currency_id"] == null
            ? null
            : List<dynamic>.from(json["cost_currency_id"].map((x) => x)),
        descriptionPurchase: json["description_purchase"] == null
            ? null
            : json["description_purchase"],
        uomPoId: json["uom_po_id"] == null
            ? null
            : List<dynamic>.from(json["uom_po_id"].map((x) => x)),
        activityState:
            json["activity_state"] == null ? null : json["activity_state"],
        messageAttachmentCount: json["message_attachment_count"] == null
            ? null
            : json["message_attachment_count"],
        variantSellerIds: json["variant_seller_ids"] == null
            ? null
            : List<dynamic>.from(json["variant_seller_ids"].map((x) => x)),
        virtualAvailable: json["virtual_available"] == null
            ? null
            : json["virtual_available"],
        routeIds: json["route_ids"] == null
            ? null
            : List<dynamic>.from(json["route_ids"].map((x) => x)),
        packagingIds: json["packaging_ids"] == null
            ? null
            : List<dynamic>.from(json["packaging_ids"].map((x) => x)),
        descriptionPickingin: json["description_pickingin"] == null
            ? null
            : json["description_pickingin"],
        priceExtra:
            json["price_extra"] == null ? null : json["price_extra"].toDouble(),
        messageIds: json["message_ids"] == null
            ? null
            : List<int>.from(json["message_ids"].map((x) => x)),
        validExistingVariantIds: json["valid_existing_variant_ids"] == null
            ? null
            : List<int>.from(json["valid_existing_variant_ids"].map((x) => x)),
        companyId: json["company_id"] == null
            ? null
            : List<dynamic>.from(json["company_id"].map((x) => x)),
        descriptionSale: json["description_sale"],
        validProductAttributeWnvaIds:
            json["valid_product_attribute_wnva_ids"] == null
                ? null
                : List<int>.from(
                    json["valid_product_attribute_wnva_ids"].map((x) => x)),
        itemIds: json["item_ids"] == null
            ? null
            : List<dynamic>.from(json["item_ids"].map((x) => x)),
        propertyStockInventory: json["property_stock_inventory"] == null
            ? null
            : List<dynamic>.from(
                json["property_stock_inventory"].map((x) => x)),
        routeFromCategIds: json["route_from_categ_ids"] == null
            ? null
            : List<dynamic>.from(json["route_from_categ_ids"].map((x) => x)),
        productTmplId: json["product_tmpl_id"] == null
            ? null
            : List<dynamic>.from(json["product_tmpl_id"].map((x) => x)),
        validProductAttributeValueIds:
            json["valid_product_attribute_value_ids"] == null
                ? null
                : List<int>.from(
                    json["valid_product_attribute_value_ids"].map((x) => x)),
        price: json["price"] == null ? null : json["price"],
        locationId: json["location_id"] == null ? null : json["location_id"],
        defaultCode: json["default_code"] == null ? null : json["default_code"],
        incomingQty: json["incoming_qty"] == null ? null : json["incoming_qty"],
        volume: json["volume"] == null ? null : json["volume"],
        validProductTemplateAttributeLineIds:
            json["valid_product_template_attribute_line_ids"] == null
                ? null
                : List<int>.from(
                    json["valid_product_template_attribute_line_ids"]
                        .map((x) => x)),
        uomId: json["uom_id"] == null
            ? null
            : List<dynamic>.from(json["uom_id"].map((x) => x)),
        image: json["image"] == null ? null : json["image"],
        pricelistId: json["pricelist_id"] == null ? null : json["pricelist_id"],
        activityUserId:
            json["activity_user_id"] == null ? null : json["activity_user_id"],
        messagePartnerIds: json["message_partner_ids"] == null
            ? null
            : List<int>.from(json["message_partner_ids"].map((x) => x)),
        productTemplateAttributeValueIds:
            json["product_template_attribute_value_ids"] == null
                ? null
                : List<int>.from(
                    json["product_template_attribute_value_ids"].map((x) => x)),
        messageMainAttachmentId: json["message_main_attachment_id"] == null
            ? null
            : json["message_main_attachment_id"],
        displayName: json["display_name"] == null ? null : json["display_name"],
        color: json["color"] == null ? null : json["color"],
        currencyId: json["currency_id"] == null
            ? null
            : List<dynamic>.from(json["currency_id"].map((x) => x)),
        messageHasErrorCounter: json["message_has_error_counter"] == null
            ? null
            : json["message_has_error_counter"],
        categId: json["categ_id"] == null
            ? null
            : List<dynamic>.from(json["categ_id"].map((x) => x)),
        stockMoveIds: json["stock_move_ids"] == null
            ? null
            : List<int>.from(json["stock_move_ids"].map((x) => x)),
        productVariantId: json["product_variant_id"] == null
            ? null
            : List<dynamic>.from(json["product_variant_id"].map((x) => x)),
        tracking: json["tracking"] == null ? null : json["tracking"],
        weightUomName:
            json["weight_uom_name"] == null ? null : json["weight_uom_name"],
        saleOk: json["sale_ok"] == null ? null : json["sale_ok"],
        attributeValueIds: json["attribute_value_ids"] == null
            ? null
            : List<int>.from(json["attribute_value_ids"].map((x) => x)),
        imageVariant: json["image_variant"],
        sellerIds: json["seller_ids"] == null
            ? null
            : List<dynamic>.from(json["seller_ids"].map((x) => x)),
        productVariantIds: json["product_variant_ids"] == null
            ? null
            : List<int>.from(json["product_variant_ids"].map((x) => x)),
        lastUpdate: json["__last_update"] == null
            ? null
            : DateTime.parse(json["__last_update"]),
        reorderingMaxQty: json["reordering_max_qty"] == null
            ? null
            : json["reordering_max_qty"],
        createDate: json["create_date"] == null
            ? null
            : DateTime.parse(json["create_date"]),
        writeUid: json["write_uid"] == null
            ? null
            : List<dynamic>.from(json["write_uid"].map((x) => x)),
        nbrReorderingRules: json["nbr_reordering_rules"] == null
            ? null
            : json["nbr_reordering_rules"],
        outgoingQty: json["outgoing_qty"] == null ? null : json["outgoing_qty"],
        attributeLineIds: json["attribute_line_ids"] == null
            ? null
            : List<int>.from(json["attribute_line_ids"].map((x) => x)),
        messageNeedaction: json["message_needaction"] == null
            ? null
            : json["message_needaction"],
        imageMedium: json["image_medium"] == null ? null : json["image_medium"],
        uomName: json["uom_name"] == null ? null : json["uom_name"],
        reorderingMinQty: json["reordering_min_qty"] == null
            ? null
            : json["reordering_min_qty"],
        validArchivedVariantIds: json["valid_archived_variant_ids"] == null
            ? null
            : List<dynamic>.from(
                json["valid_archived_variant_ids"].map((x) => x)),
        messageUnreadCounter: json["message_unread_counter"] == null
            ? null
            : json["message_unread_counter"],
        validProductAttributeValueWnvaIds:
            json["valid_product_attribute_value_wnva_ids"] == null
                ? null
                : List<int>.from(json["valid_product_attribute_value_wnva_ids"]
                    .map((x) => x)),
        active: json["active"] == null ? null : json["active"],
        warehouseId: json["warehouse_id"] == null ? null : json["warehouse_id"],
        isProductVariant: json["is_product_variant"] == null
            ? null
            : json["is_product_variant"],
        listPrice: json["list_price"].toDouble() == null
            ? null
            : json["list_price"].toDouble(),
        writeDate: json["write_date"] == null
            ? null
            : DateTime.parse(json["write_date"]),
        lstPrice:
            json["lst_price"] == null ? null : json["lst_price"].toDouble(),
        partnerRef: json["partner_ref"] == null ? null : json["partner_ref"],
        standardPrice: json["standard_price"].toDouble() == null
            ? null
            : json["standard_price"].toDouble(),
        messageHasError: json["message_has_error"] == null
            ? null
            : json["message_has_error"],
        messageChannelIds: json["message_channel_ids"] == null
            ? null
            : List<dynamic>.from(json["message_channel_ids"].map((x) => x)),
        descriptionPicking: json["description_picking"] == null
            ? null
            : json["description_picking"],
        weightUomId: json["weight_uom_id"] == null
            ? null
            : List<dynamic>.from(json["weight_uom_id"].map((x) => x)),
        pricelistItemIds: json["pricelist_item_ids"] == null
            ? null
            : List<dynamic>.from(json["pricelist_item_ids"].map((x) => x)),
        productVariantCount: json["product_variant_count"] == null
            ? null
            : json["product_variant_count"],
        createUid: json["create_uid"] == null
            ? null
            : List<dynamic>.from(json["create_uid"].map((x) => x)),
        barcode: json["barcode"] == null ? null : json["barcode"],
        validProductAttributeIds: json["valid_product_attribute_ids"] == null
            ? null
            : List<int>.from(json["valid_product_attribute_ids"].map((x) => x)),
        messageFollowerIds: json["message_follower_ids"] == null
            ? null
            : List<int>.from(json["message_follower_ids"].map((x) => x)),
        messageIsFollower: json["message_is_follower"] == null
            ? null
            : json["message_is_follower"],
        activitySummary:
            json["activity_summary"] == null ? null : json["activity_summary"],
        qtyAvailable:
            json["qty_available"] == null ? null : json["qty_available"],
        rental: json["rental"] == null ? null : json["rental"],
      );

  Map<String, dynamic> toJson() => {
        "name": name == null ? null : name,
        "code": code == null ? null : code,
        "purchase_ok": purchaseOk == null ? null : purchaseOk,
        "image_small": imageSmall == null ? null : imageSmall,
        "activity_type_id": activityTypeId == null ? null : activityTypeId,
        "description_pickingout":
            descriptionPickingout == null ? null : descriptionPickingout,
        "sequence": sequence == null ? null : sequence,
        "description": description == null ? null : description,
        "id": id == null ? null : id,
        "responsible_id": responsibleId == null
            ? null
            : List<dynamic>.from(responsibleId.map((x) => x)),
        "weight": weight == null ? null : weight,
        "orderpoint_ids": orderpointIds == null
            ? null
            : List<dynamic>.from(orderpointIds.map((x) => x)),
        "message_unread": messageUnread == null ? null : messageUnread,
        "type": type == null ? null : type,
        "property_stock_production": propertyStockProduction == null
            ? null
            : List<dynamic>.from(propertyStockProduction.map((x) => x)),
        "valid_product_template_attribute_line_wnva_ids":
            validProductTemplateAttributeLineWnvaIds == null
                ? null
                : List<dynamic>.from(
                    validProductTemplateAttributeLineWnvaIds.map((x) => x)),
        "activity_date_deadline":
            activityDateDeadline == null ? null : activityDateDeadline,
        "message_needaction_counter":
            messageNeedactionCounter == null ? null : messageNeedactionCounter,
        "stock_quant_ids": stockQuantIds == null
            ? null
            : List<dynamic>.from(stockQuantIds.map((x) => x)),
        "sale_delay": saleDelay == null ? null : saleDelay,
        "activity_ids": activityIds == null
            ? null
            : List<dynamic>.from(activityIds.map((x) => x)),
        "cost_currency_id": costCurrencyId == null
            ? null
            : List<dynamic>.from(costCurrencyId.map((x) => x)),
        "description_purchase":
            descriptionPurchase == null ? null : descriptionPurchase,
        "uom_po_id":
            uomPoId == null ? null : List<dynamic>.from(uomPoId.map((x) => x)),
        "activity_state": activityState == null ? null : activityState,
        "message_attachment_count":
            messageAttachmentCount == null ? null : messageAttachmentCount,
        "variant_seller_ids": variantSellerIds == null
            ? null
            : List<dynamic>.from(variantSellerIds.map((x) => x)),
        "virtual_available": virtualAvailable == null ? null : virtualAvailable,
        "route_ids": routeIds == null
            ? null
            : List<dynamic>.from(routeIds.map((x) => x)),
        "packaging_ids": packagingIds == null
            ? null
            : List<dynamic>.from(packagingIds.map((x) => x)),
        "description_pickingin":
            descriptionPickingin == null ? null : descriptionPickingin,
        "price_extra": priceExtra == null ? null : priceExtra,
        "message_ids": messageIds == null
            ? null
            : List<dynamic>.from(messageIds.map((x) => x)),
        "valid_existing_variant_ids": validExistingVariantIds == null
            ? null
            : List<dynamic>.from(validExistingVariantIds.map((x) => x)),
        "company_id": companyId == null
            ? null
            : List<dynamic>.from(companyId.map((x) => x)),
        "description_sale": descriptionSale,
        "valid_product_attribute_wnva_ids": validProductAttributeWnvaIds == null
            ? null
            : List<dynamic>.from(validProductAttributeWnvaIds.map((x) => x)),
        "item_ids":
            itemIds == null ? null : List<dynamic>.from(itemIds.map((x) => x)),
        "property_stock_inventory": propertyStockInventory == null
            ? null
            : List<dynamic>.from(propertyStockInventory.map((x) => x)),
        "route_from_categ_ids": routeFromCategIds == null
            ? null
            : List<dynamic>.from(routeFromCategIds.map((x) => x)),
        "product_tmpl_id": productTmplId == null
            ? null
            : List<dynamic>.from(productTmplId.map((x) => x)),
        "valid_product_attribute_value_ids": validProductAttributeValueIds ==
                null
            ? null
            : List<dynamic>.from(validProductAttributeValueIds.map((x) => x)),
        "price": price == null ? null : price,
        "location_id": locationId == null ? null : locationId,
        "default_code": defaultCode == null ? null : defaultCode,
        "incoming_qty": incomingQty == null ? null : incomingQty,
        "volume": volume == null ? null : volume,
        "valid_product_template_attribute_line_ids":
            validProductTemplateAttributeLineIds == null
                ? null
                : List<dynamic>.from(
                    validProductTemplateAttributeLineIds.map((x) => x)),
        "uom_id":
            uomId == null ? null : List<dynamic>.from(uomId.map((x) => x)),
        "image": image == null ? null : image,
        "pricelist_id": pricelistId == null ? null : pricelistId,
        "activity_user_id": activityUserId == null ? null : activityUserId,
        "message_partner_ids": messagePartnerIds == null
            ? null
            : List<dynamic>.from(messagePartnerIds.map((x) => x)),
        "product_template_attribute_value_ids":
            productTemplateAttributeValueIds == null
                ? null
                : List<dynamic>.from(
                    productTemplateAttributeValueIds.map((x) => x)),
        "message_main_attachment_id":
            messageMainAttachmentId == null ? null : messageMainAttachmentId,
        "display_name": displayName == null ? null : displayName,
        "color": color == null ? null : color,
        "currency_id": currencyId == null
            ? null
            : List<dynamic>.from(currencyId.map((x) => x)),
        "message_has_error_counter":
            messageHasErrorCounter == null ? null : messageHasErrorCounter,
        "categ_id":
            categId == null ? null : List<dynamic>.from(categId.map((x) => x)),
        "stock_move_ids": stockMoveIds == null
            ? null
            : List<dynamic>.from(stockMoveIds.map((x) => x)),
        "product_variant_id": productVariantId == null
            ? null
            : List<dynamic>.from(productVariantId.map((x) => x)),
        "tracking": tracking == null ? null : tracking,
        "weight_uom_name": weightUomName == null ? null : weightUomName,
        "sale_ok": saleOk == null ? null : saleOk,
        "attribute_value_ids": attributeValueIds == null
            ? null
            : List<dynamic>.from(attributeValueIds.map((x) => x)),
        "image_variant": imageVariant,
        "seller_ids": sellerIds == null
            ? null
            : List<dynamic>.from(sellerIds.map((x) => x)),
        "product_variant_ids": productVariantIds == null
            ? null
            : List<dynamic>.from(productVariantIds.map((x) => x)),
        "__last_update":
            lastUpdate == null ? null : lastUpdate.toIso8601String(),
        "reordering_max_qty":
            reorderingMaxQty == null ? null : reorderingMaxQty,
        "create_date": createDate == null ? null : createDate.toIso8601String(),
        "write_uid": writeUid == null
            ? null
            : List<dynamic>.from(writeUid.map((x) => x)),
        "nbr_reordering_rules":
            nbrReorderingRules == null ? null : nbrReorderingRules,
        "outgoing_qty": outgoingQty == null ? null : outgoingQty,
        "attribute_line_ids": attributeLineIds == null
            ? null
            : List<dynamic>.from(attributeLineIds.map((x) => x)),
        "message_needaction":
            messageNeedaction == null ? null : messageNeedaction,
        "image_medium": imageMedium == null ? null : imageMedium,
        "uom_name": uomName == null ? null : uomName,
        "reordering_min_qty":
            reorderingMinQty == null ? null : reorderingMinQty,
        "valid_archived_variant_ids": validArchivedVariantIds == null
            ? null
            : List<dynamic>.from(validArchivedVariantIds.map((x) => x)),
        "message_unread_counter":
            messageUnreadCounter == null ? null : messageUnreadCounter,
        "valid_product_attribute_value_wnva_ids":
            validProductAttributeValueWnvaIds == null
                ? null
                : List<dynamic>.from(
                    validProductAttributeValueWnvaIds.map((x) => x)),
        "active": active == null ? null : active,
        "warehouse_id": warehouseId == null ? null : warehouseId,
        "is_product_variant":
            isProductVariant == null ? null : isProductVariant,
        "list_price": listPrice == null ? null : listPrice,
        "write_date": writeDate == null ? null : writeDate.toIso8601String(),
        "lst_price": lstPrice == null ? null : lstPrice,
        "partner_ref": partnerRef == null ? null : partnerRef,
        "standard_price": standardPrice == null ? null : standardPrice,
        "message_has_error": messageHasError == null ? null : messageHasError,
        "message_channel_ids": messageChannelIds == null
            ? null
            : List<dynamic>.from(messageChannelIds.map((x) => x)),
        "description_picking":
            descriptionPicking == null ? null : descriptionPicking,
        "weight_uom_id": weightUomId == null
            ? null
            : List<dynamic>.from(weightUomId.map((x) => x)),
        "pricelist_item_ids": pricelistItemIds == null
            ? null
            : List<dynamic>.from(pricelistItemIds.map((x) => x)),
        "product_variant_count":
            productVariantCount == null ? null : productVariantCount,
        "create_uid": createUid == null
            ? null
            : List<dynamic>.from(createUid.map((x) => x)),
        "barcode": barcode == null ? null : barcode,
        "valid_product_attribute_ids": validProductAttributeIds == null
            ? null
            : List<dynamic>.from(validProductAttributeIds.map((x) => x)),
        "message_follower_ids": messageFollowerIds == null
            ? null
            : List<dynamic>.from(messageFollowerIds.map((x) => x)),
        "message_is_follower":
            messageIsFollower == null ? null : messageIsFollower,
        "activity_summary": activitySummary == null ? null : activitySummary,
        "qty_available": qtyAvailable == null ? null : qtyAvailable,
        "rental": rental == null ? null : rental,
      };
}
