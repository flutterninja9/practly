// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class Header extends StatelessWidget {
  const Header({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: ShadTheme.of(context).textTheme.h1,
    );
  }
}
