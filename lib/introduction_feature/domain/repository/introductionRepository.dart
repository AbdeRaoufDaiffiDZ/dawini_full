abstract class IntroductionRepository {
  Future<bool> isWatched();
  Future<String> ignorIntroduction(bool status);

  Future<String> setLanguage(String language);
  Stream<String> choosenLanguage();

  Future<String> setType(String type);
  Future<String> getType();
}
