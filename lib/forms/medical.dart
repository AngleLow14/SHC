import 'package:flutter/material.dart';
import 'package:shc/forms/treatment.dart';
import 'package:shc/patient_page/patient_page.dart';

class MedicalRecord extends StatefulWidget {
  const MedicalRecord({super.key});
  @override
  _MedRecord createState() => _MedRecord();
}

class _MedRecord extends State<MedicalRecord> {
  bool isCheckedMiddleName = false;
  bool isCheckedSuffix = false;
  bool isCheckedYes = false;
  bool isCHeckedMo = false;
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
                    child: Text(
                      'Medical Form',
                      style: TextStyle(
                        fontFamily: 'OpenSansEB',
                        fontSize: 30.sp,
                        color: Color.fromARGB(255, 182, 8, 37),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: screenHeight * 0.07,
                  width: screenWidth * 1,
                  child: Center(
                    child: Text(
                      '1 OUT OF 2',
                      style: TextStyle(fontSize: 20.sp, color: Colors.grey),
                    ),
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
                                Text(
                                  'I. PROFILE',
                                  style: TextStyle(
                                    fontSize: 25.sp,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                                SizedBox(height: screenHeight * 0.02),
                                Wrap(
                                  spacing: responsiveSpacing,
                                  runSpacing: responsiveRunSpacing,
                                  children: [
                                    SizedBox(
                                      width: 200.w,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Last Name',
                                            style: TextStyle(
                                              fontSize: 15.sp,
                                              color: Colors.black,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 30.h,
                                            child: TextField(
                                              style: TextStyle(
                                                fontSize: 15.sp,
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
                                    SizedBox(
                                      width: 250.w,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'First Name',
                                            style: TextStyle(
                                              fontSize: 15.sp,
                                              color: Colors.black,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 30.h,
                                            child: TextField(
                                              style: TextStyle(
                                                fontSize: 15.sp,
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
                                    SizedBox(
                                      width: 250.w,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Middle Name',
                                            style: TextStyle(
                                              fontSize: 15.sp,
                                              color: Colors.black,
                                            ),
                                          ),

                                          SizedBox(
                                            height: 30.h,
                                            child: TextField(
                                              enabled: !isCheckedMiddleName,
                                              style: TextStyle(
                                                fontSize: 15.sp,
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
                                          Row(
                                            children: [
                                              Checkbox(
                                                value: isCheckedMiddleName,
                                                onChanged: (bool? value) {
                                                  setState(() {
                                                    isCheckedMiddleName =
                                                        value!;
                                                  });
                                                },
                                              ),
                                              Text(
                                                'Toggle if not applicable',
                                                style: TextStyle(
                                                  fontSize: 10.sp,
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      width: 200.w,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Suffix',
                                            style: TextStyle(
                                              fontSize: 15.sp,
                                              color: Colors.black,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 30.h,
                                            child: TextField(
                                              enabled: !isCheckedSuffix,
                                              style: TextStyle(
                                                fontSize: 15.sp,
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
                                          Row(
                                            children: [
                                              Checkbox(
                                                value: isCheckedSuffix,
                                                onChanged: (bool? value) {
                                                  setState(() {
                                                    isCheckedSuffix = value!;
                                                  });
                                                },
                                              ),
                                              Text(
                                                'Toggle if not applicable',
                                                style: TextStyle(
                                                  fontSize: 10.sp,
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
                                SizedBox(height: screenHeight * 0.02),
                                Wrap(
                                  spacing: responsiveSpacing,
                                  runSpacing: responsiveRunSpacing,
                                  children: [
                                    SizedBox(
                                      width: 150.w,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Birthday',
                                            style: TextStyle(
                                              fontSize: 15.sp,
                                              color: Colors.black,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 30.h,
                                            child: TextField(
                                              style: TextStyle(
                                                fontSize: 15.sp,
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
                                    SizedBox(
                                      width: 200.w,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Place of Birth',
                                            style: TextStyle(
                                              fontSize: 15.sp,
                                              color: Colors.black,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 30.h,
                                            child: TextField(
                                              style: TextStyle(
                                                fontSize: 15.sp,
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
                                    SizedBox(
                                      width: 150.w,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                           Text(
                                            'House Number',
                                            style: TextStyle(
                                              fontSize: 15.sp,
                                              color: Colors.black,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 30.h,
                                            child: TextField(
                                              style: TextStyle(
                                                fontSize: 15.sp,
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
                                    SizedBox(
                                      width: 200.w,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Street',
                                            style: TextStyle(
                                              fontSize: 15.sp,
                                              color: Colors.black,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 30.h,
                                            child: TextField(
                                              style: TextStyle(
                                                fontSize: 15.sp,
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
                                    SizedBox(
                                      width: 150.w,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Barangay',
                                            style: TextStyle(
                                              fontSize: 15.sp,
                                              color: Colors.black,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 30.h,
                                            child: TextField(
                                              style: TextStyle(
                                                fontSize: 15.sp,
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
                                SizedBox(height: screenHeight * 0.02),
                                Wrap(
                                  spacing: responsiveSpacing,
                                  runSpacing: responsiveRunSpacing,
                                  children: [
                                    SizedBox(
                                      width: 150.w,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'City',
                                            style: TextStyle(
                                              fontSize: 15.sp,
                                              color: Colors.black,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 30.h,
                                            child: TextField(
                                              style: TextStyle(
                                                fontSize: 15.sp,
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
                                    SizedBox(
                                      width: 200.w,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Municipality',
                                            style: TextStyle(
                                              fontSize: 15.sp,
                                              color: Colors.black,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 30.h,
                                            child: TextField(
                                              style: TextStyle(
                                                fontSize: 15.sp,
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
                                    SizedBox(
                                      width: 150.w,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Province',
                                            style: TextStyle(
                                              fontSize: 15.sp,
                                              color: Colors.black,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 30.h,
                                            child: TextField(
                                              style: TextStyle(
                                                fontSize: 15.sp,
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
                                    SizedBox(
                                      width: 200.w,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'ZIP Code',
                                            style: TextStyle(
                                              fontSize: 15.sp,
                                              color: Colors.black,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 30.h,
                                            child: TextField(
                                              style: TextStyle(
                                                fontSize: 15.sp,
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
                                SizedBox(height: screenHeight * 0.02),
                                Wrap(
                                  spacing: responsiveSpacing,
                                  runSpacing: responsiveRunSpacing,
                                  children: [
                                    SizedBox(
                                      width: 150.w,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Email',
                                            style: TextStyle(
                                              fontSize: 15.sp,
                                              color: Colors.black,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 30.sp,
                                            child: TextField(
                                              style:  TextStyle(
                                                fontSize: 15.sp,
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
                                    SizedBox(
                                      width: 200.w,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Contact Number',
                                            style: TextStyle(
                                              fontSize: 15.sp,
                                              color: Colors.black,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 30.h,
                                            child: TextField(
                                              style: TextStyle(
                                                fontSize: 15.sp,
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
                                    SizedBox(
                                      width: 150.w,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Civil Status',
                                            style: TextStyle(
                                              fontSize: 15.sp,
                                              color: Colors.black,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 30.h,
                                            child: TextField(
                                              style: TextStyle(
                                                fontSize: 15.sp,
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
                                SizedBox(height: screenHeight * 0.02),
                                Text(
                                  'II Medical History',
                                  style: TextStyle(
                                    fontSize: 25.sp,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                                SizedBox(height: screenHeight * 0.02),
                                Wrap(
                                  spacing: responsiveSpacing,
                                  runSpacing: responsiveRunSpacing,
                                  children: [
                                    SizedBox(
                                      width: 200.w,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Known Allergies',
                                            style: TextStyle(
                                              fontSize: 15.sp,
                                              color: Colors.black,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 30.h,
                                            child: TextField(
                                              style: TextStyle(
                                                fontSize: 15.sp,
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
                                    SizedBox(
                                      width: 250.w,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Past and Medical Condition',
                                            style: TextStyle(
                                              fontSize: 15.sp,
                                              color: Colors.black,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 30.h,
                                            child: TextField(
                                              style: TextStyle(
                                                fontSize: 15.sp,
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
                                    SizedBox(
                                      width: 250.w,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'History of STDs/STIs',
                                            style: TextStyle(
                                              fontSize: 15.sp,
                                              color: Colors.black,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 30.h,
                                            child: TextField(
                                              style: TextStyle(
                                                fontSize: 15.sp,
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
                                    SizedBox(
                                      width: 200.w,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'History of Hospitalization',
                                            style: TextStyle(
                                              fontSize: 15.sp,
                                              color: Colors.black,
                                            ),
                                          ),

                                          Row(
                                            children: [
                                              Checkbox(
                                                value: isCheckedYes,
                                                onChanged: (bool? value) {
                                                  setState(() {
                                                    isCheckedSuffix = value!;
                                                  });
                                                },
                                              ),
                                              Text(
                                                'Yes',
                                                style: TextStyle(
                                                  fontSize: 10.sp,
                                                  color: Colors.black,
                                                ),
                                              ),
                                              Checkbox(
                                                value: isCheckedYes,
                                                onChanged: (bool? value) {
                                                  setState(() {
                                                    isCheckedSuffix = value!;
                                                  });
                                                },
                                              ),
                                              Text(
                                                'No',
                                                style: TextStyle(
                                                  fontSize: 10.sp,
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
                                SizedBox(height: screenHeight * 0.02),
                                Wrap(
                                  spacing: responsiveSpacing,
                                  runSpacing: responsiveRunSpacing,
                                  children: [
                                    SizedBox(
                                      width: 120.w,
                                      height: 30.h,
                                      child: ElevatedButton(
                                        onPressed: () {
                                          Navigator.push(
						context,
						MaterialPageRoute(builder: (context) => Dashboard()),
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
                                          'Cancel',
                                          style: TextStyle(
                                            fontSize: 15.sp,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 120.w,
                                      height: 30.h,
                                      child: ElevatedButton(
                                        onPressed: () {
                                          Navigator.push(
						context,
						MaterialPageRoute(builder: (context) => Treatment()),
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
                                          'Continue',
                                          style: TextStyle(
                                            fontSize: 15.sp,
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
