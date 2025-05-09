import 'package:flutter/material.dart';
import 'package:shc/forms/treatment.dart';
import 'package:shc/patient_page/patient_page.dart';
import 'package:intl/intl.dart';

class MedicalRecord extends StatefulWidget {
  const MedicalRecord({super.key});
  @override
  _MedRecord createState() => _MedRecord();
}

class _MedRecord extends State<MedicalRecord> {
  TextEditingController _dateController = TextEditingController();

  Future<void> _selectDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000), // earliest date
      lastDate: DateTime(2100),  // latest date
    );

    if (pickedDate != null) {
      String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
      setState(() {
        _dateController.text = formattedDate;
      });
    }
  }

  bool isCheckedMiddleName = false;
  bool isCheckedSuffix = false;
  bool isCheckedYes = false;
  bool isCheckedNo = false;

  bool CheckedSkinLessions = false;
  bool CheckedFever = false;
  bool CheckedBodyAche = false;
  bool CheckedItching = false;
  bool CheckedPainfulIntercourse = false;
  bool CheckedSwollenLymphNodes = false;

  bool CheckedSkinRashes = false;
  bool CheckedFatigue = false;
  bool CheckedGenitalSores = false;
  bool CheckedInflammation = false;
  bool CheckedAbnormalBleeding = false;
  bool CheckedSoreThroat = false;

  bool CheckedChangeSkinColor = false;
  bool CheckedSwellingGenitalArea = false;
  bool CheckedOthers = false;

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
                        fontSize: 30,
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
                      style: TextStyle(fontSize: 15, color: const Color.fromARGB(255, 0, 0, 0), fontFamily: 'Italic',),
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
                                  'I. Profile',
                                  style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                    fontFamily: 'OpenSansEB',
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
                                            'Last Name',
                                            style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.black,
                                            ),
                                          ),
                                          SizedBox(
                                            height: screenHeight * 0.07,
                                            child: TextField(
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
                                      width: screenWidth * 0.15,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'First Name',
                                            style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.black,
                                            ),
                                          ),
                                          SizedBox(
                                            height: screenHeight * 0.07,
                                            child: TextField(
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
                                      width: screenWidth * 0.15,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Middle Name',
                                            style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.black,
                                            ),
                                          ),

                                          SizedBox(
                                            height: screenHeight * 0.07,
                                            child: TextField(
                                              enabled: !isCheckedMiddleName,
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
                                                  fontSize: 15,
                                                  color: Colors.black,
                                                  fontFamily: 'Italic',
                                                ),
                                              ),
                                            ],
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
                                            'Suffix',
                                            style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.black,
                                            ),
                                          ),
                                          SizedBox(
                                            height: screenHeight * 0.07,
                                            child: TextField(
                                              enabled: !isCheckedSuffix,
                                              style: TextStyle(
                                                fontSize: 15,
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
                                                  fontSize: 15,
                                                  color: Colors.black,
                                                  fontFamily: 'Italic',
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
                                      width: screenWidth * 0.15,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Birthday',
                                            style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.black,
                                            ),
                                          ),
                                          SizedBox(
      height: screenHeight * 0.07,
      child: TextField(
        controller: _dateController,
        readOnly: true, // prevent keyboard from appearing
        onTap: () => _selectDate(context),
        style: const TextStyle(
          fontSize: 13,
          color: Colors.black,
        ),
        decoration: InputDecoration(
          hintText: 'Select Date',
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
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
                                            'Place of Birth',
                                            style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.black,
                                            ),
                                          ),
                                          SizedBox(
                                            height: screenHeight * 0.07,
                                            child: TextField(
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
                                      width: screenWidth * 0.15,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                           Text(
                                            'House Number',
                                            style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.black,
                                            ),
                                          ),
                                          SizedBox(
                                            height: screenHeight * 0.07,
                                            child: TextField(
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
                                      width: screenWidth * 0.15,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Street',
                                            style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.black,
                                            ),
                                          ),
                                          SizedBox(
                                            height: screenHeight * 0.07,
                                            child: TextField(
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
                                      width: screenWidth * 0.15,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Barangay',
                                            style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.black,
                                            ),
                                          ),
                                          SizedBox(
                                            height: screenHeight * 0.07,
                                            child: TextField(
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
                                      width: screenWidth * 0.15,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'City',
                                            style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.black,
                                            ),
                                          ),
                                          SizedBox(
                                            height: screenHeight * 0.07,
                                            child: TextField(
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
                                      width: screenWidth * 0.15,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Municipality',
                                            style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.black,
                                            ),
                                          ),
                                          SizedBox(
                                            height: screenHeight * 0.07,
                                            child: TextField(
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
                                      width: screenWidth * 0.15,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Province',
                                            style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.black,
                                            ),
                                          ),
                                          SizedBox(
                                            height: screenHeight * 0.07,
                                            child: TextField(
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
                                      width: screenWidth * 0.15,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'ZIP Code',
                                            style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.black,
                                            ),
                                          ),
                                          SizedBox(
                                            height: screenHeight * 0.07,
                                            child: TextField(
                                              style: TextStyle(
                                                fontSize: 15,
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
                                      width: screenWidth * 0.15,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Email',
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
                                                color: const Color.fromARGB(255, 2, 1, 1),
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
                                      width: screenWidth * 0.15,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Contact Number',
                                            style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.black,
                                            ),
                                          ),
                                          SizedBox(
                                            height: screenHeight * 0.07,
                                            child: TextField(
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
                                      width: screenWidth * 0.15,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Civil Status',
                                            style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.black,
                                            ),
                                          ),
                                          SizedBox(
                                            height: screenHeight * 0.07,
                                            child: TextField(
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
                                  'II. Medical History',
                                  style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                    fontFamily: 'OpenSansEB'
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
                                              color: Colors.black,
                                            ),
                                          ),
                                          SizedBox(
                                            height: screenHeight * 0.07,
                                            child: TextField(
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
                                      width: screenWidth * 0.2,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Past and Medical Condition',
                                            style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.black,
                                            ),
                                          ),
                                          SizedBox(
                                            height: screenHeight * 0.07,
                                            child: TextField(
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
                                      width: screenWidth * 0.15,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'History of STDs/STIs',
                                            style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.black,
                                            ),
                                          ),
                                          SizedBox(
                                            height: screenHeight * 0.07,
                                            child: TextField(
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
                                      width: screenWidth * 0.15,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'History of Hospitalization',
                                            style: TextStyle(
                                              fontSize: 15,
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
                                                  fontSize: 15,
                                                  color: Colors.black,
                                                  fontFamily: 'Italic',
                                                ),
                                              ),
                                              Checkbox(
                                                value: isCheckedNo,
                                                onChanged: (bool? value) {
                                                  setState(() {
                                                    isCheckedSuffix = value!;
                                                  });
                                                },
                                              ),
                                              Text(
                                                'No',
                                                style: TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.black,
                                                  fontFamily: 'Italic',
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
                                            ),
                                          ),
                                          SizedBox(
                                            height: screenHeight * 0.07,
                                            child: TextField(
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
                                      width: screenWidth * 0.22,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Family Medical History',
                                            style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.black,
                                            ),
                                          ),
                                          SizedBox(
                                            height: screenHeight * 0.07,
                                            child: TextField(
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
                                  'III. Sexual and Reproductive Health History',
                                  style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                    fontFamily: 'OpenSansEB'
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
                                              color: Colors.black,
                                            ),
                                          ),
                                          SizedBox(
                                            height: screenHeight * 0.07,
                                            child: TextField(
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
                                      width: screenWidth * 0.2,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Use of Contraceptives',
                                            style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.black,
                                            ),
                                          ),
                                          SizedBox(
                                            height: screenHeight * 0.07,
                                            child: TextField(
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
                                            ),
                                          ),
                                          SizedBox(
                                            height: screenHeight * 0.07,
                                            child: TextField(
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
                                      width: screenWidth * 0.2,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Date of Last Sexual Encounter',
                                            style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.black,
                                            ),
                                          ),
                                          SizedBox(
      height: screenHeight * 0.07,
      child: TextField(
        controller: _dateController,
        readOnly: true, // prevent keyboard from appearing
        onTap: () => _selectDate(context),
        style: const TextStyle(
          fontSize: 13,
          color: Colors.black,
        ),
        decoration: InputDecoration(
          hintText: 'Select Date',
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
        ),
      ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      width: screenWidth * 0.2,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Menstrual History',
                                            style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.black,
                                            ),
                                          ),
                                          SizedBox(
                                            height: screenHeight * 0.07,
                                            child: TextField(
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
                                      width: screenWidth * 0.22,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Pregnancy History',
                                            style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.black,
                                            ),
                                          ),
                                          SizedBox(
                                            height: screenHeight * 0.07,
                                            child: TextField(
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
                                  'IV. Symptoms and Current Complaints',
                                  style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                    fontFamily: 'OpenSansEB'
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
                                              color: Colors.black,
                                            ),
                                          ),
                                          SizedBox(
                                            height: screenHeight * 0.07,
                                            child: TextField(
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
                                      width: screenWidth * 0.2,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Abnormal Discharge',
                                            style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.black,
                                            ),
                                          ),
                                          SizedBox(
                                            height: screenHeight * 0.07,
                                            child: TextField(
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
                                      width: screenWidth * 0.15,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Urinary Problems',
                                            style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.black,
                                            ),
                                          ),
                                          SizedBox(
                                            height: screenHeight * 0.07,
                                            child: TextField(
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
                                    Text(
                                            'Select Symptoms',
                                            style: TextStyle(
                                              fontSize: 15,
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
                                            children: [
                                              Checkbox(
                                                value: CheckedSkinLessions,
                                                onChanged: (bool? value) {
                                                  setState(() {
                                                    CheckedSkinLessions = value ?? false;
                                                  });
                                                },
                                              ),
                                              Text(
                                                'Skin Lesions',
                                                style: TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.black,
                                                  fontFamily: 'Italic',
                                                ),
                                              ),
                                              Checkbox(
                                                value: CheckedFever,
                                                onChanged: (bool? value) {
                                                  setState(() {
                                                    CheckedFever = value ?? false;
                                                  });
                                                },
                                              ),
                                              Text(
                                                'Fever',
                                                style: TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.black,
                                                  fontFamily: 'Italic',
                                                ),
                                              ),
                                              Checkbox(
                                                value: CheckedBodyAche,
                                                onChanged: (bool? value) {
                                                  setState(() {
                                                    CheckedBodyAche = value ?? false;
                                                  });
                                                },
                                              ),
                                              Text(
                                                'Body Ache',
                                                style: TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.black,
                                                  fontFamily: 'Italic',
                                                ),
                                              ),

                                              Checkbox(
                                                value: CheckedItching,
                                                onChanged: (bool? value) {
                                                  setState(() {
                                                    CheckedItching = value ?? false;
                                                  });
                                                },
                                              ),
                                              Text(
                                                'Itching',
                                                style: TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.black,
                                                  fontFamily: 'Italic',
                                                ),
                                              ),
                                              Checkbox(
                                                value: CheckedPainfulIntercourse,
                                                onChanged: (bool? value) {
                                                  setState(() {
                                                    CheckedPainfulIntercourse = value ?? false;
                                                  });
                                                },
                                              ),
                                              Text(
                                                'Painful Intercourse',
                                                style: TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.black,
                                                  fontFamily: 'Italic',
                                                ),
                                              ),
                                              Checkbox(
                                                value: CheckedSwollenLymphNodes,
                                                onChanged: (bool? value) {
                                                  setState(() {
                                                    CheckedSwollenLymphNodes = value ?? false;
                                                  });
                                                },
                                              ),
                                              Text(
                                                'Swollen Lymph Nodes',
                                                style: TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.black,
                                                  fontFamily: 'Italic',
                                                ),
                                              ),
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
                                      children: [
                                        Checkbox(
                                                value: CheckedSkinRashes,
                                                onChanged: (bool? value) {
                                                  setState(() {
                                                    CheckedSkinRashes = value ?? false;
                                                  });
                                                },
                                              ),
                                              Text(
                                                'Skin Rashes',
                                                style: TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.black,
                                                  fontFamily: 'Italic',
                                                ),
                                              ),
                                              Checkbox(
                                                value: CheckedFatigue,
                                                onChanged: (bool? value) {
                                                  setState(() {
                                                    CheckedFatigue = value ?? false;
                                                  });
                                                },
                                              ),
                                              Text(
                                                'Fatigue',
                                                style: TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.black,
                                                  fontFamily: 'Italic',
                                                ),
                                              ),
                                              Checkbox(
                                                value: CheckedGenitalSores,
                                                onChanged: (bool? value) {
                                                  setState(() {
                                                    CheckedGenitalSores = value ?? false;
                                                  });
                                                },
                                              ),
                                              Text(
                                                'Genital Sores',
                                                style: TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.black,
                                                  fontFamily: 'Italic',
                                                ),
                                              ),
                                              Checkbox(
                                                value: CheckedInflammation,
                                                onChanged: (bool? value) {
                                                  setState(() {
                                                    CheckedInflammation = value ?? false;
                                                  });
                                                },
                                              ),
                                              Text(
                                                'Inflammation',
                                                style: TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.black,
                                                  fontFamily: 'Italic',
                                                ),
                                              ),
                                              Checkbox(
                                                value: CheckedAbnormalBleeding,
                                                onChanged: (bool? value) {
                                                  setState(() {
                                                    CheckedAbnormalBleeding = value ?? false;
                                                  });
                                                },
                                              ),
                                              Text(
                                                'Abnormal Bleeding',
                                                style: TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.black,
                                                  fontFamily: 'Italic',
                                                ),
                                              ),
                                              Checkbox(
                                                value: CheckedSoreThroat,
                                                onChanged: (bool? value) {
                                                  setState(() {
                                                    CheckedSoreThroat = value ?? false;
                                                  });
                                                },
                                              ),
                                              Text(
                                                'Sore Throat',
                                                style: TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.black,
                                                  fontFamily: 'Italic',
                                                )
                                              ),
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
                                            children: [
                                              Checkbox(
                                                value: CheckedChangeSkinColor,
                                                onChanged: (bool? value) {
                                                  setState(() {
                                                    CheckedChangeSkinColor = value ?? false;
                                                  });
                                                },
                                              ),
                                              Text(
                                                'Change in Skin Color',
                                                style: TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.black,
                                                  fontFamily: 'Italic',
                                                ),
                                              ),
                                              Checkbox(
                                                value: CheckedSwellingGenitalArea,
                                                onChanged: (bool? value) {
                                                  setState(() {
                                                    CheckedSwellingGenitalArea = value ?? false;
                                                  });
                                                },
                                              ),
                                              Text(
                                                'Swelling in Genital Area',
                                                style: TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.black,
                                                  fontFamily: 'Italic',
                                                ),
                                              ),
                                              Checkbox(
                                                value: CheckedOthers,
                                                onChanged: (bool? value) {
                                                  setState(() {
                                                    CheckedOthers = value ?? false;
                                                  });
                                                },
                                              ),
                                              Text(
                                                'Others',
                                                style: TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.black,
                                                  fontFamily: 'Italic',
                                                ),
                                              ),
                                              
                                            ],
                                          ),
                                  ]
                                ),
                                SizedBox(height: screenHeight * 0.02),
                                Text(
                                  'V. Laboratory and Diagnostic Tests',
                                  style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                    fontFamily: 'OpenSansEB',
                                  ),
                                ),
                                SizedBox(height: screenHeight * 0.02),
                                Wrap(
                                  spacing: responsiveSpacing,
                                  runSpacing: responsiveRunSpacing,
                                  children: [
                                    SizedBox(
                                      width: screenWidth * 0.2,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Blood Tests',
                                            style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.black,
                                            ),
                                          ),
                                          SizedBox(
                                            height: screenHeight * 0.07,
                                            child: TextField(
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
                                      width: screenWidth * 0.15,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Urinal Tests',
                                            style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.black,
                                            ),
                                          ),
                                          SizedBox(
                                            height: screenHeight * 0.07,
                                            child: TextField(
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
                                      width: screenWidth * 0.2,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Swab Tests',
                                            style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.black,
                                            ),
                                          ),
                                          SizedBox(
                                            height: screenHeight * 0.07,
                                            child: TextField(
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
                                            ),
                                          ),
                                          SizedBox(
                                            height: screenHeight * 0.07,
                                            child: TextField(
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
                                      width: screenWidth * 0.2,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Physical Examination Findings',
                                            style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.black,
                                            ),
                                          ),
                                          SizedBox(
                                            height: screenHeight * 0.07,
                                            child: TextField(
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
                                            ),
                                          ),
                                          SizedBox(
                                            height: screenHeight * 0.07,
                                            child: TextField(
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
                                      width: screenWidth * 0.10,
                                      height: screenHeight * 0.05,
                                      child: ElevatedButton(
                                        onPressed: () {
                                          Navigator.push(
						context,
						MaterialPageRoute(builder: (context) => PatientsPage()),
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
                                            fontSize: 15,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: screenWidth * 0.10,
                                      height: screenHeight * 0.05,
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
