import 'package:flutter/material.dart';

class LiteriaHubHomePage extends StatefulWidget {
  const LiteriaHubHomePage({super.key});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<LiteriaHubHomePage> {

  Color lightBlue = Color(0xffdbf0f1);
  Color darkBlue = Color(0xff39888e);
  Color yellow = Color(0xffffe9a7);
  Color pink = Color(0xfff1e7f5);

 @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightBlue,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Image.asset('assets/images/literalogo.jpg'),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment:  MainAxisAlignment.start,
          children: [
            Text("Sudhir Patil", style: TextStyle(
                    fontSize: 14,
                    fontFamily: 'circe'
                  ),),
                  Text("Class 2", style: TextStyle(
                      fontSize: 10,
                      fontFamily: 'circe',
                      fontWeight: FontWeight.w700
                  ),),
          ],
          ),
        actions: [
          IconButton(
            onPressed: (){},
            icon: Icon(
              Icons.notifications_none,
              color: Colors.black,
              size: 30,
            ),
          )
        ],
      ),
      body: Column(
        children: [
          // Container(
          //   height: MediaQuery.of(context).size.height*0.1,
          //   width: MediaQuery.of(context).size.width,
          //   child: Container(
          //     padding: EdgeInsets.all(20),
          //     child: Column(
          //       crossAxisAlignment: CrossAxisAlignment.start,
          //       children: [
                  
          //       ],
          //     ),
          //   ),
          // ),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(30),
              width: MediaQuery.of(context).size.width,
              color: Colors.white,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Top Rated Tutors", style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600
                      ),),
                      Text("See all", style: TextStyle(
                        color: Colors.blueAccent,
                        fontSize: 13
                      ),)
                    ],
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          tutorWidget("boy1Big", "Mr. Pater Parker", "English", "0-6", "150"),
                          tutorWidget("girl", "Ms. Leena Dey", "Arts & Crafts", "0-4", "100"),
                          tutorWidget("boy2", "Mr. Jason Shrute", "Math", "0-2", "100"),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
  InkWell tutorWidget(String img, String name, String subj, String grade, String price)
  {
    return InkWell(
      onTap: (){},
      child: Container(
        margin: EdgeInsets.only(top: 20),
        height: 130,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(30)),
          color: lightBlue.withOpacity(0.5)
        ),
        child: Row(
          children: [
            Container(
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(30)),
                    child: Container(
                      height: 125,
                      width: 150,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('asset/images/iconBgNew.png'),
                          fit: BoxFit.contain
                        )
                      ),
                    ),
                  ),
                  Container(
                    height: 130,
                    padding: EdgeInsets.only(left: 5, top: 5),
                    child: Stack(
                      children: [
                        Container(
                          width: 60,
                          height: 60,
                          child: RotatedBox(
                            quarterTurns: 2,
                            child: Icon(
                              Icons.star,
                              color: darkBlue,
                              size: 60,
                            ),
                          ),
                        ),
                        Container(
                          width: 60,
                          height: 60,
                          child: Center(
                            child: Text("4.5", style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w700,
                              color: Colors.white
                            ),),
                          ),
                        )
                      ],
                    ),
                  ),
                  Positioned(
                    left: 50,
                    child: Hero(
                      tag: img,
                      child: Container(
                        width: 100,
                        height: 130,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('asset/images/$img.png'),
                            fit: BoxFit.cover
                          )
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                       Text("GRADE $grade",style: TextStyle(
                         fontSize: 10,
                         color: Colors.grey
                       ),)
                      ],
                    ),
                    SizedBox(height: 5,),
                    Text(name, style: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.w700
                    ),),
                    Text('$subj Teacher', style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: darkBlue
                    ),),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("\$$price/session",style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500
                          ),)
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}