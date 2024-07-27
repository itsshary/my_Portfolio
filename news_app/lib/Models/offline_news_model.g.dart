// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'offline_news_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class OfflineNewsModelAdapter extends TypeAdapter<OfflineNewsModel> {
  @override
  final int typeId = 0;

  @override
  OfflineNewsModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return OfflineNewsModel(
      title: fields[0] as String?,
      description: fields[1] as String?,
      image: fields[2] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, OfflineNewsModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.description)
      ..writeByte(2)
      ..write(obj.image);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OfflineNewsModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
