import 'package:flutter/material.dart';

class OtpScreen extends StatefulWidget {
  final String? verificationId;
  final String? phoneNumber;
  final String? email;

  const OtpScreen({
    super.key,
    this.verificationId,
    this.phoneNumber,
    this.email,
  });

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final TextEditingController _phoneOtpController = TextEditingController();
  final TextEditingController _emailOtpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        elevation: 0,
        title: const Text(
          "OTP Verification",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 40),
            const Text(
              "Verify your identity",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              "Enter the OTPs sent to your registered phone and email.",
              style: TextStyle(color: Colors.grey, fontSize: 16),
            ),
            const SizedBox(height: 40),

            // 📱 Phone OTP Field
            TextField(
              controller: _phoneOtpController,
              decoration: InputDecoration(
                labelText: "Phone OTP",
                suffix: TextButton(
                  onPressed: () {},
                  child: const Text("Resend"),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              keyboardType: TextInputType.number,
              maxLength: 6,
            ),
            const SizedBox(height: 20),

            // 📧 Email OTP Field
            TextField(
              controller: _emailOtpController,
              decoration: InputDecoration(
                labelText: "Email OTP",
                suffix: TextButton(
                  onPressed: () {},
                  child: const Text("Resend"),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              keyboardType: TextInputType.number,
              maxLength: 6,
            ),

            const SizedBox(height: 40),

            // ✅ Verify Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {
                  // TODO: Add your verification logic here
                  Navigator.pushNamed(context, '/basic-details');
                },
                child: const Text(
                  "Verify & Continue",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
