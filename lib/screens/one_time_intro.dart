import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

final List<String> imgList = [
  'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
  'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
  'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
  'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
  'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
  'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80'
];

final List<String> TextCarouselList = [
  '    Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quisque elementum pulvinar risus, sit amet lacinia libero semper efficitur. Mauris ultricies, elit vitae volutpat vestibulum, enim ex maximus velit, ac dapibus metus ligula sit amet ex. 2caff',
  '    htt368f45b0 Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quisque elementum pulvinar risus, sit amet lacinia libero semper efficitur. Mauris ultricies, elit vitae volutpat vestibulum, enim ex maximus velit, ac dapibus metus ligula sit amet ex.',
  '    hthcHBfaWQiOjEyMD Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quisque elementum pulvinar risus, sit amet lacinia libero semper efficitur. Mauris ultricies, elit vitae volutpat vestibulum, enim ex maximus velit, ac dapibus metus ligula sit amet ex.',
  '    faWQiOjEyMDd9&s=89719    Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quisque elementum pulvinar risus, sit amet lacinia libero semper efficitur. Mauris ultricies, elit vitae volutpat vestibulum, enim ex maximus velit, ac dapibus metus ligula sit amet ex.a0d55dd05e',
  '    6e5e3aba7     Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quisque elementum pulvinar risus, sit amet lacinia libero semper efficitur. Mauris ultricies, elit vitae volutpat vestibulum, enim ex maximus velit, ac dapibus metus ligula sit amet ex.',
  '    9893258f5     Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quisque elementum pulvinar risus, sit amet lacinia libero semper efficitur. Mauris ultricies, elit vitae volutpat vestibulum, enim ex maximus velit, ac dapibus metus ligula sit amet ex.'
];

final themeMode = ValueNotifier(2);

final List<Widget> imageSliders = imgList
    .map((item) => Container(
          child: Container(
            margin: EdgeInsets.all(5.0),
            child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                child: Stack(
                  children: <Widget>[
                    Image.asset(
                      "assets/jemput_jelantah_1.jpg",
                      fit: BoxFit.cover,
                      width: 1000.0,
                    ),
                    //Image.network(item, fit: BoxFit.cover, width: 1000.0),
                    Positioned(
                      bottom: 0.0,
                      left: 0.0,
                      right: 0.0,
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Color.fromARGB(200, 0, 0, 0),
                              Color.fromARGB(0, 0, 0, 0)
                            ],
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                          ),
                        ),
                        padding: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 20.0),
                      ),
                    ),
                  ],
                )),
          ),
        ))
    .toList();

class CarouselWithIndicatorDemo extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _CarouselWithIndicatorState();
  }
}

class _CarouselWithIndicatorState extends State<CarouselWithIndicatorDemo> {
  int _current = 0;
  final CarouselController _controller = CarouselController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        Expanded(
          child: CarouselSlider(
            items: imageSliders,
            carouselController: _controller,
            options: CarouselOptions(
                autoPlay: true,
                enlargeCenterPage: true,
                aspectRatio: 2.0,
                onPageChanged: (index, reason) {
                  setState(() {
                    _current = index;
                  });
                }),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: imgList.asMap().entries.map((entry) {
            return GestureDetector(
              onTap: () => _controller.animateToPage(entry.key),
              child: Container(
                width: 12.0,
                height: 12.0,
                margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: (Theme.of(context).brightness == Brightness.dark
                            ? Colors.white
                            : Colors.black)
                        .withOpacity(_current == entry.key ? 0.9 : 0.4)),
              ),
            );
          }).toList(),
        ),
        Container(
          height: 350,
          //transform: Matrix4.translationValues(0.0, -10.0, 0.0),
          //margin: EdgeInsets.fromLTRB(15, 0, 15, 15),

          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Text(
              "${TextCarouselList[_current]}",
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.black,
              ),
            ),
          ),
        ),
      ]),
      floatingActionButton: FAB(),
    );
  }

  Widget FAB() {
    if (_current != 5) {
      return Container();
    } else {
      return FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, 'main_dashboard');
        },
        child: const Icon(Icons.navigate_next_sharp),
        backgroundColor: Colors.blue,
      );
    }
  }
}
