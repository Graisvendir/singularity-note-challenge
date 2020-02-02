import 'package:flutter/widgets.dart';

const LIGHT_THEME = ['Light theme', 'Светлая тема'];
const DARK_THEME = ['Dark theme', 'Темная тема'];
const SING_APP_TRY_NOW = ['Singularity App — try now', 'Попробуй SingularityApp'];
const AVAILABLE = ['Available for all platforms', 'Доступно на всех платформах'];
const SWIPE_UP = ['Swipe up to send', 'Свайп вверх для отправки'];
const SWIPE_DOWN = ['Swipe down to trash', 'Свайп вниз для удаления заметки'];
const SWIPE_LEFT = ['Swipe left to see all notes', 'Свайп влево ко всем заметкам'];
const SWIPE_RIGHT = ['Swipe right to make settings', 'Свайп вправо к Настройкам'];
const LOGIN = ['Login', 'Логин'];
const PASS = ['Password', 'Пароль'];
const ALWAYS_SYNC = ['Always sync', 'Всегда синхронизировать'];
const SAVE = ['Save', 'Сохранить'];
const DELETE_SYNC = ['Delete this sync', 'Удалить эту синхронизацию'];
const EMAIL_ADRESS = ['Email Adress', 'Email'];
const EMAIL_SETTINGS = ['Email Settings', 'Настройки Email'];
const SING_SETTINGS = ['SingularityApp Settings', 'Настройки SingularityApp'];
const EVERNOTE_SETTINGS = ['Evernote Settings', 'Настройки Evernote'];
const REQUIRED_FIELD = ['Required field', 'Обязательное поле'];
const EMAIL_NOT_CORRECT = ['Email is not correct', 'Некорректный Email'];
const NO_NOTES = ['There are no notes yet', 'У вас пока нет заметок'];
const CAMERA = ['Camera', 'Камера'];
const GALLERY = ['Gallery', 'Галерея'];

String localize(List<String> textConstant, BuildContext context) {
  Locale myLocale = Localizations.localeOf(context);

  if (myLocale.languageCode == 'en') {
    return textConstant.first;
  } else {
    return textConstant.last;
  }
}