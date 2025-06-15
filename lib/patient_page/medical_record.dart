import 'package:flutter/material.dart';
import 'package:shc/patient_page/personal_information.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:intl/intl.dart';

class ViewDetails extends StatefulWidget {
  final Map<String, dynamic> data;

  const ViewDetails({super.key, required this.data});

  @override
  _ViewDetailsState createState() => _ViewDetailsState();
}

class _ViewDetailsState extends State<ViewDetails> {
  final supabase = Supabase.instance.client;

  Map<String, dynamic>? _laboratoryTest;
  Map<String, dynamic>? _sexualHealthData;
  Map<String, dynamic>? _symptomsData;
  Map<String, dynamic>? _treatmentPlan;
  Map<String, dynamic>? _diagnosis;

  @override
  void initState() {
    super.initState();
    _fetchMedicalRecords();
  }

  Future<void> _fetchMedicalRecords() async {
    // Fetch all data concurrently
    final results = await Future.wait([
      supabase.from('laboratory_test').select().eq('patient_id', widget.data['patient_id']).order('date', ascending: false).limit(1),
      supabase.from('sexual_and_reproductive_health').select().eq('patient_id', widget.data['patient_id']).order('date', ascending: false).limit(1),
      supabase.from('symptoms_and_current_complaint').select().eq('patient_id', widget.data['patient_id']).order('date', ascending: false).limit(1),
      supabase.from('treatment_plan').select().eq('patient_id', widget.data['patient_id']).order('date', ascending: false).limit(1),
      supabase.from('diagnosis').select().eq('patient_id', widget.data['patient_id']).order('date', ascending: false).limit(1),
    ]);

    setState(() {
      _laboratoryTest = results[0].isNotEmpty ? results[0].first : null;
      _sexualHealthData = results[1].isNotEmpty ? results[1].first : null;
      _symptomsData = results[2].isNotEmpty ? results[2].first : null;
      _treatmentPlan = results[3].isNotEmpty ? results[3].first : null;
      _diagnosis = results[4].isNotEmpty ? results[4].first : null;
    });
  }

@override
  Widget build(BuildContext context) {
    final history = widget.data;
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
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Center(
                                  child: Text(
                                  '${history['date'] ?? 'N/A'}',
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
                                const SizedBox(height: 8),
                                _diagnosis == null
                                    ? const Text('No diagnosis records found.')
                                    : Column(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                Center(
                                  child: Text(
                                  'Diagnosis',
                                  style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                    fontFamily: 'OpenSansEB',
                                  ),
                                ),
                                ),
                                Text(
                                              '${_diagnosis!['diagnosis_inf'] ?? 'N/A'}',
                                              style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.black,
                                              ),
                                            ),
                                ]
                                ),
                                SizedBox(height: screenHeight * 0.02),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [                                 
                                  Wrap(
                                    spacing: responsiveSpacing,
                                    runSpacing: responsiveRunSpacing,
                                    children: [

                                      SizedBox(
                                        width: screenWidth * 0.15,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
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
                                              '${history['known_allergies'] ?? 'N/A'}',
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
                                              CrossAxisAlignment.center,
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
                                              ' ${history['past_current_med_condition'] ?? 'N/A'}',
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
                                              CrossAxisAlignment.center,
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
                                              '${history['sti_history'] ?? 'N/A'}',
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
                                              CrossAxisAlignment.center,
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
                                              '${history['hospitalization_history'] ?? 'N/A'}',
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
                                              CrossAxisAlignment.center,
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
                                              '${history['current_medication'] ?? 'N/A'}',
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
                                              CrossAxisAlignment.center,
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
                                              ' ${history['family_med_history'] ?? 'N/A'}',
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
                                  ]
                                ),
                                const Divider(),
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
                                _sexualHealthData == null
                                ? const Text('No sexual/reproductive health records found.')
                                :  Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                  Wrap(
                                    spacing: responsiveSpacing,
                                    runSpacing: responsiveRunSpacing,
                                    children: [
                                      SizedBox(
                                        width: screenWidth * 0.15,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
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
                                              '${_sexualHealthData!['number_of_sex_partner'] ?? 'N/A'}',
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
                                              CrossAxisAlignment.center,
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
                                              '${_sexualHealthData!['use_of_contraceptives'] ?? 'N/A'}',
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
                                              CrossAxisAlignment.center,
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
                                              '${_sexualHealthData!['history_of_unprotected_sex'] ?? 'N/A'}',
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
                                              CrossAxisAlignment.center,
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
                                              '${_sexualHealthData!['date_of_last_sexual_encounter'] ?? 'N/A'}',
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
                                              CrossAxisAlignment.center,
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
                                              '${_sexualHealthData!['menstrual_history'] ?? 'N/A'}',
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
                                              CrossAxisAlignment.center,
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
                                              '${_sexualHealthData!['pregnancy_history'] ?? 'N/A'}',
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
                                  ]
                                ),
                                const Divider(),
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
                                _symptomsData == null
                                ? const Text('No symptoms or complaints found.')
                                :  Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                  Wrap(
                                    spacing: responsiveSpacing,
                                    runSpacing: responsiveRunSpacing,
                                    children: [
                                      SizedBox(
                                        width: screenWidth * 0.15,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
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
                                              '${_symptomsData!['pain_or_discomfort'] ?? 'N/A'}',
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
                                              CrossAxisAlignment.center,
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
                                              '${_symptomsData!['abnormal_discharge'] ?? 'N/A'}',
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
                                              CrossAxisAlignment.center,
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
                                              '${_symptomsData!['urinary_problem'] ?? 'N/A'}',
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
                                              CrossAxisAlignment.center,
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
                                              '${_symptomsData!['symptoms'] ?? 'N/A'}',
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
                                  ]
                                ),
                                const Divider(),
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
                                _laboratoryTest == null
                                ? const Text('No laboratory test records found.')
                                :Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                Wrap(
                                  spacing: responsiveSpacing,
                                  runSpacing: responsiveRunSpacing,
                                  children: [
                                    SizedBox(
                                      width: screenWidth * 0.15,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
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
                                            '${_laboratoryTest!['blood_tests'] ?? 'N/A'}',
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
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            'Infection Status',
                                            style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          SizedBox(
                                            height: screenHeight * 0.07,
                                            child: Text(
                                            '${_laboratoryTest!['infection_status'] ?? 'N/A'}',
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
                                            CrossAxisAlignment.center,
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
                                            '${_laboratoryTest!['urinal_tests'] ?? 'N/A'}',
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
                                            CrossAxisAlignment.center,
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
                                            '${_laboratoryTest!['swab_tests'] ?? 'N/A'}',
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
                                            CrossAxisAlignment.center,
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
                                            '${_laboratoryTest!['physical_examination_findings'] ?? 'N/A'}',
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
                                            CrossAxisAlignment.center,
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
                                            '${_laboratoryTest!['semenalysis'] ?? 'N/A'}',
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
                                            CrossAxisAlignment.center,
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
                                            '${_laboratoryTest!['pap_smear'] ?? 'N/A'}',
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
                                ]
                                ),
                                const Divider(),
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
                                _treatmentPlan == null
                                ? const Text('No treatment plans found.')
                                : Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                Wrap(
                                  spacing: responsiveSpacing,
                                  runSpacing: responsiveRunSpacing,
                                  children: [
                                    SizedBox(
                                      width: screenWidth * 0.15,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
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
                                            ' ${_treatmentPlan!['prescription'] ?? 'N/A'}',
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
                                            CrossAxisAlignment.center,
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
                                            '${_treatmentPlan!['quantity'] ?? 'N/A'}',
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
                                            CrossAxisAlignment.center,
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
                                            '${_treatmentPlan!['frequency'] ?? 'N/A'}',
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
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            'For Referral',
                                            style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                            ),
                                          ),
                                          SizedBox(
                                            height: screenHeight * 0.07,
                                            child: Text(
                                            '${(_treatmentPlan!['for_referral'] as bool?) == true ? 'Yes' : 'No'}',
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
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            'Validation',
                                            style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                            ),
                                          ),
                                          SizedBox(
                                            height: screenHeight * 0.07,
                                            child: Text(
                                            '${_treatmentPlan!['validity_date'] ?? 'N/A'}',
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
                                            CrossAxisAlignment.center,
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
                                            "${_treatmentPlan!['follow_up_check_up'] ?? 'N/A'}",
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
                                ]
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
                                          Navigator.pop(context); },
                  style: ButtonStyle(
                    textStyle: WidgetStateProperty.all<TextStyle>(
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