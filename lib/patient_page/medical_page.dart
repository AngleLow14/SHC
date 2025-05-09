import 'package:shc/patient_page/patient_page.dart';
import 'package:shc/patient_page/medical_record.dart';
import 'package:flutter/material.dart';

class MedicalHistoryPage extends StatelessWidget {
  const MedicalHistoryPage({super.key});
  @override
  Widget build(BuildContext context) {
    double responsiveSpacing = 20.0;
    double responsiveRunSpacing = 10.0;
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: const Color.fromARGB(255, 255, 242, 242),
          height: screenHeight * 1,
          width: screenWidth * 1,
          child: Wrap(
            spacing: responsiveSpacing,
            runSpacing: responsiveRunSpacing,
            children: [
              Row(
                children: [
                  SizedBox(height: screenHeight * 0.02),
                  Container(
                    padding: EdgeInsets.only(left: 20),
                    height: screenHeight * 0.07,
                    width: screenWidth * 0.07,
                    child: Image.asset(
                      'assets/icon/shc.png',
                    height: screenHeight * 0.06,
                    width: screenWidth * 0.06,
                    ),
                  ),
                  Text(
                      'San Pablo Social Hygiene Clinic',
                      style: TextStyle(
                        fontFamily: 'OpenSansEB',
                        fontSize: 30,
                        color: Color.fromARGB(255, 182, 8, 37),
                      ),
                    ),
                ],
              ),
              SizedBox(height: screenHeight * 0.02),
              Wrap(
                spacing: responsiveSpacing,
                runSpacing: responsiveRunSpacing,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      height: screenHeight * 0.7,
                      width: screenWidth * 0.47,
                      color: Colors.white,
                      child: Column(
                        children: [
                          SizedBox(height: screenHeight * 0.03),
                          Row(
                            children: [
                              SizedBox(
                                child: Row(
                                  children: [
                                    SizedBox(height: screenHeight * 0.02),
                                    Container(
                                height: screenHeight * 0.15,
                                width: screenWidth * 0.15,
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
                                    Column(
                                      children: [
                                        Text(
                                    'Gene Jerrylene Arnigo Alvarez',
                                    style: TextStyle(
                                      fontFamily: 'OpenSansEB',
                                      fontSize: 20,
                                      color: Colors.black,
                                    ),
                                  ),
                                  SizedBox(height: screenHeight * 0.02),
                                  Text(
                                      '21 years old',
                                      style: TextStyle(
                                        fontFamily: 'OpenSansSB',
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                        color: Colors.black,
                                      ),
                                    ),
                                      ],
                                    )                                  
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: screenHeight * 0.03),
                          Wrap(
                            spacing: responsiveSpacing,
                            runSpacing: responsiveRunSpacing,
                            children: [
                              Text(
                                  'I. PROFILE',
                                  style: TextStyle(
                                    fontFamily: 'OpenSansEB',
                                    fontSize: 20,
                                    color: Colors.black,
                                  ),
                                ),
                            ],
                          ),
                          SizedBox(height: screenHeight * 0.02),
                            Wrap(
                            spacing: responsiveSpacing, 
                            runSpacing: responsiveRunSpacing,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                'Birthday',
                                style: TextStyle(
                                  fontFamily: 'OpenSansSB',
                                  fontSize: 20,
                                  color: Colors.black,
                                ),
                              ),
                              Text(
                                'May 14, 2001',
                                style: TextStyle(
                                  fontFamily: 'OpenSansLight',
                                  fontSize: 15,
                                  color: Colors.black,
                                ),
                              ),
                                ],
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                Text(
                                'Place of Birth',
                                style: TextStyle(
                                  fontFamily: 'OpenSansSB',
                                  fontSize: 20,
                                  color: Colors.black,
                                ),
                              ),
                              Text(
                                'Tiaong, Quezon',
                                style: TextStyle(
                                  fontFamily: 'OpenSansLight',
                                  fontSize: 15,
                                  color: Colors.black,
                                ),
                              ),
                                ],
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                Text(
                                'Civil Status',
                                style: TextStyle(
                                  fontFamily: 'OpenSansSB',
                                  fontSize: 20,
                                  color: Colors.black,
                                ),
                              ),
                              Text(
                                'Married',
                                style: TextStyle(
                                  fontFamily: 'OpenSansLight',
                                  fontSize: 15,
                                  color: Colors.black,
                                ),
                              ),
                                ],
                              ),
                              
                              SizedBox(width: screenWidth * 0.07),
                              
                            ],
                          ),
                            ],
                          ),
                          
                          SizedBox(height: screenHeight * 0.02),
                          Wrap(
                            spacing: responsiveSpacing,
                            runSpacing: responsiveRunSpacing,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                'Contact Number',
                                style: TextStyle(
                                  fontFamily: 'OpenSansSB',
                                  fontSize: 20,
                                  color: Colors.black,
                                ),
                              ),
                              Text(
                                '09123456789',
                                style: TextStyle(
                                  fontFamily: 'OpenSansLight',
                                  fontSize: 15,
                                  color: Colors.black,
                                ),
                              ),
                                    ]
                                  ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                'Email',
                                style: TextStyle(
                                  fontFamily: 'OpenSansSB',
                                  fontSize: 20,
                                  color: Colors.black,
                                ),
                              ),
                              Text(
                                'genealvarezjerrylene@gmail.com',
                                style: TextStyle(
                                  fontFamily: 'OpenSansLight',
                                  fontSize: 15,
                                  color: Colors.black,
                                ),
                              ),
                                  ],
                                )
                                ]
                              )
                            ]
                          ),
                          
                          SizedBox(height: screenHeight * 0.02),
                          Wrap(
                            spacing: responsiveSpacing,
                            runSpacing: responsiveRunSpacing,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                'House Number',
                                style: TextStyle(
                                  fontFamily: 'OpenSansSB',
                                  fontSize: 20,
                                  color: Colors.black,
                                ),
                              ),
                              Text(
                                '0123',
                                style: TextStyle(
                                  fontFamily: 'OpenSansLight',
                                  fontSize: 15,
                                  color: Colors.black,
                                ),
                              ),
                                    ],
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                'Street',
                                style: TextStyle(
                                  fontFamily: 'OpenSansSB',
                                  fontSize: 20,
                                  color: Colors.black,
                                ),
                              ),
                              Text(
                                'Rizal St.',
                                style: TextStyle(
                                  fontFamily: 'OpenSansLight',
                                  fontSize: 15,
                                  color: Colors.black,
                                ),
                              ),
                                    ],
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                'Barangay',
                                style: TextStyle(
                                  fontFamily: 'OpenSansSB',
                                  fontSize: 20,
                                  color: Colors.black,
                                ),
                              ),
                              Text(
                                'Seoul',
                                style: TextStyle(
                                  fontFamily: 'OpenSansLight',
                                  fontSize: 15,
                                  color: Colors.black,
                                ),
                              ),

                                    ],
                                  ),
                                ],
                              )
                            ],
                          ),
                          
                          SizedBox(height: screenHeight * 0.02),
                          Wrap(
                            spacing: responsiveSpacing,
                            runSpacing: responsiveRunSpacing,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                'Municipality/City',
                                style: TextStyle(
                                  fontFamily: 'OpenSansSB',
                                  fontSize: 20,
                                  color: Colors.black,
                                ),
                              ),
                              Text(
                                'San Pablo',
                                style: TextStyle(
                                  fontFamily: 'OpenSansLight',
                                  fontSize: 15,
                                  color: Colors.black,
                                ),
                              ),
                                    ],
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                'Province',
                                style: TextStyle(
                                  fontFamily: 'OpenSansSB',
                                  fontSize: 20,
                                  color: Colors.black,
                                ),
                              ),
                              Text(
                                'Laguna',
                                style: TextStyle(
                                  fontFamily: 'OpenSansLight',
                                  fontSize: 15,
                                  color: Colors.black,
                                ),
                              ),
                                    ],
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                'Zip Code',
                                style: TextStyle(
                                  fontFamily: 'OpenSansSB',
                                  fontSize: 20,
                                  color: Colors.black,
                                ),
                              ),
                              Text(
                                '4000',
                                style: TextStyle(
                                  fontFamily: 'OpenSansLight',
                                  fontSize: 15,
                                  color: Colors.black,
                                ),
                              ),

                                    ],
                                  ),
                                ],
                              )
                            ],
                          ),                                                    
                        ],
                      ),
                    ),
                    SizedBox(width: screenWidth * 0.02),
                    Container(
                      height: screenHeight * 0.7,
                      width: screenWidth * 0.47,
                      color: Colors.white,
                      padding: EdgeInsets.only(left: 20),
                      child: Column(
                        children: [
                          SizedBox(height: screenHeight * 0.05),
                          Text(
                            'Medical History',
                            style: TextStyle(
                              fontFamily: 'OpenSansEB',
                              fontSize: 25,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(height: screenHeight * 0.03),
                          Container(
                            width: screenWidth * 0.4,
                            height: screenHeight * 0.2,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: Colors.black, width: 1),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                      Text(
                                    'March 11, 2025',
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    'Follow up check up',
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.black,
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => ViewDetails(),
                                        ),
                                      );
                                    },
                                    style: ButtonStyle(
                                      textStyle:
                                          MaterialStateProperty.all<TextStyle>(
                                            TextStyle(
                                              decoration:
                                                  TextDecoration.underline,
                                            ),
                                          ),
                                    ),
                                    child: Text(
                                      'View Record',
                                      style: TextStyle(
                                        fontFamily: 'OpenSansLight',
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        color: Color.fromARGB(255, 235, 49, 49),
                                      ),
                                    ),
                                  )         
                              ]
                            )
                          ),
                          SizedBox(height: screenHeight * 0.02),
                          Container(
                            width: screenWidth * 0.4,
                            height: screenHeight * 0.2,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: Colors.black, width: 1),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                      Text(
                                    'March 11, 2025',
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    'Follow up check up',
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.black,
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => ViewDetails(),
                                        ),
                                      );
                                    },
                                    style: ButtonStyle(
                                      textStyle:
                                          MaterialStateProperty.all<TextStyle>(
                                            TextStyle(
                                              decoration:
                                                  TextDecoration.underline,
                                            ),
                                          ),
                                    ),
                                    child: Text(
                                      'View Record',
                                      style: TextStyle(
                                        fontFamily: 'OpenSansLight',
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        color: Color.fromARGB(255, 235, 49, 49),
                                      ),
                                    ),
                                  )
                              
                            
                              ]
                            )
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                ]
              ),
              SizedBox(height: screenHeight * 0.02),
              Center(
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => PatientsPage()),
                    );
                  },
                  style: ButtonStyle(
                    textStyle: MaterialStateProperty.all<TextStyle>(
                      TextStyle(decoration: TextDecoration.underline),
                    ),
                  ),
                  child: Text(
                    'Go Back',
                    style: TextStyle(
                      fontFamily: 'OpenSansLight',
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 0, 0, 0),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
