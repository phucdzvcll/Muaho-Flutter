/// senderId : 206
/// msg : "hi"
/// roomId : 206
/// sendTime : 1640187589203

class NewsChat {
  NewsChat({
      this.senderId, 
      this.msg, 
      this.roomId, 
      this.sendTime,});

  NewsChat.fromJson(dynamic json) {
    senderId = json['senderId'];
    msg = json['msg'];
    roomId = json['roomId'];
    sendTime = json['sendTime'];
  }
  int? senderId;
  String? msg;
  int? roomId;
  int? sendTime;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['senderId'] = senderId;
    map['msg'] = msg;
    map['roomId'] = roomId;
    map['sendTime'] = sendTime;
    return map;
  }

}