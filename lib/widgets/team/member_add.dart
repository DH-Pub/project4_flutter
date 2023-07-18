import 'package:flutter/material.dart';
import 'package:proj4_flutter/constants/team_member_role.dart';
import 'package:proj4_flutter/controllers/team_controllers.dart';

class MemberAdd extends StatefulWidget {
  final Function getAllMems;
  const MemberAdd({super.key, required this.getAllMems});

  @override
  State<MemberAdd> createState() => _MemberAddState();
}

class _MemberAddState extends State<MemberAdd> {
  List<String> list = <String>[
    TeamMemberRole.ADMINISTRATOR.name,
    TeamMemberRole.MEMBER.name,
    TeamMemberRole.GUEST.name,
  ];
  TeamController teamController = TeamController();
  TextEditingController emailController = TextEditingController();
  String? teamRole;
  @override
  Widget build(BuildContext context) {
    return Row(
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
                      widget.getAllMems();
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            teamController.errMsg ?? "",
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
    );
  }
}
