import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedImage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Animated Image'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildImageButton(1, 'Tap to Show Image 1'),
            _buildImageButton(2, 'Tap to Show Image 2'),
            _buildImageButton(3, 'Tap to Show Image 3'),
            SizedBox(height: 20),
            _selectedImage != 0
                ? AnimatedSwitcher(
              duration: Duration(milliseconds: 500),
              transitionBuilder: (child, animation) {
                return SlideTransition(
                  position: Tween<Offset>(
                    begin: Offset(-1.0, 0.0),
                    end: Offset(0.0, 0.0),
                  ).animate(animation),
                  child: child,
                );
              },
              child: _buildImage(),
            )
                : SizedBox.shrink(),
          ],
        ),
      ),
    );
  }

  Widget _buildImageButton(int imageNumber, String label) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedImage = imageNumber;
        });
      },
      child: Container(
        height: 100,
        width: 200,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          label,
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  Widget _buildImage() {
    return Container(
      key: ValueKey<int>(_selectedImage),
      height: 200,
      width: 200,
      child: Image.asset(
        'assets/$_selectedImage.png',
        fit: BoxFit.contain,
      ),
    );
  }
}

