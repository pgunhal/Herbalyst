// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'disclaimer_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: use_key_in_widget_constructors
class DisclaimerPage extends StatefulWidget {
  @override
  // ignore: library_private_types_in_public_api
  _DisclaimerPageState createState() => _DisclaimerPageState();
}

class _DisclaimerPageState extends State<DisclaimerPage> {
  bool _accepted = false;

  @override
  void initState() {
    super.initState();
    _loadAcceptedState();
  }

  Future<void> _loadAcceptedState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _accepted = prefs.getBool('acceptedTOC') ?? false;
    });
  }

  Future<void> _acceptTOC() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('acceptedTOC', true);
    setState(() {
      _accepted = true;
    });
    Provider.of<DisclaimerProvider>(context, listen: false).acceptDisclaimer();
    Navigator.pushReplacementNamed(context, '/home');
  }

  void _showInfoDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Disclaimer'),
          content: const Text('You must agree to the terms in order to use the app. You can opt out of the terms at anytime by returning to this page from the app\'s main menu.'),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Disclaimer and Terms'),
        foregroundColor: Colors.white,
        backgroundColor: Colors.grey[900],
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.info_outline),
            onPressed: _showInfoDialog,
          ),
        ],
      ),
      body: _accepted ? SizedBox(child: Text('hi')) : 
      Padding(
        padding: const EdgeInsets.all(16.0),
        child: Consumer<DisclaimerProvider>(
          builder: (context, disclaimerProvider, child) {
            return SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                 const Text(
                    'Terms and Conditions',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                    ),
                  ),
                  const Text(
                    'The information provided by Herbalyst ("the App") is intended for general informational and educational purposes only. Herbalyst and Tibbee Application Development Co. ("we", "us", or "our") do not provide medical, legal, or other professional advice. The App\'s content, including but not limited to text, graphics, images, and other material, is not intended to be a substitute for professional medical advice, diagnosis, or treatment. Always seek the advice of your physician or other qualified health provider with any questions you may have regarding a medical condition.',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w300,
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 5),
                  const Text(
                    'The App offers health and nutritional information and is designed for educational purposes only. You should not rely on this information as a substitute for professional medical advice, diagnosis, or treatment. If you have any concerns or questions about your health, you should always consult with a physician or other healthcare professional.',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w300,
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 5),
                  const Text(
                    'Your use of the App does not create a doctor-patient relationship between you and any of the healthcare professionals affiliated with our App.',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w300,
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 5),
                  const Text(
                    'Do not use the App for medical emergencies. If you have a medical emergency, call your doctor or emergency services immediately.',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w300,
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 5),
                  const Text(
                    'While we strive to ensure that the information provided within the App is accurate and up-to-date, we make no guarantees regarding the completeness, accuracy, reliability, suitability, or availability of any information. Any reliance you place on such information is strictly at your own risk.',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w300,
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 5),
                  const Text(
                    'Your use of the App is at your own risk. The App is provided on an "as is" and "as available" basis. We make no representations or warranties of any kind, express or implied, as to the operation of the App or the information, content, materials, or products included in the App.',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w300,
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 5),
                  const Text(
                    'To the fullest extent permitted by law, we disclaim all warranties, express or implied, including, but not limited to, implied warranties of merchantability and fitness for a particular purpose. We do not warrant that the App, its servers, or email sent from us are free of viruses or other harmful components. We will not be liable for any damages of any kind arising from the use of the App, including, but not limited to, direct, indirect, incidental, punitive, and consequential damages.',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w300,
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 5),
                  const Text(
                    'The App and its entire contents, features, and functionality (including but not limited to all information, software, text, displays, images, video, and audio, and the design, selection, and arrangement thereof) are owned by Herbalyst, Tibbee Application Development Co., its licensors, or other providers of such material and are protected by copyright, trademark, patent, trade secret, and other intellectual property or proprietary rights laws.',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w300,
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 5),
                  const Text(
                    'The App may contain links to third-party websites or resources. We provide these links for your convenience, but we have no control over the content, privacy policies, or practices of any third-party websites. We are not responsible or liable for the availability, content, privacy policies, or practices of such third-party websites. Your use of third-party websites is at your own risk.',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w300,
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 5),
                  const Text(
                    'You agree to use the App only for lawful purposes and in a way that does not infringe on the rights of, restrict or inhibit anyone else\'s use and enjoyment of the App. Prohibited conduct includes harassing or causing distress or inconvenience to any person, transmitting or uploading any material that contains viruses or malware, or engaging in any other conduct that restricts or inhibits anyone\'s use or enjoyment of the App, or which, as determined by us, may harm Herbalyst, Tibbee Application Development Co. or users of the App.',
                    style: TextStyle(
                      color: Colors.black,  
                      fontWeight: FontWeight.w300,
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 5),
                  const Text(
                    'We reserve the right to terminate or suspend your access to the App at any time, for any reason, including if we reasonably believe that you have violated or acted inconsistently with these Terms. You may also delete your account at any time. We reserve the right to maintain copies of information related to you.',
                    style: TextStyle(
                      color: Colors.black,  
                      fontWeight: FontWeight.w300,
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 5),
                  const Text(
                    'In no event shall Herbalyst, Tibbee Application Development Co., its affiliates, or their licensors, service providers, employees, agents, officers, or directors be liable for any indirect, special, incidental, or consequential damages arising out of or in connection with your use or inability to use the App, whether based on warranty, contract, tort (including negligence), product liability, or any other legal theory.',
                    style: TextStyle(
                      color: Colors.black,  
                      fontWeight: FontWeight.w300,
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 5),
                  const Text(
                    'These Terms and your use of the App shall be governed by and construed in accordance with the laws of the United States of America, without giving effect to any choice or conflict of law provision or rule. Any legal suit, action, or proceeding arising out of or related to these Terms or the App shall be instituted exclusively in the courts of the United States of America.',
                    style: TextStyle(
                      color: Colors.black,  
                      fontWeight: FontWeight.w300,
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 5),
                  const Text(
                    'We reserve the right to modify these Terms at any time. If we make changes, we will notify you by revising the date at the top of these Terms and, in some cases, provide you with additional notice (such as adding a statement to the App\'s homepage or sending you an email notification). Your continued use of the App after any such change constitutes your acceptance of the new Terms.',
                    style: TextStyle(
                      color: Colors.black,  
                      fontWeight: FontWeight.w300,
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 5),
                  const Text(
                    'If you have any questions about these Terms, please visit https://herbalyst.netlify.app or go to "Support".',
                    style: TextStyle(
                      color: Colors.black,  
                      fontWeight: FontWeight.w300,
                      fontSize: 12,
                    ),
                  ),



                  Row(
                    children: [
                      Checkbox(
                        value: disclaimerProvider.isDisclaimerAccepted,
                        onChanged: (value) {
                          if (value == true) {
                            disclaimerProvider.acceptDisclaimer();
                            _accepted = true;
                          } else {
                            disclaimerProvider.revokeDisclaimer();
                            _accepted = false;
                          }
                        },
                      ),
                      const Text('I agree to the terms and conditions', style: TextStyle(color: Colors.black)),
                    ],
                  ),
                  ElevatedButton(
                    onPressed: _accepted ? _acceptTOC : _showInfoDialog,
                    child: const Text('Back to Home'),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}