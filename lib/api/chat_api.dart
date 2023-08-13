import 'package:chatgpt_client/models/chat_message.dart';
import 'package:chatgpt_client/secrets.dart';
import 'package:dart_openai/openai.dart';

class ChatApi {
  static const _model = 'gpt-3.5-turbo';

  ChatApi() {
    final apiKey = Secrets.apiKey; // Use the default API key as a backup
    OpenAI.apiKey = apiKey;
  }

  Future<String> completeChat(List<ChatMessage> messages) async {
    final chatCompletion = await OpenAI.instance.chat.create(
      model: _model,
      messages: messages
          .map((e) => OpenAIChatCompletionChoiceMessageModel(
                role: e.isUserMessage ? 'user' : 'assistant',
                content: e.content,
              ))
          .toList(),
    );
    return chatCompletion.choices.first.message.content;
  }
}
