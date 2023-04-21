
class UserData {
  Bodydata? bodydata;
  String? email;
  String? name;

  UserData({this.bodydata, this.email, this.name});

  UserData.fromJson(Map<String, dynamic> json) {
    bodydata = json['bodydata'] != null
        ? new Bodydata.fromJson(json['bodydata'])
        : null;
    email = json['email'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.bodydata != null) {
      data['bodydata'] = this.bodydata!.toJson();
    }
    data['email'] = this.email;
    data['name'] = this.name;
    return data;
  }
}

class Bodydata {
  int? age;
  String? allergy;
  String? bodyShape;
  int? drinks;
  String? gender;
  String? goalOfWeight;
  double? height;
  int? meals;
  double? physicalActivityLevel;
  int? snacks;
  double? weight;
  double? calorie;

  Bodydata(
      {this.age,
      this.allergy,
      this.bodyShape,
      this.drinks,
      this.gender,
      this.goalOfWeight,
      this.height,
      this.meals,
      this.physicalActivityLevel,
      this.snacks,
      this.weight,
      this.calorie});

  Bodydata.fromJson(Map<String, dynamic> json) {
    age = json['age'];
    allergy = json['allergy'];
    bodyShape = json['body shape'];
    drinks = json['drinks'];
    gender = json['gender'];
    goalOfWeight = json['goal of Weight'];
    height = json['height'];
    meals = json['meals'];
    physicalActivityLevel = json['physical activity level'];
    snacks = json['snacks'];
    weight = json['weight'];
    calorie = json['maintainable Calorie'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['age'] = this.age;
    data['allergy'] = this.allergy;
    data['body shape'] = this.bodyShape;
    data['drinks'] = this.drinks;
    data['gender'] = this.gender;
    data['goal of Weight'] = this.goalOfWeight;
    data['height'] = this.height;
    data['meals'] = this.meals;
    data['physical activity level'] = this.physicalActivityLevel;
    data['snacks'] = this.snacks;
    data['weight'] = this.weight;
    data['maintainable Calorie'] = this.calorie;
    return data;
  }
}
