class Settings {
  String email, evernote, singLogin, singPass;
  bool alwaysSyncEmail, alwaysSyncEvernote, alwaysSyncSingularity;
 
  // 0 - черная 1 - белая
  bool theme;

  Settings(
    String email, 
    String evernote, 
    String singLogin, 
    String singPass, 
    bool alwaysSyncEmail, 
    bool alwaysSyncEvernote, 
    bool alwaysSyncSingularity, 
    bool theme
    ){
    this.email = email;
    this.evernote = evernote;
    this.singLogin = singLogin;
    this.singPass = singPass;
    this.alwaysSyncEmail = alwaysSyncEmail;
    this.alwaysSyncEvernote = alwaysSyncEvernote;
    this.alwaysSyncSingularity = alwaysSyncSingularity;
    this.theme = theme;
  }
  static Settings empty() {
    return Settings('', '','','', true, true, true, true);
  }
}