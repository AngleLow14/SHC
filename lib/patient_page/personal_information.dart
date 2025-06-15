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
    // Get the screen width
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(title: const Text('Patient Info')),
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
                Text('Full Name: ${_formatFullName(patient)}'),
                Text('Birthday: ${patient['birthday'] ?? 'N/A'}'),
                Text('Age: ${_calculateAge(patient['birthday'])}'),
                Text('Email: ${patient['email'] ?? 'N/A'}'),
                Text('Sex: ${patient['sex'] ?? 'N/A'}'),
                Text('Civil Status: ${patient['civil_status'] ?? 'N/A'}'),
                Text('Contact: ${patient['contact_number'] ?? 'N/A'}'),

                const SizedBox(height: 10),
                const Text('Other Information', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                Text('Place of Birth: ${patient['place_of_birth'] ?? 'N/A'}'),
                Text('House No.: ${patient['house_number'] ?? 'N/A'}'),
                Text('Street: ${patient['street'] ?? 'N/A'}'),
                Text('Barangay: ${patient['barangay'] ?? 'N/A'}'),
                Text('City: ${patient['city'] ?? 'N/A'}'),
                Text('Province: ${patient['province'] ?? 'N/A'}'),
                Text('Zip Code: ${patient['zip_code'] ?? 'N/A'}'),

                const SizedBox(height: 20),
                const Divider(),
                const Text('Medical History', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
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
                        title: Text('Medication: ${item['current_medication'] ?? 'N/A'}'),
                        subtitle: Text('Date: ${item['date'] ?? 'N/A'}'),
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
                const SizedBox(height: 10),
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
                  child: const Text('Add Medical Record'),
                ),
                const SizedBox(height: 20),
              ],
            ),
          );
        },
      ),
    );
  }
}