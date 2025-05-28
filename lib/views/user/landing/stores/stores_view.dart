import 'package:autoguide/services/get_data_services.dart';
import 'package:flutter/cupertino.dart';

class StoresView extends StatelessWidget {
  const StoresView({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: GetDataServices().getCategoriesStores(),
      builder: (context, snapshot) {
        return const Placeholder();
      },
    );
  }
}
