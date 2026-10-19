
import '../../../util/common.dart';
import '../../../util/shared_preferences.dart';

class CategoryRepo {

  Future<String> loadCategory() async {
    return await loadCategoryInPreferences();
  }

  void saveUserPreference(String key, String value){
    savePreference(key, value);
  }
}