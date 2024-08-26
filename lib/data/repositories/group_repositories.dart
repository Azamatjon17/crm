import 'package:crm/data/model/group.dart';
import 'package:crm/services/group_services.dart';

class GroupRepositories{
  final GroupServices _services;

  GroupRepositories({required GroupServices services}) : _services = services;


  Future<List<Group>> getAllGroups() async{
    return await _services.getAllGroups();
  }

  Future<void> deleteGroup(int id) async{
    await _services.deleteGroup(id);
  }

  Future<Group> createGroup(Group group) async{
    return await _services.createGroup(group);
  }

  Future<void> updateGroup(Group group) async{
    await _services.updateGroup(group);
  }

}
