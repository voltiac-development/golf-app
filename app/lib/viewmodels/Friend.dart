class Friend {
  String name;
  double handicap;
  String id;
  String image;

  String get getName => this.name;

  set setName(String name) => this.name = name;

  double get getHandicap => this.handicap;

  set setHandicap(double handicap) => this.handicap = handicap;

  String get getId => this.id;

  set setId(String id) => this.id = id;

  String get getImage => this.image;

  set setImage(String image) => this.image = image;

  Friend(this.name, this.handicap, this.id, this.image);
}

class UserRequest {
  String name;
  String email;
  String id;

  String get getName => this.name;

  set setName(String name) => this.name = name;

  String get getId => this.id;

  set setId(String id) => this.id = id;

  String get getEmail => this.email;

  set setEmail(String email) => this.email = email;

  UserRequest(this.name, this.email, this.id);
}
