import 'package:flutter/material.dart';

import '../../../common/components/common_footer.dart';

class TermsAndConditionPage extends StatefulWidget {
  const TermsAndConditionPage({super.key});

  @override
  State<TermsAndConditionPage> createState() => _TermsAndConditionPageState();
}

class _TermsAndConditionPageState extends State<TermsAndConditionPage> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(children: [Text("T&C Content")]),
          ),
          SizedBox(height: 20),
          CommonFooter(),
        ],
      ),
    );
  }
}
