import 'dart:convert';
import "package:http/http.dart" as http;

class RecipeModel {
  RecipeModel({
    required this.from,
    required this.to,
    required this.count,
    required this.links,
    required this.hits,
  });

  int from;
  int to;
  int count;
  RecipeModelLinks links;
  List<Hit> hits;

  factory RecipeModel.fromJson(String str) =>
      RecipeModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory RecipeModel.fromMap(Map<String, dynamic> json) => RecipeModel(
        from: json["from"],
        to: json["to"],
        count: json["count"],
        links: RecipeModelLinks.fromMap(json["_links"]),
        hits: List<Hit>.from(json["hits"].map((x) => Hit.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "from": from,
        "to": to,
        "count": count,
        "_links": links.toMap(),
        "hits": List<dynamic>.from(hits.map((x) => x.toMap())),
      };
}

class Hit {
  Hit({
    required this.recipe,
    required this.links,
  });

  Recipe recipe;
  HitLinks links;

  factory Hit.fromJson(String str) => Hit.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Hit.fromMap(Map<String, dynamic> json) => Hit(
        recipe: Recipe.fromMap(json["recipe"]),
        links: HitLinks.fromMap(json["_links"]),
      );

  Map<String, dynamic> toMap() => {
        "recipe": recipe.toMap(),
        "_links": links.toMap(),
      };
}

class HitLinks {
  HitLinks({
    required this.self,
  });

  Next self;

  factory HitLinks.fromJson(String str) => HitLinks.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory HitLinks.fromMap(Map<String, dynamic> json) => HitLinks(
        self: Next.fromMap(json["self"]),
      );

  Map<String, dynamic> toMap() => {
        "self": self.toMap(),
      };
}

class Next {
  Next({
    required this.href,
    required this.title,
  });

  String href;
  Title? title;

  factory Next.fromJson(String str) => Next.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Next.fromMap(Map<String, dynamic> json) => Next(
        href: json["href"],
        title: titleValues.map[json["title"]],
      );

  Map<String, dynamic> toMap() => {
        "href": href,
        "title": titleValues.reverse[title],
      };
}

enum Title { NEXT_PAGE, SELF }

final titleValues =
    EnumValues({"Next page": Title.NEXT_PAGE, "Self": Title.SELF});

class Recipe {
  Recipe({
    required this.uri,
    required this.label,
    required this.image,
    required this.images,
    required this.source,
    required this.url,
    required this.shareAs,
    required this.recipeYield,
    required this.dietLabels,
    required this.healthLabels,
    required this.cautions,
    required this.ingredientLines,
    required this.ingredients,
    required this.calories,
    required this.totalWeight,
    required this.totalTime,
    required this.cuisineType,
    required this.mealType,
    required this.dishType,
    required this.totalNutrients,
    required this.totalDaily,
    required this.digest,
  });

  String uri;
  String label;
  String image;
  Images images;
  String source;
  String url;
  String shareAs;
  int recipeYield;
  List<String> dietLabels;
  List<String> healthLabels;
  List<String> cautions;
  List<String> ingredientLines;
  List<Ingredient> ingredients;
  double calories;
  double totalWeight;
  int totalTime;
  List<String> cuisineType;
  List<MealType> mealType;
  List<String> dishType;
  Map<String, Total> totalNutrients;
  Map<String, Total> totalDaily;
  List<Digest> digest;

  factory Recipe.fromJson(String str) => Recipe.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Recipe.fromMap(Map<String, dynamic> json) => Recipe(
        uri: json["uri"],
        label: json["label"],
        image: json["image"],
        images: Images.fromMap(json["images"]),
        source: json["source"],
        url: json["url"],
        shareAs: json["shareAs"],
        recipeYield: json["yield"],
        dietLabels: List<String>.from(json["dietLabels"].map((x) => x)),
        healthLabels: List<String>.from(json["healthLabels"].map((x) => x)),
        cautions: List<String>.from(json["cautions"].map((x) => x)),
        ingredientLines:
            List<String>.from(json["ingredientLines"].map((x) => x)),
        ingredients: List<Ingredient>.from(
            json["ingredients"].map((x) => Ingredient.fromMap(x))),
        calories: json["calories"].toDouble(),
        totalWeight: json["totalWeight"].toDouble(),
        totalTime: json["totalTime"],
        cuisineType: List<String>.from(json["cuisineType"].map((x) => x)),
        mealType: List<MealType>.from(
            json["mealType"].map((x) => mealTypeValues.map[x])),
        dishType: List<String>.from(json["dishType"].map((x) => x)),
        totalNutrients: Map.from(json["totalNutrients"])
            .map((k, v) => MapEntry<String, Total>(k, Total.fromMap(v))),
        totalDaily: Map.from(json["totalDaily"])
            .map((k, v) => MapEntry<String, Total>(k, Total.fromMap(v))),
        digest: List<Digest>.from(json["digest"].map((x) => Digest.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "uri": uri,
        "label": label,
        "image": image,
        "images": images.toMap(),
        "source": source,
        "url": url,
        "shareAs": shareAs,
        "yield": recipeYield,
        "dietLabels": List<dynamic>.from(dietLabels.map((x) => x)),
        "healthLabels": List<dynamic>.from(healthLabels.map((x) => x)),
        "cautions": List<dynamic>.from(cautions.map((x) => x)),
        "ingredientLines": List<dynamic>.from(ingredientLines.map((x) => x)),
        "ingredients": List<dynamic>.from(ingredients.map((x) => x.toMap())),
        "calories": calories,
        "totalWeight": totalWeight,
        "totalTime": totalTime,
        "cuisineType": List<dynamic>.from(cuisineType.map((x) => x)),
        "mealType":
            List<dynamic>.from(mealType.map((x) => mealTypeValues.reverse[x])),
        "dishType": List<dynamic>.from(dishType.map((x) => x)),
        "totalNutrients": Map.from(totalNutrients)
            .map((k, v) => MapEntry<String, dynamic>(k, v.toMap())),
        "totalDaily": Map.from(totalDaily)
            .map((k, v) => MapEntry<String, dynamic>(k, v.toMap())),
        "digest": List<dynamic>.from(digest.map((x) => x.toMap())),
      };
}

class Digest {
  Digest({
    required this.label,
    required this.tag,
    required this.schemaOrgTag,
    required this.total,
    required this.hasRdi,
    required this.daily,
    required this.unit,
    required this.sub,
  });

  String label;
  String tag;
  SchemaOrgTag? schemaOrgTag;
  double total;
  bool hasRdi;
  double daily;
  Unit? unit;
  List<Digest>? sub;

  factory Digest.fromJson(String str) => Digest.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Digest.fromMap(Map<String, dynamic> json) => Digest(
        label: json["label"],
        tag: json["tag"],
        schemaOrgTag: json["schemaOrgTag"] == null
            ? null
            : schemaOrgTagValues.map[json["schemaOrgTag"]],
        total: json["total"].toDouble(),
        hasRdi: json["hasRDI"],
        daily: json["daily"].toDouble(),
        unit: unitValues.map[json["unit"]],
        sub: json["sub"] == null
            ? null
            : List<Digest>.from(json["sub"].map((x) => Digest.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "label": label,
        "tag": tag,
        "schemaOrgTag": schemaOrgTag == null
            ? null
            : schemaOrgTagValues.reverse[schemaOrgTag],
        "total": total,
        "hasRDI": hasRdi,
        "daily": daily,
        "unit": unitValues.reverse[unit],
        "sub":
            sub == null ? null : List<dynamic>.from(sub!.map((x) => x.toMap())),
      };
}

enum SchemaOrgTag {
  FAT_CONTENT,
  CARBOHYDRATE_CONTENT,
  PROTEIN_CONTENT,
  CHOLESTEROL_CONTENT,
  SODIUM_CONTENT,
  SATURATED_FAT_CONTENT,
  TRANS_FAT_CONTENT,
  FIBER_CONTENT,
  SUGAR_CONTENT
}

final schemaOrgTagValues = EnumValues({
  "carbohydrateContent": SchemaOrgTag.CARBOHYDRATE_CONTENT,
  "cholesterolContent": SchemaOrgTag.CHOLESTEROL_CONTENT,
  "fatContent": SchemaOrgTag.FAT_CONTENT,
  "fiberContent": SchemaOrgTag.FIBER_CONTENT,
  "proteinContent": SchemaOrgTag.PROTEIN_CONTENT,
  "saturatedFatContent": SchemaOrgTag.SATURATED_FAT_CONTENT,
  "sodiumContent": SchemaOrgTag.SODIUM_CONTENT,
  "sugarContent": SchemaOrgTag.SUGAR_CONTENT,
  "transFatContent": SchemaOrgTag.TRANS_FAT_CONTENT
});

enum Unit { G, MG, UNIT_G, EMPTY, KCAL }

final unitValues = EnumValues({
  "%": Unit.EMPTY,
  "g": Unit.G,
  "kcal": Unit.KCAL,
  "mg": Unit.MG,
  "µg": Unit.UNIT_G
});

class Images {
  Images({
    required this.thumbnail,
    required this.small,
    required this.regular,
    required this.large,
  });

  Regular thumbnail;
  Regular small;
  Regular regular;
  Regular? large;

  factory Images.fromJson(String str) => Images.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Images.fromMap(Map<String, dynamic> json) => Images(
        thumbnail: Regular.fromMap(json["THUMBNAIL"]),
        small: Regular.fromMap(json["SMALL"]),
        regular: Regular.fromMap(json["REGULAR"]),
        large: json["LARGE"] == null ? null : Regular.fromMap(json["LARGE"]),
      );

  Map<String, dynamic> toMap() => {
        "THUMBNAIL": thumbnail.toMap(),
        "SMALL": small.toMap(),
        "REGULAR": regular.toMap(),
        "LARGE": large == null ? null : large!.toMap(),
      };
}

class Regular {
  Regular({
    required this.url,
    required this.width,
    required this.height,
  });

  String url;
  int width;
  int height;

  factory Regular.fromJson(String str) => Regular.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Regular.fromMap(Map<String, dynamic> json) => Regular(
        url: json["url"],
        width: json["width"],
        height: json["height"],
      );

  Map<String, dynamic> toMap() => {
        "url": url,
        "width": width,
        "height": height,
      };
}

class Ingredient {
  Ingredient({
    required this.text,
    required this.quantity,
    required this.measure,
    required this.food,
    required this.weight,
    required this.foodCategory,
    required this.foodId,
    required this.image,
  });

  String text;
  double quantity;
  String measure;
  String food;
  double weight;
  String foodCategory;
  String foodId;
  String image;

  factory Ingredient.fromJson(String str) =>
      Ingredient.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Ingredient.fromMap(Map<String, dynamic> json) => Ingredient(
        text: json["text"],
        quantity: json["quantity"].toDouble(),
        measure: json["measure"] == null ? null : json["measure"],
        food: json["food"],
        weight: json["weight"].toDouble(),
        foodCategory: json["foodCategory"],
        foodId: json["foodId"],
        image: json["image"],
      );

  Map<String, dynamic> toMap() => {
        "text": text,
        "quantity": quantity,
        "measure": measure == null ? null : measure,
        "food": food,
        "weight": weight,
        "foodCategory": foodCategory,
        "foodId": foodId,
        "image": image,
      };
}

enum MealType { LUNCH_DINNER, SNACK, BREAKFAST }

final mealTypeValues = EnumValues({
  "breakfast": MealType.BREAKFAST,
  "lunch/dinner": MealType.LUNCH_DINNER,
  "snack": MealType.SNACK
});

class Total {
  Total({
    required this.label,
    required this.quantity,
    required this.unit,
  });

  String label;
  double quantity;
  Unit? unit;

  factory Total.fromJson(String str) => Total.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Total.fromMap(Map<String, dynamic> json) => Total(
        label: json["label"],
        quantity: json["quantity"].toDouble(),
        unit: unitValues.map[json["unit"]],
      );

  Map<String, dynamic> toMap() => {
        "label": label,
        "quantity": quantity,
        "unit": unitValues.reverse[unit],
      };
}

class RecipeModelLinks {
  RecipeModelLinks({
    required this.next,
  });

  Next next;

  factory RecipeModelLinks.fromJson(String str) =>
      RecipeModelLinks.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory RecipeModelLinks.fromMap(Map<String, dynamic> json) =>
      RecipeModelLinks(
        next: Next.fromMap(json["next"]),
      );

  Map<String, dynamic> toMap() => {
        "next": next.toMap(),
      };
}

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String>? reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap!;
  }
}

Future<List> getUsers(String q) async {
  List list1 = [];
  List list2 = [];
  var url =
      "https://api.edamam.com/api/recipes/v2?type=public&q=$q&app_id=062e2906&app_key=ab4f8a9c1b6ba8b2b72c475829e7f354";
  final response = await http.get(Uri.parse(url));

  final body = json.decode(response.body)['hits'];

  for (var item in body) {
    list1.add(item['recipe']);

    list1.forEach((element) {
      list2.add(element);
    });
  }

  return list2;
}
