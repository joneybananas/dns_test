// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TaskDto _$TaskDtoFromJson(Map<String, dynamic> json) => TaskDto(
      json['name'] as String,
      json['description'] as String,
      json['shortDescription'] as String,
      $enumDecode(_$TaskStatusEnumMap, json['taskStatus']),
      DateTime.parse(json['creationDate'] as String),
    );

Map<String, dynamic> _$TaskDtoToJson(TaskDto instance) => <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
      'shortDescription': instance.shortDescription,
      'taskStatus': _$TaskStatusEnumMap[instance.taskStatus]!,
      'creationDate': instance.creationDate.toIso8601String(),
    };

const _$TaskStatusEnumMap = {
  TaskStatus.NEW: 'NEW',
  TaskStatus.PROGRESS: 'PROGRESS',
  TaskStatus.DONE: 'DONE',
};
