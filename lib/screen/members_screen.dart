import 'package:flutter/material.dart';
import 'package:proj4_flutter/constants/team_member_role.dart';
import 'package:proj4_flutter/controllers/team_controllers.dart';
import 'package:proj4_flutter/models/team_member.dart';
import 'package:proj4_flutter/routes/route_utils.dart';
import 'package:proj4_flutter/shared/menu_bottom.dart';
import 'package:proj4_flutter/shared/menu_drawer.dart';
import 'package:proj4_flutter/widgets/team/members_list.dart';
import 'package:proj4_flutter/widgets/team/remove_member_alert.dart';

List<String> list = <String>[
  TeamMemberRole.ADMINISTRATOR.name,
  TeamMemberRole.MEMBER.name,
  TeamMemberRole.GUEST.name,
];

class MembersScreen extends StatefulWidget {
  const MembersScreen({super.key});

  @override
  State<MembersScreen> createState() => _MembersScreenState();
}

class _MembersScreenState extends State<MembersScreen> {
  TeamController teamController = TeamController();
  TeamMemberDetail currentMember = TeamMemberDetail(0, '', '', '', '', '', '', '', '');
  bool isAdmin = false;
  TextEditingController emailController = TextEditingController();
  String? teamRole;

  Widget mainContent = const Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      CircularProgressIndicator(),
    ],
  );

  Future<void> _showRemoveDialog(
    context,
    TeamMemberDetail mem,
  ) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return RemoveMemberAlert(getAllMems: getAllMems, mem: mem);
      },
    );
  }

  void getAllMems() async {
    teamController.getAllMembersDetails().then((value) {
      if (value == null) {
        mainContent = const Text(
          "Error",
          style: TextStyle(color: Colors.red),
        );
      } else {
        mainContent = MembersList(members: value, showRemoveDialog: _showRemoveDialog);
      }
      setState(() {});
    });
  }

  @override
  void initState() {
    teamController.initPrefs().then((_) {
      currentMember = teamController.getCurrentMemberInPrefs();
      isAdmin = currentMember.teamMemberRole == TeamMemberRole.CREATOR.name ||
          currentMember.teamMemberRole == TeamMemberRole.ADMINISTRATOR.name;
      getAllMems();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBar(
          foregroundColor: Colors.white,
          title: Text(APP_PAGE.members.toTitle),
        ),
        drawer: const MenuDrawer(),
        bottomNavigationBar: const MenuBottom(),
        body: Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              isAdmin
                  ? Row(
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              TextFormField(
                                controller: emailController,
                                decoration: const InputDecoration(
                                  labelText: "Enter email",
                                ),
                              ),
                              DropdownButton(
                                hint: const Text("Choose a role"),
                                value: teamRole,
                                items: list.map<DropdownMenuItem<String>>((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                                onChanged: (String? value) {
                                  setState(() {
                                    teamRole = value!;
                                  });
                                },
                              )
                            ],
                          ),
                        ),
                        const SizedBox(width: 10),
                        ElevatedButton(
                          onPressed: teamRole == null || emailController.text == ''
                              ? null
                              : () {
                                  teamController.addMember(emailController.text, teamRole!).then((value) {
                                    if (value != null) {
                                      setState(() {
                                        emailController.text = '';
                                        teamRole = null;
                                      });
                                      getAllMems();
                                    } else {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                          content: Text(
                                            teamController.errMsg,
                                            style: const TextStyle(color: Colors.red),
                                          ),
                                        ),
                                      );
                                    }
                                  });
                                },
                          child: const Row(
                            children: [
                              Icon(
                                Icons.add,
                                color: Colors.white,
                              ),
                              SizedBox(width: 5),
                              Text(
                                "Add",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
                  : const SizedBox(height: 20),
              const SizedBox(height: 20),
              Expanded(
                child: mainContent,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
