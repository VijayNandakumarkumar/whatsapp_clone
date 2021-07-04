import 'package:whatsapp/model/ChatModel.dart';

class Constants {
  static List<ChatModel> chatModels= [
    ChatModel("", "Vijay", "Hello, there mate", "18:00", false, "Hey I use whatsApp", 1),
    ChatModel("", "Vinesh", "Hello, there mate", "19:00", false, "Hey I use whatsApp", 2),
    ChatModel("", "Kumar's Family", "Hello, there mate", "18:00", true, "Hey I use whatsApp", 3),
    ChatModel("", "Kumar", "Hello, there mate", "20:00", false, "Hey I use whatsApp", 4),
    ChatModel("", "Sarath", "Hello, there mate", "21:00", false, "Hey I use whatsApp", 5),
    ChatModel("", "Friends", "Hello, there mate", "22:00", true, "Hey I use whatsApp", 6),
    ChatModel("", "Selvi", "Hello, there mate", "23:00", false, "Hey I use whatsApp", 7),
    ChatModel("", "Anamika", "Hello, there mate", "24:00", false, "Hey I use whatsApp", 8),
  ];
  static List<List<ChatModel>> groups;
}