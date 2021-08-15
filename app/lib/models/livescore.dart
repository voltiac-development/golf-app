import 'package:golfcaddie/viewmodels/Friend.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

class LiveScore {
  late bool callMade = false;
  late io.Socket socket;
  List<int> white = [];
  List<int> blue = [];
  List<int> yellow = [];
  List<int> red = [];
  List<int> orange = [];
  List<int> si = new List.filled(18, -1);
  List<int> par = new List.filled(18, -1);

  List<List<int>> scores = [
    new List.filled(18, 0),
    new List.filled(18, 0),
    new List.filled(18, 0),
    new List.filled(18, 0),
  ];
  List<List<int>> holePhc = [
    new List.filled(18, 2),
    new List.filled(18, 1),
    new List.filled(18, 4),
    new List.filled(18, 3),
  ];
  List<List<int?>> strokes = [
    new List.filled(18, null),
    new List.filled(18, null),
    new List.filled(18, null),
    new List.filled(18, null),
  ];

  int holes = 18;

  List<Friend> players = [];

  LiveScore.filled(
    this.callMade,
    this.socket,
  );
  LiveScore();
}
