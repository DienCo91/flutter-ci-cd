import 'package:batterylevel/cubit/counter_cubit.dart';
import 'package:batterylevel/cubit/theme_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  final cubit = CounterCubit(initialState: 6);
  final themeCubit = ThemeCubit();

  void handleBackToHome() {
    Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
  }

  void handleIncrement() {
    cubit.increment();
    themeCubit.changeColor(Colors.white);
  }

  void handleDecrement() {
    cubit.decrement();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    print('====${themeCubit.state}');

    return BlocBuilder(
      bloc: themeCubit,
      builder: (context, state) {
        return Scaffold(
          backgroundColor: themeCubit.state,
          appBar: AppBar(
            elevation: 0,
            centerTitle: true,
            backgroundColor: Colors.transparent,
            title: const Text("Cài đặt", style: TextStyle(fontWeight: FontWeight.bold)),
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildProfileCard(theme),
                const SizedBox(height: 24),

                _buildSettingsCard(
                  children: [
                    SwitchListTile(
                      secondary: const Icon(Icons.dark_mode_outlined),
                      title: const Text("Chế độ tối (Dark Mode)"),
                      value: themeCubit.state == Colors.deepPurple,
                      onChanged: (value) {
                        themeCubit.changeColor(value ? Colors.deepPurple : Colors.lightBlue);
                      },
                    ),
                    const Divider(height: 1),
                    ListTile(
                      leading: const Icon(Icons.language_outlined),
                      title: const Text("Ngôn ngữ"),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text("Tiếng Việt", style: TextStyle(color: theme.colorScheme.secondary)),
                          const SizedBox(width: 8),
                          const Icon(Icons.arrow_forward_ios, size: 16),
                        ],
                      ),
                      onTap: () {}, // Xử lý đổi ngôn ngữ
                    ),
                  ],
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: handleIncrement,
                        label: Text("Increment", style: TextStyle(color: theme.colorScheme.onPrimary)),
                        icon: Icon(Icons.add, color: theme.colorScheme.onPrimary),
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                          backgroundColor: theme.colorScheme.primary,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: handleDecrement,
                        label: Text("Decrement"),
                        icon: Icon(Icons.remove),
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                          backgroundColor: theme.colorScheme.onSecondary,
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 16),

                BlocBuilder(
                  bloc: cubit,
                  builder: (context, state) {
                    return Center(child: Text("Counter: ${cubit.state}", style: TextStyle(fontSize: 24)));
                  },
                ),

                const Divider(height: 1),
                Container(
                  margin: const EdgeInsets.only(top: 16),
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: handleBackToHome,
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      backgroundColor: theme.colorScheme.primary,
                    ),
                    child: Text("Back Home", style: TextStyle(color: theme.colorScheme.onPrimary)),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildProfileCard(ThemeData theme) {
    return Container(
      decoration: BoxDecoration(color: theme.colorScheme.surface, borderRadius: BorderRadius.circular(16)),
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: theme.colorScheme.primary,
            child: Icon(Icons.person, size: 35, color: theme.colorScheme.onPrimary),
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Người Dùng", style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
              const SizedBox(height: 4),
              Text(
                "user@example.com",
                style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant),
              ),
            ],
          ),
          const Spacer(),
          IconButton(
            icon: const Icon(Icons.edit_outlined),
            onPressed: () {}, // Chỉnh sửa profile
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsCard({required List<Widget> children}) {
    return Card(
      elevation: 0,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: Colors.grey.withValues(alpha: 0.2)),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(children: children),
    );
  }
}
