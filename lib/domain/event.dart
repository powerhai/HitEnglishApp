class UserLoggedInEvent {
  String userId;
  bool needRegister;

  UserLoggedInEvent(this.userId, this.needRegister);
}
