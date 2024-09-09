abstract class LocalSessionRepository {
  Future<void> insertData(Map<String,String> data);
  Future<String> getData(String key);
  Future<bool> clearSession();
}