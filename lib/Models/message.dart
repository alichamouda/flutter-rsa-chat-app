class Message {
  String data;
  String receiver;
  String source;
  String time;

  Message(this.data, this.receiver, this.source, this.time);

  factory Message.fromJson(Map<String, dynamic> data) {

     return Message(
      data['data'] as String,
      data['receiver'] as String,
      data['source'] as String,
      data['time'] as String,
    );
  }


}