import 'package:flutter/material.dart';
import 'package:genui/genui.dart';
import 'package:json_schema_builder/json_schema_builder.dart';

final schema = S.object(
  properties: {
    'question': S.string(description: 'Tiêu đề của mẹo hoặc chế độ gymer (Ví dụ: 🏋️ MẸO SQUAT).'),
    'answer': S.string(description: 'Nội dung chi tiết hướng dẫn thực hiện tác vụ.'),
    'category': S.string(description: 'Phân loại mẹo: "Tập Luyện", "Dinh Dưỡng", "Nghỉ Ngơi".'),
    'hint': S.string(description: 'Một lưu ý nhỏ hoặc cảnh báo nhanh trước khi xem chi tiết.'),
  },
  required: ['question', 'answer'],
);

final riddleCard = CatalogItem(
  name: 'RiddleCard',
  dataSchema: schema,
  widgetBuilder: (itemContext) {
    final json = itemContext.data as Map<String, Object?>;
    final tipTitle = json['question'] as String;
    final instructions = json['answer'] as String;
    final category = (json['category'] as String?) ?? 'Thể Hình';
    final hint = json['hint'] as String?;

    IconData headerIcon = Icons.fitness_center;
    Color themeColor = Colors.orange[700]!;

    if (category.contains('Dinh Dưỡng') || category.contains('Ăn')) {
      headerIcon = Icons.restaurant_menu;
      themeColor = Colors.green[600]!;
    } else if (category.contains('Nghỉ Ngơi') || category.contains('Ngủ')) {
      headerIcon = Icons.bedtime;
      themeColor = Colors.indigo[600]!;
    }

    bool isLocalExpanded = false;

    return StatefulBuilder(
      builder: (context, setStateLocal) {
        return Center(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 400),
            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 4),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(color: Colors.black.withValues(alpha: 0.06), blurRadius: 14, offset: const Offset(0, 6)),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Thanh tiêu đề trên cùng (Header Bar)
                  Container(
                    color: themeColor,
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    width: double.infinity,
                    child: Row(
                      children: [
                        Icon(headerIcon, color: Colors.white, size: 18),
                        const SizedBox(width: 8),
                        Text(
                          category.toUpperCase(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                            letterSpacing: 1.1,
                          ),
                        ),
                      ],
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Tiêu đề bài viết
                        Text(
                          tipTitle,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF0F172A),
                            height: 1.3,
                          ),
                        ),
                        const SizedBox(height: 12),

                        if (hint != null && !isLocalExpanded) ...[
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                            decoration: BoxDecoration(color: Colors.amber[50], borderRadius: BorderRadius.circular(8)),
                            child: Row(
                              children: [
                                Icon(Icons.warning_amber_rounded, size: 16, color: Colors.amber[800]),
                                const SizedBox(width: 6),
                                Expanded(
                                  child: Text(
                                    hint,
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: Colors.amber[900],
                                      fontStyle: FontStyle.italic,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 14),
                        ],

                        Center(
                          child: TextButton.icon(
                            onPressed: () {
                              setStateLocal(() {
                                isLocalExpanded = !isLocalExpanded;
                              });
                            },
                            icon: Icon(
                              isLocalExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                              color: themeColor,
                            ),
                            label: Text(
                              isLocalExpanded ? "Thu gọn hướng dẫn" : "Xem hướng dẫn chi tiết",
                              style: TextStyle(color: themeColor, fontWeight: FontWeight.bold, fontSize: 14),
                            ),
                            style: TextButton.styleFrom(
                              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                              backgroundColor: themeColor.withValues(alpha: 0.08),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                            ),
                          ),
                        ),

                        AnimatedSize(
                          duration: const Duration(milliseconds: 250),
                          curve: Curves.fastOutSlowIn,
                          child: Container(
                            width: double.infinity,
                            child: isLocalExpanded
                                ? Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(height: 16),
                                      const Divider(height: 1),
                                      const SizedBox(height: 14),
                                      Text(
                                        "📝 HƯỚNG DẪN CHI TIẾT:",
                                        style: TextStyle(
                                          fontSize: 11,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.grey[600],
                                          letterSpacing: 1,
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        instructions,
                                        style: const TextStyle(fontSize: 15, color: Color(0xFF334155), height: 1.5),
                                      ),
                                    ],
                                  )
                                : const SizedBox.shrink(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  },
);
