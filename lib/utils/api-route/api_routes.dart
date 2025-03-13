class ApiRoutes {
  static const String baseUrl = 'https://learn-language-app.azurewebsites.net/api/';

  static const String register = 'Register';
  static const String login = 'Login';
  static const String confirmEmail = 'ConfirmEmail';
  static const String resendConfirmationEmail = 'ResendEmailConfirmationCode';
  static const String verifyCode = 'ConfirmPasswordResetCode';
  static const String googleAuth = 'GoogleAuth';
  static const String refreshToken = 'RefreshToken';
  static const String forgotPassword = 'ForgotPassword';
  static const String confirmResetToken = 'ConfirmPasswordResetToken';
  static const String resetPassword = 'ResetPassword';

  static const String deleteAccount = 'DeleteUser';

  static const String changePassword = 'ChangePassword';


  static const String getNotificationSettings = 'Notification/GetByUserId';

  static const String getUserSettings = 'UserSetting/GetUserSetting';

  static const String changeNotificationSettings = 'Notification/Update';
  static const String changeQuizVisibility = 'UserSetting/ChangeQuizVisibility';
  static const String changeNotificationStatus = 'UserSetting//ChangeNotificationStatus';
  static const String changeQuizListenable = 'UserSetting/ChangeQuizListenable';

  static const String getAllLanguages = 'Language/GetAll';
  static const String setUserLanguage = 'UserLanguage/Create';
  static const String setUserTiming = 'Notification/Create';
  static const String getAllTimingIntervals = 'Interval/GetAll';

  static const String setFcmToken = 'FcmToken/Create';

  static const String getAllCategories = 'Category/GetAllByUserId';
  static const String addFromCategoryToLearning = 'UserVocabulary/AddFromVocabulary';
  static const String addToLearning = 'UserVocabulary/SetLearning/';
  static const String addToMaster = 'UserVocabulary/SetMastered/';
  static const String searchWord = 'UserVocabulary/Search';

  static const String getAllCategoryVocabulary = 'Vocabulary/GetAllByCategoryId';

  static const String getAllCardsCounts = 'UserVocabulary/GetCountByUserId';

  static const String getAllNotification = 'UserNotification/GetAllByUserId';

  static const String getAllWords = 'UserVocabulary/GetPaginatedByUserId';
  static const String getAllWordsList = 'UserVocabulary/GetAllByUserId';

  static const String deleteWord = 'UserVocabulary/Delete';

  static const String updateWord = 'UserVocabulary/Update';

  static const String downloadTemplate = 'UserVocabularyDownloadTemplate';

  static const String downloadTemplate64 = 'UserVocabulary/DownloadTemplate64';

  static const String exportWords = 'UserVocabulary/ExportToExcel64';

  static const String uploadTemplate = 'UserVocabulary/AddFromFile';



  static const String getAllLearningWords = 'UserVocabulary/GetAllLearningByUserId';

  static const String getAllMasteredWords = 'UserVocabulary/GetAllMasteredByUserId';
  static const String getUserLanguagePairs = 'UserLanguage/GetAllByUserId';
  static const String deleteLanguagePair = 'UserLanguage/Delete';
  static const String deleteAllWords = 'UserVocabulary/DeleteAll';
  static const String swapLanguagePair = 'UserLanguage/Swap';
  static const String getQuizQuestion = 'Quiz/GetQuestion';
  static const String createQuizReport = 'Quiz/CreateReport';
  static const String quizSession = 'QuizSession/Create';
  static const String getPersonalRecord = 'QuizSession/GetPersonalRecord';

  static const String getQuizAccuracy = 'QuizSession/GetQuizAccuracy';

  static const String setSelectedLanguagePair = 'UserLanguage/SetSelected/';

  static const String newWord = 'UserVocabulary/Create';
}
