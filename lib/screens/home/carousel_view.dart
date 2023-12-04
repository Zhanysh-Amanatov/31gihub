/*External dependencies */
import 'package:finik/screens/home/home_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:chewie/chewie.dart';
import 'package:video_player/video_player.dart';
/*Local dependencies */
import 'package:finik/screens/common/button_widget.dart';
import 'package:finik/view_routes/routes.dart';

class MyItem {
  String path;
  String itemName;
  String itemDescription;
  Color itemBgColorTopLeft;
  Color itemBgColorBottomRight;
  Alignment alignment;
  MyItem(
    this.itemBgColorTopLeft,
    this.itemBgColorBottomRight,
    this.path,
    this.itemName,
    this.itemDescription,
    this.alignment,
  );
}

class CarouselView extends StatefulWidget {
  const CarouselView({super.key});
  static Page<void> page() => const MaterialPage<void>(child: CarouselView());

  @override
  State<CarouselView> createState() => _CarouselViewState();
}

class _CarouselViewState extends State<CarouselView> {
  final PageController _pageController = PageController(initialPage: 0);
  int currentPage = 0;
  final String videoUrl = 'assets/videos/mapGif.mp4';

  List<MyItem> items = [
    MyItem(
      const Color(0xFF709F0B),
      const Color(0xFF26FFF2),
      'assets/images/iPhone15.png',
      "Обменивай.",
      'Получай подарки',
      Alignment.center,
    ),
    MyItem(
      const Color(0xFF2663FF),
      const Color(0xFF26FFF2),
      'assets/images/blueBox.png',
      'Играй.',
      'Увлекательная игра',
      Alignment.center,
    ),
    MyItem(
      const Color(0xFF709F0B),
      const Color(0xFFFF7246),
      'assets/images/macBookPro16.png',
      'Везде.',
      'На всех платформах',
      Alignment.center,
    ),
    MyItem(
      const Color(0xFFFF5959),
      const Color(0xFFEC74FF),
      'assets/images/terminal.png',
      'Оглянись.',
      'Терминалы везде',
      Alignment.bottomCenter,
    ),
    MyItem(
      const Color(0xFFFFC046),
      const Color(0xFFFF5959),
      'assets/images/mapSign.png',
      'Отмечай. Мы',
      'поставим терминал',
      Alignment.center,
    ),
    MyItem(
      const Color(0xFFFFC046),
      const Color(0xFFFF5959),
      'assets/videos/mapGif.mp4',
      'Изучай',
      'Уникальная карта',
      Alignment.center,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.82,
                  // height: MediaQuery.of(context).size.height * 0.72,
                  child: PageView.builder(
                    controller: _pageController,
                    itemCount: items.length,
                    onPageChanged: (index) {
                      setState(() {
                        currentPage = index;
                      });
                    },
                    itemBuilder: (context, index) {
                      final item = items[index];
                      return Column(
                        children: [
                          index != 5
                              ? Container(
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                        colors: [
                                          item.itemBgColorTopLeft,
                                          item.itemBgColorBottomRight
                                        ]),
                                  ),
                                  width: double.infinity,
                                  height:
                                      MediaQuery.of(context).size.height * 0.65,
                                  child: Image.asset(
                                    item.path,
                                    // alignment: Alignment.center
                                    alignment: item.alignment,
                                    // fit: BoxFit.fitWidth,
                                  ),
                                )
                              : VideoCarousel(videoUrl: videoUrl),
                          Container(
                            color: const Color.fromARGB(255, 0, 0, 0),
                            width: double.infinity,
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                vertical: 16.h,
                                horizontal: 10.w,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item.itemName,
                                    style: TextStyle(
                                      color: Colors.white70,
                                      fontSize: 32.sp,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  Text(
                                    item.itemDescription,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 32.sp,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
                currentPage == items.length - 1
                    ? Column(
                        children: [
                          SizedBox(height: 52.h),
                          ButtonWidget(
                            btnText: 'Супер',
                            bgColor: const Color(0xFFD7F863),
                            onPressed: () {
                              Navigator.of(context).pushNamedAndRemoveUntil(
                                  homeViewRoute, (route) => false);
                            },
                          ),
                        ],
                      )
                    : Column(
                        children: [
                          ButtonWidget(
                            btnText: 'Далее',
                            bgColor: const Color(0xFFD7F863),
                            onPressed: () {
                              if (currentPage < items.length - 1) {
                                _pageController.animateToPage(
                                  currentPage + 1,
                                  duration: const Duration(milliseconds: 500),
                                  curve: Curves.easeOut,
                                );
                              }
                            },
                          ),
                          SizedBox(height: 8.h),
                          ButtonWidget(
                            btnText: 'Пропустить',
                            bgColor: const Color(0xFF222222),
                            fgColor: Colors.white,
                            onPressed: () {
                              Navigator.of(context).pushNamedAndRemoveUntil(
                                  homeViewRoute, (route) => false);
                            },
                          ),
                        ],
                      )
              ],
            ),
            Positioned(
              top: 80.h,
              right: 20.w,
              child: IconButton(
                onPressed: () {
                  // Navigator.of(context)
                  //     .pushNamedAndRemoveUntil(homeViewRoute, (route) => false);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const HomeView()),
                  );
                },
                icon: const Icon(
                  Icons.close,
                  color: Colors.white,
                  size: 32,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class VideoCarousel extends StatefulWidget {
  final String videoUrl;
  const VideoCarousel({
    super.key,
    required this.videoUrl,
  });

  @override
  State<VideoCarousel> createState() => _VideoCarouselState();
}

class _VideoCarouselState extends State<VideoCarousel> {
  late VideoPlayerController _videoPlayerController;
  late ChewieController _chewieController;

  @override
  void initState() {
    super.initState();
    _videoPlayerController = VideoPlayerController.asset(widget.videoUrl);
    _chewieController = ChewieController(
        videoPlayerController: _videoPlayerController,
        autoPlay: true,
        looping: true,
        aspectRatio: 1,
        showControls: false);
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    _chewieController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: double.infinity,
        height: MediaQuery.of(context).size.height * 0.65,
        child: Chewie(controller: _chewieController));
  }
}
