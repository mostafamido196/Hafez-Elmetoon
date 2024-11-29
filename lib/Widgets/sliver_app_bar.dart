import 'package:flutter/material.dart';

class SliverAppBarBldr extends StatelessWidget {
  const SliverAppBarBldr({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      elevation: 0,
      pinned: false,
      centerTitle: false,
      stretch: true,
      expandedHeight: 200.0,
      flexibleSpace: FlexibleSpaceBar(
        stretchModes: [StretchMode.zoomBackground],
        background: Stack(
          fit: StackFit.expand,
          children: [
            // Background image
            Container(
              margin: EdgeInsets.all(4,),  // Adjust the margin as needed
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(32.0),  // Adjust the radius as needed
                image: DecorationImage(
                  image: AssetImage('assets/Images/yellow.jpeg'),
                  fit: BoxFit.cover,
                ),
              ),
              width: double.infinity,  // You can adjust width if needed
              height: 200.0,  // You can adjust the height as needed
            ),
            // Overlayed text
            Center(
              child: Container(
                padding: EdgeInsets.all(16.0),
                color: Colors.black.withOpacity(0), // semi-transparent background
                child:  Text(
                  "لا تحسبن المجد تمرا أنت آكله \n لن تبلغ المجد حتى تلعق الصبرا",
                  textAlign: TextAlign.center,
                  style:Theme.of(context).textTheme.headlineMedium ,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

}
