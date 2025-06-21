import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

class Treatment extends StatefulWidget {
  final Map<String, dynamic> patientData;

  const Treatment({super.key, required this.patientData});
  
  @override
  _TreatmState createState() => _TreatmState();
}

class _TreatmState extends State<Treatment> {
  final _formKey = GlobalKey<FormState>();
  final List<TextEditingController> _prescriptionControllers = [TextEditingController()];
  final List<TextEditingController> _quantityControllers = [TextEditingController()];
  final List<TextEditingController> _frequencyControllers = [TextEditingController()];
  bool _isActive = true; // Default to 'Yes'

  bool _forReferral = false;
  DateTime? _followUpCheckUp;
  DateTime? _validityDate;

  final TextEditingController _diagnosisInfController = TextEditingController();

  Future<void> _selectFollowUpDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _followUpCheckUp ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(DateTime.now().year + 1),
    );
    if (picked != null && picked != _followUpCheckUp) {
      setState(() {
        _followUpCheckUp = picked;
      });
    }
  }

  Future<void> _selectValidityDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _validityDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(DateTime.now().year + 5),
    );
    if (picked != null && picked != _validityDate) {
      setState(() {
        _validityDate = picked;
      });
    }
  }

  void _addPrescriptionField() {
    setState(() {
      _prescriptionControllers.add(TextEditingController());
      _quantityControllers.add(TextEditingController());
      _frequencyControllers.add(TextEditingController());
    });
  }

  void _removePrescriptionField(int index) {
    setState(() {
      _prescriptionControllers[index].dispose(); // Dispose controller when removed
      _quantityControllers[index].dispose();
      _frequencyControllers[index].dispose();
      _prescriptionControllers.removeAt(index);
      _quantityControllers.removeAt(index);
      _frequencyControllers.removeAt(index);
    });
  }

  late final String patientId;
  late final String diagnosisId;
  // `treatmentId` is generated inside the loop, so it shouldn't be late final here.
  // late final String treatmentId; // Remove this line

  @override
  void initState() {
    super.initState();
    patientId = widget.patientData['patient_id'];
    diagnosisId = widget.patientData['diagnosis_id'];
    // treatmentId = const Uuid().v4(); // This should be inside the loop for unique IDs per prescription
  }

  @override
  void dispose() {
    for (var controller in _prescriptionControllers) {
      controller.dispose();
    }
    for (var controller in _quantityControllers) {
      controller.dispose();
    }
    for (var controller in _frequencyControllers) {
      controller.dispose();
    }
    _diagnosisInfController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    double responsiveSpacing = 20.0;
    double responsiveRunSpacing = 10.0;
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                  height: screenHeight * 0.07,
                  width: screenWidth,
                  child: Center(
                    child: Text(
                      '2 OUT OF 2',
                      style: TextStyle(fontSize: 15, color: const Color.fromARGB(255, 0, 0, 0), fontFamily: 'Italic',),
                    ),
                  ),
                ),
              Wrap(
                spacing: responsiveSpacing,
                runSpacing: responsiveRunSpacing,
                children: [
                  Container(
                    width: screenWidth * 0.2,
                    height: screenHeight * 0.1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                        'Patient Name:',
                        style: TextStyle(fontSize: 15, fontFamily: 'OpenSansEB', color: Colors.black),
                      ),
                      Text(
                        '${widget.patientData['first_name']} ${widget.patientData['last_name']}',
                        style: TextStyle(fontSize: 12, fontFamily: 'OpenSansSB', color: Colors.black),
                      ),
                      ],
                    ),
                  ),
                  Container(
                    width: screenWidth * 0.2,
                    height: screenHeight * 0.1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                        'Patient Number:',
                        style: TextStyle(fontSize: 15, fontFamily: 'OpenSansEB', color: Colors.black),
                      ),
                      Text(
                        '${widget.patientData['patient_number']}',
                        style: TextStyle(fontSize: 12, fontFamily: 'OpenSansSB', color: Colors.black),
                      ),
                      ],
                    ),
                  ),
                ],
              ),
              Container(
                width: screenWidth * 0.8,
                height: screenHeight,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      Text(
                      'VI. Treatment',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),

                    ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _prescriptionControllers.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Row( // <-- Wrap with Row to use Expanded
                      crossAxisAlignment: CrossAxisAlignment.end, // Align the delete icon to the bottom
                      children: [
                        Expanded(
                          flex: 3, // Adjust flex as needed
                          child: TextFormField(
                            key: ValueKey('prescription_${index}'), // Good practice
                            controller: _prescriptionControllers[index],
                            decoration: InputDecoration(
                                labelText: 'Prescription ${index + 1}'),
                            validator: (value) => value == null || value.isEmpty ? 'Required' : null,
                          ),
                        ),
                        const SizedBox(width: 10),
                        SizedBox( // Use SizedBox for fixed width
                          width: 80,
                          child: TextFormField(
                            key: ValueKey('quantity_${index}'), // Good practice
                            controller: _quantityControllers[index],
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(labelText: 'Quantity'),
                            validator: (value) => value == null || value.isEmpty ? 'Required' : null,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          flex: 2, // Adjust flex as needed
                          child: TextFormField(
                            key: ValueKey('frequency_${index}'), // Good practice
                            controller: _frequencyControllers[index],
                            decoration: InputDecoration(labelText: 'Frequency'),
                            validator: (value) => value == null || value.isEmpty ? 'Required' : null,
                          ),
                        ),
                        if (_prescriptionControllers.length > 1) // Only show delete if more than one
                          IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () => _removePrescriptionField(index), // Use new method
                          ),
                      ],
                    ),
                  );
                },
              ),
              
              SizedBox(height: screenHeight * 0.02),
              Align(
                alignment: Alignment.centerLeft,
                child: TextButton.icon(
                  onPressed: _addPrescriptionField,
                  icon: const Icon(Icons.add),
                  label: const Text('Add Prescription'),
                ),
              ),
              SizedBox(height: screenHeight * 0.02),
              Row(
                children: [
                  Checkbox(
                    value: _forReferral,
                    onChanged: (bool? value) {
                      setState(() {
                        _forReferral = value!;
                      });
                    },
                  ),
                  const Text('For Referral (Check If Yes)'),
                ],
              ),
              SizedBox(height: screenHeight * 0.02),
              InkWell(
                onTap: () => _selectFollowUpDate(context),
                child: InputDecorator(
                  decoration: const InputDecoration(
                    labelText: 'Follow Up Check Up',
                    hintText: 'Select date',
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        _followUpCheckUp == null
                            ? 'Select Date'
                            : DateFormat('yyyy-MM-dd').format(_followUpCheckUp!),
                      ),
                      const Icon(Icons.calendar_today),
                    ],
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.02),
              InkWell(
                onTap: () => _selectValidityDate(context),
                child: InputDecorator(
                  decoration: const InputDecoration(
                    labelText: 'Validity Date',
                    hintText: 'Select validity date',
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        _validityDate == null
                            ? 'Select Date'
                            : DateFormat('yyyy-MM-dd').format(_validityDate!),
                      ),
                      const Icon(Icons.calendar_today),
                    ],
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.02),
              Row(
                children: [
                  Checkbox(
                    value: _isActive,
                    onChanged: (bool? value) {
                      setState(() {
                        _isActive = value!;
                      });
                    },
                  ),
                  const Text('Active (Yes/No)'),
                ],
              ),

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
                height: screenHeight * 0.06,
                child: TextFormField(controller: _diagnosisInfController, validator: (value) => value == null || value.isEmpty ? 'Required' : null, style: TextStyle(fontSize: 12, color: Colors.black), decoration: InputDecoration(filled: true, fillColor: Colors.white, border: OutlineInputBorder( borderRadius: BorderRadius.circular(5.0,),),),),
                ),
                ]
              ),
              ),
              ]
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Back'),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) { // Validate all fields
                        final now = DateTime.now().toIso8601String();

                        try {
                          for (int i = 0; i < _prescriptionControllers.length; i++) {
                            final treatmentId = const Uuid().v4(); // unique per prescription

                            await Supabase.instance.client.from('treatment_plan').insert({
                              'treatment_id': treatmentId,
                              'patient_id': patientId,
                              'prescription': _prescriptionControllers[i].text,
                              'quantity': _quantityControllers[i].text,
                              'frequency': _frequencyControllers[i].text,
                              'for_referral': _forReferral ? 'Yes' : 'No',
                              'follow_up_check_up': _followUpCheckUp?.toIso8601String(),
                              'date': now,
                              'validity_date': _validityDate?.toIso8601String(),
                              'active': _isActive ? 'Yes' : 'No',
                            });

                            await Supabase.instance.client.from('diagnosis').insert({
                              'diagnosis_id': diagnosisId,
                              'patient_id': patientId,
                              'treatment_id': treatmentId, // Link diagnosis to specific treatment
                              'diagnosis_inf': _diagnosisInfController.text,
                              // 'date' will auto-generate in Supabase if default is set
                            });
                          }

                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Treatment plans saved successfully!')),
                          );

                          Navigator.popUntil(context, (route) => route.isFirst);
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Error: ${e.toString()}')),
                          );
                        }
                      }
                    },
                    child: const Text('Submit'),
                  ),
                ],
              ),


                    ],
                  ),
                ),
              ),
              
              
              const SizedBox(height: 20),
              const Text(
                'Recent Data Input:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Text('Patient Name: ${widget.patientData['first_name']} ${widget.patientData['last_name']}'),
              // Displaying only the first prescription details for brevity.
              // You might want to loop through all controllers if displaying all.
              if (_prescriptionControllers.isNotEmpty && _prescriptionControllers.first.text.isNotEmpty)
                Text('Prescription 1: ${_prescriptionControllers.first.text}'),
              if (_quantityControllers.isNotEmpty && _quantityControllers.first.text.isNotEmpty)
                Text('Quantity 1: ${_quantityControllers.first.text}'),
              if (_frequencyControllers.isNotEmpty && _frequencyControllers.first.text.isNotEmpty)
                Text('Frequency 1: ${_frequencyControllers.first.text}'),
              Text('For Referral: ${_forReferral ? 'Yes' : 'No'}'),
              Text('Follow Up: ${_followUpCheckUp != null ? DateFormat('yyyy-MM-dd').format(_followUpCheckUp!) : 'Not Set'}'),
              Text('Validity: ${_validityDate != null ? DateFormat('yyyy-MM-dd').format(_validityDate!) : 'Not Set'}'),
              Text('Diagnosis Info: ${_diagnosisInfController.text}'), // Added this
              Text('Active: ${_isActive ? 'Yes' : 'No'}'),
            ],
          ),
        ),
      ),
    );
  }
}