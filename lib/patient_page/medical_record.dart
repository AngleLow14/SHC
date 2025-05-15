import 'package:flutter/material.dart';
import 'package:shc/patient_page/medical_page.dart';

class ViewDetails extends StatelessWidget{
 final String patientId;

  const ViewDetails({Key? key, required this.patientId}) : super(key: key);

@override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    double responsiveSpacing = 20.0;
    double responsiveRunSpacing = 10.0;

    return Scaffold(
      body: SafeArea(
        child: Container(
          height: screenHeight * 1,
          width: screenWidth * 1,
          color: const Color.fromARGB(255, 255, 245, 245),
          child: Center(
            child: Column(
              children: [
                Container(
                  height: screenHeight * 0.07,
                  width: screenWidth * 1,
                  color: Colors.white,
                  child: Center(
                    
                  ),
                ),
                SizedBox(
                  height: screenHeight * 0.07,
                  width: screenWidth * 1,
                  child: Center(
                    
                  ),
                ),

                Expanded(
                  child: Container(
                    width: screenWidth * 1,
                    color: Colors.white,
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(16.0),
                            width: screenWidth * 0.75,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Center(
                                  child: Text(
                                  'March 11, 2025',
                                  style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                    fontFamily: 'OpenSansEB',
                                  ),
                                ),
                                ),
                                SizedBox(height: screenHeight * 0.02),
                                Center(
                                  child: Text(
                                  'Medical History',
                                  style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                    fontFamily: 'OpenSansEB',
                                  ),
                                ),
                                ),
                                SizedBox(height: screenHeight * 0.02),
                                Wrap(
                                  spacing: responsiveSpacing,
                                  runSpacing: responsiveRunSpacing,
                                  children: [
                                    SizedBox(
                                      width: screenWidth * 0.15,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Known Allergies',
                                            style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                            ),
                                          ),
                                          SizedBox(
                                            height: screenHeight * 0.07,
                                            child: Text(
                                            'None',
                                            style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.black,
                                            ),
                                          ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      width: screenWidth * 0.15,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Past and Current Condition',
                                            style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          SizedBox(
                                            height: screenHeight * 0.07,
                                            child: Text(
                                            'None',
                                            style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.black,
                                            ),
                                          ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      width: screenWidth * 0.15,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'History of STIs/STDs',
                                            style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),

                                          SizedBox(
                                            height: screenHeight * 0.07,
                                            child: Text(
                                            'None',
                                            style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: screenHeight * 0.02),
                                Wrap(
                                  spacing: responsiveSpacing,
                                  runSpacing: responsiveRunSpacing,
                                  children: [
                                    SizedBox(
                                      width: screenWidth * 0.15,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'History of Hospitalization',
                                            style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                            ),
                                          ),
                                          SizedBox(
                                            height: screenHeight * 0.07,
                                            child: Text(
                                            'None',
                                            style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.black,
                                            ),
                                          ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      width: screenWidth * 0.15,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Current Medication',
                                            style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          SizedBox(
                                            height: screenHeight * 0.07,
                                            child: Text(
                                            'Montilukast Sodium',
                                            style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.black,
                                            ),
                                          ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      width: screenWidth * 0.15,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Family Medical History',
                                            style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),

                                          SizedBox(
                                            height: screenHeight * 0.07,
                                            child: Text(
                                            'Hypertension',
                                            style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: screenHeight * 0.02),
                                Center(
                                  child: Text(
                                  'Sexual and Reproductive Health History',
                                  style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                    fontFamily: 'OpenSansEB',
                                  ),
                                ),
                                ),
                                SizedBox(height: screenHeight * 0.02),
                                Wrap(
                                  spacing: responsiveSpacing,
                                  runSpacing: responsiveRunSpacing,
                                  children: [
                                    SizedBox(
                                      width: screenWidth * 0.15,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Number of Sexual Partners',
                                            style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                            ),
                                          ),
                                          SizedBox(
                                            height: screenHeight * 0.07,
                                            child: Text(
                                            '13',
                                            style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.black,
                                            ),
                                          ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      width: screenWidth * 0.15,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Use of Contraceptives',
                                            style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          SizedBox(
                                            height: screenHeight * 0.07,
                                            child: Text(
                                            'Condoms, Pills',
                                            style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.black,
                                            ),
                                          ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      width: screenWidth * 0.15,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'History of Unprotected Sex',
                                            style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),

                                          SizedBox(
                                            height: screenHeight * 0.07,
                                            child: Text(
                                            'Yes',
                                            style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: screenHeight * 0.02),
                                Wrap(
                                  spacing: responsiveSpacing,
                                  runSpacing: responsiveRunSpacing,
                                  children: [
                                    SizedBox(
                                      width: screenWidth * 0.15,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Date of Last Sexual Encounter',
                                            style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                            ),
                                          ),
                                          SizedBox(
                                            height: screenHeight * 0.07,
                                            child: Text(
                                            'March 01, 2025',
                                            style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.black,
                                            ),
                                          ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      width: screenWidth * 0.15,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Menstrual Histpry',
                                            style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          SizedBox(
                                            height: screenHeight * 0.07,
                                            child: Text(
                                            'Regular',
                                            style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.black,
                                            ),
                                          ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      width: screenWidth * 0.15,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Pregnancy History',
                                            style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),

                                          SizedBox(
                                            height: screenHeight * 0.07,
                                            child: Text(
                                            'None',
                                            style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: screenHeight * 0.02),
                                Center(
                                  child: Text(
                                  'Symptoms and Current Complaint',
                                  style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                    fontFamily: 'OpenSansEB',
                                  ),
                                ),
                                ),
                                SizedBox(height: screenHeight * 0.02),
                                Wrap(
                                  spacing: responsiveSpacing,
                                  runSpacing: responsiveRunSpacing,
                                  children: [
                                    SizedBox(
                                      width: screenWidth * 0.15,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Pain or Discomfort',
                                            style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                            ),
                                          ),
                                          SizedBox(
                                            height: screenHeight * 0.07,
                                            child: Text(
                                            'None',
                                            style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.black,
                                            ),
                                          ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      width: screenWidth * 0.15,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Abnormal Discharge',
                                            style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          SizedBox(
                                            height: screenHeight * 0.07,
                                            child: Text(
                                            'Yellowish',
                                            style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.black,
                                            ),
                                          ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      width: screenWidth * 0.15,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Urinary Problem',
                                            style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),

                                          SizedBox(
                                            height: screenHeight * 0.07,
                                            child: Text(
                                            'Urinary Track Infection',
                                            style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: screenHeight * 0.02),
                                Wrap(
                                  spacing: responsiveSpacing,
                                  runSpacing: responsiveRunSpacing,
                                  children: [
                                    SizedBox(
                                      width: screenWidth * 0.15,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Symptoms',
                                            style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                            ),
                                          ),
                                          SizedBox(
                                            height: screenHeight * 0.07,
                                            child: Text(
                                            'Fever, Fatigue, Itching, Skin Rashes, Body Ache',
                                            style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.black,
                                            ),
                                          ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: screenHeight * 0.02),
                                Text(
                                  'II. Medical History',
                                  style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                    fontFamily: 'OpenSansEB'
                                  ),
                                ),
                                SizedBox(height: screenHeight * 0.02),
                                Center(
                                  child: Text(
                                  'Laboratory and Diagnostic Tests',
                                  style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                    fontFamily: 'OpenSansEB',
                                  ),
                                ),
                                ),
                                SizedBox(height: screenHeight * 0.02),
                                Wrap(
                                  spacing: responsiveSpacing,
                                  runSpacing: responsiveRunSpacing,
                                  children: [
                                    SizedBox(
                                      width: screenWidth * 0.15,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Blood Tests',
                                            style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                            ),
                                          ),
                                          SizedBox(
                                            height: screenHeight * 0.07,
                                            child: Text(
                                            'No Findings',
                                            style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.black,
                                            ),
                                          ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      width: screenWidth * 0.15,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Urinary Test',
                                            style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          SizedBox(
                                            height: screenHeight * 0.07,
                                            child: Text(
                                            'Urinary Track Infection',
                                            style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.black,
                                            ),
                                          ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      width: screenWidth * 0.15,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Swab Tests',
                                            style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),

                                          SizedBox(
                                            height: screenHeight * 0.07,
                                            child: Text(
                                            'No Findings',
                                            style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: screenHeight * 0.02),
                                Wrap(
                                  spacing: responsiveSpacing,
                                  runSpacing: responsiveRunSpacing,
                                  children: [
                                    SizedBox(
                                      width: screenWidth * 0.15,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Physical Examination Findings',
                                            style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                            ),
                                          ),
                                          SizedBox(
                                            height: screenHeight * 0.07,
                                            child: Text(
                                            'No Findings',
                                            style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.black,
                                            ),
                                          ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      width: screenWidth * 0.15,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Semenalysis',
                                            style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          SizedBox(
                                            height: screenHeight * 0.07,
                                            child: Text(
                                            'Not Applicable',
                                            style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.black,
                                            ),
                                          ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      width: screenWidth * 0.15,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Pap Smear',
                                            style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),

                                          SizedBox(
                                            height: screenHeight * 0.07,
                                            child: Text(
                                            'No Findings',
                                            style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: screenHeight * 0.02),
                                Center(
                                  child: Text(
                                  'Treatment and Follow Up Plan',
                                  style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                    fontFamily: 'OpenSansEB',
                                  ),
                                ),
                                ),
                                SizedBox(height: screenHeight * 0.02),
                                Wrap(
                                  spacing: responsiveSpacing,
                                  runSpacing: responsiveRunSpacing,
                                  children: [
                                    SizedBox(
                                      width: screenWidth * 0.15,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Prescription',
                                            style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                            ),
                                          ),
                                          SizedBox(
                                            height: screenHeight * 0.07,
                                            child: Column(
                                              children: [
                                                Text(
                                            'Benzathine Penicilin (100mg)',
                                            style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.black,
                                            ),
                                          ),
                                          Text(
                                            'Doxyciline (100mg)',
                                            style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.black,
                                            ),
                                          ),
                                              ],
                                            )
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      width: screenWidth * 0.15,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Quantity',
                                            style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          SizedBox(
                                            height: screenHeight * 0.07,
                                            child: Column(
                                              children: [
                                                Text(
                                            '21 Tablets',
                                            style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.black,
                                            ),
                                          ),
                                          Text(
                                            '7 Tablets',
                                            style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.black,
                                            ),
                                          ),
                                              ],
                                            )
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      width: screenWidth * 0.15,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Frequency',
                                            style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),

                                          SizedBox(
                                            height: screenHeight * 0.07,
                                            child: Column(
                                              children: [
                                                Text(
                                            '3x a Day',
                                            style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            '1 in Evening',
                                            style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                              ],
                                            )
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: screenHeight * 0.02),
                                Wrap(
                                  spacing: responsiveSpacing,
                                  runSpacing: responsiveRunSpacing,
                                  children: [
                                    SizedBox(
                                      width: screenWidth * 0.15,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'No Referral',
                                            style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                            ),
                                          ),
                                          SizedBox(
                                            height: screenHeight * 0.07,
                                            child: Text(
                                            'No',
                                            style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.black,
                                            ),
                                          ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      width: screenWidth * 0.15,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Follow Up Check Up',
                                            style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          SizedBox(
                                            height: screenHeight * 0.07,
                                            child: Text(
                                            'March 11, 2025',
                                            style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.black,
                                            ),
                                          ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                                                SizedBox(height: screenHeight * 0.02),
                                Wrap(
                                  spacing: responsiveSpacing,
                                  runSpacing: responsiveRunSpacing,
                                  children: [
                                    SizedBox(
                                      width: screenWidth * 0.10,
                                      height: screenHeight * 0.05,
                                      child: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MedicalHistoryPage(patientId: patientId)),
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
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}