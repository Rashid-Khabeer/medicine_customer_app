abstract class Model {
  String id;

  Model({this.id});

  Map<String, dynamic> toJson();

  Model.fromJson(Map<String, dynamic> json);
}
