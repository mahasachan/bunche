import 'package:bunche/data/datasources/local/hive_database.dart';
import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

part 'hive_group.g.dart';

const uuid = Uuid();

@HiveType(typeId: 0)
class GroupHive {
  @HiveField(0)
  String id;

  @HiveField(1)
  String groupName;

  @HiveField(2)
  List<FriendHive> friends;

  GroupHive({
    required this.groupName,
    required this.friends,
  }) : id = uuid.v4();

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['groupName'] = groupName;
    data['friends'] = friends;
    return data;
  }

  factory GroupHive.fromJson(Map<String, dynamic> json) {
    return GroupHive(
      groupName: json['accountName'],
      friends: (json['friends']),
    );
  }
}
