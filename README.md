<div align="center">

# 💎 Crypto

**Аналог Tonkeeper на Flutter**

Некастодиальный кошелёк в стиле TON: ПИН-код, секретная фраза, кастомизация кошелька и главный экран.

![Flutter](https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white)
![Dart](https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white)
![TON](https://img.shields.io/badge/TON-0098EA?style=for-the-badge&logo=ton&logoColor=white)
![Status](https://img.shields.io/badge/status-in%20development-orange?style=for-the-badge)

</div>

---

## ✨ Возможности

- 🚀 **Сплэш-экран** и экран авторизации
- 🔐 **ПИН-код**: создание, подтверждение и вход
- 🔑 **Секретная фраза** из 24 слов (словарь BIP39) с проверкой по случайным номерам слов
- 🎨 **Кастомизация кошелька**: имя, цвет и иконка-тег
- 🏠 **Главный экран**: баланс, действия (отправить, получить, купить, обменять), активы и история
- 🧭 **Навигация** на `go_router`
- 🌙 **Тёмная тема** в цветах TON

## 🛠 Стек

| Технология | Зачем |
| --- | --- |
| Flutter / Dart | Основа приложения |
| `go_router` | Навигация |
| `bip39` | Генерация секретной фразы |
| `shared_preferences` | Хранение ПИН-кода и настроек кошелька |

## 📁 Структура проекта

```
lib/
├── main.dart
└── features/
    ├── auth/
    │   ├── data/            # data_sources, repositories, models
    │   ├── domain/          # entities, repositories, usecases
    │   └── presentation/
    │       ├── bloc/
    │       ├── pages/       # splash, auth, seed, home, wallet_customization
    │       └── widgets/     # generator, pincode
    ├── config/
    │   ├── routes/          # app_router.dart
    │   └── theme/           # app_colors, app_strings, app_text_styles, app_theme
    └── core/                # error, network, usecases, util
```

## 🧭 Маршруты

| Путь | Экран |
| --- | --- |
| `/splash` | Сплэш |
| `/pin` | ПИН-код |
| `/generator` | Секретная фраза и проверка |
| `/wallet-customization` | Настройка кошелька |
| `/home` | Главный экран |
| `/error` | Экран ошибки |

## 🚀 Запуск

```bash
# 1. Клонировать репозиторий
git clone https://github.com/<teaxed>/Crypto-Tonkeeper-analog-.git
cd Crypto-Tonkeeper-analog-

# 2. Установить зависимости
flutter pub get

# 3. Запустить
flutter run
```

Требования: Flutter 3.x и Dart 3.x.

## 🗺 Планы

- [ ] Подключение TON-сети (баланс и транзакции)
- [ ] Реальная деривация ключей для TON
- [ ] Безопасное хранение (`flutter_secure_storage`)
- [ ] Биометрия
- [ ] Отправка и получение (QR-код)
- [ ] Список токенов и история операций

## ⚠️ Важно

Это учебный проект. ПИН-код и данные кошелька хранятся в `shared_preferences` без шифрования, а кошелёк пока не подключён к блокчейну. Не используйте его для хранения реальных средств.