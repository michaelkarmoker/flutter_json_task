import 'package:flutter/material.dart';
import 'package:flutter_json_task/model/androidVerison.dart';

class GridList extends StatelessWidget {
   GridList({Key? key, required this.outPut}) : super(key: key);
  final List<AndroidVerison> outPut;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          border: Border.all(width: 1,color: Colors.black)
        ),
        child: GridView.builder(

          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,

            crossAxisSpacing: 4,
            childAspectRatio: (2),
          ),
          itemCount:outPut.length,
          physics: BouncingScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (context, index) {
            print(outPut[index].id);
            return Container(
              child:Text(outPut[index].title??"",style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),) ,
            );
          },
        ),
      ),
    );
  }
}
