import 'package:flutter/cupertino.dart';
import 'package:kzm/core/models/common_item.dart';

class KzmSelectedUsers {
  final KzmCommonItem user;
  final KzmCommonItem role;
  final bool canBeDeleted;

  const KzmSelectedUsers({
    @required this.user,
    @required this.role,
    this.canBeDeleted = true,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is KzmSelectedUsers &&
          runtimeType == other.runtimeType &&
          user == other.user &&
          role == other.role &&
          canBeDeleted == other.canBeDeleted;

  @override
  int get hashCode => user.hashCode ^ role.hashCode ^ canBeDeleted.hashCode;
}
