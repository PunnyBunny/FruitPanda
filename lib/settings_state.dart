import 'package:json_annotation/json_annotation.dart';
part 'settings_state.g.dart';
@JsonSerializable()
class SettingsState {
  bool music;
  bool sound;
  SettingsState({required this.music, required this.sound});

  factory SettingsState.fromJson(Map<String, dynamic> json) => _$SettingsStateFromJson(json);
  Map<String, dynamic> toJson() => _$SettingsStateToJson(this);
}