import 'package:flutter/widgets.dart';

const LIGHT_THEME = ['Light theme', 'Светлая тема'];
const DARK_THEME = ['Dark theme', 'Темная тема'];
const SING_APP_TRY_NOW = ['Singularity App — try now', 'Singularity App — попробуйте сейчас'];
const AVAILABLE = ['Available for all platforms', 'Доступно для всех платформ'];
const SWIPE_UP = ['Swipe up to send', 'Свайп вверх чтобы отправить'];
const SWIPE_DOWN = ['Swipe down to thrash', 'Свайп вниз чтобы удалить'];
const SWIPE_LEFT = ['Swipe left to see all notes', 'Свайп влево — список заметок'];
const SWIPE_RIGHT = ['Swipe right to make settings', 'Свайп вправо — настройки'];
const LOGIN = ['Login', 'Логин'];
const PASS = ['Password', 'Пароль'];
const ALWAYS_SYNC = ['Always sync', 'Синхронизация включена'];
const SAVE = ['Save', 'Сохранить'];
const DELETE_SYNC = ['Delete this sync', 'Удалить синхронизацию'];
const EMAIL_ADRESS = ['Email Adress', 'Адрес почты'];
const EMAIL_SETTINGS = ['Email Settings', 'Настройки почты'];
const SING_SETTINGS = ['Singularity App Settings', 'Настройки Singularity App'];
const EVERNOTE_SETTINGS = ['Evernote Settings', 'Настройки Evernote'];

String localize(List<String> textConstant, context) {
  Locale myLocale = Localizations.localeOf(context);
  print(myLocale.languageCode);
  print(myLocale.countryCode);
  if (myLocale.languageCode == 'en') {
    return textConstant.first;
  } else {
    return textConstant.last;
  }
}