import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class OrdersPage extends StatelessWidget {
  const OrdersPage({Key? key}) : super(key: key);
  @override
  Widget build(context) {
    final l10n = context.read<AppLocalizations>();
    return Text(l10n.orders);
  }
}
