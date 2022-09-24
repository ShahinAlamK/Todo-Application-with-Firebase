import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:todo_application/utilities/constant.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {




  File?file;

  ImagePicker imagePicker=ImagePicker();

  _imagePick()async{
    final pick=await imagePicker.pickImage(source:ImageSource.gallery);
    if(pick!=null){
      setState(() {
        file=File(pick.path.toString());
      });
    }
  }


  displayProfileImage() {
    if (file == null) {
        return const AssetImage('assets/image/placeholder.png');
    } else {
      return FileImage(file!);
    }
  }




  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text("Profile"),
      ),

      body:Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [

            const SizedBox(height:50),

            Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(50),
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image:displayProfileImage()
                  )
              ),
            ),
            const SizedBox(height: 30,),

            Center(child: GestureDetector(
              onTap: (){
                _imagePick();
              },
              child: Text("Choose image",style:Theme.of(context).textTheme.bodyText1
                ,),
            )),

            const SizedBox(height:40,),

            Container(
              margin: const EdgeInsets.symmetric(horizontal: 30),
              child: Form(
                child: Column(
                  children: [

                    TextFormField(
                      onChanged: (val){
                      },
                      decoration: const InputDecoration(
                          hintText: "Username",
                          filled: true,
                          border: InputBorder.none
                      ),
                    ),

                    const SizedBox(height:30,),


                  ],
                ),
              ),
            ),
            
            
            ElevatedButton(onPressed:(){},style:Theme.of(context).elevatedButtonTheme.style, child:const Text("Update"))
          ],
        ),
      ),
    );
  }
}
