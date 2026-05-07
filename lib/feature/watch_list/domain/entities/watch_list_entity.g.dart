
part of 'watch_list_entity.dart';
class WatchListEntityAdapter extends TypeAdapter<WatchListEntity> {
  @override
  final int typeId = 0;

  @override
  WatchListEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return WatchListEntity(
      id: fields[0] as int,
      title: fields[1] as String,
      image: fields[2] as String,
      voteAverage: fields[3] as double,
      publishDate: fields[4] as String,
      category: fields[5] as String,
      timeOfMovie: fields[6] as String,
      description: fields[7] as String,
    );
  }

  @override
  void write(BinaryWriter writer, WatchListEntity obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.image)
      ..writeByte(3)
      ..write(obj.voteAverage)
      ..writeByte(4)
      ..write(obj.publishDate)
      ..writeByte(5)
      ..write(obj.category)
      ..writeByte(6)
      ..write(obj.timeOfMovie)
      ..writeByte(7)
      ..write(obj.description);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WatchListEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
