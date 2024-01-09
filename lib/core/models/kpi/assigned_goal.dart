// To parse this JSON data, do
//
//     final assignedGoal = assignedGoalFromMap(jsonString);

import 'dart:convert';

class AssignedGoal {
  AssignedGoal({
    this.entityName,
    this.instanceName,
    this.id,
    this.goalLibrary,
    this.goalString,
    this.goalType,
    this.goal,
    this.weight,
    this.category,
  });

  String entityName;
  String instanceName;
  String id;
  GoalLibrary goalLibrary;
  String goalString;
  String goalType;
  Goal goal;
  double weight;
  Category category;

  factory AssignedGoal.fromJson(String str) => AssignedGoal.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory AssignedGoal.fromMap(Map<String, dynamic> json) => AssignedGoal(
    entityName: json['_entityName'],
    instanceName: json['_instanceName'],
    id: json['id'],
    goalLibrary: json['goalLibrary'] == null ? null : GoalLibrary.fromMap(json['goalLibrary']),
    goalString: json['goalString'],
    goalType: json['goalType'],
    goal: json['goal'] == null ? null : Goal.fromMap(json['goal']),
    weight: json['weight'],
    category: json['category'] == null ? null : Category.fromMap(json['category']),
  );

  Map<String, dynamic> toMap() => {
    '_entityName': entityName,
    '_instanceName': instanceName,
    'id': id,
    'goalLibrary': goalLibrary == null ? null : goalLibrary.toMap(),
    'goalString': goalString,
    'goalType': goalType,
    'goal': goal == null ? null : goal.toMap(),
    'weight': weight,
    'category': category == null ? null : category.toMap(),
  };
}

class Category {
  Category({
    this.entityName,
    this.instanceName,
    this.id,
    this.order,
    this.langValue3,
    this.langValue1,
  });

  String entityName;
  String instanceName;
  String id;
  int order;
  String langValue3;
  String langValue1;

  factory Category.fromJson(String str) => Category.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Category.fromMap(Map<String, dynamic> json) => Category(
    entityName: json['_entityName'],
    instanceName: json['_instanceName'],
    id: json['id'],
    order: json['order'],
    langValue3: json['langValue3'],
    langValue1: json['langValue1'],
  );

  Map<String, dynamic> toMap() => {
    '_entityName': entityName,
    '_instanceName': instanceName,
    'id': id,
    'order': order,
    'langValue3': langValue3,
    'langValue1': langValue1,
  };
}

class Goal {
  Goal({
    this.entityName,
    this.instanceName,
    this.id,
    this.successCriteria,
    this.goalName,
  });

  String entityName;
  String instanceName;
  String id;
  String successCriteria;
  String goalName;

  factory Goal.fromJson(String str) => Goal.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Goal.fromMap(Map<String, dynamic> json) => Goal(
    entityName: json['_entityName'],
    instanceName: json['_instanceName'],
    id: json['id'],
    successCriteria: json['successCriteria'],
    goalName: json['goalName'],
  );

  Map<String, dynamic> toMap() => {
    '_entityName': entityName,
    '_instanceName': instanceName,
    'id': id,
    'successCriteria': successCriteria,
    'goalName': goalName,
  };
}

class GoalLibrary {
  GoalLibrary({
    this.entityName,
    this.instanceName,
    this.id,
    this.libraryName,
  });

  String entityName;
  String instanceName;
  String id;
  String libraryName;

  factory GoalLibrary.fromJson(String str) => GoalLibrary.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory GoalLibrary.fromMap(Map<String, dynamic> json) => GoalLibrary(
    entityName: json['_entityName'],
    instanceName: json['_instanceName'],
    id: json['id'],
    libraryName: json['libraryName'],
  );

  Map<String, dynamic> toMap() => {
    '_entityName': entityName,
    '_instanceName': instanceName,
    'id': id,
    'libraryName': libraryName,
  };
}
