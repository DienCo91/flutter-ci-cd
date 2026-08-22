import 'package:batterylevel/provider/theme_provider.dart';
import 'package:material_ui/material_ui.dart';
import 'package:go_router/go_router.dart';

class Profile extends StatefulWidget {
  const Profile({super.key, this.userId});

  final String? userId;

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  void handleGotoSetting() {
    context.push('/setting');
  }

  void handleBackToHome() {
    context.go('/');
  }

  void handleChangeColor(Color? color, BuildContext context) {
    final provider = ThemeProvider.of(context);
    if (color == Colors.deepPurple) {
      provider?.onColorChange(Colors.blue);
    } else {
      provider?.onColorChange(Colors.deepPurple);
    }
  }

  @override
  Widget build(BuildContext context) {
    final color = ThemeProvider.of(context)?.themeColor;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("Profile"),
      ),
      body: Container(
        color: color,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("User ID: ${widget.userId}"),
              ElevatedButton(
                onPressed: handleGotoSetting,
                child: Text("Go to Setting Page"),
              ),
              ElevatedButton(
                onPressed: handleBackToHome,
                child: Text("Back to Home Page"),
              ),
              ElevatedButton(
                onPressed: () => handleChangeColor(color, context),
                child: Text("Change Color"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// adb shell am start -a android.intent.action.VIEW -d "interacting://deeplink.vn/profile/1234" com.example.batterylevel
