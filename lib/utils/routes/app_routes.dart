enum Routes {

  splash('splash'),
  onboarding( 'onboarding'),
  login( 'login'),
  register( 'register'),
  verification( 'verification'),
  verifyCode( 'verify-code'),
  forgotPassword( 'forgot-password'),
  resetPassword( 'reset-password'),
  passwordChanged( 'password-changed'),
  setLanguage('set-language'),
  learningLanguage('learning-language'),
  setTiming('set-timing'),
  home('home'),
  notification('notification'),
  quiz('quiz'),
  masterQuiz('master-quiz'),
  wordList('word-list'),
  vocabulary('vocabulary'),
  vocabularyAI('vocabulary-ai'),
  statistics('statistics'),
  story('story'),
  learningVocabulary('learning-vocabulary'),
  masteredVocabulary('mastered-vocabulary'),
  newWord('new-word'),
  settings('settings'),
  changePassword('change-password'),
  changeTiming('change-timing'),
  configuration('configuration'),
  addLanguagePair('add-language-pair'),
  createLanguagePair('create-language-pair'),
  termsConditions('terms-conditions');

  const Routes( this.path);

  final String path;


  static Routes? fromString(String? route){
    return Routes.values.firstWhere((element) => element.path == route);
  }
}