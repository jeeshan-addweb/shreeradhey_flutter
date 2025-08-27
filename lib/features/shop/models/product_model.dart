// To parse this JSON data, do
//
//     final productModel = productModelFromJson(jsonString);

import 'dart:convert';

ProductModel productModelFromJson(String str) =>
    ProductModel.fromJson(json.decode(str));

String productModelToJson(ProductModel data) => json.encode(data.toJson());

class ProductModel {
  Data? data;
  Extensions? extensions;

  ProductModel({this.data, this.extensions});

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
    extensions:
        json["extensions"] == null
            ? null
            : Extensions.fromJson(json["extensions"]),
  );

  Map<String, dynamic> toJson() => {
    "data": data?.toJson(),
    "extensions": extensions?.toJson(),
  };
}

class Data {
  Products? products;

  Data({this.products});

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    products:
        json["products"] == null ? null : Products.fromJson(json["products"]),
  );

  Map<String, dynamic> toJson() => {"products": products?.toJson()};
}

class Products {
  List<ProductsNode>? nodes;

  Products({this.nodes});

  factory Products.fromJson(Map<String, dynamic> json) => Products(
    nodes:
        json["nodes"] == null
            ? []
            : List<ProductsNode>.from(
              json["nodes"]!.map((x) => ProductsNode.fromJson(x)),
            ),
  );

  Map<String, dynamic> toJson() => {
    "nodes":
        nodes == null ? [] : List<dynamic>.from(nodes!.map((x) => x.toJson())),
  };
}

class ProductsNode {
  String? id;
  String? name;
  String? slug;
  String? uri;
  Image? image;
  ProductCategories? productCategories;
  String? price;
  String? regularPrice;
  String? salePrice;
  String? bestPrice;
  double? discountPercentage;
  double? averageRating;
  int? reviewCount;

  ProductsNode({
    this.id,
    this.name,
    this.slug,
    this.uri,
    this.image,
    this.productCategories,
    this.price,
    this.regularPrice,
    this.salePrice,
    this.bestPrice,
    this.discountPercentage,
    this.averageRating,
    this.reviewCount,
  });

  factory ProductsNode.fromJson(Map<String, dynamic> json) => ProductsNode(
    id: json["id"],
    name: json["name"],
    slug: json["slug"],
    uri: json["uri"],
    image: json["image"] == null ? null : Image.fromJson(json["image"]),
    productCategories:
        json["productCategories"] == null
            ? null
            : ProductCategories.fromJson(json["productCategories"]),
    price: json["price"],
    regularPrice: json["regularPrice"],
    salePrice: json["salePrice"],
    bestPrice: json["bestPrice"],
    discountPercentage: json["discountPercentage"]?.toDouble(),
    averageRating: json["averageRating"]?.toDouble(),
    reviewCount: json["reviewCount"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "slug": slug,
    "uri": uri,
    "image": image?.toJson(),
    "productCategories": productCategories?.toJson(),
    "price": price,
    "regularPrice": regularPrice,
    "salePrice": salePrice,
    "bestPrice": bestPrice,
    "discountPercentage": discountPercentage,
    "averageRating": averageRating,
    "reviewCount": reviewCount,
  };
}

class Image {
  String? sourceUrl;
  String? altText;

  Image({this.sourceUrl, this.altText});

  factory Image.fromJson(Map<String, dynamic> json) =>
      Image(sourceUrl: json["sourceUrl"], altText: json["altText"]);

  Map<String, dynamic> toJson() => {"sourceUrl": sourceUrl, "altText": altText};
}

class ProductCategories {
  List<ProductCategoriesNode>? nodes;

  ProductCategories({this.nodes});

  factory ProductCategories.fromJson(Map<String, dynamic> json) =>
      ProductCategories(
        nodes:
            json["nodes"] == null
                ? []
                : List<ProductCategoriesNode>.from(
                  json["nodes"]!.map((x) => ProductCategoriesNode.fromJson(x)),
                ),
      );

  Map<String, dynamic> toJson() => {
    "nodes":
        nodes == null ? [] : List<dynamic>.from(nodes!.map((x) => x.toJson())),
  };
}

class ProductCategoriesNode {
  Name? name;
  Slug? slug;

  ProductCategoriesNode({this.name, this.slug});

  factory ProductCategoriesNode.fromJson(Map<String, dynamic> json) =>
      ProductCategoriesNode(
        name: nameValues.map[json["name"]]!,
        slug: slugValues.map[json["slug"]]!,
      );

  Map<String, dynamic> toJson() => {
    "name": nameValues.reverse[name],
    "slug": slugValues.reverse[slug],
  };
}

enum Name { COMBO, GHEE, OIL }

final nameValues = EnumValues({
  "Combo": Name.COMBO,
  "Ghee": Name.GHEE,
  "Oil": Name.OIL,
});

enum Slug { COMBO, GHEE, OIL }

final slugValues = EnumValues({
  "combo": Slug.COMBO,
  "ghee": Slug.GHEE,
  "oil": Slug.OIL,
});

class Extensions {
  List<Debug>? debug;
  QueryAnalyzer? queryAnalyzer;

  Extensions({this.debug, this.queryAnalyzer});

  factory Extensions.fromJson(Map<String, dynamic> json) => Extensions(
    debug:
        json["debug"] == null
            ? []
            : List<Debug>.from(json["debug"]!.map((x) => Debug.fromJson(x))),
    queryAnalyzer:
        json["queryAnalyzer"] == null
            ? null
            : QueryAnalyzer.fromJson(json["queryAnalyzer"]),
  );

  Map<String, dynamic> toJson() => {
    "debug":
        debug == null ? [] : List<dynamic>.from(debug!.map((x) => x.toJson())),
    "queryAnalyzer": queryAnalyzer?.toJson(),
  };
}

class Debug {
  DebugType? type;
  String? message;
  String? fieldName;
  TypeName? typeName;
  ExistingField? existingField;
  DuplicateField? duplicateField;
  List<String>? stack;

  Debug({
    this.type,
    this.message,
    this.fieldName,
    this.typeName,
    this.existingField,
    this.duplicateField,
    this.stack,
  });

  factory Debug.fromJson(Map<String, dynamic> json) => Debug(
    type: debugTypeValues.map[json["type"]]!,
    message: json["message"],
    fieldName: json["field_name"],
    typeName: typeNameValues.map[json["type_name"]]!,
    existingField:
        json["existing_field"] == null
            ? null
            : ExistingField.fromJson(json["existing_field"]),
    duplicateField:
        json["duplicate_field"] == null
            ? null
            : DuplicateField.fromJson(json["duplicate_field"]),
    stack:
        json["stack"] == null
            ? []
            : List<String>.from(json["stack"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "type": debugTypeValues.reverse[type],
    "message": message,
    "field_name": fieldName,
    "type_name": typeNameValues.reverse[typeName],
    "existing_field": existingField?.toJson(),
    "duplicate_field": duplicateField?.toJson(),
    "stack": stack == null ? [] : List<dynamic>.from(stack!.map((x) => x)),
  };
}

class DuplicateField {
  String? toType;
  bool? oneToOne;
  dynamic description;
  DeprecationReason? deprecationReason;
  DeprecationReason? resolve;
  TypeName? fromType;
  String? fromFieldName;
  ConnectionArgs? connectionArgs;
  dynamic type;
  dynamic args;
  List<dynamic>? auth;
  bool? isConnectionField;
  bool? allowFieldUnderscores;
  String? queryClass;
  String? connectionTypeName;

  DuplicateField({
    this.toType,
    this.oneToOne,
    this.description,
    this.deprecationReason,
    this.resolve,
    this.fromType,
    this.fromFieldName,
    this.connectionArgs,
    this.type,
    this.args,
    this.auth,
    this.isConnectionField,
    this.allowFieldUnderscores,
    this.queryClass,
    this.connectionTypeName,
  });

  factory DuplicateField.fromJson(Map<String, dynamic> json) => DuplicateField(
    toType: json["toType"],
    oneToOne: json["oneToOne"],
    description: json["description"],
    deprecationReason:
        json["deprecationReason"] == null
            ? null
            : DeprecationReason.fromJson(json["deprecationReason"]),
    resolve:
        json["resolve"] == null
            ? null
            : DeprecationReason.fromJson(json["resolve"]),
    fromType: typeNameValues.map[json["fromType"]]!,
    fromFieldName: json["fromFieldName"],
    connectionArgs:
        json["connectionArgs"] == null
            ? null
            : ConnectionArgs.fromJson(json["connectionArgs"]),
    type: json["type"],
    args: json["args"],
    auth:
        json["auth"] == null
            ? []
            : List<dynamic>.from(json["auth"]!.map((x) => x)),
    isConnectionField: json["isConnectionField"],
    allowFieldUnderscores: json["allowFieldUnderscores"],
    queryClass: json["queryClass"],
    connectionTypeName: json["connectionTypeName"],
  );

  Map<String, dynamic> toJson() => {
    "toType": toType,
    "oneToOne": oneToOne,
    "description": description,
    "deprecationReason": deprecationReason?.toJson(),
    "resolve": resolve?.toJson(),
    "fromType": typeNameValues.reverse[fromType],
    "fromFieldName": fromFieldName,
    "connectionArgs": connectionArgs?.toJson(),
    "type": type,
    "args": args,
    "auth": auth == null ? [] : List<dynamic>.from(auth!.map((x) => x)),
    "isConnectionField": isConnectionField,
    "allowFieldUnderscores": allowFieldUnderscores,
    "queryClass": queryClass,
    "connectionTypeName": connectionTypeName,
  };
}

class ArgsArgs {
  CacheDomainClass? where;
  Format? format;
  Format? key;
  KeysIn? keysIn;
  Format? multiple;
  CacheDomainClass? first;
  CacheDomainClass? last;
  CacheDomainClass? after;
  CacheDomainClass? before;

  ArgsArgs({
    this.where,
    this.format,
    this.key,
    this.keysIn,
    this.multiple,
    this.first,
    this.last,
    this.after,
    this.before,
  });

  factory ArgsArgs.fromJson(Map<String, dynamic> json) => ArgsArgs(
    where:
        json["where"] == null ? null : CacheDomainClass.fromJson(json["where"]),
    format: json["format"] == null ? null : Format.fromJson(json["format"]),
    key: json["key"] == null ? null : Format.fromJson(json["key"]),
    keysIn: json["keysIn"] == null ? null : KeysIn.fromJson(json["keysIn"]),
    multiple:
        json["multiple"] == null ? null : Format.fromJson(json["multiple"]),
    first:
        json["first"] == null ? null : CacheDomainClass.fromJson(json["first"]),
    last: json["last"] == null ? null : CacheDomainClass.fromJson(json["last"]),
    after:
        json["after"] == null ? null : CacheDomainClass.fromJson(json["after"]),
    before:
        json["before"] == null
            ? null
            : CacheDomainClass.fromJson(json["before"]),
  );

  Map<String, dynamic> toJson() => {
    "where": where?.toJson(),
    "format": format?.toJson(),
    "key": key?.toJson(),
    "keysIn": keysIn?.toJson(),
    "multiple": multiple?.toJson(),
    "first": first?.toJson(),
    "last": last?.toJson(),
    "after": after?.toJson(),
    "before": before?.toJson(),
  };
}

class CacheDomainClass {
  String? type;
  DeprecationReason? description;

  CacheDomainClass({this.type, this.description});

  factory CacheDomainClass.fromJson(Map<String, dynamic> json) =>
      CacheDomainClass(
        type: json["type"],
        description:
            json["description"] == null
                ? null
                : DeprecationReason.fromJson(json["description"]),
      );

  Map<String, dynamic> toJson() => {
    "type": type,
    "description": description?.toJson(),
  };
}

class DeprecationReason {
  DeprecationReason();

  factory DeprecationReason.fromJson(Map<String, dynamic> json) =>
      DeprecationReason();

  Map<String, dynamic> toJson() => {};
}

class Format {
  FormatType? type;
  String? description;

  Format({this.type, this.description});

  factory Format.fromJson(Map<String, dynamic> json) => Format(
    type: formatTypeValues.map[json["type"]]!,
    description: json["description"],
  );

  Map<String, dynamic> toJson() => {
    "type": formatTypeValues.reverse[type],
    "description": description,
  };
}

enum FormatType {
  BOOLEAN,
  CATALOG_VISIBILITY_ENUM,
  DATE_QUERY_INPUT,
  FLOAT,
  INT,
  PRICING_FIELD_FORMAT_ENUM,
  PRODUCT_ATTRIBUTE_QUERY_INPUT,
  PRODUCT_TAXONOMY_INPUT,
  PRODUCT_TYPES_ENUM,
  STRING,
}

final formatTypeValues = EnumValues({
  "Boolean": FormatType.BOOLEAN,
  "CatalogVisibilityEnum": FormatType.CATALOG_VISIBILITY_ENUM,
  "DateQueryInput": FormatType.DATE_QUERY_INPUT,
  "Float": FormatType.FLOAT,
  "Int": FormatType.INT,
  "PricingFieldFormatEnum": FormatType.PRICING_FIELD_FORMAT_ENUM,
  "ProductAttributeQueryInput": FormatType.PRODUCT_ATTRIBUTE_QUERY_INPUT,
  "ProductTaxonomyInput": FormatType.PRODUCT_TAXONOMY_INPUT,
  "ProductTypesEnum": FormatType.PRODUCT_TYPES_ENUM,
  "String": FormatType.STRING,
});

class KeysIn {
  KeysInType? type;
  String? description;

  KeysIn({this.type, this.description});

  factory KeysIn.fromJson(Map<String, dynamic> json) => KeysIn(
    type: json["type"] == null ? null : KeysInType.fromJson(json["type"]),
    description: json["description"],
  );

  Map<String, dynamic> toJson() => {
    "type": type?.toJson(),
    "description": description,
  };
}

class KeysInType {
  NonNull? listOf;

  KeysInType({this.listOf});

  factory KeysInType.fromJson(Map<String, dynamic> json) =>
      KeysInType(listOf: nonNullValues.map[json["list_of"]]!);

  Map<String, dynamic> toJson() => {"list_of": nonNullValues.reverse[listOf]};
}

enum NonNull {
  ID,
  INT,
  INTEGER,
  PRODUCTS_ORDERBY_INPUT,
  PRODUCT_TYPES_ENUM,
  STOCK_STATUS_ENUM,
  STRING,
  TAXONOMY_ENUM,
}

final nonNullValues = EnumValues({
  "ID": NonNull.ID,
  "Int": NonNull.INT,
  "Integer": NonNull.INTEGER,
  "ProductsOrderbyInput": NonNull.PRODUCTS_ORDERBY_INPUT,
  "ProductTypesEnum": NonNull.PRODUCT_TYPES_ENUM,
  "StockStatusEnum": NonNull.STOCK_STATUS_ENUM,
  "String": NonNull.STRING,
  "TaxonomyEnum": NonNull.TAXONOMY_ENUM,
});

class ConnectionArgs {
  Parent? search;
  Clude? exclude;
  Clude? include;
  Orderby? orderby;
  Format? dateQuery;
  Parent? parent;
  KeysIn? parentIn;
  KeysIn? parentNotIn;
  KeysIn? slugIn;
  Format? status;
  Format? type;
  KeysIn? typeIn;
  KeysIn? typeNotIn;
  Format? sku;
  Format? featured;
  Format? category;
  KeysIn? categoryIn;
  KeysIn? categoryNotIn;
  Format? categoryId;
  KeysIn? categoryIdIn;
  KeysIn? categoryIdNotIn;
  Format? tag;
  KeysIn? tagIn;
  KeysIn? tagNotIn;
  Format? tagId;
  KeysIn? tagIdIn;
  KeysIn? tagIdNotIn;
  Format? shippingClassId;
  Format? attributes;
  Attribute? attribute;
  Attribute? attributeTerm;
  KeysIn? stockStatus;
  Format? onSale;
  Format? minPrice;
  Format? maxPrice;
  Format? visibility;
  Format? taxonomyFilter;
  Format? supportedTypesOnly;
  Format? includeVariations;
  KeysIn? rating;
  CacheDomainClass? childless;
  CacheDomainClass? childOf;
  CacheDomainClass? cacheDomain;
  CacheDomainClass? descriptionLike;
  ExcludeTree? excludeTree;
  CacheDomainClass? hideEmpty;
  CacheDomainClass? hierarchical;
  ExcludeTree? name;
  CacheDomainClass? nameLike;
  ExcludeTree? objectIds;
  CacheDomainClass? order;
  CacheDomainClass? padCounts;
  ExcludeTree? slug;
  TermTaxonomId? termTaxonomId;
  ExcludeTree? termTaxonomyId;
  CacheDomainClass? updateTermMetaCache;
  ExcludeTree? taxonomies;

  ConnectionArgs({
    this.search,
    this.exclude,
    this.include,
    this.orderby,
    this.dateQuery,
    this.parent,
    this.parentIn,
    this.parentNotIn,
    this.slugIn,
    this.status,
    this.type,
    this.typeIn,
    this.typeNotIn,
    this.sku,
    this.featured,
    this.category,
    this.categoryIn,
    this.categoryNotIn,
    this.categoryId,
    this.categoryIdIn,
    this.categoryIdNotIn,
    this.tag,
    this.tagIn,
    this.tagNotIn,
    this.tagId,
    this.tagIdIn,
    this.tagIdNotIn,
    this.shippingClassId,
    this.attributes,
    this.attribute,
    this.attributeTerm,
    this.stockStatus,
    this.onSale,
    this.minPrice,
    this.maxPrice,
    this.visibility,
    this.taxonomyFilter,
    this.supportedTypesOnly,
    this.includeVariations,
    this.rating,
    this.childless,
    this.childOf,
    this.cacheDomain,
    this.descriptionLike,
    this.excludeTree,
    this.hideEmpty,
    this.hierarchical,
    this.name,
    this.nameLike,
    this.objectIds,
    this.order,
    this.padCounts,
    this.slug,
    this.termTaxonomId,
    this.termTaxonomyId,
    this.updateTermMetaCache,
    this.taxonomies,
  });

  factory ConnectionArgs.fromJson(Map<String, dynamic> json) => ConnectionArgs(
    search: json["search"] == null ? null : Parent.fromJson(json["search"]),
    exclude: json["exclude"] == null ? null : Clude.fromJson(json["exclude"]),
    include: json["include"] == null ? null : Clude.fromJson(json["include"]),
    orderby: json["orderby"] == null ? null : Orderby.fromJson(json["orderby"]),
    dateQuery:
        json["dateQuery"] == null ? null : Format.fromJson(json["dateQuery"]),
    parent: json["parent"] == null ? null : Parent.fromJson(json["parent"]),
    parentIn:
        json["parentIn"] == null ? null : KeysIn.fromJson(json["parentIn"]),
    parentNotIn:
        json["parentNotIn"] == null
            ? null
            : KeysIn.fromJson(json["parentNotIn"]),
    slugIn: json["slugIn"] == null ? null : KeysIn.fromJson(json["slugIn"]),
    status: json["status"] == null ? null : Format.fromJson(json["status"]),
    type: json["type"] == null ? null : Format.fromJson(json["type"]),
    typeIn: json["typeIn"] == null ? null : KeysIn.fromJson(json["typeIn"]),
    typeNotIn:
        json["typeNotIn"] == null ? null : KeysIn.fromJson(json["typeNotIn"]),
    sku: json["sku"] == null ? null : Format.fromJson(json["sku"]),
    featured:
        json["featured"] == null ? null : Format.fromJson(json["featured"]),
    category:
        json["category"] == null ? null : Format.fromJson(json["category"]),
    categoryIn:
        json["categoryIn"] == null ? null : KeysIn.fromJson(json["categoryIn"]),
    categoryNotIn:
        json["categoryNotIn"] == null
            ? null
            : KeysIn.fromJson(json["categoryNotIn"]),
    categoryId:
        json["categoryId"] == null ? null : Format.fromJson(json["categoryId"]),
    categoryIdIn:
        json["categoryIdIn"] == null
            ? null
            : KeysIn.fromJson(json["categoryIdIn"]),
    categoryIdNotIn:
        json["categoryIdNotIn"] == null
            ? null
            : KeysIn.fromJson(json["categoryIdNotIn"]),
    tag: json["tag"] == null ? null : Format.fromJson(json["tag"]),
    tagIn: json["tagIn"] == null ? null : KeysIn.fromJson(json["tagIn"]),
    tagNotIn:
        json["tagNotIn"] == null ? null : KeysIn.fromJson(json["tagNotIn"]),
    tagId: json["tagId"] == null ? null : Format.fromJson(json["tagId"]),
    tagIdIn: json["tagIdIn"] == null ? null : KeysIn.fromJson(json["tagIdIn"]),
    tagIdNotIn:
        json["tagIdNotIn"] == null ? null : KeysIn.fromJson(json["tagIdNotIn"]),
    shippingClassId:
        json["shippingClassId"] == null
            ? null
            : Format.fromJson(json["shippingClassId"]),
    attributes:
        json["attributes"] == null ? null : Format.fromJson(json["attributes"]),
    attribute:
        json["attribute"] == null
            ? null
            : Attribute.fromJson(json["attribute"]),
    attributeTerm:
        json["attributeTerm"] == null
            ? null
            : Attribute.fromJson(json["attributeTerm"]),
    stockStatus:
        json["stockStatus"] == null
            ? null
            : KeysIn.fromJson(json["stockStatus"]),
    onSale: json["onSale"] == null ? null : Format.fromJson(json["onSale"]),
    minPrice:
        json["minPrice"] == null ? null : Format.fromJson(json["minPrice"]),
    maxPrice:
        json["maxPrice"] == null ? null : Format.fromJson(json["maxPrice"]),
    visibility:
        json["visibility"] == null ? null : Format.fromJson(json["visibility"]),
    taxonomyFilter:
        json["taxonomyFilter"] == null
            ? null
            : Format.fromJson(json["taxonomyFilter"]),
    supportedTypesOnly:
        json["supportedTypesOnly"] == null
            ? null
            : Format.fromJson(json["supportedTypesOnly"]),
    includeVariations:
        json["includeVariations"] == null
            ? null
            : Format.fromJson(json["includeVariations"]),
    rating: json["rating"] == null ? null : KeysIn.fromJson(json["rating"]),
    childless:
        json["childless"] == null
            ? null
            : CacheDomainClass.fromJson(json["childless"]),
    childOf:
        json["childOf"] == null
            ? null
            : CacheDomainClass.fromJson(json["childOf"]),
    cacheDomain:
        json["cacheDomain"] == null
            ? null
            : CacheDomainClass.fromJson(json["cacheDomain"]),
    descriptionLike:
        json["descriptionLike"] == null
            ? null
            : CacheDomainClass.fromJson(json["descriptionLike"]),
    excludeTree:
        json["excludeTree"] == null
            ? null
            : ExcludeTree.fromJson(json["excludeTree"]),
    hideEmpty:
        json["hideEmpty"] == null
            ? null
            : CacheDomainClass.fromJson(json["hideEmpty"]),
    hierarchical:
        json["hierarchical"] == null
            ? null
            : CacheDomainClass.fromJson(json["hierarchical"]),
    name: json["name"] == null ? null : ExcludeTree.fromJson(json["name"]),
    nameLike:
        json["nameLike"] == null
            ? null
            : CacheDomainClass.fromJson(json["nameLike"]),
    objectIds:
        json["objectIds"] == null
            ? null
            : ExcludeTree.fromJson(json["objectIds"]),
    order:
        json["order"] == null ? null : CacheDomainClass.fromJson(json["order"]),
    padCounts:
        json["padCounts"] == null
            ? null
            : CacheDomainClass.fromJson(json["padCounts"]),
    slug: json["slug"] == null ? null : ExcludeTree.fromJson(json["slug"]),
    termTaxonomId:
        json["termTaxonomId"] == null
            ? null
            : TermTaxonomId.fromJson(json["termTaxonomId"]),
    termTaxonomyId:
        json["termTaxonomyId"] == null
            ? null
            : ExcludeTree.fromJson(json["termTaxonomyId"]),
    updateTermMetaCache:
        json["updateTermMetaCache"] == null
            ? null
            : CacheDomainClass.fromJson(json["updateTermMetaCache"]),
    taxonomies:
        json["taxonomies"] == null
            ? null
            : ExcludeTree.fromJson(json["taxonomies"]),
  );

  Map<String, dynamic> toJson() => {
    "search": search?.toJson(),
    "exclude": exclude?.toJson(),
    "include": include?.toJson(),
    "orderby": orderby?.toJson(),
    "dateQuery": dateQuery?.toJson(),
    "parent": parent?.toJson(),
    "parentIn": parentIn?.toJson(),
    "parentNotIn": parentNotIn?.toJson(),
    "slugIn": slugIn?.toJson(),
    "status": status?.toJson(),
    "type": type?.toJson(),
    "typeIn": typeIn?.toJson(),
    "typeNotIn": typeNotIn?.toJson(),
    "sku": sku?.toJson(),
    "featured": featured?.toJson(),
    "category": category?.toJson(),
    "categoryIn": categoryIn?.toJson(),
    "categoryNotIn": categoryNotIn?.toJson(),
    "categoryId": categoryId?.toJson(),
    "categoryIdIn": categoryIdIn?.toJson(),
    "categoryIdNotIn": categoryIdNotIn?.toJson(),
    "tag": tag?.toJson(),
    "tagIn": tagIn?.toJson(),
    "tagNotIn": tagNotIn?.toJson(),
    "tagId": tagId?.toJson(),
    "tagIdIn": tagIdIn?.toJson(),
    "tagIdNotIn": tagIdNotIn?.toJson(),
    "shippingClassId": shippingClassId?.toJson(),
    "attributes": attributes?.toJson(),
    "attribute": attribute?.toJson(),
    "attributeTerm": attributeTerm?.toJson(),
    "stockStatus": stockStatus?.toJson(),
    "onSale": onSale?.toJson(),
    "minPrice": minPrice?.toJson(),
    "maxPrice": maxPrice?.toJson(),
    "visibility": visibility?.toJson(),
    "taxonomyFilter": taxonomyFilter?.toJson(),
    "supportedTypesOnly": supportedTypesOnly?.toJson(),
    "includeVariations": includeVariations?.toJson(),
    "rating": rating?.toJson(),
    "childless": childless?.toJson(),
    "childOf": childOf?.toJson(),
    "cacheDomain": cacheDomain?.toJson(),
    "descriptionLike": descriptionLike?.toJson(),
    "excludeTree": excludeTree?.toJson(),
    "hideEmpty": hideEmpty?.toJson(),
    "hierarchical": hierarchical?.toJson(),
    "name": name?.toJson(),
    "nameLike": nameLike?.toJson(),
    "objectIds": objectIds?.toJson(),
    "order": order?.toJson(),
    "padCounts": padCounts?.toJson(),
    "slug": slug?.toJson(),
    "termTaxonomId": termTaxonomId?.toJson(),
    "termTaxonomyId": termTaxonomyId?.toJson(),
    "updateTermMetaCache": updateTermMetaCache?.toJson(),
    "taxonomies": taxonomies?.toJson(),
  };
}

class Attribute {
  FormatType? type;
  String? description;
  DeprecationReasonEnum? deprecationReason;

  Attribute({this.type, this.description, this.deprecationReason});

  factory Attribute.fromJson(Map<String, dynamic> json) => Attribute(
    type: formatTypeValues.map[json["type"]]!,
    description: json["description"],
    deprecationReason:
        deprecationReasonEnumValues.map[json["deprecationReason"]]!,
  );

  Map<String, dynamic> toJson() => {
    "type": formatTypeValues.reverse[type],
    "description": description,
    "deprecationReason": deprecationReasonEnumValues.reverse[deprecationReason],
  };
}

enum DeprecationReasonEnum { USE_ATTRIBUTES_INSTEAD }

final deprecationReasonEnumValues = EnumValues({
  "Use attributes instead.": DeprecationReasonEnum.USE_ATTRIBUTES_INSTEAD,
});

class Clude {
  KeysInType? type;
  dynamic description;

  Clude({this.type, this.description});

  factory Clude.fromJson(Map<String, dynamic> json) => Clude(
    type: json["type"] == null ? null : KeysInType.fromJson(json["type"]),
    description: json["description"],
  );

  Map<String, dynamic> toJson() => {
    "type": type?.toJson(),
    "description": description,
  };
}

enum DescriptionEnum {
  ENSURE_RESULT_SET_EXCLUDES_SPECIFIC_I_DS,
  LIMIT_RESULT_SET_TO_SPECIFIC_IDS,
}

final descriptionEnumValues = EnumValues({
  "Ensure result set excludes specific IDs.":
      DescriptionEnum.ENSURE_RESULT_SET_EXCLUDES_SPECIFIC_I_DS,
  "Limit result set to specific ids.":
      DescriptionEnum.LIMIT_RESULT_SET_TO_SPECIFIC_IDS,
});

class ExcludeTree {
  KeysInType? type;
  DeprecationReason? description;

  ExcludeTree({this.type, this.description});

  factory ExcludeTree.fromJson(Map<String, dynamic> json) => ExcludeTree(
    type: json["type"] == null ? null : KeysInType.fromJson(json["type"]),
    description:
        json["description"] == null
            ? null
            : DeprecationReason.fromJson(json["description"]),
  );

  Map<String, dynamic> toJson() => {
    "type": type?.toJson(),
    "description": description?.toJson(),
  };
}

class Orderby {
  dynamic type;
  dynamic description;

  Orderby({this.type, this.description});

  factory Orderby.fromJson(Map<String, dynamic> json) =>
      Orderby(type: json["type"], description: json["description"]);

  Map<String, dynamic> toJson() => {"type": type, "description": description};
}

class Parent {
  FormatType? type;
  dynamic description;

  Parent({this.type, this.description});

  factory Parent.fromJson(Map<String, dynamic> json) => Parent(
    type: formatTypeValues.map[json["type"]]!,
    description: json["description"],
  );

  Map<String, dynamic> toJson() => {
    "type": formatTypeValues.reverse[type],
    "description": description,
  };
}

class TermTaxonomId {
  KeysInType? type;
  DeprecationReason? description;
  DeprecationReason? deprecationReason;

  TermTaxonomId({this.type, this.description, this.deprecationReason});

  factory TermTaxonomId.fromJson(Map<String, dynamic> json) => TermTaxonomId(
    type: json["type"] == null ? null : KeysInType.fromJson(json["type"]),
    description:
        json["description"] == null
            ? null
            : DeprecationReason.fromJson(json["description"]),
    deprecationReason:
        json["deprecationReason"] == null
            ? null
            : DeprecationReason.fromJson(json["deprecationReason"]),
  );

  Map<String, dynamic> toJson() => {
    "type": type?.toJson(),
    "description": description?.toJson(),
    "deprecationReason": deprecationReason?.toJson(),
  };
}

enum TypeName { PRODUCT, PRODUCT_VARIATION }

final typeNameValues = EnumValues({
  "Product": TypeName.PRODUCT,
  "ProductVariation": TypeName.PRODUCT_VARIATION,
});

class PurpleType {
  NonNull? nonNull;
  String? listOf;

  PurpleType({this.nonNull, this.listOf});

  factory PurpleType.fromJson(Map<String, dynamic> json) => PurpleType(
    nonNull: nonNullValues.map[json["non_null"]]!,
    listOf: json["list_of"],
  );

  Map<String, dynamic> toJson() => {
    "non_null": nonNullValues.reverse[nonNull],
    "list_of": listOf,
  };
}

class ExistingField {
  TypeName? fromType;
  String? toType;
  String? fromFieldName;
  dynamic description;
  bool? oneToOne;
  String? queryClass;
  DeprecationReason? resolve;
  ConnectionArgs? connectionArgs;
  DeprecationReason? type;
  ExistingFieldArgs? args;
  List<dynamic>? auth;
  bool? isConnectionField;
  dynamic deprecationReason;
  bool? allowFieldUnderscores;
  String? name;
  String? connectionTypeName;

  ExistingField({
    this.fromType,
    this.toType,
    this.fromFieldName,
    this.description,
    this.oneToOne,
    this.queryClass,
    this.resolve,
    this.connectionArgs,
    this.type,
    this.args,
    this.auth,
    this.isConnectionField,
    this.deprecationReason,
    this.allowFieldUnderscores,
    this.name,
    this.connectionTypeName,
  });

  factory ExistingField.fromJson(Map<String, dynamic> json) => ExistingField(
    fromType: typeNameValues.map[json["fromType"]]!,
    toType: json["toType"],
    fromFieldName: json["fromFieldName"],
    description: json["description"],
    oneToOne: json["oneToOne"],
    queryClass: json["queryClass"],
    resolve:
        json["resolve"] == null
            ? null
            : DeprecationReason.fromJson(json["resolve"]),
    connectionArgs:
        json["connectionArgs"] == null
            ? null
            : ConnectionArgs.fromJson(json["connectionArgs"]),
    type:
        json["type"] == null ? null : DeprecationReason.fromJson(json["type"]),
    args:
        json["args"] == null ? null : ExistingFieldArgs.fromJson(json["args"]),
    auth:
        json["auth"] == null
            ? []
            : List<dynamic>.from(json["auth"]!.map((x) => x)),
    isConnectionField: json["isConnectionField"],
    deprecationReason: json["deprecationReason"],
    allowFieldUnderscores: json["allowFieldUnderscores"],
    name: json["name"],
    connectionTypeName: json["connectionTypeName"],
  );

  Map<String, dynamic> toJson() => {
    "fromType": typeNameValues.reverse[fromType],
    "toType": toType,
    "fromFieldName": fromFieldName,
    "description": description,
    "oneToOne": oneToOne,
    "queryClass": queryClass,
    "resolve": resolve?.toJson(),
    "connectionArgs": connectionArgs?.toJson(),
    "type": type?.toJson(),
    "args": args?.toJson(),
    "auth": auth == null ? [] : List<dynamic>.from(auth!.map((x) => x)),
    "isConnectionField": isConnectionField,
    "deprecationReason": deprecationReason,
    "allowFieldUnderscores": allowFieldUnderscores,
    "name": name,
    "connectionTypeName": connectionTypeName,
  };
}

class ExistingFieldArgs {
  FormatClass? where;
  FormatClass? format;
  FormatClass? key;
  FormatClass? keysIn;
  FormatClass? multiple;
  FormatClass? first;
  FormatClass? last;
  FormatClass? after;
  FormatClass? before;

  ExistingFieldArgs({
    this.where,
    this.format,
    this.key,
    this.keysIn,
    this.multiple,
    this.first,
    this.last,
    this.after,
    this.before,
  });

  factory ExistingFieldArgs.fromJson(
    Map<String, dynamic> json,
  ) => ExistingFieldArgs(
    where: json["where"] == null ? null : FormatClass.fromJson(json["where"]),
    format:
        json["format"] == null ? null : FormatClass.fromJson(json["format"]),
    key: json["key"] == null ? null : FormatClass.fromJson(json["key"]),
    keysIn:
        json["keysIn"] == null ? null : FormatClass.fromJson(json["keysIn"]),
    multiple:
        json["multiple"] == null
            ? null
            : FormatClass.fromJson(json["multiple"]),
    first: json["first"] == null ? null : FormatClass.fromJson(json["first"]),
    last: json["last"] == null ? null : FormatClass.fromJson(json["last"]),
    after: json["after"] == null ? null : FormatClass.fromJson(json["after"]),
    before:
        json["before"] == null ? null : FormatClass.fromJson(json["before"]),
  );

  Map<String, dynamic> toJson() => {
    "where": where?.toJson(),
    "format": format?.toJson(),
    "key": key?.toJson(),
    "keysIn": keysIn?.toJson(),
    "multiple": multiple?.toJson(),
    "first": first?.toJson(),
    "last": last?.toJson(),
    "after": after?.toJson(),
    "before": before?.toJson(),
  };
}

class FormatClass {
  DeprecationReason? type;
  String? description;
  String? name;

  FormatClass({this.type, this.description, this.name});

  factory FormatClass.fromJson(Map<String, dynamic> json) => FormatClass(
    type:
        json["type"] == null ? null : DeprecationReason.fromJson(json["type"]),
    description: json["description"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "type": type?.toJson(),
    "description": description,
    "name": name,
  };
}

enum DebugType { DUPLICATE_FIELD, GRAPHQL_DEBUG }

final debugTypeValues = EnumValues({
  "DUPLICATE_FIELD": DebugType.DUPLICATE_FIELD,
  "GRAPHQL_DEBUG": DebugType.GRAPHQL_DEBUG,
});

class QueryAnalyzer {
  String? keys;
  int? keysLength;
  int? keysCount;
  String? skippedKeys;
  int? skippedKeysSize;
  int? skippedKeysCount;
  List<dynamic>? skippedTypes;

  QueryAnalyzer({
    this.keys,
    this.keysLength,
    this.keysCount,
    this.skippedKeys,
    this.skippedKeysSize,
    this.skippedKeysCount,
    this.skippedTypes,
  });

  factory QueryAnalyzer.fromJson(Map<String, dynamic> json) => QueryAnalyzer(
    keys: json["keys"],
    keysLength: json["keysLength"],
    keysCount: json["keysCount"],
    skippedKeys: json["skippedKeys"],
    skippedKeysSize: json["skippedKeysSize"],
    skippedKeysCount: json["skippedKeysCount"],
    skippedTypes:
        json["skippedTypes"] == null
            ? []
            : List<dynamic>.from(json["skippedTypes"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "keys": keys,
    "keysLength": keysLength,
    "keysCount": keysCount,
    "skippedKeys": skippedKeys,
    "skippedKeysSize": skippedKeysSize,
    "skippedKeysCount": skippedKeysCount,
    "skippedTypes":
        skippedTypes == null
            ? []
            : List<dynamic>.from(skippedTypes!.map((x) => x)),
  };
}

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
