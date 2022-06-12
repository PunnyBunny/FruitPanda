// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fruit_record.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FruitRecord _$FruitRecordFromJson(Map<String, dynamic> json) => FruitRecord(
      (json['records'] as List<dynamic>)
          .map((e) => Record.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$FruitRecordToJson(FruitRecord instance) =>
    <String, dynamic>{
      'records': instance.records.map((e) => e.toJson()).toList(),
    };
