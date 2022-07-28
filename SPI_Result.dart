// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:gtu_marks/pages/HomePage.dart';
import 'package:hexcolor/hexcolor.dart';

class SPI_Result extends StatefulWidget {
  //here we getting data from SPI.dart page
  //here we using dynamic because we perfrom various operraion on list....
  List<String> SubCreaditList = [];
  List<String> MID_I_MarksList = [];
  List<String> MID_II_MarksList = [];
  List<String> GtuMarksList = [];
  List<String> InternalMarksList = [];
  late int getSubjectNumber;


  //constructor
  //here all the user data comes from SPI.dart page
  SPI_Result({
    Key? key,
    required this.SubCreaditList,
    required this.MID_I_MarksList,
    required this.MID_II_MarksList,
    required this.GtuMarksList,
    required this.InternalMarksList,
    required this.getSubjectNumber,
    // required this.SPI,
  }) : super(key: key);

  @override
  State<SPI_Result> createState() => _SPI_ResultState();
}

class _SPI_ResultState extends State<SPI_Result> {
  //variable
  double SPI = 0.0;

  //one method for all calculation
  Widget FinalSPI() {
    //convert all list into String to int
    List<int> GetSubCreaditList = widget.SubCreaditList.map(int.parse).toList();
    List<int> GetMidIMarksList = widget.MID_I_MarksList.map(int.parse).toList();
    List<int> GetMidIIMarksList =
        widget.MID_II_MarksList.map(int.parse).toList();
    List<int> GetGTUMarksList = widget.GtuMarksList.map(int.parse).toList();
    List<int> GetInternalMarkList =
        widget.InternalMarksList.map(int.parse).toList();

//****************************************************************************************** */
    //final list
    //for mid-1 marks converte
    List<num> ConvertedMidIMarks = [];

    //for mid-2 marks converte
    List<num> ConvertedMidIIMarks = [];

    //final mid mark out of 30 (combine of both mid)
    List<num> finalMidMarks = [];

    //store addition of all 3 [gtumarks + mid marks + internal marks]
    List<num> addition = [];

    //totalmarks out of 100
    List<num> TotalMarkList = [];

    //for store Gread Point
    List<int> GreadPoint = [];

    //for Greadpoint * Subject Creadit
    List<num> Multiply = [];

    //for Total Subject Creadit
    double TotalSubCreadit = 0.0;

    //for Total Earned Point (additon of (Gread point * Subject Creadit) )
    double TotalEarnedPoint = 0.0;

//********************************************************************************************** */

    //All calculation

    //for convert mid-1 & mid-2 mark in to 70 to 15
    for (int i = 0; i < widget.getSubjectNumber; i++) {
      ConvertedMidIMarks[i] = (GetMidIMarksList[i] * 15) / 70;
      ConvertedMidIIMarks[i] = (GetMidIIMarksList[i] * 15) / 70;
    }

    //final mid mark --> convcerted mid-1 + convaerted mid-2  (15 + 15 = 30)
    for (int i = 0; i < widget.getSubjectNumber; i++) {
      finalMidMarks[i] = ConvertedMidIMarks[i] + ConvertedMidIIMarks[i];
    }

    //addition of all 3 list GTU + Internal + Mid --> (70 + 50 + 30 = 150)
    for (int i = 0; i < widget.getSubjectNumber; i++) {
      addition[i] =
          finalMidMarks[i] + GetGTUMarksList[i] + GetInternalMarkList[i];
    }

    //convert this 150 marks into 100
    for (int i = 0; i < widget.getSubjectNumber; i++) {
      TotalMarkList[i] = (addition[i] * 100) / 150;
    }

    /* Gtu Gread System
  
  Marks       --   Gread    -- Gread Point

  85-100            AA           10
  75-84             AB           9
  65-74             BB           8
  55-64             BC           7
  45-54             CC           6
  40-44             CD           5
  35-39             DD           4
  <35               FF           0
*/

    //get Gread Point According to Total Marks
    for (int i = 0; i < widget.getSubjectNumber; i++) {
      //store gread point
      if (85 <= TotalMarkList[i] || TotalMarkList[i] <= 100) {
        GreadPoint[i] = 10;
      } else if (75 <= TotalMarkList[i] || TotalMarkList[i] <= 84) {
        GreadPoint[i] = 9;
      } else if (65 <= TotalMarkList[i] || TotalMarkList[i] <= 74) {
        GreadPoint[i] = 8;
      } else if (55 <= TotalMarkList[i] || TotalMarkList[i] <= 64) {
        GreadPoint[i] = 7;
      } else if (45 <= TotalMarkList[i] || TotalMarkList[i] <= 54) {
        GreadPoint[i] = 6;
      } else if (40 <= TotalMarkList[i] || TotalMarkList[i] <= 44) {
        GreadPoint[i] = 5;
      } else if (35 <= TotalMarkList[i] || TotalMarkList[i] <= 39) {
        GreadPoint[i] = 4;
      } else {
        GreadPoint[i] = 0;
      }
    }

    //multiply Subject Creadit  & Gread Point
    for (int i = 0; i < widget.getSubjectNumber; i++) {
      Multiply[i] = GetSubCreaditList[i] * GreadPoint[i];
    }

    //for total Subject creadit
    for (int i = 0; i < widget.getSubjectNumber; i++) {
      TotalSubCreadit = TotalSubCreadit + GetSubCreaditList[i];
    }

    //for Total Earned Point (additon of (Gread point * Subject Creadit) )
    for (int i = 0; i < widget.getSubjectNumber; i++) {
      TotalEarnedPoint = TotalEarnedPoint + Multiply[i];
    }
    //get Final result
    double getResult = (TotalEarnedPoint / TotalSubCreadit);

    return GestureDetector(
      onTap: () {
        setState(() {
          SPI = getResult;
        });
      },
    );
  }

//**************************************************************************** */
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor("#242E38"),
      body: SafeArea(
        child: Column(
          children: [
            //for image
            Container(
              margin: EdgeInsets.only(top: 50, left: 35, right: 40),
              // height: 310,
              // width: 200,
              // color: Colors.white,
              child: Image.asset(
                "assets/images/SPI_Result.png",
                height: 310,
              ),
            ),

            //circule box
            Container(
              margin: EdgeInsets.only(left: 17, top: 25),

              width: 200,
              height: 200,
              decoration: BoxDecoration(
                color: HexColor("#3D5A80"),
                shape: BoxShape.circle,
              ),

              //for SPI text and getting Result
              child: Column(
                children: [
                  //for Geeting SPI Result
                  Container(
                    padding: EdgeInsets.only(left: 3, top: 40),
                    child: Text(
                      "$SPI",
                      style: TextStyle(
                          fontFamily: "RobotoSlab",
                          color: HexColor("#EE6C4D"),
                          fontSize: 50,
                          fontWeight: FontWeight.bold,
                          shadows: const [
                            Shadow(color: Colors.black, blurRadius: 12)
                          ]),
                    ),
                  ),

                  //for SPI text
                  Container(
                    padding: EdgeInsets.only(left: 3, top: 6),
                    child: Text(
                      "SPI",
                      style: TextStyle(
                          fontFamily: "RobotoSlab",
                          color: HexColor("#EE6C4D"),
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          shadows: const [
                            Shadow(color: Colors.black, blurRadius: 12)
                          ]),
                    ),
                  ),
                ],
              ),
            ),

            //for home button
            Container(
              margin: EdgeInsets.only(top: 30, left: 15),

              height: 48,
              width: 95,
              // color: Colors.white,
              child: TextButton(
                // //goto SPI Page
                // onPressed: () {
                //   Navigator.push(context,
                //       MaterialPageRoute(builder: (context) => HomePage()));
                // },

                onPressed: () {},
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(HexColor("#EE6C4D")),

                  //for circular border radius for button
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                  ),
                ),

                //for button text
                child: const Text(
                  "Home",
                  style: TextStyle(
                    letterSpacing: 0.4,
                    fontFamily: "RobotoSlab",
                    fontSize: 24,
                    color: Colors.black,
                    shadows: [
                      Shadow(
                        color: Colors.white,
                        blurRadius: 8,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
