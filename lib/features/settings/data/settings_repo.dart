
import '../../../util/shared_preferences.dart';
import '../../../util/source.dart';

class SettingsRepo {

  Future<bool> getSoundStatus() async{
    return  await getBoolPreference('sound');
  }

  Future<String> loadCategory() async {
    var category = await getPreference('category_search');
    return category.isEmpty ? 'General' : category;
  }

  Future<String> loadSource() async {
    var source = await getPreference('source_search');
    return source.isEmpty ? generalDomains().first : source;
  }

  void saveSound (bool value){
    saveBoolPreference('sound', value);
  }
}