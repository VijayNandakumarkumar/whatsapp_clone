class ChatModel {
  String icon;
  String name;
  String currentMessage;
  String time;
  bool isGroup;
  String status;
  int id;
  bool selected = false;


  ChatModel(this.icon, this.name, this.currentMessage, this.time, this.isGroup, this.status, this.id, {this.selected = false});
}