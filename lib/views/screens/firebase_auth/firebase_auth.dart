import 'package:flutter/material.dart';
import 'package:venkatesh/services/google_service/googe_service.dart';
import 'package:venkatesh/services/route_helper.dart';
import 'package:venkatesh/views/screens/home_screen/home_screen.dart';

class GoogleLoginScreen extends StatefulWidget {
  const GoogleLoginScreen({super.key});

  @override
  State<GoogleLoginScreen> createState() => GoogleLoginScreenState();
}

class GoogleLoginScreenState extends State<GoogleLoginScreen> {
  bool _isLoading = false;

  Future<void> _signInWithGoogle() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final userCredential = await GoogleSignInService.signInWithGoogle();

      if (!mounted) return;
      if (userCredential != null) {
        Navigator.of(context).pushAndRemoveUntil(
          getCustomRoute(child: HomeScreen()),
          (route) => false,
        );

        print("User signed in ${userCredential.user!.displayName}");
      }
    } catch (e) {
      if (!mounted) return;
      print("Error : UT -__________");
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // leading: const BackButton(color: Colors.black),
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Text(
          "Google Authentication",
          style: Theme.of(
            context,
          ).textTheme.displaySmall!.copyWith(fontSize: 20),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(Icons.lock_outline, size: 100, color: Colors.blueAccent),
            const SizedBox(height: 30),

            // Title
            Text(
              "What's your",
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                fontSize: 35,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              "Login with Google",
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                fontSize: 35,
                color: Colors.black,
                fontWeight: FontWeight.w900,
              ),
            ),

            const SizedBox(height: 10),
            SizedBox(
              width: double.infinity,
              child: _isLoading
                  ? Center(child: CircularProgressIndicator())
                  : OutlinedButton(
                      onPressed: () async {
                        _signInWithGoogle();
                      },
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        "Continue with Email",
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
