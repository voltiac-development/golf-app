class CourseInfo {
  String name;
  int holes;
  String id;
  String image;

  int get getHoles {
    return this.holes;
  }

  set setHoles(int holes) {
    this.holes = holes;
  }

  String get getName {
    return this.name;
  }

  set setName(String name) {
    this.name = name;
  }

  String get getId {
    return this.id;
  }

  set setId(String id) {
    this.id = id;
  }

  String get getImage {
    return this.image;
  }

  set setImage(String image) {
    this.image = image;
  }

  CourseInfo(this.name, this.holes, this.id, this.image);
}
