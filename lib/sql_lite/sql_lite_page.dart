import 'dart:math';

import 'package:batterylevel/sql_lite/dog_database.dart';
import 'package:batterylevel/sql_lite/model/dog.dart';
import 'package:flutter/material.dart';

class SqlLitePage extends StatefulWidget {
  const SqlLitePage({super.key});

  @override
  State<SqlLitePage> createState() => _SqlLitePageState();
}

class _SqlLitePageState extends State<SqlLitePage> {
  late Future<List<Dog>> _dogList;

  @override
  void initState() {
    super.initState();
    _refreshDogs();
  }

  void _refreshDogs() {
    setState(() {
      _dogList = DogDatabase.instance.readAllDogs();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Quản lý Thú Cưng (SQLite)'), backgroundColor: Colors.amber),
      body: FutureBuilder<List<Dog>>(
        future: _dogList,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Đã xảy ra lỗi: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Chưa có chú chó nào trong DB.'));
          }

          final dogs = snapshot.data!;
          return ListView.builder(
            itemCount: dogs.length,
            itemBuilder: (context, index) {
              final dog = dogs[index];
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                child: ListTile(
                  leading: const CircleAvatar(child: Icon(Icons.pets)),
                  title: Text(dog.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text('Tuổi: ${dog.age}'),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () async {
                      await DogDatabase.instance.deleteDog(dog.id);
                      _refreshDogs();
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final randomNames = ['Fido', 'Milu', 'Lulu', 'Kiki', 'Rocky'];
          final randomName = randomNames[Random().nextInt(randomNames.length)];
          final randomAge = Random().nextInt(10) + 1;

          final newDog = Dog(id: Random().nextInt(1000), name: randomName, age: randomAge);

          await DogDatabase.instance.insertDog(newDog);

          _refreshDogs();
        },
        backgroundColor: Colors.amber,
        child: const Icon(Icons.add),
      ),
    );
  }
}
