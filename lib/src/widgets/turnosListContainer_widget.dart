import 'package:flutter/material.dart';

class ListContainerTurnos extends StatelessWidget {
  final _controller = ScrollController();
  final List<Widget> lstContainers;
  ListContainerTurnos(this.lstContainers);
  @override
  Widget build(BuildContext context) {
    return Column(
          children: [
            Container(
              margin: EdgeInsets.only(left: 5,right: 5),
              height: MediaQuery.of(context).size.height / 8,
              child: ListView(
                controller: _controller,
                scrollDirection: Axis.horizontal,
                children: lstContainers,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children :[
                IconButton(icon: Icon(Icons.arrow_back), onPressed: (){
                  _controller.animateTo(
                    _controller.position.minScrollExtent,
                    duration: Duration(seconds: 1),
                    curve: Curves.fastOutSlowIn,
                  );
                }),
                Text('Deslizá o usá las flechas'),
                IconButton(icon: Icon(Icons.arrow_forward),onPressed: () {
                  _controller.animateTo(
                    _controller.position.maxScrollExtent,
                    duration: Duration(seconds: 1),
                    curve: Curves.fastOutSlowIn,
                  );
                })
              ]
            )
          ],
        );
  }
}