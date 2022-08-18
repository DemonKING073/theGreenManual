import 'package:flutter/material.dart';

import '../../constants/constant.dart';

class ProjectDetails extends StatelessWidget {
  const ProjectDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        title: Text(
          'Project Name',
          style: LBoldTextStyle(),
        ),
        actions: [
          IconButton(onPressed: (){}, icon: Icon(Icons.bookmark, color: primaryColor,))
        ],
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              child: Row(
                children: [
                  InkWell(
                    onTap: () {},
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 10),
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text('Assembly/Set up',
                          style:
                              kBoldTextStyle().copyWith(color: Colors.black)),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  InkWell(
                    onTap: () {},
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 10),
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text('Section 2',
                          style:
                              kBoldTextStyle().copyWith(color: Colors.black)),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  InkWell(
                    onTap: () {},
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 10),
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text('Section 3',
                          style:
                              kBoldTextStyle().copyWith(color: Colors.black)),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  InkWell(
                    onTap: () {},
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 10),
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text('Section 4',
                          style:
                              kBoldTextStyle().copyWith(color: Colors.black)),
                    ),
                  ),
                ],
              ),
            ),
            LSizedBox(),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 2,
                      blurRadius: 1,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: MediaQuery.of(context).size.height*0.04),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text('Assembly/SetUp', style: LBoldTextStyle().copyWith(fontWeight: FontWeight.w600),),
                      ],
                    ),
                    kSizedBox(),
                    Text('Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s', style: kTextStyle(),),
                    LSizedBox(),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          Image.asset('assets/images/anime1.jpeg', width: MediaQuery.of(context).size.width*0.4,),
                          SizedBox(width: 10,),
                          Image.asset('assets/images/anime1.jpeg', width: MediaQuery.of(context).size.width*0.4,),
                          SizedBox(width: 10,),
                          Image.asset('assets/images/anime1.jpeg', width: MediaQuery.of(context).size.width*0.4,),
                    
                        ],
                      ),
                    ),
                    LSizedBox(),
                     Row(
                      children: [
                        Text('Assembly/SetUp', style: LBoldTextStyle().copyWith(fontWeight: FontWeight.w600),),
                      ],
                    ),
                    kSizedBox(),
                    Text('Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s', style: kTextStyle(),),
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
