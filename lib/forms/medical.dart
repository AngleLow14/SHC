import 'package:flutter/material.dart';
import 'package:shc/forms/treatment.dart';
import 'package:shc/patient_page/patient_page.dart';
import 'package:intl/intl.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';

class AddMedicalRecord extends StatefulWidget {
  const AddMedicalRecord({super.key});
  @override
  _MedRecord createState() => _MedRecord();
}

class _MedRecord extends State<AddMedicalRecord> {
  final diagnosisId = const Uuid().v4();
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _middleNameController = TextEditingController();
  bool _middleNameNA = false;
  final TextEditingController _suffixController = TextEditingController();
  bool _suffixNA = false;
  DateTime? _birthday;
  final TextEditingController _placeOfBirthController = TextEditingController();
  final TextEditingController _houseNumberController = TextEditingController();
  final TextEditingController _streetController = TextEditingController();
  final TextEditingController _barangayController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _provinceController = TextEditingController();
  final TextEditingController _zipCodeController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _contactNumberController = TextEditingController();
  String? _civilStatus;
  String? _sex;

  final TextEditingController _knownAllergiesController = TextEditingController();
  final TextEditingController _pastMedConditionController = TextEditingController();
  final TextEditingController _stiHistoryController = TextEditingController();
  final TextEditingController _currentMedicationController = TextEditingController();
  final TextEditingController _familyMedHistoryController = TextEditingController();
  String? _hospitalizationHistory = 'No'; // default

  final TextEditingController _numSexPartnersController = TextEditingController();
  final TextEditingController _contraceptiveController = TextEditingController();
  List<String> _contraceptivesList = [];
  final TextEditingController _unprotectedSexController = TextEditingController();
  DateTime? _lastSexualEncounterDate;
  final TextEditingController _menstrualHistoryController = TextEditingController();
  final TextEditingController _pregnancyHistoryController = TextEditingController();

  final TextEditingController _painOrDiscomfortController = TextEditingController();
  final TextEditingController _abnormalDischargeController = TextEditingController();
  final TextEditingController _urinaryProblemController = TextEditingController();

  final Map<String, bool> _symptomsOptions = {
    "Skin Lesions": false,
    "Fever": false,
    "Body Ache": false,
    "Itching": false,
    "Painful Intercourse": false,
    "Swollen Lymph Nodes": false,
    "Skin Rushes": false,
    "Fatigue": false,
    "Genital Sores": false,
    "Inflammation": false,
    "Abnormal Bleeding": false,
    "Sore Throat": false,
    "Changes In Skin Color": false,
    "Swelling In Genital Area": false,
    "Others": false,
  };

  final TextEditingController _diagnosisInfoController = TextEditingController();

  final TextEditingController _bloodTestsController = TextEditingController();
  final TextEditingController _urinalTestsController = TextEditingController();
  final TextEditingController _swabTestsController = TextEditingController();
  final TextEditingController _papSmearController = TextEditingController();
  final TextEditingController _physicalFindingsController = TextEditingController();
  final TextEditingController _semenalysisController = TextEditingController();
  final TextEditingController _infectionStatusController = TextEditingController();

  // For patient_number generation (simplified for this example)
  Future<String> _generatePatientNumber() async {
    final year = DateTime.now().year;

    // Query latest patient_number for the current year
    final response = await Supabase.instance.client
        .from('patient')
        .select('patient_number')
        .like('patient_number', '$year-%')
        .order('patient_number', ascending: false)
        .limit(1);

    if (response.isEmpty) {
      return '$year-0001';
    } else {
      final lastNumber = response[0]['patient_number'];
      final lastSeq = int.parse(lastNumber.split('-')[1]);
      final nextSeq = (lastSeq + 1).toString().padLeft(4, '0');
      return '$year-$nextSeq';
    }
  }

  Future<void> _selectBirthday(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _birthday ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != _birthday) {
      setState(() {
        _birthday = picked;
      });
    }
  }

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
                    child: Form(
                      key: _formKey,
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(16.0),
                            width: screenWidth * 0.75,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
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
                                            height: screenHeight * 0.06,
                                            child: TextFormField(
                                              controller: _lastNameController,
                                              style: TextStyle(
                                                fontSize: 12,
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
                                              validator: (value) {
                                                if (value == null || value.isEmpty) {
                                                  return 'Please enter the last name';
                                                }
                                                return null;
                                              },
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
                                            height: screenHeight * 0.06,
                                            child: TextFormField(
                                              controller: _firstNameController,
                                              style: TextStyle(
                                                fontSize: 12,
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
                                              validator: (value) {
                                                if (value == null || value.isEmpty) {
                                                  return 'Please enter the first name';
                                                }
                                                return null;
                                              },
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
                                            height: screenHeight * 0.06,
                                            child: TextFormField(
                                              controller: _middleNameController,
                                              style: TextStyle(
                                                fontSize: 12,
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
                                                value: _middleNameNA,
                                                onChanged: (bool? value) {
                                                  setState(() {
                                                    _middleNameNA = value!;
                                                    if (_middleNameNA) {
                                                      _middleNameController.text = 'N/A';
                                                    } else if (_middleNameController.text == 'N/A') {
                                                      _middleNameController.clear();
                                                    }
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
                                            height: screenHeight * 0.06,
                                            child: TextFormField(
                                              controller: _suffixController,
                                              style: TextStyle(
                                                fontSize: 12,
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
                                                value: _suffixNA,
                                                onChanged: (bool? value) {
                                                  setState(() {
                                                    _suffixNA = value!;
                                                    if (_suffixNA) {
                                                      _suffixController.text = 'N/A';
                                                    } else if (_suffixController.text == 'N/A') {
                                                      _suffixController.clear();
                                                    }
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
                                          InkWell(
                                              onTap: () => _selectBirthday(context),
                                              child: InputDecorator(
                                                decoration: InputDecoration(
                                                  hintText: 'Select your birthday',
                                                ),
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: <Widget>[
                                                    Text(
                                                      _birthday == null
                                                          ? 'Select Date'
                                                          : DateFormat('yyyy-MM-dd').format(_birthday!),
                                                    ),
                                                    const Icon(Icons.calendar_today),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            if (_birthday == null)
                                            const Padding(
                                              padding: EdgeInsets.only(top: 5.0),
                                              child: Text(
                                                'Please select the birthday',
                                                style: TextStyle(color: Colors.red, fontSize: 12),
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
                                            height: screenHeight * 0.06,
                                            child: TextFormField(
                                              controller: _placeOfBirthController,
                                              style: TextStyle(
                                                fontSize: 12,
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
                                            height: screenHeight * 0.06,
                                            child: TextFormField(
                                              controller: _houseNumberController,
                                              style: TextStyle(
                                                fontSize: 12,
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
                                            height: screenHeight * 0.06,
                                            child: TextFormField(
                                              controller: _streetController,
                                              style: TextStyle(
                                                fontSize: 12,
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
                                            height: screenHeight * 0.06,
                                            child: TextFormField(
                                              controller: _barangayController,
                                              style: TextStyle(
                                                fontSize: 12,
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
                                            'City/Municipality',
                                            style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.black,
                                            ),
                                          ),
                                          SizedBox(
                                            height: screenHeight * 0.06,
                                            child: TextFormField(
                                              controller: _cityController,
                                              style: TextStyle(
                                                fontSize: 12,
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
                                            height: screenHeight * 0.06,
                                            child: TextFormField(
                                              controller: _provinceController,
                                              style: TextStyle(
                                                fontSize: 12,
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
                                            height: screenHeight * 0.06,
                                            child: TextFormField(
                                              controller: _zipCodeController,
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
                                            height: screenHeight * 0.06,
                                            child: TextFormField(
                                              controller: _emailController,
                                              style:  TextStyle(
                                                fontSize: 12,
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
                                              validator: (value) {
                                                if (value == null || value.isEmpty) {
                                                  return 'Please enter the email';
                                                }
                                                if (!value.contains('@')) {
                                                  return 'Please enter a valid email address';
                                                }
                                                return null;
                                              },
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
                                            'Contact Number',
                                            style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.black,
                                            ),
                                          ),
                                          SizedBox(
                                            height: screenHeight * 0.06,
                                            child: TextFormField(
                                              controller: _contactNumberController,
                                              style: TextStyle(
                                                fontSize: 12,
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
                                            height: screenHeight * 0.06,
                                            child: DropdownButtonFormField<String>(
                                              decoration: InputDecoration(),
                                              value: _civilStatus,
                                              items: <String>['Single', 'Married', 'Widowed', 'Annulled', 'Divorced', 'Other']
                                                  .map((String value) {
                                                return DropdownMenuItem<String>(
                                                  value: value,
                                                  child: Text(value),
                                                );
                                              }).toList(),
                                              onChanged: (String? newValue) {
                                                setState(() {
                                                  _civilStatus = newValue;
                                                });
                                              },
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
                                            'Sex',
                                            style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.black,
                                            ),
                                          ),
                                          SizedBox(
                                            height: screenHeight * 0.06,
                                            child: DropdownButtonFormField<String>(
                                              decoration: InputDecoration(),
                                              value: _sex,
                                              items: <String>['Male', 'Female'].map((String value) {
                                                return DropdownMenuItem<String>(
                                                  value: value,
                                                  child: Text(value),
                                                );
                                              }).toList(),
                                              onChanged: (String? newValue) {
                                                setState(() {
                                                  _sex = newValue;
                                                });
                                              },
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
                                            height: screenHeight * 0.06,
                                            child: TextFormField(
                                              controller: _knownAllergiesController,
                                              style: TextStyle(
                                                fontSize: 12,
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
                                            height: screenHeight * 0.06,
                                            child: TextFormField(
                                              controller: _pastMedConditionController,
                                              style: TextStyle(
                                                fontSize: 12,
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
                                            height: screenHeight * 0.06,
                                            child: TextFormField(
                                              controller: _stiHistoryController,
                                              style: TextStyle(
                                                fontSize: 12,
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
                                              Expanded(
                                                child: CheckboxListTile(
                                                  title: const Text('Yes'),
                                                  value: _hospitalizationHistory == 'Yes',
                                                  onChanged: (val) {
                                                    if (val == true) {
                                                      setState(() {
                                                        _hospitalizationHistory = 'Yes';
                                                      });
                                                    }
                                                  },
                                                ),
                                              ),
                                              Expanded(
                                                child: CheckboxListTile(
                                                  title: const Text('No'),
                                                  value: _hospitalizationHistory == 'No',
                                                  onChanged: (val) {
                                                    if (val == true) {
                                                      setState(() {
                                                        _hospitalizationHistory = 'No';
                                                      });
                                                    }
                                                  },
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
                                            height: screenHeight * 0.06,
                                            child: TextFormField(
                                              controller: _currentMedicationController,
                                              style: TextStyle(
                                                fontSize: 12,
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
                                            height: screenHeight * 0.06,
                                            child: TextFormField(
                                              controller: _familyMedHistoryController,
                                              style: TextStyle(
                                                fontSize: 12,
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
                                            height: screenHeight * 0.06,
                                            child: TextFormField(
                                              controller: _numSexPartnersController,
                                              style: TextStyle(
                                                fontSize: 12,
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
                                              keyboardType: TextInputType.number,
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
                                            height: screenHeight * 0.06,
                                            child: TextFormField(
                                              controller: _contraceptiveController,
                                              style: TextStyle(
                                                fontSize: 12,
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
                                            'Add Another',
                                            style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.black,
                                            ),
                                          ),
                                          SizedBox(
                                            height: screenHeight * 0.06,
                                            child: ElevatedButton(
                                              onPressed: () {
                                                if (_contraceptiveController.text.isNotEmpty) {
                                                  setState(() {
                                                    _contraceptivesList.add(_contraceptiveController.text);
                                                    _contraceptiveController.clear();
                                                  });
                                                }
                                              },
                                              child: const Text('Add Contraceptive'),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Wrap(
                                      spacing: 6,
                                      children: _contraceptivesList.map((item) => Chip(label: Text(item))).toList(),
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
                                            height: screenHeight * 0.06,
                                            child: TextFormField(
                                              controller: _unprotectedSexController,
                                              style: TextStyle(
                                                fontSize: 12,
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
                                            height: screenHeight * 0.06,
                                            child: TextFormField(
                                              readOnly: true,
                                              decoration: InputDecoration(
                                                suffixIcon: const Icon(Icons.calendar_today),
                                              ),
                                              onTap: () async {
                                                final picked = await showDatePicker(
                                                  context: context,
                                                  initialDate: DateTime.now(),
                                                  firstDate: DateTime(1900),
                                                  lastDate: DateTime.now(),
                                                );
                                                if (picked != null) {
                                                  setState(() {
                                                    _lastSexualEncounterDate = picked;
                                                  });
                                                }
                                              },
                                              controller: TextEditingController(
                                                text: _lastSexualEncounterDate != null
                                                    ? DateFormat('yyyy-MM-dd').format(_lastSexualEncounterDate!)
                                                    : '',
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
                                            height: screenHeight * 0.06,
                                            child: TextFormField(
                                              controller: _menstrualHistoryController,
                                              style: TextStyle(
                                                fontSize: 12,
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
                                            height: screenHeight * 0.06,
                                            child: TextFormField(
                                              controller: _pregnancyHistoryController,
                                              style: TextStyle(
                                                fontSize: 12,
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
                                            height: screenHeight * 0.06,
                                            child: TextFormField(
                                              controller: _painOrDiscomfortController,
                                              style: TextStyle(
                                                fontSize: 12,
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
                                            height: screenHeight * 0.06,
                                            child: TextFormField(
                                              controller: _abnormalDischargeController,
                                              style: TextStyle(
                                                fontSize: 12,
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
                                            height: screenHeight * 0.06,
                                            child: TextFormField(
                                              controller: _urinaryProblemController,
                                              style: TextStyle(
                                                fontSize: 12,
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
                                  Column(
                                    children: _symptomsOptions.keys.map((symptom) {
                                      return CheckboxListTile(
                                        title: Text(symptom),
                                        value: _symptomsOptions[symptom],
                                        onChanged: (value) {
                                          setState(() {
                                            _symptomsOptions[symptom] = value!;
                                          });
                                        },
                                      );
                                    }).toList(),
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
                                      width: screenWidth * 0.15,
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
                                            height: screenHeight * 0.06,
                                            child: TextFormField(
                                              controller: _bloodTestsController,
                                              style: TextStyle(
                                                fontSize: 12,
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
                                            height: screenHeight * 0.06,
                                            child: TextFormField(
                                              controller: _urinalTestsController,
                                              style: TextStyle(
                                                fontSize: 12,
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
                                            'Swab Tests',
                                            style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.black,
                                            ),
                                          ),
                                          SizedBox(
                                            height: screenHeight * 0.06,
                                            child: TextFormField(
                                              controller: _swabTestsController,
                                              style: TextStyle(
                                                fontSize: 12,
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
                                            height: screenHeight * 0.06,
                                            child: TextFormField(
                                              controller: _papSmearController,
                                              style: TextStyle(
                                                fontSize: 12,
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
                                            height: screenHeight * 0.06,
                                            child: TextFormField(
                                              controller: _physicalFindingsController,
                                              style: TextStyle(
                                                fontSize: 12,
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
                                            height: screenHeight * 0.06,
                                            child: TextFormField(
                                              controller: _semenalysisController,
                                              style: TextStyle(
                                                fontSize: 12,
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
                                            'Infection Status',
                                            style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.black,
                                            ),
                                          ),
                                          SizedBox(
                                            height: screenHeight * 0.06,
                                            child: TextFormField(
                                              controller: _infectionStatusController,
                                              style: TextStyle(
                                                fontSize: 12,
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
                                      width: screenWidth * 0.3,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Diagnosis Information',
                                            style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.black,
                                            ),
                                          ),
                                          SizedBox(
                                            height: screenHeight * 0.06,
                                            child: TextFormField(
                                              controller: _diagnosisInfoController,
                                              style: TextStyle(
                                                fontSize: 12,
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
                                              maxLines: 3,
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
                                  children: <Widget>[
                                    SizedBox(
                                      width: screenWidth * 0.10,
                                      height: screenHeight * 0.05,
                                      child: ElevatedButton(
                                        onPressed: () {
                                            Navigator.pop(context);
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
                                        onPressed: () async {
                        if (_formKey.currentState!.validate() && _birthday != null) {
                          final patientId = const Uuid().v4();
                          final patientNumber = await _generatePatientNumber();

                          final selectedSymptoms = _symptomsOptions.entries
                              .where((entry) => entry.value)
                              .map((entry) => entry.key)
                              .toList();

                          try {
                            // Insert patient
                            final insertResponse = await Supabase.instance.client
                                .from('patient')
                                .insert({
                              'patient_id': patientId,
                              'last_name': _lastNameController.text,
                              'first_name': _firstNameController.text,
                              'middle_name': _middleNameNA ? null : _middleNameController.text,
                              'suffix': _suffixNA ? null : _suffixController.text,
                              'birthday': DateFormat('yyyy-MM-dd').format(_birthday!),
                              'place_of_birth': _placeOfBirthController.text,
                              'house_number': _houseNumberController.text,
                              'street': _streetController.text,
                              'barangay': _barangayController.text,
                              'city': _cityController.text,
                              'province': _provinceController.text,
                              'zip_code': _zipCodeController.text,
                              'email': _emailController.text,
                              'contact_number': _contactNumberController.text,
                              'civil_status': _civilStatus,
                              'sex': _sex,
                              'patient_number': patientNumber,
                            })
                                .select()
                                .single();

                            if (insertResponse != null) {
                              // Insert medical_history
                              await Supabase.instance.client.from('medical_history').insert({
                                'patient_id': patientId,
                                'known_allergies': _knownAllergiesController.text.isEmpty ? null : _knownAllergiesController.text,
                                'past_current_med_condition': _pastMedConditionController.text.isEmpty ? null : _pastMedConditionController.text,
                                'sti_history': _stiHistoryController.text.isEmpty ? null : _stiHistoryController.text,
                                'hospitalization_history': _hospitalizationHistory,
                                'current_medication': _currentMedicationController.text.isEmpty ? null : _currentMedicationController.text,
                                'family_med_history': _familyMedHistoryController.text.isEmpty ? null : _familyMedHistoryController.text,
                              });

                              // Insert sexual_and_reproductive_health
                              await Supabase.instance.client.from('sexual_and_reproductive_health').insert({
                                'patient_id': patientId,
                                'number_of_sex_partner': int.tryParse(_numSexPartnersController.text),
                                'use_of_contraceptives': _contraceptivesList.isEmpty ? null : _contraceptivesList.join(', '),
                                'history_of_unprotected_sex': _unprotectedSexController.text.isEmpty ? null : _unprotectedSexController.text,
                                'date_of_last_sexual_encounter': _lastSexualEncounterDate != null
                                    ? DateFormat('yyyy-MM-dd').format(_lastSexualEncounterDate!)
                                    : null,
                                'menstrual_history': _menstrualHistoryController.text.isEmpty ? null : _menstrualHistoryController.text,
                                'pregnancy_history': _pregnancyHistoryController.text.isEmpty ? null : _pregnancyHistoryController.text,
                              });

                              // Insert symptoms_and_current_complaint
                              await Supabase.instance.client.from('symptoms_and_current_complaint').insert({
                                'patient_id': patientId,
                                'pain_or_discomfort': _painOrDiscomfortController.text.isEmpty ? null : _painOrDiscomfortController.text,
                                'abnormal_discharge': _abnormalDischargeController.text.isEmpty ? null : _abnormalDischargeController.text,
                                'urinary_problems': _urinaryProblemController.text.isEmpty ? null : _urinaryProblemController.text,
                                'symptoms': selectedSymptoms.isEmpty ? null : selectedSymptoms.join(', '),
                              });

                              await Supabase.instance.client.from('laboratory_test').insert({
                                'patient_id': patientId,
                                'blood_tests': _bloodTestsController.text.isEmpty ? null : _bloodTestsController.text,
                                'urinal_tests': _urinalTestsController.text.isEmpty ? null : _urinalTestsController.text,
                                'swab_tests': _swabTestsController.text.isEmpty ? null : _swabTestsController.text,
                                'pap_smear': _papSmearController.text.isEmpty ? null : _papSmearController.text,
                                'physical_examination_findings': _physicalFindingsController.text.isEmpty ? null : _physicalFindingsController.text,
                                'semenalysis': _semenalysisController.text.isEmpty ? null : _semenalysisController.text,
                                'infection_status': _infectionStatusController.text.isEmpty ? null : _infectionStatusController.text,
                                // 'date' is auto-set in Supabase if default configured
                              });

                              final diagnosisId = const Uuid().v4();
                              // Navigate to form2 with patientData
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Treatment(
                                    patientData:{
                                      ...insertResponse, // patient_id, patient_number, etc.
                                      'diagnosis_id': diagnosisId,
                                    },
                                  ),
                                ),
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Failed to save patient.')),
                              );
                            }
                          } catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Error saving data: $e')),
                            );
                            print('Error saving data: $e'); // Print the error to console for debugging
                          }
                        } else if (_birthday == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Please select the birthday.')),
                          );
                        }
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
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
