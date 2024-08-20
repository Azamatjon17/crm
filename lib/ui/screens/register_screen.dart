import 'package:crm/controllers/auth_controller.dart';
import 'package:crm/ui/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();

  String _name = '';
  String _phone = '';
  String _password = '';
  String _passwordConfiger = '';

  String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Name is required';
    }
    if (value.length < 2) {
      return 'Name must be at least 2 characters';
    }
    return null;
  }

  String? validatePhone(String? value) {
    final phoneRegExp = RegExp(r'^\d{10}$');
    if (value == null || value.isEmpty) {
      return 'Phone is required';
    }
    if (!phoneRegExp.hasMatch(value)) {
      return null;
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }

  void signUp() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      showDialog(
        context: context,
        builder: (context) => const AlertDialog(
          content: CircularProgressIndicator(),
        ),
      );

      final auth = context.read<AuthController>();
      await auth.siginUp(_name, _password, _phone, _passwordConfiger);
      Navigator.pop(context);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => HomeScreen
          (),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 55, left: 15, right: 15),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset('assets/appicon.svg'),
                const SizedBox(
                  width: 10,
                ),
                const Text(
                  "Woorkroom",
                  style: TextStyle(
                    color: Color(0xff3A89FF),
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
            const Gap(25),
            Container(
              height: MediaQuery.of(context).size.height / 1.5,
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.white,
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      'Sign In to Woorkroom',
                      style:
                          TextStyle(fontWeight: FontWeight.w700, fontSize: 25),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "  Name",
                          style: TextStyle(
                            color: Color(0xff7D8592),
                            fontSize: 15,
                          ),
                        ),
                        TextFormField(
                          validator: validateName,
                          onSaved: (value) {
                            _name = value!;
                          },
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: const BorderSide(
                                color: Color(0xffB8C8E0),
                              ),
                            ),
                            hintText: "Alex",
                            hintStyle: const TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                        )
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "  Phone",
                          style: TextStyle(
                            color: Color(0xff7D8592),
                            fontSize: 15,
                          ),
                        ),
                        TextFormField(
                          validator: validatePhone,
                          onSaved: (value) {
                            _phone = value!;
                          },
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: const BorderSide(
                                color: Color(0xffB8C8E0),
                              ),
                            ),
                            hintText: "phone",
                            hintStyle: const TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                        )
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "  Password",
                          style: TextStyle(
                            color: Color(0xff7D8592),
                            fontSize: 15,
                          ),
                        ),
                        TextFormField(
                          validator: validatePassword,
                          onSaved: (value) {
                            _password = value!;
                          },
                          obscureText: true,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: const BorderSide(
                                color: Color(0xffB8C8E0),
                              ),
                            ),
                            suffixIcon: IconButton(
                              icon: const Icon(
                                Icons.visibility,
                                color: Colors.grey,
                              ),
                              onPressed: () {},
                            ),
                            hintText: "password",
                            hintStyle: const TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                        )
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "  Password",
                          style: TextStyle(
                            color: Color(0xff7D8592),
                            fontSize: 15,
                          ),
                        ),
                        TextFormField(
                          validator: validatePassword,
                          onSaved: (value) {
                            _passwordConfiger = value!;
                          },
                          obscureText: true,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: const BorderSide(
                                color: Color(0xffB8C8E0),
                              ),
                            ),
                            suffixIcon: IconButton(
                              icon: const Icon(
                                Icons.visibility,
                                color: Colors.grey,
                              ),
                              onPressed: () {},
                            ),
                            hintText: "password",
                            hintStyle: const TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Checkbox(
                              value: false,
                              onChanged: (value) {},
                            ),
                            const Text("Remember me"),
                          ],
                        ),
                        TextButton(
                          child: const Text(
                            "Forgot Password?",
                            style: TextStyle(color: Colors.grey),
                          ),
                          onPressed: () {},
                        ),
                      ],
                    ),
                    InkWell(
                      onTap: signUp,
                      child: Container(
                        width: double.infinity,
                        alignment: Alignment.center,
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: const Color(0xff3F8CFF),
                        ),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "Sign Up",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                            Gap(5),
                            Icon(
                              Icons.arrow_forward,
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        "I have an account?",
                        style: TextStyle(
                          fontSize: 18,
                          color: Color(0xff3F8CFF),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
