class ChatModel {
  String icon;
  String name;
  String currentMessage;
  String time;
  bool isGroup;
  String status;
  bool selected = false;
  ChatModel(this.icon, this.name, this.currentMessage, this.time, this.isGroup, this.status, {this.selected = false});
}