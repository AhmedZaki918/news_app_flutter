import '../../../util/app_constants.dart';
import '../../../util/common.dart';
import '../../../util/shared_preferences.dart';

class SourceRepo {

  Future<String> loadCategory() async {
    return await loadCategoryInPreferences();
  }

  Future<String> loadSource() async {
    return await loadSourceInPreferences();
  }

  void saveUserPreference( String value){
    savePreference(AppConstants.sourceSearch, value);
  }
}