import 'package:flutter/material.dart';
import 'package:scroll_buttons/constants.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Scroll Buttons',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const ScrollButtons(),
    );
  }
}

class ScrollButtons extends StatefulWidget {
  const ScrollButtons({Key? key}) : super(key: key);

  @override
  State<ScrollButtons> createState() => _ScrollButtonsState();
}

class _ScrollButtonsState extends State<ScrollButtons> {
  late ScrollController _gridviewScrollController;

  @override
  void initState() {
    _gridviewScrollController = ScrollController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final itemSize = MediaQuery.of(context).size.width - 50;

    moveLeft() {
      _gridviewScrollController.animateTo(
        _gridviewScrollController.offset - itemSize,
        duration: const Duration(milliseconds: 500),
        curve: Curves.linear,
      );
    }

    moveRight() {
      _gridviewScrollController.animateTo(
        _gridviewScrollController.offset + itemSize,
        duration: const Duration(milliseconds: 500),
        curve: Curves.linear,
      );
    }

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Stack(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 25, vertical: 16),
                child: Scrollbar(
                  controller: _gridviewScrollController,
                  child: ListView.builder(
                      controller: _gridviewScrollController,
                      scrollDirection: Axis.horizontal,
                      itemCount: imageItems.length,
                      itemBuilder: (context, index) {
                        return Container(
                          width: MediaQuery.of(context).size.width - 50,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(imageItems[index].imageUrl),
                              fit: BoxFit.fitWidth,
                            ),
                          ),
                        );
                      }),
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: FloatingActionButton(
                  onPressed: moveLeft,
                  heroTag: null,
                  backgroundColor: Colors.grey[350],
                  child: const Icon(
                    Icons.arrow_back_ios_new,
                    color: Colors.black,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: FloatingActionButton(
                  onPressed: moveRight,
                  heroTag: null,
                  backgroundColor: Colors.grey[350],
                  child: const Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
