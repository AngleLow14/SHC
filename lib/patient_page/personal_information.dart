import 'package:shc/patient_page/patient_page.dart';
import 'package:shc/patient_page/id_based_form/patient_medical_form.dart';
import 'package:flutter/material.dart';
import 'package:shc/patient_page/medical_record.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class MedicalHistoryPage extends StatefulWidget {
  final String patientId;
  const MedicalHistoryPage({super.key, required this.patientId});

  @override
  State<MedicalHistoryPage> createState() => _MedicalHistoryPageState();
}

class _MedicalHistoryPageState extends State<MedicalHistoryPage> {
  final supabase = Supabase.instance.client;

  Future<Map<String, dynamic>> _fetchData() async {
    final patient = await supabase
        .from('patient')
        .select('''
          *,
          house_number,
          street,
          barangay,
          city,
          province,
          zip_code,
          place_of_birth
        ''')
        .eq('patient_id', widget.patientId)
        .single();

    final history = await supabase
        .from('medical_history')
        .select()
        .eq('patient_id', widget.patientId)
        .order('date', ascending: false);

    return {'patient': patient, 'medical_history': history};
  }

  String _formatFullName(Map patient) {
    final first = patient['first_name'] ?? '';
    final middle = patient['middle_name'] == 'N/A' ? '' : patient['middle_name'] ?? '';
    final last = patient['last_name'] ?? '';
    final suffix = patient['suffix'] == 'N/A' ? '' : patient['suffix'] ?? '';
    return '$first ${middle.isNotEmpty ? '$middle ' : ''}$last ${suffix.isNotEmpty ? suffix : ''}'.trim();
  }

  // Modified _calculateAge to handle null or invalid birthday
  String _calculateAge(String? birthday) {
    if (birthday == null || birthday.isEmpty) {
      return 'N/A'; // Or any other suitable placeholder
    }
    try {
      final birth = DateTime.parse(birthday);
      final today = DateTime.now();
      int age = today.year - birth.year;
      if (today.month < birth.month || (today.month == birth.month && today.day < birth.day)) {
        age--;
      }
      return age.toString();
    } catch (e) {
      return 'Invalid Date'; // Handle parsing errors
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    double responsiveSpacing = 20.0;
    double responsiveRunSpacing = 10.0;

    return Scaffold(
      body: FutureBuilder<Map<String, dynamic>>(
        future: _fetchData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (!snapshot.hasData || snapshot.data!['patient'] == null) {
            return const Center(child: Text('Patient not found.'));
          }

          final patient = snapshot.data!['patient'];
          final histories = snapshot.data!['medical_history'] as List<dynamic>;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: screenHeight * 0.1,
                  width: screenWidth,
                  color: const Color.fromARGB(255, 255, 245, 245),
                  child: Center(
                    child: Text('SAN PABLO SOCIAL HYGIENE CLINIC', style: TextStyle(fontSize: 20, fontFamily: 'OpenSansEB', color: Color.fromARGB(255, 182, 8, 37),))
                  )
                ),
                Container(
                  height: screenHeight * 0.8,
                  width: screenWidth,
                  color: Colors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(height: screenHeight * 0.02),
                      Center(child: Text('PROFILE', style: TextStyle(fontSize: 20, fontFamily: 'OpenSansEB', color: Colors.black))),
                      SizedBox(height: screenHeight * 0.02),
                      Wrap(
                        spacing: responsiveSpacing,
                        runSpacing: responsiveRunSpacing,
                        children: [
                          Container(
                                height: screenHeight * 0.15,
                                width: screenWidth * 0.15,
                                padding: EdgeInsets.all(8.0),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.grey,
                                ),
                                child: CircleAvatar(
                                  radius: 30,
                                  backgroundColor: Colors.transparent,
                                ),
                              ),
                            Column(
                              children: [
                                Text('${_formatFullName(patient)}', style: TextStyle(fontSize: 20, fontFamily: 'OpenSansEB', color: Colors.black)),
                                Text('${_calculateAge(patient['birthday'])} years old', style: TextStyle(fontFamily: 'OpensSansEB', fontSize: 20, color: Colors.black)),
                              ],
                            )
                        ],
                      ),
                      SizedBox(height: screenHeight * 0.02),
                      Wrap(
                        spacing: responsiveSpacing,
                        runSpacing: responsiveRunSpacing,
                        children: [
                          Container(
                            width: screenWidth * 0.15,
                            height: screenHeight * 0.1,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text('BIRTHDAY', style: TextStyle(fontFamily: 'OpenSansEB', fontSize: 15, color: Colors.black)),
                                Text('${patient['birthday'] ?? 'N/A'}', style: TextStyle(fontFamily: 'OpenSansSB', fontSize: 12, color: Colors.black),)
                              ],
                            ),
                          ),
                          Container(
                            width: screenWidth * 0.15,
                            height: screenHeight * 0.1,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text('SEX', style: TextStyle(fontFamily: 'OpenSansEB', fontSize: 15, color: Colors.black)),
                                Text('${patient['sex'] ?? 'N/A'}', style: TextStyle(fontFamily: 'OpenSansSB', fontSize: 12, color: Colors.black),)
                              ],
                            ),
                          ),
                          Container(
                            width: screenWidth * 0.15,
                            height: screenHeight * 0.1,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text('CIVIL STATUS', style: TextStyle(fontFamily: 'OpenSansEB', fontSize: 15, color: Colors.black)),
                                Text('${patient['civil_status'] ?? 'N/A'}', style: TextStyle(fontFamily: 'OpenSansSB', fontSize: 12, color: Colors.black),)
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
                          Container(
                            width: screenWidth * 0.15,
                            height: screenHeight * 0.1,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text('CONTACT NO.', style: TextStyle(fontFamily: 'OpenSansEB', fontSize: 15, color: Colors.black)),
                                Text('${patient['contact_number'] ?? 'N/A'}', style: TextStyle(fontFamily: 'OpenSansSB', fontSize: 12, color: Colors.black),)
                              ],
                            ),
                          ),
                          Container(
                            width: screenWidth * 0.15,
                            height: screenHeight * 0.1,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text('EMAIL', style: TextStyle(fontFamily: 'OpenSansEB', fontSize: 15, color: Colors.black)),
                                Text('${patient['email'] ?? 'N/A'}', style: TextStyle(fontFamily: 'OpenSansSB', fontSize: 12, color: Colors.black),)
                              ],
                            ),
                          ),
                          Container(
                            width: screenWidth * 0.15,
                            height: screenHeight * 0.1,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text('HOUSE NO.', style: TextStyle(fontFamily: 'OpenSansEB', fontSize: 15, color: Colors.black)),
                                Text('${patient['house_number'] ?? 'N/A'}', style: TextStyle(fontFamily: 'OpenSansSB', fontSize: 12, color: Colors.black),)
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
                          Container(
                            width: screenWidth * 0.15,
                            height: screenHeight * 0.1,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text('PLACE OF BIRTH', style: TextStyle(fontFamily: 'OpenSansEB', fontSize: 15, color: Colors.black)),
                                Text('${patient['place_of_birth'] ?? 'N/A'}', style: TextStyle(fontFamily: 'OpenSansSB', fontSize: 12, color: Colors.black),)
                              ],
                            ),
                          ),
                          Container(
                            width: screenWidth * 0.15,
                            height: screenHeight * 0.1,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text('STREET', style: TextStyle(fontFamily: 'OpenSansEB', fontSize: 15, color: Colors.black)),
                                Text('${patient['street'] ?? 'N/A'}', style: TextStyle(fontFamily: 'OpenSansSB', fontSize: 12, color: Colors.black),)
                              ],
                            ),
                          ),
                          Container(
                            width: screenWidth * 0.15,
                            height: screenHeight * 0.1,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text('BARANGAY', style: TextStyle(fontFamily: 'OpenSansEB', fontSize: 15, color: Colors.black)),
                                Text('${patient['barangay'] ?? 'N/A'}', style: TextStyle(fontFamily: 'OpenSansSB', fontSize: 12, color: Colors.black),)
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
                          Container(
                            width: screenWidth * 0.15,
                            height: screenHeight * 0.1,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text('CITY/MUNICIPALITY', style: TextStyle(fontFamily: 'OpenSansEB', fontSize: 15, color: Colors.black)),
                                Text('${patient['city'] ?? 'N/A'}', style: TextStyle(fontFamily: 'OpenSansSB', fontSize: 12, color: Colors.black),)
                              ],
                            ),
                          ),
                          Container(
                            width: screenWidth * 0.15,
                            height: screenHeight * 0.1,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text('PROVINCE', style: TextStyle(fontFamily: 'OpenSansEB', fontSize: 15, color: Colors.black)),
                                Text('${patient['province'] ?? 'N/A'}', style: TextStyle(fontFamily: 'OpenSansSB', fontSize: 12, color: Colors.black),)
                              ],
                            ),
                          ),
                          Container(
                            width: screenWidth * 0.15,
                            height: screenHeight * 0.1,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text('ZIP CODE', style: TextStyle(fontFamily: 'OpenSansEB', fontSize: 15, color: Colors.black)),
                                Text('${patient['zip_code'] ?? 'N/A'}', style: TextStyle(fontFamily: 'OpenSansSB', fontSize: 12, color: Colors.black),)
                              ],
                            ),
                          ),
                        ],

                      ),
                    ]
                  ),
                ),
                SizedBox(height: screenHeight * 0.02),
                Container(
                  width: screenWidth,
                  height: screenHeight * 0.1,
                  color: const Color.fromARGB(255, 255, 245, 245),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text('MEDICAL HISTORY', style: TextStyle(fontSize: 20, fontFamily: 'OpenSansEB', color: Color.fromARGB(255, 182, 8, 37))),
                      ElevatedButton(
                        onPressed: () async {
                          final updated = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => PatientForm(patientId: widget.patientId),
                            ),
                          );
                          if (updated == true) {
                            setState(() {});
                          }
                        },
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
                                            ), // Border
                                          ),
                                        ),
                        child: const Text('Add New Record'),
                      ),
                    ],
                  )
                ),
                Container(
                  width: screenWidth,
                  height: screenHeight * 0.4,
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        if (histories.isEmpty)
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 10.0),
                          child: Text('No medical history found.'),
                        ),
                      ...histories.map<Widget>((item) {
                        return Card(
                          margin: const EdgeInsets.symmetric(vertical: 4.0),
                          // Constrain the width of the Card using SizedBox or Container
                          child: SizedBox( // <--- Use SizedBox to set explicit width
                            width: screenWidth * 0.9, // Example: 90% of screen width
                            // Or specify a fixed width: width: 350.0,
                            child: ListTile(
                              title: Text('Medication: ${item['current_medication'] ?? 'N/A'}', style: TextStyle(fontFamily: 'OpenSansSB', color: const Color.fromARGB(255, 29, 29, 29))),
                              subtitle: Text('Date: ${item['date'] ?? 'N/A'}', style: TextStyle(fontFamily: 'OpenSansSB', color: const Color.fromARGB(255, 29, 29, 29))),
                              trailing: ElevatedButton(
                                child: const Text('View'),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => ViewDetails(data: item),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                      ],
                    )
                  ),
                ),
                SizedBox(height: screenHeight * 0.02),
                Container(
                  height: screenHeight * 0.1,
                  width: screenWidth,
                  color: const Color.fromARGB(255, 255, 245, 245),
                  child: Center(
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
                  )
                ),
                const SizedBox(height: 10),
              ],
            ),
          );
        },
      ),
    );
  }
}