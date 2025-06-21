import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

class Treatment extends StatefulWidget {
  final String patientId;
  final Map<String, dynamic> medicalHistoryData;

  const Treatment({
    super.key,
    required this.patientId,
    required this.medicalHistoryData,
  });  
  @override
  _TreatmState createState() => _TreatmState();
}

class _TreatmState extends State<Treatment> {
  final _formKey = GlobalKey<FormState>();
  final supabase = Supabase.instance.client;
  final uuid = const Uuid();

  final TextEditingController _prescription = TextEditingController();
  final TextEditingController _quantity = TextEditingController();
  final TextEditingController _frequency = TextEditingController();
  final TextEditingController _diagnosisInfo = TextEditingController();

  bool _forReferral = false;
  bool _active = true;
  DateTime? _followUpDate;
  DateTime? _validityDate;

  @override
  void dispose() {
    _prescription.dispose();
    _quantity.dispose();
    _frequency.dispose();
    _diagnosisInfo.dispose();
    super.dispose();
  }

  Future<void> _selectFollowUpDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (picked != null) setState(() => _followUpDate = picked);
  }

  Future<void> _selectValidityDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (picked != null) setState(() => _validityDate = picked);
  }

  Future<void> _submitAll() async {
    if (!_formKey.currentState!.validate()) return;

    final treatmentId = uuid.v4();
    final diagnosisId = uuid.v4();

    try {
      // Insert treatment_plan
      await supabase.from('treatment_plan').insert({
        'treatment_id': treatmentId,
        'patient_id': widget.patientId,
        'prescription': _prescription.text,
        'quantity': int.tryParse(_quantity.text) ?? 0,
        'frequency': _frequency.text,
        'for_referral': _forReferral,
        'follow_up_check_up': _followUpDate?.toIso8601String(),
        'validity_date': _validityDate?.toIso8601String(),
        'active': _active,
      });

      // Insert diagnosis
      await supabase.from('diagnosis').insert({
        'diagnosis_id': diagnosisId,
        'patient_id': widget.patientId,
        'treatment_id': treatmentId,
        'diagnosis_inf': _diagnosisInfo.text,
      });

      // Insert medical_history
      final mh = widget.medicalHistoryData;
      await supabase.from('medical_history').insert({
        'patient_id': widget.patientId,
        'known_allergies': mh['known_allergies'],
        'past_current_med_condition': mh['past_current_med_condition'],
        'sti_history': mh['sti_history'],
        'hospitalization_history': mh['hospitalization_history'],
        'current_medication': mh['current_medication'],
        'family_med_history': mh['family_med_history'],
        // Add date column if exists and is required in medical_history table
        'date': DateTime.now().toIso8601String(), // Assuming a 'date' column for medical history
      });

      // Insert sexual and reproductive health
      await supabase.from('sexual_and_reproductive_health').insert({
        'patient_id': widget.patientId,
        'number_of_sex_partner': mh['number_of_sex_partner'],
        'use_of_contraceptives': mh['use_of_contraceptives'],
        'history_of_unprotected_sex': mh['history_of_unprotected_sex'],
        'date_of_last_sexual_encounter': mh['date_of_last_sexual_encounter'],
        'menstrual_history': mh['menstrual_history'],
        'pregnancy_history': mh['pregnancy_history'],
      });

      // If all insertions are successful, pop the page and send 'true'
      Navigator.pop(context, true);

    } on PostgrestException catch (e) {
      // Specific handling for Supabase database errors
      print('Supabase Error: ${e.message}');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Database Error: ${e.message}')),
      );
    } catch (e) {
      // General error handling
      print('An unexpected error occurred: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An unexpected error occurred. Please try again.')),
      );
    }
  }

  @override
  Widget build(BuildContext ctx) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    double responsiveSpacing = 20.0;
    double responsiveRunSpacing = 10.0;
    return Scaffold(
      appBar: AppBar(
        title: Text('Treatment & Diagnosis'),
        leading: BackButton(onPressed: () => Navigator.pop(ctx)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Container(
                  height: screenHeight * 0.1,
                  width: screenWidth,
                  color: Color.fromARGB(255, 255, 245, 245),
                  child: Center(
                    child: Text(
                      '2 OUT OF 2',
                      style: TextStyle(fontSize: 15, color: Color.fromARGB(255, 0, 0, 0), fontFamily: 'Italic',),
                    ),
                  ),
                ),
                Container(
                  height: screenHeight,
                  width: screenWidth * 0.9,
                  color: Color.fromARGB(255, 255, 255, 255),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        Text('V. Treatment', style: TextStyle(fontSize: 20, fontFamily: 'OpenSansEB', color: Colors.black)),
              
              SizedBox(height: screenHeight * 0.02,),
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
              Text('Prescription', style: TextStyle(fontSize: 15,color: Colors.black,),),
              SizedBox(
                height: screenHeight * 0.06,
                child: TextFormField(controller: _prescription, validator: (value) => value!.isEmpty ? 'Required' : null, style: TextStyle(fontSize: 12, color: Colors.black), decoration: InputDecoration(filled: true, fillColor: Colors.white, border: OutlineInputBorder( borderRadius: BorderRadius.circular(5.0,),),),),
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
              Text('Quantity', style: TextStyle(fontSize: 15,color: Colors.black,),),
              SizedBox(
                height: screenHeight * 0.06,
                child: TextFormField(controller: _quantity, validator: (value) => value!.isEmpty ? 'Required' : null, style: TextStyle(fontSize: 12, color: Colors.black), decoration: InputDecoration(filled: true, fillColor: Colors.white, border: OutlineInputBorder( borderRadius: BorderRadius.circular(5.0,),),),),
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
              Text('Frequency', style: TextStyle(fontSize: 15,color: Colors.black,),),
              SizedBox(
                height: screenHeight * 0.06,
                child: TextFormField(controller: _frequency, validator: (value) => value!.isEmpty ? 'Required' : null, style: TextStyle(fontSize: 12, color: Colors.black), decoration: InputDecoration(filled: true, fillColor: Colors.white, border: OutlineInputBorder( borderRadius: BorderRadius.circular(5.0,),),),),
                ),
                ]
              ),
              ),
              ]
              ),

              
              SizedBox(height: screenHeight * 0.02,),
              CheckboxListTile(
                title: Text('For Referral'),
                value: _forReferral,
                onChanged: (v) => setState(() => _forReferral = v!),
              ),

              SizedBox(height: screenHeight * 0.02,),
              CheckboxListTile(
                title: Text('Active'),
                value: _active,
                onChanged: (v) => setState(() => _active = v!),
              ),

              SizedBox(height: screenHeight * 0.02,),
              Row(
                children: [
                 Text('Follow-up Date:'),
                 SizedBox(width: 10),
                  Text(_followUpDate == null
                      ? 'Not selected'
                      : _followUpDate!.toLocal().toString().split(' ')[0]),
                  IconButton(
                    icon: const Icon(Icons.calendar_today),
                    onPressed: _selectFollowUpDate,
                  ),
                ],
              ),

              SizedBox(height: screenHeight * 0.02,),
              Row(
                children: [
                 Text('Validity Date:'),
                 SizedBox(width: 10),
                  Text(_validityDate == null
                      ? 'Not selected'
                      : _validityDate!.toLocal().toString().split(' ')[0]),
                  IconButton(
                    icon: Icon(Icons.calendar_today),
                    onPressed: _selectValidityDate,
                  ),
                ],
              ),

              SizedBox(height: screenHeight * 0.02,),
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
              Text('Diagnosis Information', style: TextStyle(fontSize: 15,color: Colors.black,),),
              SizedBox(
                height: screenHeight * 0.1,
                child: TextFormField(controller: _diagnosisInfo, maxLines: 3, validator: (value) => value!.isEmpty ? 'Required' : null, style: TextStyle(fontSize: 12, color: Colors.black), decoration: InputDecoration(filled: true, fillColor: Colors.white, border: OutlineInputBorder( borderRadius: BorderRadius.circular(5.0,),),),),
                ),
                ]
              ),
              ),
              ]
              ),
                

              SizedBox(height: screenHeight * 0.03,),
              ElevatedButton(
                onPressed: _submitAll,
                child: Text('Submit All'),
              ),

                      ],
                    ),
                  ) 

                ),

            ],
          ),
        ),
      ),
    );
  }
}