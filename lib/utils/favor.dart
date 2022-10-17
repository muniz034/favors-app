import "friend.dart";

class Favor {
  String uuid;
  String description;
  DateTime dueDate;
  bool? accepted = false;
  DateTime? completed = null;
  Friend friend;

  Favor({
    required this.uuid,
    required this.description,
    required this.dueDate,
    this.accepted,
    this.completed,
    required this.friend,
  });

  get isDoing => accepted == true && completed == false;

  get isRequested => accepted == false;

  get isCompleted => completed != null;

  get isRefused => accepted == false;
}