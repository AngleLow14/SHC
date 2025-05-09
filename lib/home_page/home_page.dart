import 'package:flutter/material.dart';
import 'package:shc/login_page/login_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:shc/patient_page/patient_page.dart';
import 'package:shc/appointment_page/appointment_page.dart';
import 'package:shc/heat_map/heat_map.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<Dashboard> {
  final supabase = Supabase.instance.client;
  int maleCount = 0;
  int femaleCount = 0;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchSexDistribution();
  }

  Future<void> fetchSexDistribution() async {
    final data = await supabase
        .from('patient')
        .select('sex');

    setState(() {
      maleCount = data.where((item) => item['sex'] == 'Male').length;
      femaleCount = data.where((item) => item['sex'] == 'Female').length;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Color.fromARGB(255, 255, 245, 245),
          height: screenHeight * 1,
          width: screenWidth * 1,
          child: Column(
            children: [
              Expanded(
                child: Row(
                  children: [
                    Column(
                      children: [
                        Container(
                          color: const Color.fromARGB(255, 255, 251, 251),
                          height: screenHeight * 1,
                          width: screenWidth * 0.20,
                          child: Column(
                            children: [
                              SizedBox(height: screenHeight * 0.05),
                              Container(
                                height: screenHeight * 0.2,
                                width: screenWidth * 0.2,
                                padding: EdgeInsets.all(8.0),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.grey,
                                ),
                                child: CircleAvatar(
                                  radius: 30,
                                  backgroundColor: Colors.transparent,
                                ),
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.03,
                              ),
                              Center(
                                child: Text(
                                  'San Pablo Social Hygiene Clinic',
                                  softWrap: true,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 25,
                                    fontFamily: 'OpenSansEB',
                                    color: Color.fromARGB(255, 182, 8, 37),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.03,
                              ),
                              Center(
                                child: SizedBox(
                                  height: screenHeight * 0.05,
                                  width: screenWidth * 0.13,
                                  child: TextButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => Dashboard(),
                                        ),
                                      );
                                    },
                                    child: Text(
                                      'Dashboard',
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontFamily: 'OpenSansEB',
                                        fontWeight: FontWeight.bold,
                                        color: Color.fromARGB(255, 0, 0, 0),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: screenHeight * 0.02),
                              Center(
                                child: SizedBox(
                                  height: screenHeight * 0.05,
                                  width: screenWidth * 0.13,
                                  child: TextButton(
                                    onPressed: () {Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(builder: (context) => PatientsPage())
                                    );},
                                    child: Text(
                                      'Patients',
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontFamily: 'OpenSansLight',
                                        fontWeight: FontWeight.bold,
                                        color: Color.fromARGB(255, 43, 43, 43),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: screenHeight * 0.02),
                              Center(
                                child: SizedBox(
                                  height: screenHeight * 0.05,
                                  width: screenWidth * 0.13,
                                  child: TextButton(
                                    onPressed: () {Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(builder: (context) => AppointmentPage())
                                    );},
                                    child: Text(
                                      'Appointments',
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontFamily: 'OpenSansLight',
                                        fontWeight: FontWeight.bold,
                                        color: Color.fromARGB(255, 43, 43, 43),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: screenHeight * 0.20),
                              SizedBox(
                                  height: screenHeight * 0.05,
                                  width: screenWidth * 0.13,
                                child: TextButton(
                                  onPressed: () {
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(builder: (context) => AdminLoginPage())
                                    );
                                  },
                                  child: Text(
                                    'Log Out',
                                    style: TextStyle(
                                      fontFamily: 'OpenSansLight',
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                      color: Color.fromARGB(255, 43, 43, 43),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(width: screenWidth * 0.05),
                    SingleChildScrollView(
                      child: Container(
                        color: Color.fromARGB(255, 255, 245, 245),
                        height: screenHeight,
                        width: screenWidth * 0.7,
                        child: Column(
                          children: [
                            SizedBox(
                              height: screenHeight * 0.02,
                              width: screenWidth * 0.03,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Dashboard',
                                  style: TextStyle(
                                    fontFamily: 'OpenSansEB',
                                    fontSize: 30,
                                    color: Color.fromARGB(255, 182, 8, 37),
                                  ),
                                ),

                                SizedBox(
                                  height: screenHeight * 0.06,
                                  width: screenWidth * 0.2,
                                  child: TextField(
                                    style: TextStyle(fontSize: 15),
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Colors.white,
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(
                                          10.0,
                                        ),
                                      ),
                                      hintText: 'Search...',
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: screenHeight * 0.05),
                            SingleChildScrollView(
                              child: Container(
                                child: Row(
                                  children: [
                                    Column(
                                      children: [
                                        Row(
                                          children: [
                                            Container(
                                              height: screenHeight * 0.30,
                                              width: screenWidth * 0.16,
                                              color: Colors.white,
                                              child: Column(
                                                children: [
                                                  SizedBox(
                                                    height: screenHeight * 0.02,
                                                  ),
                                                  Text(
                                                    'STD Cases',
                                                    textAlign: TextAlign.left,
                                                    style: TextStyle(
                                                      fontSize: 25,
                                                      fontFamily: 'OpenSansSB',
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: screenHeight * 0.02,
                                                  ),
                                                  Text(
                                                    '86',
                                                    style: TextStyle(
                                                      fontSize: 50,
                                                      fontFamily: 'OpenSansEB',
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(width: screenWidth * 0.01),
                                            Container(
                                              height: screenHeight * 0.30,
                                              width: screenWidth * 0.16,
                                              color: Colors.white,
                                              child: Column(
                                                children: [
                                                  SizedBox(
                                                    height: screenHeight * 0.02,
                                                  ),
                                                  Text(
                                                    'Sex',
                                                    style: TextStyle(
                                                      fontSize: 25,
                                                      fontFamily: 'OpenSansSB',
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: screenHeight * 0.03,
                                                  ),
                                                  Row(
                                                    children: [
                                                      SizedBox(
                                                        width:
                                                            screenWidth * 0.02,
                                                      ),
                                                      Text(
                                                        'Male',
                                                        style: TextStyle(
                                                          fontSize: 15,
                                                          fontFamily:
                                                              'OpenSansLight',
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),

                                                      SizedBox(
                                                        width:
                                                            screenWidth * 0.07,
                                                      ),
                                                      Text(
                                                        '$maleCount',
                                                        style: TextStyle(
                                                          fontSize: 15,
                                                          fontFamily:
                                                              'OpenSansLight',
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: screenHeight * 0.03,
                                                  ),
                                                  Row(
                                                    children: [
                                                      SizedBox(
                                                        width:
                                                            screenWidth * 0.02,
                                                      ),
                                                      Text(
                                                        'Female',
                                                        style: TextStyle(
                                                          fontSize: 15,
                                                          fontFamily:
                                                              'OpenSansLight',
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),

                                                      SizedBox(
                                                        width:
                                                            screenWidth * 0.06,
                                                      ),
                                                      Text(
                                                        '$femaleCount',
                                                        style: TextStyle(
                                                          fontSize: 15,
                                                          fontFamily:
                                                              'OpenSansLight',
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: screenHeight * 0.02),
                                        Column(
                                          children: [
                                            Container(
                                              height: screenHeight * 0.45,
                                              width: screenWidth * 0.33,
                                              color: Colors.white,
                                              child: GestureDetector(
                                                onTap: () {
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(builder: (context) => HeatMap())
                                    );
                                  },
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    SizedBox(
                                                      height:
                                                          screenHeight * 0.005,
                                                    ),
                                                    Image.asset(
                                                      'assets/icon/assessment.PNG',
                                                      height: screenHeight * 0.42,
                                                      width: screenWidth * 0.32,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    SizedBox(width: screenWidth * 0.02),
                                    Row(
                                      children: [
                                        Column(
                                          children: [
                                            Container(
                                              height: screenHeight * 0.40,
                                              width: screenWidth * 0.16,
                                              color: Colors.white,
                                              child: Column(
                                                children: [
                                                  SizedBox(
                                                    height: screenHeight * 0.02,
                                                  ),
                                                  Text(
                                                    'Age Group',
                                                    style: TextStyle(
                                                      fontFamily: 'OpenSansSB',
                                                      fontSize: 25,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: screenHeight * 0.01,
                                                  ),
                                                  Row(
                                                    children: [
                                                      SizedBox(
                                                        width:
                                                            screenWidth * 0.03,
                                                      ),
                                                      Text(
                                                        'Children',
                                                        style: TextStyle(
                                                          fontFamily:
                                                              'OpenSansLight',
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width:
                                                            screenWidth * 0.05,
                                                      ),
                                                      Text(
                                                        '1',
                                                        style: TextStyle(
                                                          fontFamily:
                                                              'OpenSansLight',
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      SizedBox(
                                                        width:
                                                            screenWidth * 0.03,
                                                      ),
                                                      Text(
                                                        'Youth',
                                                        style: TextStyle(
                                                          fontFamily:
                                                              'OpenSansLight',
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width:
                                                            screenWidth * 0.06,
                                                      ),
                                                      Text(
                                                        '25',
                                                        style: TextStyle(
                                                          fontFamily:
                                                              'OpenSansLight',
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      SizedBox(
                                                        width:
                                                            screenWidth * 0.03,
                                                      ),
                                                      Text(
                                                        'Adult',
                                                        style: TextStyle(
                                                          fontFamily:
                                                              'OpenSansLight',
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width:
                                                            screenWidth * 0.065,
                                                      ),
                                                      Text(
                                                        '53',
                                                        style: TextStyle(
                                                          fontFamily:
                                                              'OpenSansLight',
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      SizedBox(
                                                        width:
                                                            screenWidth * 0.03,
                                                      ),
                                                      Text(
                                                        'Senior Citizen',
                                                        style: TextStyle(
                                                          fontFamily:
                                                              'OpenSansLight',
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width:
                                                            screenWidth * 0.02,
                                                      ),
                                                      Text(
                                                        '7',
                                                        style: TextStyle(
                                                          fontFamily:
                                                              'OpenSansLight',
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: screenHeight * 0.03,
                                                  ),
                                                  Center(
                                                    child: Text(
                                                      'Children (0-14)',
                                                      style: TextStyle(
                                                        fontFamily:
                                                            'OpenSansLight',
                                                        fontSize: 10,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height:
                                                        screenHeight * 0.005,
                                                  ),
                                                  Center(
                                                    child: Text(
                                                      'Youth (15-24)',
                                                      style: TextStyle(
                                                        fontFamily:
                                                            'OpenSansLight',
                                                        fontSize: 10,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height:
                                                        screenHeight * 0.005,
                                                  ),
                                                  Center(
                                                    child: Text(
                                                      'Adults (24-59)',
                                                      style: TextStyle(
                                                        fontFamily:
                                                            'OpenSansLight',
                                                        fontSize: 10,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height:
                                                        screenHeight * 0.005,
                                                  ),
                                                  Center(
                                                    child: Text(
                                                      'Senior Citizens (60 above)',
                                                      style: TextStyle(
                                                        fontFamily:
                                                            'OpenSansLight',
                                                        fontSize: 10,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              height: screenHeight * 0.03,
                                            ),
                                            Container(
                                              height: screenHeight * 0.35,
                                              width: screenWidth * 0.16,
                                              color: Colors.white,
                                              child: Column(
                                                children: [
                                                  SizedBox(
                                                    height: screenHeight * 0.02,
                                                  ),
                                                  Center(
                                                    child: Text(
                                                      'Civil Status',
                                                      style: TextStyle(
                                                        fontFamily:
                                                            'OpenSansSB',
                                                        fontSize: 25,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                  ),
                                                  Row(
                                                    children: [
                                                      SizedBox(
                                                        width:
                                                            screenWidth * 0.02,
                                                      ),
                                                      Text(
                                                        'Single',
                                                        style: TextStyle(
                                                          fontFamily:
                                                              'OpenSansLight',
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width:
                                                            screenWidth * 0.075,
                                                      ),
                                                      Text(
                                                        '56',
                                                        style: TextStyle(
                                                          fontFamily:
                                                              'OpenSansLight',
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      SizedBox(
                                                        width:
                                                            screenWidth * 0.02,
                                                      ),
                                                      Text(
                                                        'Married',
                                                        style: TextStyle(
                                                          fontFamily:
                                                              'OpenSansLight',
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width:
                                                            screenWidth * 0.06,
                                                      ),
                                                      Text(
                                                        '10',
                                                        style: TextStyle(
                                                          fontFamily:
                                                              'OpenSansLight',
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      SizedBox(
                                                        width:
                                                            screenWidth * 0.02,
                                                      ),
                                                      Text(
                                                        'Widowed',
                                                        style: TextStyle(
                                                          fontFamily:
                                                              'OpenSansLight',
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width:
                                                            screenWidth * 0.065,
                                                      ),
                                                      Text(
                                                        '5',
                                                        style: TextStyle(
                                                          fontFamily:
                                                              'OpenSansLight',
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      SizedBox(
                                                        width:
                                                            screenWidth * 0.02,
                                                      ),
                                                      Text(
                                                        'Separated',
                                                        style: TextStyle(
                                                          fontFamily:
                                                              'OpenSansLight',
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width:
                                                            screenWidth * 0.055,
                                                      ),
                                                      Text(
                                                        '1',
                                                        style: TextStyle(
                                                          fontFamily:
                                                              'OpenSansLight',
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      SizedBox(
                                                        width:
                                                            screenWidth * 0.02,
                                                      ),
                                                      Text(
                                                        'Annulled',
                                                        style: TextStyle(
                                                          fontFamily:
                                                              'OpenSansLight',
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width:
                                                            screenWidth * 0.065,
                                                      ),
                                                      Text(
                                                        '0',
                                                        style: TextStyle(
                                                          fontFamily:
                                                              'OpenSansLight',
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      SizedBox(
                                                        width:
                                                            screenWidth * 0.02,
                                                      ),
                                                      Text(
                                                        'Live-In',
                                                        style: TextStyle(
                                                          fontFamily:
                                                              'OpenSansLight',
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.black,
                                                        ),
                                                      ),

                                                      SizedBox(
                                                        width:
                                                            screenWidth * 0.07,
                                                      ),
                                                      Text(
                                                        '13',
                                                        style: TextStyle(
                                                          fontFamily:
                                                              'OpenSansLight',
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      SizedBox(
                                                        width:
                                                            screenWidth * 0.02,
                                                      ),
                                                      Text(
                                                        'Others',
                                                        style: TextStyle(
                                                          fontFamily:
                                                              'OpenSansLight',
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.black,
                                                        ),
                                                      ),

                                                      SizedBox(
                                                        width:
                                                            screenWidth * 0.075,
                                                      ),
                                                      Text(
                                                        '1',
                                                        style: TextStyle(
                                                          fontFamily:
                                                              'OpenSansLight',
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(width: screenWidth * 0.01),
                                        Column(
                                          children: [
                                            Container(
                                              height: screenHeight * 0.75,
                                              width: screenWidth * 0.16,
                                              color: Colors.white,
                                              child: Column(
                                                children: [
                                                  SizedBox(
                                                    height: screenHeight * 0.03,
                                                  ),
                                                  Text(
                                                    'Cases Classification',
                                                    style: TextStyle(
                                                      fontFamily: 'OpenSansSB',
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 18,
                                                      color: Colors.black,
                                                    ),
                                                  ),

                                                  SizedBox(
                                                    height: screenHeight * 0.1,
                                                  ),
                                                  Center(
                                                    child: SizedBox(
                                                      height: screenHeight * 0.10,
                                                      width: screenWidth * 0.10,
                                                      child: Expanded(
                                                        child: PieChart(
                                                          PieChartData(
                                                            sectionsSpace: 1,
                                                            centerSpaceRadius:
                                                                20,
                                                            sections: [
                                                              PieChartSectionData(
                                                                color:
                                                                    Color.fromARGB(
                                                                      255,
                                                                      94,
                                                                      204,
                                                                      98,
                                                                    ),
                                                                value: 30,
                                                                radius: 50,
                                                              ),
                                                              PieChartSectionData(
                                                                color:
                                                                    Color.fromARGB(
                                                                      255,
                                                                      228,
                                                                      55,
                                                                      43,
                                                                    ),
                                                                value: 20,
                                                                radius: 50,
                                                              ),
                                                              PieChartSectionData(
                                                                color:
                                                                    Color.fromARGB(
                                                                      255,
                                                                      224,
                                                                      64,
                                                                      117,
                                                                    ),
                                                                value: 20,
                                                                radius: 50,
                                                              ),
                                                              PieChartSectionData(
                                                                color:
                                                                    Color.fromARGB(
                                                                      255,
                                                                      153,
                                                                      153,
                                                                      153,
                                                                    ),
                                                                value: 15,
                                                                radius: 50,
                                                              ),
                                                              PieChartSectionData(
                                                                color:
                                                                    Colors
                                                                        .orangeAccent,
                                                                value: 15,
                                                                radius: 50,
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: screenHeight * 0.1,
                                                  ),
                                                  Row(
                                                    children: [
                                                      SizedBox(
                                                        width:
                                                            screenWidth * 0.02,
                                                      ),
                                                      Container(
                                                        height: 15,
                                                        width: 15,

                                                        decoration:
                                                            BoxDecoration(
                                                              shape:
                                                                  BoxShape
                                                                      .circle,
                                                              color:
                                                                  Color.fromARGB(
                                                                    255,
                                                                    240,
                                                                    75,
                                                                    63,
                                                                  ),
                                                            ),
                                                        child: CircleAvatar(
                                                          radius: 20,
                                                          backgroundColor:
                                                              Colors
                                                                  .transparent,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width:
                                                            screenWidth * 0.01,
                                                      ),
                                                      Text(
                                                        'STD/STI 1',
                                                        style: TextStyle(
                                                          fontFamily:
                                                              'OpenSansLight',
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 15,
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width:
                                                            screenWidth * 0.01,
                                                      ),
                                                      Text(
                                                        '5',
                                                        style: TextStyle(
                                                          fontFamily:
                                                              'OpenSansLight',
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 15,
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                    ],
                                                  ),

                                                  SizedBox(
                                                    height: screenHeight * 0.02,
                                                  ),
                                                  Row(
                                                    children: [
                                                      SizedBox(
                                                        width:
                                                            screenWidth * 0.02,
                                                      ),
                                                      Container(
                                                        height: 15,
                                                        width: 15,
                                                        padding: EdgeInsets.all(
                                                          8.0,
                                                        ),
                                                        decoration:
                                                            BoxDecoration(
                                                              shape:
                                                                  BoxShape
                                                                      .circle,
                                                              color:
                                                                  Color.fromARGB(
                                                                    255,
                                                                    255,
                                                                    183,
                                                                    50,
                                                                  ),
                                                            ),
                                                        child: CircleAvatar(
                                                          radius: 30,
                                                          backgroundColor:
                                                              Colors
                                                                  .transparent,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width:
                                                            screenWidth * 0.01,
                                                      ),
                                                      Text(
                                                        'STD/STI 1',
                                                        style: TextStyle(
                                                          fontFamily:
                                                              'OpenSansLight',
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 15,
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width:
                                                            screenWidth * 0.01,
                                                      ),
                                                      Text(
                                                        '10',
                                                        style: TextStyle(
                                                          fontFamily:
                                                              'OpenSansLight',
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 15,
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                    ],
                                                  ),

                                                  SizedBox(
                                                    height: screenHeight * 0.02,
                                                  ),

                                                  Row(
                                                    children: [
                                                      SizedBox(
                                                        width:
                                                            screenWidth * 0.02,
                                                      ),
                                                      Container(
                                                        height: 15,
                                                        width: 15,

                                                        decoration:
                                                            BoxDecoration(
                                                              shape:
                                                                  BoxShape
                                                                      .circle,
                                                              color:
                                                                  Color.fromARGB(
                                                                    255,
                                                                    153,
                                                                    153,
                                                                    153,
                                                                  ),
                                                            ),
                                                        child: CircleAvatar(
                                                          radius: 30,
                                                          backgroundColor:
                                                              Colors
                                                                  .transparent,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width:
                                                            screenWidth * 0.01,
                                                      ),
                                                      Text(
                                                        'STD/STI 1',
                                                        style: TextStyle(
                                                          fontFamily:
                                                              'OpenSansLight',
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 15,
                                                          color: Colors.black,
                                                        ),
                                                      ),

                                                      SizedBox(
                                                        width:
                                                            screenWidth * 0.01,
                                                      ),
                                                      Text(
                                                        '22',
                                                        style: TextStyle(
                                                          fontFamily:
                                                              'OpenSansLight',
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 15,
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                    ],
                                                  ),

                                                  SizedBox(
                                                    height: screenHeight * 0.02,
                                                  ),
                                                  Row(
                                                    children: [
                                                      SizedBox(
                                                        width:
                                                            screenWidth * 0.02,
                                                      ),
                                                      Container(
                                                        height: 15,
                                                        width: 15,

                                                        decoration:
                                                            BoxDecoration(
                                                              shape:
                                                                  BoxShape
                                                                      .circle,
                                                              color:
                                                                  Color.fromARGB(
                                                                    255,
                                                                    94,
                                                                    204,
                                                                    98,
                                                                  ),
                                                            ),
                                                        child: CircleAvatar(
                                                          radius: 30,
                                                          backgroundColor:
                                                              Colors
                                                                  .transparent,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width:
                                                            screenWidth * 0.01,
                                                      ),
                                                      Text(
                                                        'STD/STI 1',
                                                        style: TextStyle(
                                                          fontFamily:
                                                              'OpenSansLight',
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 15,
                                                          color: Colors.black,
                                                        ),
                                                      ),

                                                      SizedBox(
                                                        width:
                                                            screenWidth * 0.01,
                                                      ),
                                                      Text(
                                                        '45',
                                                        style: TextStyle(
                                                          fontFamily:
                                                              'OpenSansLight',
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 15,
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                    ],
                                                  ),

                                                  SizedBox(
                                                    height: screenHeight * 0.02,
                                                  ),
                                                  Row(
                                                    children: [
                                                      SizedBox(
                                                        width:
                                                            screenWidth * 0.02,
                                                      ),
                                                      Container(
                                                        height: 15,
                                                        width: 15,

                                                        decoration:
                                                            BoxDecoration(
                                                              shape:
                                                                  BoxShape
                                                                      .circle,
                                                              color:
                                                                  Color.fromARGB(
                                                                    255,
                                                                    224,
                                                                    64,
                                                                    117,
                                                                  ),
                                                            ),
                                                        child: CircleAvatar(
                                                          radius: 30,
                                                          backgroundColor:
                                                              Colors
                                                                  .transparent,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width:
                                                            screenWidth * 0.01,
                                                      ),
                                                      Text(
                                                        'STD/STI 1',
                                                        style: TextStyle(
                                                          fontFamily:
                                                              'OpenSansLight',
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 15,
                                                          color: Colors.black,
                                                        ),
                                                      ),

                                                      SizedBox(
                                                        width:
                                                            screenWidth * 0.01,
                                                      ),
                                                      Text(
                                                        '14',
                                                        style: TextStyle(
                                                          fontFamily:
                                                              'OpenSansLight',
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 15,
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
