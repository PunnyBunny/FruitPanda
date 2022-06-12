import 'package:json_annotation/json_annotation.dart';
import 'record.dart';
part 'fruit_record.g.dart';

@JsonSerializable(explicitToJson: true)
class FruitRecord {
  List<Record> records;

  FruitRecord(this.records);

  factory FruitRecord.fromJson(Map<String, dynamic> json) => _$FruitRecordFromJson(json);
  Map<String, dynamic> toJson() => _$FruitRecordToJson(this);
}


