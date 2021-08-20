import 'package:dio/dio.dart';
import 'package:golfcaddie/viewmodels/CourseInformation.dart';
import 'package:golfcaddie/env.dart';

class CourseInfoManager {
  CourseInfo model = new CourseInfo();

  Future<CourseInfo> retrieveCourseInformation(id) async {
    Dio dio = await AppUtils.getDio();
    Response response = await dio.get('/course/info/' + id);
    Map<String, dynamic> data = response.data;
    model = new CourseInfo.fullInfo(data['name'], data['holes'], id, data['image'], data['roundTypes'], data['teeboxes'], data['website'], data['background']);
    return model;
  }

  Future<CourseInfo> retrieveRecentRounds(id) async {
    Dio dio = await AppUtils.getDio();
    Response r = await dio.get('/course/rounds/' + id);
    List<dynamic> rounds = r.data as List<dynamic>;
    this.model.rounds = rounds;
    return this.model;
  }

  Future<CourseInfo> retrieveBusinessHours(id) async {
    Dio dio = await AppUtils.getDio();
    Response r = await dio.get('/course/hours/' + id);
    List<dynamic> hours = r.data as List<dynamic>;
    this.model.openingHours = hours;
    return model;
  }
}
