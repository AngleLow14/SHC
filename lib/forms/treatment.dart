import 'package:flutter/material.dart';
import 'package:shc/forms/medical.dart';
import 'package:shc/home_page/home_page.dart';

class Treatment extends StatefulWidget {
  const Treatment({super.key});
  @override
  _TreatmState createState() => _TreatmState();
}

class _TreatmState extends State<Treatment> {
  bool isCheckedYes = false;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    
    double responsiveSpacing = 20.0;
    double responsiveRunSpacing = 10.0;
    TableRow buildHeaderRow() {
      return TableRow(
        children: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'Prescription',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'Quantity',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'Frequency',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      );
    }

    TableRow buildDataRow() {
      return TableRow(
        children: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Text('Benzathine Penicillin(100mg)',
                style: TextStyle(fontSize: 15)),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Text('21 tablets', style: TextStyle(fontSize: 15)),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Text('3x a day', style: TextStyle(fontSize: 15)),
          ),
        ],
      );
    }

    TableRow sndDataRow() {
      return TableRow(
        children: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Text('Doxycyline(100mg)', style: TextStyle(fontSize: 15)),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Text('7 tablets', style: TextStyle(fontSize: 15)),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Text('1 in the Evening', style: TextStyle(fontSize: 15)),
          ),
        ],
      );
    }

    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          height: screenHeight,
          width: screenWidth,
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                width: screenWidth,
                color: Colors.white,
                child: Center(
                  child: Text(
                    'Prescription Treatment',
                    style: TextStyle(
                      fontFamily: 'OpenSansEB',
                      fontSize: 30,
                      color: const Color.fromARGB(255, 182, 8, 37),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: screenHeight * 0.07,
                width: screenWidth,
                child:  Center(
                  child: Text(
                    '2 OUT OF 2',
                    style: TextStyle(fontSize: 20, color: Colors.grey, fontFamily: 'Italic'),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  width: screenWidth * 0.78,
                  color: Colors.white,
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                           Text(
                            'VI. TREATMENT AND FOLLOW UP PLAN',
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'OpenSansEB',
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(height: screenHeight * 0.02),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Table(
                                border: TableBorder.all(),
                                columnWidths: {
                                  0: FixedColumnWidth(screenWidth * 0.2),
                                  1: FixedColumnWidth(screenWidth * 0.15),
                                  2: FixedColumnWidth(screenWidth * 0.2),
                                },
                                children: [
                                  buildHeaderRow(),
                                  buildDataRow(),
                                  sndDataRow(),
                                ],
                              ),
                              SizedBox(width: screenWidth * 0.05),
                              Expanded(
                                child: Column(
                                  children: [
                                    SizedBox(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                           Text(
                                            'For Referral',
                                            style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.black,
                                            ),
                                          ),
                                          Row(
                                            children: [
                                              Expanded(
                                                child: SizedBox(
                                                  height: screenHeight * 0.07,
                                                  child: TextField(
                                                    enabled: !isCheckedYes,
                                                    style: TextStyle(
                                                      fontSize: 13,
                                                      color: Colors.black,
                                                    ),
                                                    decoration: InputDecoration(
                                                      filled: true,
                                                      fillColor: Colors.white,
                                                      border: OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                5.0),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Checkbox(
                                                value: isCheckedYes,
                                                onChanged: (bool? value) {
                                                  setState(() {
                                                    isCheckedYes = value ?? false;
                                                  });
                                                },
                                              ),
                                               Text(
                                                'No',
                                                style: TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Follow up Check up',
                                            style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.black,
                                            ),
                                          ),
                                          SizedBox(
                                            height: screenHeight * 0.07,
                                            child: TextField(
                                              style:  TextStyle(
                                                fontSize: 13,
                                                color: Colors.black,
                                              ),
                                              decoration: InputDecoration(
                                                filled: true,
                                                fillColor: Colors.white,
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                    5.0,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
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
                                      width: 120,
                                      height: 30,
                                      child: ElevatedButton(
                                        onPressed: () {
                                          Navigator.push(
						context,
						MaterialPageRoute(builder: (context) => MedicalRecord()),
					);
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              Colors
                                                  .transparent, // Transparent background
                                          foregroundColor:
                                              Colors.green, // Text/icon color
                                          elevation: 0, // No shadow
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 20,
                                            vertical: 12,
                                          ),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                              8,
                                            ),
                                            side: BorderSide(
                                              color: Colors.green,
                                              width: 2,
                                            ), // Green border
                                          ),
                                        ),
                                        child: Text(
                                          'Back',
                                          style: TextStyle(
                                            fontSize: 15,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 120,
                                      height: 30,
                                      child: ElevatedButton(
                                        onPressed: () {
                                          Navigator.push(
						context,
						MaterialPageRoute(builder: (context) => Dashboard()),
					);
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.green,
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 20,
                                            vertical: 12,
                                          ),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                              8,
                                            ),
                                            side: BorderSide(
                                              color: Colors.green.shade900,
                                              width: 2,
                                            ), // Border
                                          ),
                                        ),
                                        child: Text(
                                          'Submit',
                                          style: TextStyle(
                                            fontSize: 15,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                        ],
                      ),
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