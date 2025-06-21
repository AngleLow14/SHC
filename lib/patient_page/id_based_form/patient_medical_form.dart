import 'package:flutter/material.dart';
import 'package:shc/patient_page/id_based_form/treatment_form.dart';
import 'package:shc/patient_page/personal_information.dart';
import 'package:intl/intl.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';

class PatientForm extends StatefulWidget {
  final String patientId;
  const PatientForm({super.key, required this.patientId});
  @override
  _MedRecord createState() => _MedRecord();
}
class _MedRecord extends State<PatientForm> {
  final _formKey = GlobalKey<FormState>();
  final supabase = Supabase.instance.client;

  final TextEditingController _allergies = TextEditingController();
  final TextEditingController _pastConditions = TextEditingController();
  bool _stiYes = false;
  final TextEditingController _hospitalHistory = TextEditingController();
  final TextEditingController _currentMedication = TextEditingController();
  final TextEditingController _familyHistory = TextEditingController();

  // Sexual & Reprod Health
  final TextEditingController _numPartners = TextEditingController();
  final TextEditingController _contraceptives = TextEditingController();
  final TextEditingController _unprotectedSex = TextEditingController();
  bool _disableLastSex = false;
  final TextEditingController _menstrualHistory = TextEditingController();
  final TextEditingController _pregnancyHistory = TextEditingController();

  final TextEditingController _bloodTestsController = TextEditingController();
  final TextEditingController _urinalTestsController = TextEditingController();
  final TextEditingController _swabTestsController = TextEditingController();
  final TextEditingController _papSmearController = TextEditingController();
  final TextEditingController _physicalExamController = TextEditingController();
  final TextEditingController _semenalysisController = TextEditingController();
  final TextEditingController _infectionStatusController = TextEditingController();

  final TextEditingController _painController = TextEditingController();
  final TextEditingController _dischargeController = TextEditingController();
  final TextEditingController _urinaryProblemController = TextEditingController();
  List<String> _selectedSymptoms = [];

  DateTime? _lastSexDate;

  @override
  void dispose() {
    _allergies.dispose();
    _pastConditions.dispose();
    _hospitalHistory.dispose();
    _currentMedication.dispose();
    _familyHistory.dispose();
    _numPartners.dispose();
    _contraceptives.dispose();
    _unprotectedSex.dispose();
    _menstrualHistory.dispose();
    _pregnancyHistory.dispose();
    super.dispose();
  }
  
// Inside _MedicalHistoryFormPageState
void _submitFirstForm() async { // <--- Make the function async
  if (_formKey.currentState!.validate()) {
    // Await the result from the pushed page
    final resultFromTreatmentDiagnosis = await Navigator.push( // <--- Declare and assign
      context,
      MaterialPageRoute(
        builder: (_) => Treatment(
          patientId: widget.patientId,
          medicalHistoryData: {
            // Medical History
            'known_allergies': _allergies.text,
            'past_current_med_condition': _pastConditions.text,
            'sti_history': _stiYes ? 'Yes' : 'No',
            'hospitalization_history': _hospitalHistory.text,
            'current_medication': _currentMedication.text,
            'family_med_history': _familyHistory.text,

            // Sexual and Reproductive Health
            'number_of_sex_partner': int.tryParse(_numPartners.text) ?? 0,
            'use_of_contraceptives': _contraceptives.text,
            'history_of_unprotected_sex': _unprotectedSex.text,
            'date_of_last_sexual_encounter': _disableLastSex ? null : _lastSexDate?.toIso8601String(),
            'menstrual_history': _menstrualHistory.text,
            'pregnancy_history': _pregnancyHistory.text,

            // Laboratory Tests
            'blood_tests': _bloodTestsController.text,
            'urinal_tests': _urinalTestsController.text,
            'swab_tests': _swabTestsController.text,
            'pap_smear': _papSmearController.text,
            'physical_examination_findings': _physicalExamController.text,
            'semenalysis': _semenalysisController.text,
            'infection_status': _infectionStatusController.text,

            // Symptoms and Current Complaint
            'pain_or_discomfort': _painController.text,
            'abnormal_discharge': _dischargeController.text,
            'urinary_problem': _urinaryProblemController.text,
            'symptoms': _selectedSymptoms.join(', '), // Or store as List<String> if appropriate
          },
        ),
      ),
    );

    // After TreatmentDiagnosisFormPage has been popped, check its result
    if (resultFromTreatmentDiagnosis == true) {
      // Pop the current MedicalHistoryFormPage, also sending 'true' back to PatientInfoPage.
      Navigator.pop(context, true);
    }
  }
}

  Future<void> _selectDate(BuildContext ctx) async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: ctx,
      initialDate: now,
      firstDate: DateTime(now.year - 100),
      lastDate: now,
    );
    if (picked != null) setState(() => _lastSexDate = picked);
  }

  @override
  Widget build(BuildContext c) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    double responsiveSpacing = 20.0;
    double responsiveRunSpacing = 10.0;
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                  height: screenHeight * 0.1,
                  width: screenWidth,
                  color: const Color.fromARGB(255, 255, 245, 245),
                  child: Center(
                    child: Text(
                      '1 OUT OF 2',
                      style: TextStyle(fontSize: 15, color: const Color.fromARGB(255, 0, 0, 0), fontFamily: 'Italic',),
                    ),
                  ),
                ),
                Container(
                  height: screenHeight,
                  width: screenWidth * 0.9,
                  color: Colors.white,
                  child: SingleChildScrollView(
                    child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                           SizedBox(
                height: screenHeight * 0.02),
                                Text(
                                  'I. Medical History',
                                  style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                    fontFamily: 'OpenSansEB'
                                  ),
                                ),
              Wrap(
                spacing: responsiveSpacing,
                runSpacing: responsiveRunSpacing,
                children: [
                  SizedBox(
                    width: screenWidth * 0.1,
                    child: Column(
                      crossAxisAlignment:
                    CrossAxisAlignment.start,
                    children: [
              Text('Known Allergies', style: TextStyle(fontSize: 15,color: Colors.black,),),
              SizedBox(
                height: screenHeight * 0.06,
                child: TextFormField(controller: _allergies, style: TextStyle(fontSize: 12, color: Colors.black), decoration: InputDecoration(filled: true, fillColor: Colors.white, border: OutlineInputBorder( borderRadius: BorderRadius.circular(5.0,),),),),
                ),
                ]
              ),
              ),
              SizedBox(
                    width: screenWidth * 0.2,
                    child: Column(
                      crossAxisAlignment:
                    CrossAxisAlignment.start,
                    children: [
              Text('Past/Current Medical Condition', style: TextStyle(fontSize: 15,color: Colors.black,),),
              SizedBox(
                height: screenHeight * 0.06,
                child: TextFormField(controller: _pastConditions, style: TextStyle(fontSize: 12, color: Colors.black), decoration: InputDecoration(filled: true, fillColor: Colors.white, border: OutlineInputBorder( borderRadius: BorderRadius.circular(5.0,),),),),
                ),
                ]
              ),
              ),
              SizedBox(
                    width: screenWidth * 0.15,
                    child: Column(
                      crossAxisAlignment:
                    CrossAxisAlignment.start,
                    children: [
              Text('Hospitalization History', style: TextStyle(fontSize: 15,color: Colors.black,),),
              SizedBox(
                height: screenHeight * 0.06,
                child: TextFormField(controller: _hospitalHistory, style: TextStyle(fontSize: 12, color: Colors.black), decoration: InputDecoration(filled: true, fillColor: Colors.white, border: OutlineInputBorder( borderRadius: BorderRadius.circular(5.0,),),),),
                ),
                ]
              ),
              ),
              ]
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
              Text('Current Medication', style: TextStyle(fontSize: 15,color: Colors.black,),),
              SizedBox(
                height: screenHeight * 0.06,
                child: TextFormField(controller: _currentMedication, style: TextStyle(fontSize: 12, color: Colors.black), decoration: InputDecoration(filled: true, fillColor: Colors.white, border: OutlineInputBorder( borderRadius: BorderRadius.circular(5.0,),),),),
                ),
                ]
              ),
              ),
              SizedBox(
                    width: screenWidth * 0.2,
                    child: Column(
                      crossAxisAlignment:
                    CrossAxisAlignment.start,
                    children: [
              Text('Family Medical History', style: TextStyle(fontSize: 15,color: Colors.black,),),
              SizedBox(
                height: screenHeight * 0.06,
                child: TextFormField(controller: _familyHistory, style: TextStyle(fontSize: 12, color: Colors.black), decoration: InputDecoration(filled: true, fillColor: Colors.white, border: OutlineInputBorder( borderRadius: BorderRadius.circular(5.0,),),),),
                ),
                ]
              ),
              ),
              ]
              ),
              
              CheckboxListTile(title: const Text('STI History'), value: _stiYes, onChanged: (v) => setState(() => _stiYes = v!)),
              const SizedBox(height: 20),

              SizedBox(height: screenHeight * 0.02),
                                Text(
                                  'II. Sexual and Reproductive Health History',
                                  style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                    fontFamily: 'OpenSansEB'
                                  ),
                                ),

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
              Text('No. of Sex Partner', style: TextStyle(fontSize: 15,color: Colors.black,),),
              SizedBox(
                height: screenHeight * 0.06,
                child: TextFormField(controller: _numPartners, style: TextStyle(fontSize: 12, color: Colors.black), decoration: InputDecoration(filled: true, fillColor: Colors.white, border: OutlineInputBorder( borderRadius: BorderRadius.circular(5.0,),),),),
                ),
                ]
              ),
              ),
              SizedBox(
                    width: screenWidth * 0.2,
                    child: Column(
                      crossAxisAlignment:
                    CrossAxisAlignment.start,
                    children: [
              Text('Use of Contraceptives', style: TextStyle(fontSize: 15,color: Colors.black,),),
              SizedBox(
                height: screenHeight * 0.06,
                child: TextFormField(controller: _contraceptives, style: TextStyle(fontSize: 12, color: Colors.black), decoration: InputDecoration(filled: true, fillColor: Colors.white, border: OutlineInputBorder( borderRadius: BorderRadius.circular(5.0,),),),),
                ),
                ]
              ),
              ),
              SizedBox(
                    width: screenWidth * 0.15,
                    child: Column(
                      crossAxisAlignment:
                    CrossAxisAlignment.start,
                    children: [
              Text('History of Unprotected Sex', style: TextStyle(fontSize: 15,color: Colors.black,),),
              SizedBox(
                height: screenHeight * 0.06,
                child: TextFormField(controller: _unprotectedSex, style: TextStyle(fontSize: 12, color: Colors.black), decoration: InputDecoration(filled: true, fillColor: Colors.white, border: OutlineInputBorder( borderRadius: BorderRadius.circular(5.0,),),),),
                ),
                ]
              ),
              ),
              SizedBox(
                    width: screenWidth * 0.15,
                    child: Column(
                      crossAxisAlignment:
                    CrossAxisAlignment.start,
                    children: [
              Text('Pap Smear', style: TextStyle(fontSize: 15,color: Colors.black,),),
              SizedBox(
                height: screenHeight * 0.06,
                child: TextFormField(controller: _papSmearController, style: TextStyle(fontSize: 12, color: Colors.black), decoration: InputDecoration(filled: true, fillColor: Colors.white, border: OutlineInputBorder( borderRadius: BorderRadius.circular(5.0,),),),),
                ),
                ]
              ),
              ),
              ]
              ),

              Row(children: [
                Expanded(
                  child: Text(_lastSexDate == null ? 'Last Sex Encounter' : _lastSexDate!.toLocal().toString().split(' ')[0]),
                ),
                TextButton(
                  onPressed: _disableLastSex ? null : () => _selectDate(context),
                  child: const Text('Select Date'),
                ),
              ]),
              CheckboxListTile(
                title: const Text('Disable Date'),
                value: _disableLastSex,
                onChanged: (v) => setState(() => _disableLastSex = v!),
              ),

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
              Text('Menstrual History', style: TextStyle(fontSize: 15,color: Colors.black,),),
              SizedBox(
                height: screenHeight * 0.06,
                child: TextFormField(controller: _menstrualHistory, style: TextStyle(fontSize: 12, color: Colors.black), decoration: InputDecoration(filled: true, fillColor: Colors.white, border: OutlineInputBorder( borderRadius: BorderRadius.circular(5.0,),),),),
                ),
                ]
              ),
              ),
              SizedBox(
                    width: screenWidth * 0.2,
                    child: Column(
                      crossAxisAlignment:
                    CrossAxisAlignment.start,
                    children: [
              Text('Pregnancy History', style: TextStyle(fontSize: 15,color: Colors.black,),),
              SizedBox(
                height: screenHeight * 0.06,
                child: TextFormField(controller: _pregnancyHistory, style: TextStyle(fontSize: 12, color: Colors.black), decoration: InputDecoration(filled: true, fillColor: Colors.white, border: OutlineInputBorder( borderRadius: BorderRadius.circular(5.0,),),),),
                ),
                ]
              ),
              ),
              ]
              ),
              
              SizedBox(height: screenHeight * 0.02),
                                Text(
                                  'III. Laboratory and Diagnostic Tests',
                                  style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                    fontFamily: 'OpenSansEB',
                                  ),
                                ),
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
              Text('Blood Tests', style: TextStyle(fontSize: 15,color: Colors.black,),),
              SizedBox(
                height: screenHeight * 0.06,
                child: TextFormField(controller: _bloodTestsController, style: TextStyle(fontSize: 12, color: Colors.black), decoration: InputDecoration(filled: true, fillColor: Colors.white, border: OutlineInputBorder( borderRadius: BorderRadius.circular(5.0,),),),),
                ),
                ]
              ),
              ),
              SizedBox(
                    width: screenWidth * 0.15,
                    child: Column(
                      crossAxisAlignment:
                    CrossAxisAlignment.start,
                    children: [
              Text('Urinal Test', style: TextStyle(fontSize: 15,color: Colors.black,),),
              SizedBox(
                height: screenHeight * 0.06,
                child: TextFormField(controller: _urinalTestsController, style: TextStyle(fontSize: 12, color: Colors.black), decoration: InputDecoration(filled: true, fillColor: Colors.white, border: OutlineInputBorder( borderRadius: BorderRadius.circular(5.0,),),),),
                ),
                ]
              ),
              ),
              SizedBox(
                    width: screenWidth * 0.15,
                    child: Column(
                      crossAxisAlignment:
                    CrossAxisAlignment.start,
                    children: [
              Text('Swab Test', style: TextStyle(fontSize: 15,color: Colors.black,),),
              SizedBox(
                height: screenHeight * 0.06,
                child: TextFormField(controller: _swabTestsController, style: TextStyle(fontSize: 12, color: Colors.black), decoration: InputDecoration(filled: true, fillColor: Colors.white, border: OutlineInputBorder( borderRadius: BorderRadius.circular(5.0,),),),),
                ),
                ]
              ),
              ),
              SizedBox(
                    width: screenWidth * 0.15,
                    child: Column(
                      crossAxisAlignment:
                    CrossAxisAlignment.start,
                    children: [
              Text('Pap Smear', style: TextStyle(fontSize: 15,color: Colors.black,),),
              SizedBox(
                height: screenHeight * 0.06,
                child: TextFormField(controller: _papSmearController, style: TextStyle(fontSize: 12, color: Colors.black), decoration: InputDecoration(filled: true, fillColor: Colors.white, border: OutlineInputBorder( borderRadius: BorderRadius.circular(5.0,),),),),
                ),
                ]
              ),
              ),
              ]
              ),

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
              Text('Physical Examination Findings', style: TextStyle(fontSize: 15,color: Colors.black,),),
              SizedBox(
                height: screenHeight * 0.06,
                child: TextFormField(controller: _physicalExamController, style: TextStyle(fontSize: 12, color: Colors.black), decoration: InputDecoration(filled: true, fillColor: Colors.white, border: OutlineInputBorder( borderRadius: BorderRadius.circular(5.0,),),),),
                ),
                ]
              ),
              ),
              SizedBox(
                    width: screenWidth * 0.15,
                    child: Column(
                      crossAxisAlignment:
                    CrossAxisAlignment.start,
                    children: [
              Text('Semenalysis', style: TextStyle(fontSize: 15,color: Colors.black,),),
              SizedBox(
                height: screenHeight * 0.06,
                child: TextFormField(controller: _semenalysisController, style: TextStyle(fontSize: 12, color: Colors.black), decoration: InputDecoration(filled: true, fillColor: Colors.white, border: OutlineInputBorder( borderRadius: BorderRadius.circular(5.0,),),),),
                ),
                ]
              ),
              ),
              SizedBox(
                    width: screenWidth * 0.15,
                    child: Column(
                      crossAxisAlignment:
                    CrossAxisAlignment.start,
                    children: [
              Text('Infection Status', style: TextStyle(fontSize: 15,color: Colors.black,),),
              SizedBox(
                height: screenHeight * 0.06,
                child: TextFormField(controller: _infectionStatusController, style: TextStyle(fontSize: 12, color: Colors.black), decoration: InputDecoration(filled: true, fillColor: Colors.white, border: OutlineInputBorder( borderRadius: BorderRadius.circular(5.0,),),),),
                ),
                ]
              ),
              ),
              ]
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
              Text('Pain or Discomfort', style: TextStyle(fontSize: 15,color: Colors.black,),),
              SizedBox(
                height: screenHeight * 0.06,
                child: TextFormField(controller: _painController, style: TextStyle(fontSize: 12, color: Colors.black), decoration: InputDecoration(filled: true, fillColor: Colors.white, border: OutlineInputBorder( borderRadius: BorderRadius.circular(5.0,),),),),
                ),
                ]
              ),
              ),
              SizedBox(
                    width: screenWidth * 0.15,
                    child: Column(
                      crossAxisAlignment:
                    CrossAxisAlignment.start,
                    children: [
              Text('Abnormal Discharge', style: TextStyle(fontSize: 15,color: Colors.black,),),
              SizedBox(
                height: screenHeight * 0.06,
                child: TextFormField(controller: _dischargeController, style: TextStyle(fontSize: 12, color: Colors.black), decoration: InputDecoration(filled: true, fillColor: Colors.white, border: OutlineInputBorder( borderRadius: BorderRadius.circular(5.0,),),),),
                ),
                ]
              ),
              ),
              SizedBox(
                    width: screenWidth * 0.15,
                    child: Column(
                      crossAxisAlignment:
                    CrossAxisAlignment.start,
                    children: [
              Text('Urinary Problem', style: TextStyle(fontSize: 15,color: Colors.black,),),
              SizedBox(
                height: screenHeight * 0.06,
                child: TextFormField(controller: _urinaryProblemController, style: TextStyle(fontSize: 12, color: Colors.black), decoration: InputDecoration(filled: true, fillColor: Colors.white, border: OutlineInputBorder( borderRadius: BorderRadius.circular(5.0,),),),),
                ),
                ]
              ),
              ),
              ]
              ),

              Text('Select Symptoms:', style: TextStyle(fontWeight: FontWeight.bold)),
              Wrap(
                spacing: 8.0,
                children: [
                  for (var symptom in [
                    'Skin Lesions', 'Fever', 'Body Ache', 'Itching', 'Painful Intercourse', 'Swollen Lymph Nodes',
                    'Skin Rashes', 'Fatigue', 'Genital Sores', 'Inflammation', 'Abnormal Bleeding', 'Sore Throat',
                    'Change of Skin Color', 'Swelling in Genital Area', 'Others'
                  ])
                    FilterChip(
                      label: Text(symptom),
                      selected: _selectedSymptoms.contains(symptom),
                      onSelected: (bool selected) {
                        setState(() {
                          selected
                            ? _selectedSymptoms.add(symptom)
                            : _selectedSymptoms.remove(symptom);
                        });
                      },
                    )
                ],
              ),

              const SizedBox(height: 30),
              Container(
                width: screenWidth,
                height: screenHeight * 0.1,
                child: Wrap(
                  spacing: responsiveSpacing,
                  runSpacing: responsiveRunSpacing,
                  children: [
                ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                                          backgroundColor: const Color.fromRGBO(247, 198, 226, 1),
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 20,
                                            vertical: 12,
                                          ),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                              5,
                                            ),
                                            side: BorderSide(
                                              color: const Color.fromARGB(255, 255, 255, 255),
                                              width: 2,
                                            ),
                                          ),
                                        ),
                child: Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: _submitFirstForm,
                style: ElevatedButton.styleFrom(
                                          backgroundColor: const Color.fromRGBO(247, 198, 226, 1),
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 20,
                                            vertical: 12,
                                          ),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                              5,
                                            ),
                                            side: BorderSide(
                                              color: Colors.green.shade900,
                                              width: 2,
                                            ),
                                          ),
                                        ),
                child: const Text('Continue'),
              ),
                  ],
                )
              )

                    ],
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
