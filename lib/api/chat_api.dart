import 'package:herbal_tea_assistant/models/chat_message.dart';
import 'package:herbal_tea_assistant/secrets.dart';
import 'package:dart_openai/dart_openai.dart';

class ChatApi {
  static const _model = 'gpt-3.5-turbo';

  ChatApi() {
    final apiKey = Secrets.apiKey;
    OpenAI.apiKey = apiKey;
  }

  Future<List<OpenAIChatCompletionChoiceMessageContentItemModel>?> completeChat(List<ChatMessage> messages) async {
    final chatCompletion = await OpenAI.instance.chat.create(
      model: _model,
      messages: messages
          .map((e) => 
                OpenAIChatCompletionChoiceMessageModel(
                  role: e.isUserMessage ? OpenAIChatMessageRole.user : OpenAIChatMessageRole.assistant,
                  content: [
                              OpenAIChatCompletionChoiceMessageContentItemModel.text(e.content),
                            ],
                ))
            .toList(),
    );
    return chatCompletion.choices.first.message.content;
  }
}
