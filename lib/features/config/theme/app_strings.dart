abstract class AppStrings {
  // Экран авторизации (Auth Screen)
  static const String authTitle = 'Crypto';
  static const String authSubtitle = 'Создайте свой кошелек или подключите существующий';
  static const String createWallet = 'Создать кошелек';
  static const String importWallet = 'Подключить кошелек';

  // Экран Seed-фразы (Секретные слова)
  static const String seedTitle = 'Ваша секретная фраза';
  static const String seedSubtitle = 'Запишите эти 24 слова в точном порядке и сохраните их в безопасном месте. Не показывайте их никому.';
  static const String seedWarning = 'Внимание: если вы потеряете эти слова, вы навсегда потеряете доступ к своим средствам.';
  static const String copyPhrase = 'Скопировать фразу';
  static const String checkPhrase = 'Проверить фразу';

  // Главный экран (Home / Wallet)
  static const String mainBalance = 'Баланс кошелька';
  static const String send = 'Отправить';
  static const String receive = 'Получить';
  static const String buy = 'Купить';
  static const String swap = 'Обменять';
  static const String assets = 'Активы';
  static const String history = 'История';

  // Ошибки (Error Screen)
  static const String errorTitle = 'Упс! Что-то пошло не так';
  static const String errorButton = 'Попробовать снова';

   static const String pinCreate = 'Создайте ПИН-код';
  static const String pinConfirm = 'Повторите ПИН-код';
  static const String pinEnter = 'Введите ПИН-код для входа';
  
  // Уведомления и ошибки ПИН-кода
  static const String pinSuccessCreated = 'Пароль успешно создан!';
  static const String pinMismatch = 'Пароли не совпали. Попробуйте сначала.';
  static const String pinIncorrect = 'Неверный ПИН-код!';
  static const String pinReset = 'Пароль стерт из памяти устройства!';


  // Экран секретной фразы (12 слов / Seed Phrase)
  // static const String seedTitle = 'Ваша секретная фраза';
  // static const String seedSubtitle = 'Запишите эти 12 слов на листке бумаги в правильном порядке. Никогда не делитесь ими и не делайте скриншот.';
  // static const String seedWarning = 'Внимание: если вы потеряете эти слова или удалите приложение, ваши средства будут безвозвратно утеряны.';
  
  // Кнопки и уведомления экрана фразы
  static const String btnCopyPhrase = 'Скопировать в буфер';
  static const String phraseCopied = 'Фраза скопирована! Сохраните её надежно.';
  static const String btnPhraseSaved = 'Я записал эти 12 слов';

  // Сохранение в Shared Preferences для макета
  static const String phraseSavedInMemory = 'Секретная фраза успешно зафиксирована!';

  // NEW: Генератор — кнопки
  static const String btnNext = 'Далее';
  static const String btnRegenerate = 'Сгенерировать заново';
  static const String btnConfirm = 'Подтвердить';

  // NEW: Генератор — экран проверки
  static const String checkTitle = 'Проверка';
  static const String checkSubtitle = 'Введите слова под номерами';
  static const String checkWordHint = 'Слово';
  static const String checkError = 'Неверно. Проверьте слова и попробуйте снова.';
  static const String checkSuccess = 'Фраза подтверждена';
    // NEW: Кастомизация кошелька
  static const String customTitle = 'Настройка кошелька';
  static const String customNameLabel = 'Название';
  static const String customNameHint = 'Мой кошелёк';
  static const String customColorLabel = 'Цвет';
  static const String customIconLabel = 'Иконка';
  static const String customSave = 'Сохранить';
  static const String customSaved = 'Кошелёк обновлён';
  static const String customDefaultName = 'Кошелёк';
    // NEW: Нижняя навигация
  static const String navHome = 'Главная';
  static const String navTrading = 'Трейдинг';
  static const String navSettings = 'Настройки';

  // NEW: Трейдинг и настройки
  static const String tradingTitle = 'Трейдинг';
  static const String tradingSoon = 'Раздел в разработке';
  static const String settingsTitle = 'Настройки';
  static const String settingsWallet = 'Настройка кошелька';
  static const String settingsSeed = 'Секретная фраза';
  static const String settingsPin = 'Сменить ПИН-код';
  static const String soon = 'Скоро';
  
    static const String homeBalanceValue = '0.00';
  static const String homeCurrency = 'TON';
  static const String homeNoHistory = 'Пока нет операций';
  static const String homeYieldTitle = 'Доходность';
  static const String homeYieldError = 'Не удалось загрузить данные';
  static const String homeRetry = 'Повторить';
}
