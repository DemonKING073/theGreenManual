// ignore_for_file: empty_catches

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:the_green_manual/common/ui/ui_helpers.dart';
import 'package:the_green_manual/core/http/http.dart';
import 'package:the_green_manual/modules/faq_module/faq_response.dart';
import 'package:the_green_manual/themes/app_theme.dart';

class FAQScreen extends StatefulWidget {
  const FAQScreen({super.key});

  @override
  State<FAQScreen> createState() => _FAQScreenState();
}

class _FAQScreenState extends State<FAQScreen> {
  @override
  void initState() {
    fetchFAQ();
    super.initState();
  }

  Dio dio = getHttp();

  FAQResponse? faqState;

  bool isLoading = true;

  fetchFAQ() async {
    try {
      final res = await dio.get("v1/faqs");
      faqState = FAQResponse.fromJson(res.data);
    } catch (err) {}
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(
          color: Colors.black, //change your color here
        ),
        title: Text(
          'FAQ',
          style: TextStyle(
            color: Colors.grey[800],
            fontFamily: 'Poppins',
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(
                color: primaryColor,
              ),
            )
          : (faqState == null ||
                  (faqState != null && faqState!.data!.faqs!.isEmpty))
              ? const Center(
                  child: Text("No FAQ's"),
                )
              : Padding(
                  padding: const EdgeInsets.only(
                    left: 18,
                    right: 18,
                    bottom: 18,
                    top: 25,
                  ),
                  child: Column(
                    children: faqState!.data!.faqs!
                        .map((e) => FAQCard(item: e))
                        .toList(),
                  ),
                ),
    );
  }
}

class FAQCard extends StatefulWidget {
  final Faqs item;
  const FAQCard({super.key, required this.item});

  @override
  State<FAQCard> createState() => _FAQCardState();
}

class _FAQCardState extends State<FAQCard> {
  Map<String, dynamic> faqToggle = {};

  onToggle(String id) {
    final isKeyStored = faqToggle.containsKey(id);
    if (!isKeyStored) {
      setState(() {
        faqToggle[id] = true;
      });
    } else {
      setState(() {
        faqToggle[id] = !faqToggle[id];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: () {
            onToggle(widget.item.sId!);
          },
          child: Row(
            children: [
              Expanded(
                child: Row(
                  children: [
                    SizedBox(
                      width: 60,
                      height: 60,
                      child: Image.asset(
                        "assets/icons/faq.png",
                        fit: BoxFit.contain,
                      ),
                    ),
                    mWidthSpan,
                    Text(
                      widget.item.question ?? "",
                      style: const TextStyle(
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                      ),
                    )
                  ],
                ),
              ),
              if (faqToggle[widget.item.sId] == false)
                Icon(
                  Icons.chevron_right,
                  color: Colors.grey[400],
                  size: 25,
                )
              else
                Icon(
                  Icons.keyboard_arrow_down,
                  color: Colors.grey[400],
                  size: 25,
                )
            ],
          ),
        ),
        if (faqToggle[widget.item.sId] == true)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  right: 10,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: const Color(0xffEFEFEF),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 30,
                        vertical: 20,
                      ),
                      child: Text(
                        widget.item.answer ?? "",
                        style: const TextStyle(
                          fontFamily: "Poppins",
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              sHeightSpan,
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: const [
                  Text(
                    "Still need help?",
                    style: TextStyle(
                      fontFamily: "Poppins",
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                      color: primaryColor,
                    ),
                  ),
                ],
              )
            ],
          )
      ],
    );
  }
}
