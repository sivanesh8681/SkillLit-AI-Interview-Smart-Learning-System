import 'package:flutter/material.dart';
import 'lesson_loading_screen.dart';

class LessonGenerateScreen extends StatefulWidget {
  const LessonGenerateScreen({super.key});

  @override
  State<LessonGenerateScreen> createState() => _LessonGenerateScreenState();
}

class _LessonGenerateScreenState extends State<LessonGenerateScreen> {
  final TextEditingController _topicController = TextEditingController();

  String selectedDuration = "45 min";
  String selectedDifficulty = "Medium";
  String errorText = "";

  bool isChecking = false;
  bool? isValidTopic; // null = not checked, true = valid, false = invalid

  final durations = ["15 min", "30 min", "1 hr", "45 min", "2 hrs"];
  final difficulties = ["Easy", "Medium", "Exam"];

  bool validateTopic(String text) {
    final trimmed = text.trim();
    if (trimmed.length < 4) return false;
    final hasLetters = RegExp(r'[a-zA-Z]').hasMatch(trimmed);
    return hasLetters;
  }

  Future<void> checkTopic() async {
    final text = _topicController.text.trim();

    if (text.isEmpty) {
      setState(() {
        isValidTopic = false;
        errorText = "Enter a valid topic";
      });
      return;
    }
    setState(() {
      isChecking = true;
      errorText = "";
    });

    await Future.delayed(const Duration(seconds: 1));

    final valid = validateTopic(text);

    setState(() {
      isChecking = false;
      isValidTopic = valid;
      if (!valid) {
        errorText = "Enter a valid topic";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
        backgroundColor: const Color(0xfff6f7fb),
        body: SafeArea(
            child: Center(
                child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                        /// 🔙 BACK BUTTON
                        GestureDetector(
                        onTap: () => Navigator.pop(context),
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.08),
                        blurRadius: 10,
                        offset: const Offset(0, 6),
                      )
                    ],
                  ),
                  child: const Icon(Icons.arrow_back_ios_new, size: 18),
                ),
            ),

            const SizedBox(height: 30),

            /// ⭐ TITLE
            const Center(
              child: Text(
                "What would you\nlike to learn?",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w700,
                  height: 1.2,
                ),
              ),
            ),

            const SizedBox(height: 28),

            /// 🔍 TOPIC INPUT
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(28),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.06),
                    blurRadius: 18,
                    offset: const Offset(0, 10),
                  )
                ],
              ),
              child: Row(
                children: [
              Expanded(
              child: TextField(
              controller: _topicController,
                onChanged: (_) {
                  setState(() {
                    isValidTopic = null;
                    errorText = "";
                  });
                },
                decoration: const InputDecoration(
                  hintText: "Enter topic (e.g. Power System Unit 2)",
                  border: InputBorder.none,
                ),
              ),
            ),

            /// ⬆️ CHECK BUTTON
            GestureDetector(
                onTap: checkTopic,
                child: Container(
                    width: 44,
                    height: 44,
                    decoration:
                    const BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        colors: [Color(0xff8a9cff), Color(0xffb07cff)],
                      ),
                    ),
                  child: Center(
                    child: isChecking
                        ? const SizedBox(
                      width: 22,
                      height: 22,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 2.5,
                      ),
                    )
                        : isValidTopic == true
                        ? const Icon(Icons.check, color: Colors.white)
                        : isValidTopic == false
                        ? const Icon(Icons.close, color: Colors.white)
                        : const Icon(Icons.arrow_upward, color: Colors.white),
                  ),
                ),
            )
                ],
              ),
            ),

            const SizedBox(height: 26),

            /// 📦 MAIN CARD
            Container(
              width: width,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(26),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    blurRadius: 24,
                    offset: const Offset(0, 12),
                  )
                ],
              ),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                  /// ⏱ DURATION
                  const Text("Duration", style: TextStyle(fontWeight: FontWeight.w600)),
              const SizedBox(height: 12),

              Wrap(
                spacing: 10,
                children: durations.map((d) {
                  final selected = selectedDuration == d;
                  return ChoiceChip(
                    label: Text(d),
                    selected: selected,
                    selectedColor: const Color(0xff8a9cff),
                    backgroundColor: const Color(0xfff2f3f7),
                    labelStyle: TextStyle(
                      color: selected ? Colors.white : Colors.black,
                    ),
                    onSelected: (_) {
                      setState(() => selectedDuration = d);
                    },
                  );
                }).toList(),
              ),

              const SizedBox(height: 22),

              /// ⚡ DIFFICULTY
              const Text("Difficulty", style: TextStyle(fontWeight: FontWeight.w600)),
              const SizedBox(height: 12),
                Row(
                    children: difficulties.map((d) {
                      final selected = selectedDifficulty == d;
                      return Expanded(
                          child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 4),
                              child: GestureDetector(
                                  onTap: () {
                                    setState(() => selectedDifficulty = d);
                                  },
                                  child: Container(
                                      height: 44,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        gradient: selected
                                            ? const LinearGradient(
                                          colors: [
                                            Color(0xff8a9cff),
                                            Color(0xffb07cff)
                                          ],
                                        )
                                            : null,
                                        color: selected ? null : const Color(0xfff2f3f7),
                                        borderRadius: BorderRadius.circular(22),
                                      ),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                        Text(
                                        d,
                                        style: TextStyle(
                                          color: selected ? Colors.white : Colors.black87,
                                        ),
                                        ),
                                          if (selected && d == "Medium")
                                            const Padding(
                                              padding: EdgeInsets.only(left: 6),
                                              child: Icon(Icons.check_circle,
                                                  color: Colors.white, size: 18),
                                            )
                                        ],
                                      ),
                                  ),
                              ),
                          ),
                      );
                    }).toList(),
                ),

                const SizedBox(height: 24),

                const Center(
                  child: Text(
                    "Optimized lesson delivered.",
                    style: TextStyle(color: Colors.grey),
                  ),
                ),

                const SizedBox(height: 14),

                /// ❌ ERROR
                if (errorText.isNotEmpty)
          Center(
          child: Text(
          errorText,
          style: const TextStyle(color: Colors.red),
        ),
    ),

    const SizedBox(height: 10),

    /// 🚀 GENERATE
    GestureDetector(
    onTap: () {
    if (isValidTopic != true) {
    setState(() {
    errorText = "Enter a valid topic";
    });
    return;
    }

    setState(() => errorText = "");
    /// ✅ NAVIGATE TO LOADING SCREEN
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => LessonLoadingScreen(
          topic: _topicController.text.trim(),
          duration: selectedDuration,
          difficulty: selectedDifficulty,
        ),
      ),
    );
    },
      child: Container(
        height: 54,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          gradient: const LinearGradient(
            colors: [
              Color(0xff8a9cff),
              Color(0xffb07cff)
            ],
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.purple.withOpacity(0.35),
              blurRadius: 18,
              offset: const Offset(0, 10),
            )
          ],
        ),
        child: const Text(
          "Generate",
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    ),
                  ],
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