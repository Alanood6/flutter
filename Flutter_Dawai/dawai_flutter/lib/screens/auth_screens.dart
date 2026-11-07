import 'dart:async';

import 'package:flutter/material.dart';

import '../core.dart';
import 'home_screen.dart';

// ================= SPLASH SCREEN =================

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController opening;
  late AnimationController background;

  @override
  void initState() {
    super.initState();

    opening = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2200),
    )..forward();

    background = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 9),
    )..repeat();

    Timer(const Duration(milliseconds: 3500), () {
      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const LoginScreen()),
      );
    });
  }

  @override
  void dispose() {
    opening.dispose();
    background.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          const LuxuryBackground(),
          AnimatedBuilder(
            animation: background,
            builder: (_, __) {
              return CustomPaint(
                painter: ParticlePainter(progress: background.value),
              );
            },
          ),
          Center(
            child: AnimatedBuilder(
              animation: opening,
              builder: (_, __) {
                final value =
                    Curves.easeInOutCubic.transform(opening.value);

                return Opacity(
                  opacity: value,
                  child: Transform.scale(
                    scale: 0.75 + value * 0.25,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        logo(size: 115),
                        const SizedBox(height: 20),
                        const Text(
                          "Dawa'i",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 43,
                            fontWeight: FontWeight.w800,
                            letterSpacing: 5,
                          ),
                        ),
                        const Text(
                          "دوائي",
                          style: TextStyle(
                            color: C.lavender,
                            fontSize: 29,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 13),
                        const Text(
                          "رعايتك تبدأ من هنا",
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          const Positioned(
            bottom: 35,
            left: 0,
            right: 0,
            child: Text(
              "YOUR HEALTH • OUR PRIORITY",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white38,
                fontSize: 10,
                letterSpacing: 3,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ================= LOGIN SCREEN =================

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with TickerProviderStateMixin {
  final formKey = GlobalKey<FormState>();
  final email = TextEditingController();
  final password = TextEditingController();

  bool hidePassword = true;
  late AnimationController entrance;
  late AnimationController movement;

  @override
  void initState() {
    super.initState();

    entrance = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2800),
    )..forward();

    movement = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 12),
    )..repeat();
  }

  @override
  void dispose() {
    entrance.dispose();
    movement.dispose();
    email.dispose();
    password.dispose();
    super.dispose();
  }

  Widget stagger(Widget child, double start) {
    final animation = CurvedAnimation(
      parent: entrance,
      curve: Interval(start, 1, curve: Curves.easeOutCubic),
    );

    return AnimatedBuilder(
      animation: animation,
      builder: (_, __) {
        return Opacity(
          opacity: animation.value,
          child: Transform.translate(
            offset: Offset(0, 25 * (1 - animation.value)),
            child: child,
          ),
        );
      },
    );
  }

  void login() {
    if (!formKey.currentState!.validate()) return;

    final enteredEmail = email.text.trim().toLowerCase();
    final enteredPassword = password.text;

    UserAccount? foundUser;

    for (final user in usersList) {
      if (user.email.toLowerCase() == enteredEmail) {
        foundUser = user;
        break;
      }
    }

    if (foundUser == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("الحساب غير موجود، يرجى إنشاء حساب"),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    if (foundUser.password != enteredPassword) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("كلمة المرور غير صحيحة"),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }
    Navigator.pushReplacement(
  context,
  MaterialPageRoute(
    builder: (_) => const HomeScreen(),
  ),
);
  }

  void openRegister() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => const RegisterScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: Stack(
          children: [
            const LuxuryBackground(),
            AnimatedBuilder(
              animation: movement,
              builder: (_, __) {
                return CustomPaint(
                  size: Size.infinite,
                  painter: ParticlePainter(progress: movement.value),
                );
              },
            ),
            SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(25, 25, 25, 35),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 15),
                    stagger(
                      Column(
                        children: [
                          logo(size: 90),
                          const SizedBox(height: 5),
                          const Text(
                            "Dawa'i",
                            style: TextStyle(
                              fontSize: 38,
                              fontWeight: FontWeight.w900,
                              color: Colors.white,
                              letterSpacing: 4,
                            ),
                          ),
                          const Text(
                            "دوائي",
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: C.lavender,
                            ),
                          ),
                        ],
                      ),
                      0,
                    ),
                    const SizedBox(height: 30),
                    stagger(
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "رعايتك تبدأ من هنا",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 27,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          SizedBox(height: 9),
                          Text(
                            "اعثر على دوائك، واعرف أين تجده",
                            style: TextStyle(
                              color: Color(0xFFD3C4E2),
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                      0.22,
                    ),
                    const SizedBox(height: 27),
                    glassCard(
                      child: Form(
                        key: formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            stagger(
                              const Text(
                                "تسجيل الدخول",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              0.30,
                            ),
                            const SizedBox(height: 23),
                            stagger(
                              const Text(
                                "البريد الإلكتروني",
                                style: TextStyle(
                                  color: C.lavender,
                                  fontSize: 13,
                                ),
                              ),
                              0.36,
                            ),
                            const SizedBox(height: 9),
                            stagger(
                              TextFormField(
                                controller: email,
                                keyboardType: TextInputType.emailAddress,
                                textDirection: TextDirection.ltr,
                                style: const TextStyle(color: Colors.white),
                                decoration: fieldDecoration(
                                  "example@email.com",
                                  Icons.alternate_email,
                                ),
                                validator: (v) {
                                  if (v == null ||
                                      !v.contains('@') ||
                                      !v.contains('.')) {
                                    return "أدخل بريداً إلكترونياً صحيحاً";
                                  }
                                  return null;
                                },
                              ),
                              0.42,
                            ),
                            const SizedBox(height: 20),
                            stagger(
                              const Text(
                                "كلمة المرور",
                                style: TextStyle(
                                  color: C.lavender,
                                  fontSize: 13,
                                ),
                              ),
                              0.52,
                            ),
                            const SizedBox(height: 9),
                            stagger(
                              TextFormField(
                                controller: password,
                                obscureText: hidePassword,
                                style: const TextStyle(color: Colors.white),
                                decoration: fieldDecoration(
                                  "أدخل كلمة المرور",
                                  Icons.lock_outline,
                                ).copyWith(
                                  suffixIcon: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        hidePassword = !hidePassword;
                                      });
                                    },
                                    icon: Icon(
                                      hidePassword
                                          ? Icons.visibility_off
                                          : Icons.visibility,
                                      color: C.lavender,
                                    ),
                                  ),
                                ),
                                validator: (v) {
                                  if (v == null || v.length < 6) {
                                    return "كلمة المرور يجب أن تكون 6 أحرف على الأقل";
                                  }
                                  return null;
                                },
                              ),
                              0.58,
                            ),
                            const SizedBox(height: 28),
                            stagger(
                              gradientButton(
                                text: "دخول إلى حسابي",
                                onPressed: login,
                              ),
                              0.72,
                            ),
                            const SizedBox(height: 20),
                            stagger(
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    "مستخدم جديد؟ ",
                                    style: TextStyle(color: Colors.white70),
                                  ),
                                  TextButton(
                                    onPressed: openRegister,
                                    child: const Text(
                                      "أنشئ حسابك الآن",
                                      style: TextStyle(
                                        color: C.lavender,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              0.84,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 27),
                    stagger(
                      const Text(
                        "DOCTOR • PHARMACY • CARE",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white38,
                          fontSize: 10,
                          letterSpacing: 2.5,
                        ),
                      ),
                      0.92,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ================= REGISTER SCREEN =================

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmController = TextEditingController();

  bool hidePassword = true;
  bool hideConfirm = true;

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    confirmController.dispose();
    super.dispose();
  }

  Widget registerLabel(String text) {
    return Text(
      text,
      style: const TextStyle(color: C.lavender, fontSize: 13),
    );
  }

  Widget registerField({
    required String hint,
    required IconData icon,
    required TextEditingController controller,
    TextInputType keyboardType = TextInputType.text,
    bool obscure = false,
    Widget? suffix,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscure,
      textDirection: keyboardType == TextInputType.emailAddress
          ? TextDirection.ltr
          : TextDirection.rtl,
      style: const TextStyle(color: Colors.white),
      decoration: fieldDecoration(hint, icon).copyWith(suffixIcon: suffix),
      validator: validator,
    );
  }

  void register() {
    if (!formKey.currentState!.validate()) return;

    FocusScope.of(context).unfocus();

    final enteredEmail = emailController.text.trim().toLowerCase();

    final emailExists = usersList.any(
      (user) => user.email.toLowerCase() == enteredEmail,
    );

    if (emailExists) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("هذا البريد مسجل مسبقاً"),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    usersList.add(
      UserAccount(
        name: nameController.text.trim(),
        email: enteredEmail,
        phone: phoneController.text.trim(),
        password: passwordController.text,
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("تم إنشاء الحساب بنجاح، يمكنك تسجيل الدخول"),
        behavior: SnackBarBehavior.floating,
      ),
    );

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: Stack(
          children: [
            const LuxuryBackground(),
            SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(25, 12, 25, 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Align(
                      alignment: Alignment.centerRight,
                      child: IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(
                          Icons.arrow_back_ios_new,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(height: 5),

                    // Capsule opens when the Register screen appears.
                    const Center(child: OpeningCapsule(size: 75)),

                    const SizedBox(height: 12),
                    const Text(
                      "إنشاء حساب جديد",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 27,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      "انضم إلينا وابدأ رحلتك الصحية",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xFFD3C4E2),
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 30),
                    glassCard(
                      child: Form(
                        key: formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            const Text(
                              "بيانات الحساب",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 25),

                            registerLabel("الاسم الكامل"),
                            const SizedBox(height: 9),
                            registerField(
                              hint: "أدخل اسمك الكامل",
                              icon: Icons.person_outline,
                              controller: nameController,
                              validator: (v) {
                                if (v == null || v.trim().isEmpty) {
                                  return "يرجى إدخال الاسم";
                                }
                                return null;
                              },
                            ),

                            const SizedBox(height: 20),
                            registerLabel("البريد الإلكتروني"),
                            const SizedBox(height: 9),
                            registerField(
                              hint: "example@email.com",
                              icon: Icons.email_outlined,
                              controller: emailController,
                              keyboardType: TextInputType.emailAddress,
                              validator: (v) {
                                if (v == null ||
                                    !v.contains('@') ||
                                    !v.contains('.')) {
                                  return "أدخل بريداً إلكترونياً صحيحاً";
                                }
                                return null;
                              },
                            ),

                            const SizedBox(height: 20),
                            registerLabel("رقم الهاتف"),
                            const SizedBox(height: 9),
                            registerField(
                              hint: "أدخل رقم الهاتف",
                              icon: Icons.phone_outlined,
                              controller: phoneController,
                              keyboardType: TextInputType.phone,
                              validator: (v) {
                                if (v == null || v.trim().length < 9) {
                                  return "أدخل رقم هاتف صحيحاً";
                                }
                                return null;
                              },
                            ),

                            const SizedBox(height: 20),
                            registerLabel("كلمة المرور"),
                            const SizedBox(height: 9),
                            registerField(
                              hint: "أدخل كلمة المرور",
                              icon: Icons.lock_outline,
                              controller: passwordController,
                              obscure: hidePassword,
                              suffix: IconButton(
                                onPressed: () {
                                  setState(() {
                                    hidePassword = !hidePassword;
                                  });
                                },
                                icon: Icon(
                                  hidePassword
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                  color: C.lavender,
                                ),
                              ),
                              validator: (v) {
                                if (v == null || v.length < 6) {
                                  return "كلمة المرور 6 أحرف على الأقل";
                                }
                                return null;
                              },
                            ),

                            const SizedBox(height: 20),
                            registerLabel("تأكيد كلمة المرور"),
                            const SizedBox(height: 9),
                            registerField(
                              hint: "أعد إدخال كلمة المرور",
                              icon: Icons.lock_reset,
                              controller: confirmController,
                              obscure: hideConfirm,
                              suffix: IconButton(
                                onPressed: () {
                                  setState(() {
                                    hideConfirm = !hideConfirm;
                                  });
                                },
                                icon: Icon(
                                  hideConfirm
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                  color: C.lavender,
                                ),
                              ),
                              validator: (v) {
                                if (v != passwordController.text) {
                                  return "كلمتا المرور غير متطابقتين";
                                }
                                return null;
                              },
                            ),

                            const SizedBox(height: 30),
                            gradientButton(
                              text: "إنشاء الحساب",
                              onPressed: register,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "لديك حساب بالفعل؟ ",
                          style: TextStyle(color: Colors.white70),
                        ),
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text(
                            "تسجيل الدخول",
                            style: TextStyle(
                              color: C.lavender,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      "DOCTOR • PHARMACY • CARE",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white38,
                        fontSize: 10,
                        letterSpacing: 2.5,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
