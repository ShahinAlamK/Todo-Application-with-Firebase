import 'package:flutter/material.dart';
import 'package:todo_application/utilities/size_config.dart';

import '../models/developer_model.dart';


class DeveloperInfoDialog extends StatelessWidget {
  const DeveloperInfoDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme=Theme.of(context);
    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 55),
      child: Container(
        height:250,
        decoration:BoxDecoration(
          color:theme.scaffoldBackgroundColor,
          borderRadius: BorderRadius.circular(7),
        ),
        child: Stack(
          alignment: Alignment.center,
          clipBehavior: Clip.none,
          children: [
            Positioned(
                top: -50,
                child:CircleAvatar(radius: sizeConfig.screenHeight!*.06,
                  backgroundColor: theme.colorScheme.secondary,backgroundImage: NetworkImage(developer.pic!),)),

            Container(
              padding: const EdgeInsets.all(20),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height:35),

                    Center(child: Text(developer.name!,
                        style:Theme.of(context).textTheme.headline6!.copyWith(
                            fontSize:sizeConfig.screenSizeHorizontal!*4
                        )
                    )),

                    const SizedBox(height:25),

                    Text("Email : ${developer.email}",
                      style:Theme.of(context).textTheme.bodyText2!.copyWith(
                        fontSize:sizeConfig.screenSizeHorizontal!*4
                    ),),

                    const SizedBox(height: 6,),

                    Text("professional : ${developer.professional}",
                        style:Theme.of(context).textTheme.bodyText2!.copyWith(
                            fontSize:sizeConfig.screenSizeHorizontal!*4
                        )
                    ),
                    const SizedBox(height:6),
                    Text("Address : ${developer.address}",
                        style:Theme.of(context).textTheme.bodyText2!.copyWith(
                            fontSize:sizeConfig.screenSizeHorizontal!*4
                        )
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}