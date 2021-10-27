abstract class BaseModel {
  toJson();

  @override
  String toString() {
    return toJson();
  }
}
