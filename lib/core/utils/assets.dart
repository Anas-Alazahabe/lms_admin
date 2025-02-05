class AssetsData {
  static const logo = 'assets/images/logoIcon.png';
  static const arabic = 'assets/images/arabic.jpg';
  static const profile = 'assets/images/profile.png';
  static List<String> avatars = getAvatars();
}

List<String> getAvatars() {
  List<String> avatars = [];
  for (var i = 1; i <= 15; i++) {
    avatars.add('images/avatar/$i.png');
  }
  return avatars;
}
