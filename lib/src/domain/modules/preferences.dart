abstract class IPreferences {
  setData(String key, dynamic value);
  Future getData(String key, dynamic defaultValue);
}