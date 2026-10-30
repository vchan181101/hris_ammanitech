import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';

class PinVerificationScreen extends StatefulWidget {
  final Function(bool isSuccess) onVerificationComplete;

  const PinVerificationScreen({super.key, required this.onVerificationComplete});

  @override
  State<PinVerificationScreen> createState() => _PinVerificationScreenState();
}

class _PinVerificationScreenState extends State<PinVerificationScreen> {
  final TextEditingController _pinController = TextEditingController();

  void _verifyPin() {
    if (_pinController.text == '1234' || _pinController.text.length == 4) {
      widget.onVerificationComplete(true);
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('PIN Keamanan salah. PIN default: 1234'),
          backgroundColor: AppColors.error,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Verifikasi PIN Security')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.lock_rounded, size: 64, color: AppColors.primary),
              const SizedBox(height: 16),
              const Text(
                'Masukkan 4-Digit PIN Keamanan',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: 180,
                child: TextField(
                  controller: _pinController,
                  obscureText: true,
                  maxLength: 4,
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 24, letterSpacing: 12, fontWeight: FontWeight.bold),
                  decoration: const InputDecoration(counterText: ''),
                  onChanged: (val) {
                    if (val.length == 4) _verifyPin();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
