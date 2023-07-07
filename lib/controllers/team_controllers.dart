import 'package:proj4_flutter/constants/api_const.dart';
import 'package:proj4_flutter/models/team.dart';
import 'package:proj4_flutter/services/api.dart';

class TeamController {
  Api team = Api();

  Future<List<UserTeam>?> getUserTeams() async {
    try {
      var res = await team.api.get("${API_CONSTANTS.team}/user");
      if (res.statusCode == 200) {
        List<dynamic> data = res.data;
        List<UserTeam> teams = [];
        for (Map<String, dynamic> t in data) {
          UserTeam team = UserTeam.fromJson(t);
          teams.add(team);
        }
        return teams;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}
