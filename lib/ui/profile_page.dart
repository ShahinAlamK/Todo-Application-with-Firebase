import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:todo_application/widgets/loading_widget.dart';
import '../models/user_model.dart';
import '../providers/profile_provider.dart';


class ProfilePage extends StatefulWidget {

  const ProfilePage({Key? key,
    required this.uid,
    required this.username,
    required this.profile
  }) : super(key: key);
  final String uid,username,profile;


  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {


  final _formKey=GlobalKey<FormState>();
  String?username;
  String?profile;
  String? image;
  bool isLoading=false;


  @override
  void initState() {
    username=widget.username;
    profile=widget.profile;

    super.initState();
  }
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
      if (profile!.isEmpty) {
        return AssetImage('assets/image/placeholder.png');
      } else {
        return NetworkImage(widget.profile);
      }
    } else {
      return FileImage(file!);
    }
  }

  final storageRef = FirebaseStorage.instance.ref();
  Future<String> uploadProfilePicture(File imageFile) async {
    String uniquePhotoId = DateTime.now().microsecondsSinceEpoch.toString();

    UploadTask uploadTask = storageRef
        .child('images/users/userProfile_$uniquePhotoId.jpg')
        .putFile(imageFile);
    TaskSnapshot taskSnapshot = await uploadTask.whenComplete((){});
    String downloadUrl = await taskSnapshot.ref.getDownloadURL();
    return downloadUrl;
  }


  _update()async{
    if(_formKey.currentState!.validate()){
      setState(()=>isLoading=true);
      String profilePictureUrl = '';
      if(file==null){
        profilePictureUrl=profile!;
      }
      else{
        profilePictureUrl = await uploadProfilePicture(file!);
      }

      UserModel userModel=UserModel(
          uid:widget.uid,
          name: username,
          profile: profilePictureUrl
      );
      Provider.of<ProfileProvider>(context,listen: false).updateProfile(userModel)
          .whenComplete(()=> setState(()=>isLoading=false));
    }
  }


  @override
  Widget build(BuildContext context) {
    return  OverLoading(
      isLoading:isLoading,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          title: const Text("Profile"),
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

                      Form(
                        key:_formKey,
                        child: TextFormField(
                          initialValue:username,
                          onChanged: (val){
                            username=val;
                          },
                          decoration: const InputDecoration(
                              hintText: "Username",
                              filled: true,
                              border: InputBorder.none
                          ),
                        ),
                      ),

                      const SizedBox(height:30,),


                    ],
                  ),
                ),
              ),


              ElevatedButton(onPressed:(){
                _update();
              },style:Theme.of(context).elevatedButtonTheme.style, child:const Text("Update"))
            ],
          ),
        ),
      ),
    );
  }
}
