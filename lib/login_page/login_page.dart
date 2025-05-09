import 'package:flutter/material.dart';
import 'package:shc/home_page/home_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AdminLoginPage extends StatefulWidget {
  @override
  _AdminLoginPageState createState() => _AdminLoginPageState();
}

class _AdminLoginPageState extends State<AdminLoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;

  Future<void> _login() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text;

    setState(() => _isLoading = true);

    try {
      final response = await Supabase.instance.client
          .from('admin')
          .select()
          .eq('email', email)
          .eq('password', password)
          .maybeSingle();

      setState(() => _isLoading = false);

      if (response != null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Dashboard()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Invalid email or password')),
        );
      }
    } catch (e) {
      setState(() => _isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Login failed: $e')),
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        color: const Color.fromARGB(255, 255, 152, 145),
                        height: MediaQuery.of(context).size.height,
                        width: screenWidth * 0.3,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            color: Colors.white,
                            height: MediaQuery.of(context).size.height,
                            width: screenWidth * 0.7,
                            child: Column(
                              children: [
                                SizedBox(height: screenHeight * 0.04),
                                Text(
                                  'San Pablo Social Hygiene Clinic',
                                  style: TextStyle(
                                    fontFamily: 'OpenSansEB',
                                    color: Color.fromARGB(255, 182, 8, 37),
                                    fontSize: 43,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                SizedBox(height: screenHeight * 0.2),
                                Text(
                                  'Login',
                                  style: TextStyle(
                                    fontFamily: 'OpenSansEB',
                                    fontSize: 30,
                                    fontWeight: FontWeight.w500,
                                    color: Color.fromARGB(255, 182, 8, 37),
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                SizedBox(height: screenHeight * 0.05),
                                Padding(
                                  padding: EdgeInsets.only(right: 200),
                                  child: const Text(
                                    'Username',
                                    style: TextStyle(
                                      fontFamily: 'OpenSans',
                                      fontSize: 10,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 10),
                                SizedBox(
                                  width: 250,
                                  height: 35,
                                  child: TextField(
                                    controller: _emailController,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      hintText: 'Username',
                                    ),
                                    style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Padding(
                                  padding: EdgeInsets.only(right: 195),
                                  child: const Text(
                                    'Password',
                                    style: TextStyle(
                                      fontFamily: 'OpenSans',
                                      fontSize: 10,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 10),
                                SizedBox(
                                  width: 250,
                                  height: 35,
                                  child: TextField(
                                    controller: _passwordController,
                                    obscureText: true,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      hintText: 'Password',
                                    ),
                                    style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
                                  ),
                                ),
                                const SizedBox(height: 15),
                                SizedBox(
  width: 80,
  height: 30,
  child: _isLoading
      ? const Center(child: CircularProgressIndicator())
      : ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromARGB(255, 158, 7, 82),
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
          ),
          onPressed: _login,
          child: const Text(
            'Login',
            style: TextStyle(fontSize: 10),
          ),
        ),
)

                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
