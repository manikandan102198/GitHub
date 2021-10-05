class DBUserModel {
  final int? id;
  final String name;
  final String type;
  final String avatar;

  DBUserModel(
      {this.id, required this.name, required this.type, required this.avatar});

  factory DBUserModel.fromMap(Map<String, dynamic> json) => DBUserModel(
      id: json['id'],
      name: json['name'],
      type: json['type'],
      avatar: json['avatar']);

  Map<String, dynamic> toJson() =>
      {'name': name, 'type': type, 'avatar': avatar};
}
