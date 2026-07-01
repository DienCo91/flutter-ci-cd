import 'package:batterylevel/genui_page/schema_build.dart';
import 'package:flutter/material.dart';
import 'package:genui/genui.dart';
import 'package:firebase_ai/firebase_ai.dart';

class GenUiPage extends StatefulWidget {
  const GenUiPage({super.key});

  @override
  State<GenUiPage> createState() => _GenUiPageState();
}

class _GenUiPageState extends State<GenUiPage> {
  late final SurfaceController _surfaceController;
  late final A2uiTransportAdapter _transportAdapter;
  late final Conversation _conversation;
  final _surfaceIds = <String>[];
  late final TextEditingController _textController;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController();

    final catalog = BasicCatalogItems.asCatalog().copyWith(
      newItems: [riddleCard],
    );

    _surfaceController = SurfaceController(catalogs: [catalog]);

    final promptBuilder = PromptBuilder.chat(
      catalog: catalog,
      systemPromptFragments: [
        '''
       Bạn là một chuyên gia thể hình (Gymer) chuyên nghiệp. 
       Nhiệm vụ của bạn là chia sẻ các mẹo, bí quyết cốt lõi để xây dựng một cơ thể săn chắc, khỏe mạnh, bao gồm: kỹ thuật bài tập, chế độ dinh dưỡng, và phương pháp ngủ nghỉ/phục hồi cơ bắp.

      HƯỚNG DẪN BẮT BUỘC ĐỂ ĐỒNG BỘ GIAO DIỆN (UI):
      Khi người dùng gửi tin nhắn yêu cầu một mẹo hoặc chế độ, bạn KHÔNG ĐƯỢC trả về văn bản thuần túy. 
      Bạn BẮT BUỘC phải tạo ra một đối tượng JSON cấu trúc A2UI hợp lệ để gọi component mang tên 'RiddleCard'.
      ''',
      ],
    );

    final model = FirebaseAI.googleAI().generativeModel(
      model: 'gemini-3.5-flash',
      systemInstruction: Content.system(promptBuilder.systemPromptJoined()),
    );

    final chat = model.startChat();

    _transportAdapter = A2uiTransportAdapter(
      onSend: (message) async {
        try {
          final responseStream = chat.sendMessageStream(
            Content.text(message.text),
          );
          await for (final chunk in responseStream) {
            final chunkText = chunk.text;
            if (chunkText != null) {
              _transportAdapter.addChunk(chunkText);
            }
          }
        } catch (e) {
          debugPrint("Lỗi kết nối Gemini Stream: $e");
          rethrow;
        }
      },
    );

    _conversation = Conversation(
      controller: _surfaceController,
      transport: _transportAdapter,
    );

    _conversation.events.listen((event) {
      if (event is ConversationSurfaceAdded) {
        _onSurfaceAdded(event);
      } else if (event is ConversationSurfaceRemoved) {
        _onSurfaceDeleted(event);
      }
    });
  }

  @override
  void dispose() {
    _textController.dispose();
    _conversation.dispose();
    _transportAdapter.dispose();
    super.dispose();
  }

  void _onSurfaceAdded(ConversationSurfaceAdded event) {
    setState(() {
      _surfaceIds.add(event.surfaceId);
    });
  }

  void _onSurfaceDeleted(ConversationSurfaceRemoved event) {
    setState(() {
      _surfaceIds.remove(event.surfaceId);
    });
  }

  void handleSendMessage(String text) async {
    final msg = text.trim();
    if (msg.isEmpty) return;

    _textController.clear();
    setState(() {
      _isLoading = true;
    });

    try {
      await _conversation.sendRequest(ChatMessage.user(msg));
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Lỗi: $e')));
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Gen UI - Workout Expert"),
        elevation: 1,
      ),
      body: Column(
        children: [
          Expanded(
            child: _surfaceIds.isEmpty
                ? const Center(
                    child: Text(
                      "Nhập mục tiêu tập luyện (VD: Các bài tập cơ bụng)",
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(8),
                    itemCount: _surfaceIds.length,
                    itemBuilder: (context, index) {
                      final id = _surfaceIds[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        child: Surface(
                          surfaceContext: _surfaceController.contextFor(id),
                        ),
                      );
                    },
                  ),
          ),

          if (_isLoading) const LinearProgressIndicator(),

          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 4,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: TextField(
                      controller: _textController,
                      onSubmitted: handleSendMessage,
                      style: const TextStyle(color: Colors.black),
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: "Nhập yêu cầu bài tập của bạn...",
                        hintStyle: TextStyle(color: Colors.grey),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () => handleSendMessage(_textController.text),
                  icon: const Icon(Icons.send, color: Colors.blue),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
