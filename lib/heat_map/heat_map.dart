import 'package:flutter/material.dart';
import 'package:shc/home_page/home_page.dart';
import 'package:shc/appointment_page/appointment_page.dart';
import 'package:shc/patient_page/patient_page.dart';
import 'package:shc/heat_map/map.dart';
import 'package:shc/login_page/login_page.dart';

class HeatMap extends StatelessWidget {
  const HeatMap({super.key});
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
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.05,
                              ),
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
                                      Navigator.pushReplacement(
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
                                    onPressed: () {
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => PatientsPage(),
                                        ),
                                      );
                                    },
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
                                    onPressed: () {
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => AppointmentPage(),
                                        ),
                                      );
                                    },
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
                                      MaterialPageRoute(
                                        builder: (context) => AdminLoginPage(),
                                      ),
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
                    SizedBox(width: screenWidth * 0.03),
                    Column(
                      children: [
                        Container(
                          color: const Color.fromARGB(255, 255, 245, 245),
                          height: MediaQuery.of(context).size.height,
                          width: screenWidth * 0.7,
                          child: Column(
                            children: [
                              SizedBox(
                                height: screenHeight * 0.01,
                                width: screenWidth * 0.03,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Dashboard ',
                                        style: TextStyle(
                                          fontFamily: 'OpenSansEB',
                                          fontSize: 30,
                                          color: Color.fromARGB(
                                            255,
                                            182,
                                            8,
                                            37,
                                          ),
                                        ),
                                      ),

                                      Text(
                                        ' > ',
                                        style: TextStyle(
                                          fontFamily: 'OpenSansEB',
                                          fontSize: 30,
                                          color: Color.fromARGB(
                                            255,
                                            182,
                                            8,
                                            37,
                                          ),
                                        ),
                                      ),

                                      Text(
                                        ' Heat Map',
                                        style: TextStyle(
                                          fontFamily: 'OpenSansEB',
                                          fontSize: 30,
                                          color: Color.fromARGB(
                                            255,
                                            182,
                                            8,
                                            37,
                                          ),
                                        ),
                                      ),
                                    ],
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
                             SizedBox(
                              height: screenHeight * 0.8,
                              width: screenWidth * 0.7,
                              child: HeatMapApp()
                             )
                            ],
                          ),
                        ),
                      ],
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
