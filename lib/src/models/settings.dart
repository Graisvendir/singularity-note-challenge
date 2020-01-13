class Settings {
  String email, evernote;
  bool alwaysSyncEmail, alwaysSyncEvernote;
 
  // 0 - черная 1 - белая
  bool theme;

  Settings(String email, String evernote, bool alwaysSyncEmail, bool alwaysSyncEvernote, bool theme) {
    this.email = email;
    this.evernote = evernote;
    this.alwaysSyncEmail = alwaysSyncEmail;
    this.alwaysSyncEvernote = alwaysSyncEvernote;
    this.theme = theme;
  }
}