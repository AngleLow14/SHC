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

  late final String patientId;
  late final String diagnosisId;
  late final String treatmentId;

  @override
  void initState() {
  super.initState();
  patientId = widget.patientData['patient_id'];
  diagnosisId = widget.patientData['diagnosis_id'];
  treatmentId = const Uuid().v4(); // Generate treatment_id here
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    
    double responsiveSpacing = 20.0;
    double responsiveRunSpacing = 10.0;

    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          height: screenHeight,
          width: screenWidth,
          child: Form(
            key: _formKey,
          child: Column(
            children: <Widget>[
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
                              ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: _prescriptionControllers.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: TextFormField(
                                            controller: _prescriptionControllers[index],
                                            decoration: InputDecoration(
                                                labelText: 'Prescription ${index + 1}'),
                                          ),
                                        ),
                                        SizedBox(width: screenWidth * 0.02),
                                        SizedBox(
                                          
                                          child: TextFormField(
                                            controller: _quantityControllers[index],
                                            keyboardType: TextInputType.number,
                                            decoration: InputDecoration(labelText: 'Quantity'),
                                          ),
                                        ),
                                        SizedBox(width: screenWidth * 0.02),
                                        Expanded(
                                          child: TextFormField(
                                            controller: _frequencyControllers[index],
                                            decoration: InputDecoration(labelText: 'Frequency'),
                                          ),
                                        ),
                                        if (index > 0)
                                          IconButton(
                                            icon: const Icon(Icons.delete),
                                            onPressed: () {
                                              setState(() {
                                                _prescriptionControllers.removeAt(index);
                                                _quantityControllers.removeAt(index);
                                                _frequencyControllers.removeAt(index);
                                              });
                                            },
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
                                              Checkbox(
                                                  value: _forReferral,
                                                  onChanged: (bool? value) {
                                                    setState(() {
                                                      _forReferral = value!;
                                                    });
                                                  },
                                                ),
                                               const Text(
                                                'Check if Yes',
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
                                      width: screenWidth * 0.1,
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
                                            height: screenHeight * 0.06,
                                            child: InkWell(
                                              onTap: () => _selectFollowUpDate(context),
                                              child: InputDecorator(
                                                decoration: InputDecoration(
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
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: screenHeight * 0.02),
                                    SizedBox(
                                      width: screenWidth * 0.1,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Validation Date',
                                            style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.black,
                                            ),
                                          ),
                                          SizedBox(
                                            height: screenHeight * 0.06,
                                            child: InkWell(
                                              onTap: () => _selectValidityDate(context),
                                              child: InputDecorator(
                                                decoration: InputDecoration(
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
                                          ),
                                        ],
                                      ),
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
                                                  controller: _diagnosisInfController,
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
                                                  validator: (value) => value == null || value.isEmpty ? 'Required' : null,
                                                ),
                                              ),
                                            ],
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
                                  children: <Widget>[
                                    SizedBox(
                                      width: 120,
                                      height: 30,
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
                                        onPressed: () async {
                                          final patientId = widget.patientData['patient_id'];
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
                                                'for_referral': _forReferral,
                                                'follow_up_check_up': _followUpCheckUp?.toIso8601String(),
                                                'date': now,
                                                'validity_date': _validityDate?.toIso8601String(),
                                              });

                                              await Supabase.instance.client.from('diagnosis').insert({
                                                'diagnosis_id': diagnosisId,
                                                'patient_id': patientId,
                                                'treatment_id': treatmentId,
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
                                        child: const Text(
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
      ),
    );
  }
}