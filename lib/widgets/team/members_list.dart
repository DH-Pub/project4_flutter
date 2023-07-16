import 'package:flutter/material.dart';
import 'package:proj4_flutter/constants/api_const.dart';
import 'package:proj4_flutter/constants/team_member_role.dart';
import 'package:proj4_flutter/models/team_member.dart';

class MembersList extends StatelessWidget {
  final List<TeamMemberDetail> members;
  final Function showRemoveDialog;
  const MembersList({super.key, required this.members, required this.showRemoveDialog});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      itemCount: members.length,
      itemBuilder: (context, index) {
        TeamMemberDetail mem = members[index];
        return Container(
          margin: const EdgeInsets.symmetric(vertical: 5.0),
          child: Row(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: Colors.grey,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(25),
                  child: mem.pic != ""
                      ? Image.network("${API_CONSTANTS.user}/image/${mem.pic}")
                      : Center(
                          child: Text(
                            mem.username[0],
                            style: const TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  children: [
                    Text(
                      mem.username,
                      style: const TextStyle(fontSize: 16),
                    ),
                    Text(mem.email),
                    Text(mem.teamMemberRole),
                  ],
                ),
              ),
              SizedBox(
                width: 50,
                child: members[index].teamMemberRole == TeamMemberRole.CREATOR.name
                    ? const Text('')
                    : IconButton(
                        onPressed: () {
                          showRemoveDialog(context, mem);
                        },
                        icon: const Icon(
                          Icons.remove,
                          color: Colors.red,
                        ),
                      ),
              ),
            ],
          ),
        );
      },
    );
  }
}
