import 'dart:async';

import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:side_bar/sidebar/menu_items.dart';

class SideBar extends StatefulWidget {
  const SideBar({Key? key}) : super(key: key);

  @override
  _SideBarState createState() => _SideBarState();
}

class _SideBarState extends State<SideBar> with SingleTickerProviderStateMixin<SideBar>{
  late AnimationController _animationController;
  StreamController<bool>? isSidebarOpenedStreamController ;
  Stream<bool>? isSidebarOpenedStream;
  StreamSink<bool>? isSidebarOpenedSink;
  final _animationDuration = const Duration(milliseconds: 500);

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(vsync: this, duration:  _animationDuration);
    isSidebarOpenedStreamController = PublishSubject<bool>();
    isSidebarOpenedStream = isSidebarOpenedStreamController!.stream;
    isSidebarOpenedSink = isSidebarOpenedStreamController!.sink;
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
    isSidebarOpenedStreamController!.close();
    isSidebarOpenedSink!.close();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return StreamBuilder<bool>(
      initialData: false,
      stream: isSidebarOpenedStream,
      builder: (context, isSidebarOpenedAsync) {
        return AnimatedPositioned(
          top: 0.0,
          bottom: 0.0,
          left: isSidebarOpenedAsync.data ?? false ? 0 : -screenWidth,
          right: isSidebarOpenedAsync.data ?? false ? 0 : screenWidth - 45,
          duration: _animationDuration,
          child: Row(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  color: Color(0xFF262AAA),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 100,
                      ),
                      ListTile(
                        title: Text(
                          "Rahul Gupta",
                          style: TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.w800),
                        ),
                        subtitle: Text(
                          "rahul27gupta",
                          style: TextStyle(
                            color: Color(0xFF1BB5FD),
                            fontSize: 18,
                          ),
                        ),
                        leading: CircleAvatar(
                          child: Icon(
                            Icons.perm_identity,
                            color: Colors.white,
                          ),
                          radius: 40,
                        ),
                      ),
                      Divider(
                        height: 64,
                        thickness: 0.5,
                        color: Colors.white.withOpacity(0.3),
                        indent: 32,
                        endIndent: 32,
                      ),
                      MenuItem(
                        icon: Icons.home,
                        title: "Home",
                        onTap: () {
                          onIconPressed();
                        },
                      ),
                      MenuItem(
                        icon: Icons.person,
                        title: "My Account",
                        onTap: () {
                          onIconPressed();
                        },
                      ),
                      MenuItem(
                        icon: Icons.shopping_basket,
                        title: "My Orders",
                        onTap: () {
                          onIconPressed();
                        },
                      ),
                      MenuItem(
                        icon: Icons.card_giftcard,
                        title: "Wishlist",
                      ),
                      Divider(
                        height: 64,
                        thickness: 0.5,
                        color: Colors.white.withOpacity(0.3),
                        indent: 32,
                        endIndent: 32,
                      ),
                      MenuItem(
                        icon: Icons.settings,
                        title: "Settings",
                      ),
                      MenuItem(
                        icon: Icons.exit_to_app,
                        title: "Logout",
                      ),
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment(0.0, -0.9),
                child: GestureDetector(
                  onTap: (){
                    onIconPressed();
                  },
                  child: ClipPath(
                    clipper: CustomMenuClipper(),
                    child: Container(
                      width: 35,
                      height: 110,
                      color: Color(0xFF262AAA),
                      alignment: Alignment.centerLeft,
                      child: AnimatedIcon(
                        progress: _animationController,
                        icon: AnimatedIcons.menu_close,
                        color: Color(0xFF1BB5FD),
                        size: 25,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        );
      }
    );
  }

  void onIconPressed() {
    final animationStatus = _animationController.status;
    final isAnimationComplete = animationStatus == AnimationStatus.completed;

    if(isAnimationComplete){
      isSidebarOpenedSink!.add(false);
      _animationController.reverse();
    }else{
      isSidebarOpenedSink!.add(true);
      _animationController.forward();
    }
  }
}
class CustomMenuClipper extends CustomClipper<Path>{
  @override
  Path getClip(Size size) {
    Paint paint = Paint();
    paint.color = Colors.white;
    final width = size.width;
    final height = size.height;

    Path path = Path();
    path.moveTo(0, 0);
    path.quadraticBezierTo(0, 8, 10, 16);
    path.quadraticBezierTo(width - 1, height / 2 - 20, width, height / 2);
    path.quadraticBezierTo(width + 1, height / 2 + 20, 10, height - 16);
    path.quadraticBezierTo(0, height - 8, 0, height);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
   return true;
  }

}

