// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:chat_app/presentation/enum/enums.dart';

class Message {
  final List<String>? content;
  final ChatMessageType type;
  final ChatMessageStatus status;
  final bool isSender;
  Message({
    this.content,
    required this.type,
    required this.status,
    required this.isSender,
  });
}

List<Message> demoMessages = [
  Message(
    isSender: false,
    status: ChatMessageStatus.viewed,
    type: ChatMessageType.text,
    content: [
      "Chào, Trường Sinh!",
      "Bạn có thể kể cho tôi về con mèo của bạn, tôi nhớ nó quá!",
    ],
  ),
  Message(
    isSender: true,
    status: ChatMessageStatus.viewed,
    type: ChatMessageType.text,
    content: [
      "Chào, Nguyễn Dộ",
      "Đương nhiên rồi",
    ],
  ),
  Message(
    isSender: false,
    status: ChatMessageStatus.viewed,
    type: ChatMessageType.text,
    content: [
      "Cảm ơn 🥰! thế nó sao rồi?",
    ],
  ),
  Message(
    isSender: true,
    status: ChatMessageStatus.viewed,
    type: ChatMessageType.text,
    content: [
      "Nó mới vừa ăn tối xong",
      "Tôi sẽ không nó cho bạn biết là hiện tại nó đang đi ị* 🤢",
      "😂😂😂😂🤣",
    ],
  ),
  Message(
    isSender: false,
    status: ChatMessageStatus.viewed,
    type: ChatMessageType.text,
    content: [
      "Khiếu hài hước của bạn làm tôi phải khóc đấy!",
      "Hay ra dẻ quá à! 🤣🤣",
      "Thôi bỏ qua câu chuyện nhạt nhẽo ấy đi",
      "Hôm nay làm việc thế nào?",
    ],
  ),
  Message(
    isSender: true,
    status: ChatMessageStatus.viewed,
    type: ChatMessageType.text,
    content: [
      "Tôi hả? Cũng bình thường.",
      "Vẫn bị sếp mắng như mọi lần",
    ],
  ),
  Message(
    isSender: false,
    status: ChatMessageStatus.viewed,
    type: ChatMessageType.text,
    content: [
      "Ohmm",
      "Không Sao! mai sẽ khác",
      "Tôi có chút hẹn, gặp lại sau nhé!"
    ],
  ),
];
