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
  DateTime? _lastSexEnDate;
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

  final TextEditingController _sexPartnerController = TextEditingController();
  final TextEditingController _contraceptivesController = TextEditingController();
  final TextEditingController _unprotectedSexController = TextEditingController();
  DateTime? _lastSexDate;
  bool _isNoSexChecked = false;

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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Medical History'),
        actions: [
          TextButton(
            child: const Text('Cancel', style: TextStyle(color: Colors.white)),
            onPressed: () => Navigator.pop(context),
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Medical History', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              TextFormField(controller: _allergies, decoration: const InputDecoration(labelText: 'Known Allergies')),
              TextFormField(controller: _pastConditions, decoration: const InputDecoration(labelText: 'Past/Current Medical Condition')),
              CheckboxListTile(title: const Text('STI History'), value: _stiYes, onChanged: (v) => setState(() => _stiYes = v!)),
              TextFormField(controller: _hospitalHistory, decoration: const InputDecoration(labelText: 'Hospitalization History')),
              TextFormField(controller: _currentMedication, decoration: const InputDecoration(labelText: 'Current Medication')),
              TextFormField(controller: _familyHistory, decoration: const InputDecoration(labelText: 'Family Medical History')),
              const SizedBox(height: 20),

              const Text('Sexual & Reproductive Health', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              TextFormField(controller: _numPartners, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'Number of Sex Partners')),
              TextFormField(controller: _contraceptives, decoration: const InputDecoration(labelText: 'Use of Contraceptives')),
              TextFormField(controller: _unprotectedSex, decoration: const InputDecoration(labelText: 'History of Unprotected Sex')),
              Row(children: [
                Expanded(
                  child: Text(_lastSexDate == null ? 'No Date Selected' : _lastSexDate!.toLocal().toString().split(' ')[0]),
                ),
                TextButton(
                  onPressed: _disableLastSex ? null : () => _selectDate(context),
                  child: const Text('Pick Date'),
                ),
              ]),
              CheckboxListTile(
                title: const Text('Disable Date of Last Sexual Encounter'),
                value: _disableLastSex,
                onChanged: (v) => setState(() => _disableLastSex = v!),
              ),
              TextFormField(controller: _menstrualHistory, decoration: const InputDecoration(labelText: 'Menstrual History')),
              TextFormField(controller: _pregnancyHistory, decoration: const InputDecoration(labelText: 'Pregnancy History')),
              const SizedBox(height: 20),

              const Text('Laboratory Tests', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              TextFormField(controller: _bloodTestsController, decoration: const InputDecoration(labelText: 'Blood Tests')),
              TextFormField(controller: _urinalTestsController, decoration: const InputDecoration(labelText: 'Urinal Tests')),
              TextFormField(controller: _swabTestsController, decoration: const InputDecoration(labelText: 'Swab Tests')),
              TextFormField(controller: _papSmearController, decoration: const InputDecoration(labelText: 'Pap Smear')),
              TextFormField(controller: _physicalExamController, decoration: const InputDecoration(labelText: 'Physical Examination Findings')),
              TextFormField(controller: _semenalysisController, decoration: const InputDecoration(labelText: 'Semenalysis')),
              TextFormField(controller: _infectionStatusController, decoration: const InputDecoration(labelText: 'Infection Status')),
              
              const SizedBox(height: 20),
              TextFormField(controller: _sexPartnerController, decoration: InputDecoration(labelText: 'Number of Sexual Partners'), keyboardType: TextInputType.number),
              TextFormField(controller: _contraceptivesController, decoration: InputDecoration(labelText: 'Use of Contraceptives')),
              TextFormField(controller: _unprotectedSexController, decoration: InputDecoration(labelText: 'History of Unprotected Sex')),
              Row(
                children: [
                  Expanded(
                    child: Text(_lastSexDate == null
                        ? 'Select Date of Last Sexual Encounter'
                        : 'Selected: ${_lastSexDate!.toLocal()}'.split(' ')[0]),
                  ),
                  Checkbox(
                    value: _isNoSexChecked,
                    onChanged: (val) {
                      setState(() {
                        _isNoSexChecked = val!;
                        if (_isNoSexChecked) _lastSexEnDate = null;
                      });
                    },
                  ),
                  const Text('None/No'),
                  IconButton(
                    icon: Icon(Icons.calendar_today),
                    onPressed: _isNoSexChecked
                        ? null
                        : () async {
                            DateTime? picked = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(1900),
                              lastDate: DateTime.now(),
                            );
                            if (picked != null) setState(() => _lastSexDate = picked);
                          },
                  ),
                ],
              ),

              const SizedBox(height: 20),
              TextFormField(controller: _painController, decoration: InputDecoration(labelText: 'Pain or Discomfort')),
              TextFormField(controller: _dischargeController, decoration: InputDecoration(labelText: 'Abnormal Discharge')),
              TextFormField(controller: _urinaryProblemController, decoration: InputDecoration(labelText: 'Urinary Problem')),
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
              ElevatedButton(
                onPressed: _submitFirstForm,
                child: const Text('Continue'),
              ),
            ],
          ),
        ),

      ),
    );
  }
}
