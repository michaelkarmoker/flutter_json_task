import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_json_task/data/staticData.dart';
import 'package:flutter_json_task/model/androidVerison.dart';
import 'package:flutter_json_task/view/base/custom_button.dart';
import 'package:flutter_json_task/view/base/grid_list.dart';

class HomeScreen extends StatefulWidget {
   HomeScreen({Key? key}) : super(key: key);


  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //controller and focus of search input field
  TextEditingController searchEdtCtr=new TextEditingController();
  FocusNode searchEdtFcs=new FocusNode();

//list from json data
   List<AndroidVerison> outPutList=[];
   //search result variable
   AndroidVerison? searchResult=null;


  @override
  Widget build(BuildContext context) {

    return Scaffold(
       appBar: AppBar(title: Text("Flutter JSON Task"),),
        body: SafeArea(child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 30,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  CustomButton(buttonText: "Output1", onTap: ()  {

                    setState((){
                      outPutList= jsonParser(StaticData.input1);
                    });
                  },),
                CustomButton(buttonText: "Output 2", onTap: ()  {

                  setState((){
                    outPutList= jsonParser(StaticData.input2);
                  });

                })
                ],
              ),
              SizedBox(height: 20,),

              outPutList.length>0?GridList(outPut:outPutList ):Container(),
              SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: searchEdtCtr,
                        focusNode:searchEdtFcs ,
                        decoration: InputDecoration(
                          contentPadding:EdgeInsets.only(top:16,bottom:16,left: 10),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(3),
                            borderSide: BorderSide(style: BorderStyle.none, width: 1),
                          ),
                          isDense: true,
                          hintText: "Enter version Id",
                          fillColor: Theme.of(context).cardColor,
                          hintStyle: TextStyle(fontSize: 14, color: Theme.of(context).hintColor),
                          filled: true,
                        ),
                      ),
                    ),
                    SizedBox(width: 10,),

                    CustomButton(buttonText: "Search", onTap:  ()  {
                      if(searchEdtCtr.text.toString().isNotEmpty){
                        setState((){
                          searchResult=getResultBySearch(int.parse(searchEdtCtr.text));
                          if(searchResult==null){
                            final snackBar = SnackBar(
                              content: const Text('Not Found this id ,Please try again'),
                              backgroundColor: (Colors.red),
                              action: SnackBarAction(
                                label: 'dismiss',
                                onPressed: () {
                                },
                              ),
                            );
                            ScaffoldMessenger.of(context).showSnackBar(snackBar);
                          }
                        });
                      }else{
                        final snackBar = SnackBar(
                          content: const Text('Please Enter Version id'),
                          backgroundColor: (Colors.red),
                          action: SnackBarAction(
                            label: 'dismiss',
                            onPressed: () {
                            },
                          ),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }


                    }),
                    

                  ],
                ),
              ),
              searchResult!=null?Card(
                elevation: 3,
                child: Container(

                  padding: EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                         Text("Id:",style: TextStyle(color: Theme.of(context).primaryColor,fontWeight:FontWeight.bold ),),
                         SizedBox(width: 10,),
                         Text("${searchResult!.id.toString()}")
                      ],),
                      SizedBox(height: 10,),
                      Row(children: [
                        Text("Title:",style: TextStyle(color: Theme.of(context).primaryColor,fontWeight:FontWeight.bold )),
                        SizedBox(width: 10,),
                        Text("${searchResult!.title.toString()}")
                      ],),
                    ],
                  ),
                ),
              ):Container()
            ],
          ),
        )));
  }

//Function of json parser
  List<AndroidVerison> jsonParser(String input){
    List<AndroidVerison> outPut=[];

    final parsedJson = jsonDecode(input);
    for(int i=0;i<parsedJson.length;i++){
      print(parsedJson[i].runtimeType);
      if(parsedJson[i].runtimeType==List<dynamic>){
        print("test");
        List<dynamic> dataList=parsedJson[i];
        for(int i=0;i<dataList.length;i++){
          var item=dataList[i];
          outPut.add(new AndroidVerison(id:item["id"],title:item["title"]));
        }
      }else{
        var data=parsedJson[i];
        for(int i=0;i<4;i++){
          if(data[i.toString()]!=null){
            outPut.add(new AndroidVerison(id:data[i.toString()]["id"],title:data[i.toString()]["title"]));
          }else{
            outPut.add(new AndroidVerison(id:null,title:null));
          }
        }
      }
    }
    return outPut;
  }


//Function of searching by id
  AndroidVerison? getResultBySearch(int id){
    AndroidVerison? result=null;
       if(outPutList.length>0){
         outPutList.map((e) {
           if(e.id==id){
            return result= new AndroidVerison(id: e.id,title: e.title);

           }
         }).toList();
       }
       return result;
  }



}
