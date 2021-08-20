class CourseInfo {
  String name = "";
  int holes = 0;
  String id = "";
  String image = "";
  List<dynamic> roundTypes = [];
  String teeBoxes = "";
  String website = "";
  List<dynamic> rounds = [];
  String background = "";
  List<dynamic> openingHours = [];

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

  CourseInfo.filled(this.name, this.holes, this.id, this.image, this.roundTypes, this.teeBoxes);
  CourseInfo.fullInfo(this.name, this.holes, this.id, this.image, this.roundTypes, this.teeBoxes, this.website, this.background);
  CourseInfo();
}

class RoundType {
  String courseId;
  String roundVariation;
  String roundTypeId;
  int startHole;
  int endHole;

  RoundType(this.courseId, this.roundTypeId, this.roundVariation, this.startHole, this.endHole);
}
