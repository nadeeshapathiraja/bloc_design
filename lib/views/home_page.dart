import 'package:bloc_patterns/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_switch/flutter_advanced_switch.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

import '../bloc/get_user_data_bloc.dart';
import '../components/show_dialog.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final userDataBloc = DataBloc();
  @override
  void initState() {
    super.initState();
    userDataBloc.add(GetUserData());
  }

  @override
  Widget build(BuildContext context) {
    final controller15 = ValueNotifier<bool>(false);
    final size = MediaQuery.of(context).size;
    return Consumer<ThemeProvider>(
      builder: (context, ref, child) {
        return Scaffold(
          backgroundColor: Theme.of(context).colorScheme.background,
          appBar: AppBar(
            backgroundColor: Colors.deepPurple,
            centerTitle: true,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Home page",
                ),
                AdvancedSwitch(
                  width: 60,
                  height: 28,
                  activeChild: const Icon(
                    Icons.light_mode,
                    color: Colors.black,
                  ),
                  inactiveChild: const Icon(
                    Icons.dark_mode,
                    color: Colors.white,
                  ),
                  activeColor: Colors.white,
                  inactiveColor: Colors.black,
                  onChanged: (val) {
                    Logger().w(val);

                    ref.toggleTap();
                  },
                  controller: controller15,
                ),
              ],
            ),
          ),
          body: Stack(
            children: [
              Center(
                child: Container(
                  color: Theme.of(context).colorScheme.primary,
                  width: 300,
                  height: 300,
                ),
              ),
              Center(
                child: Container(
                  width: 150,
                  height: 150,
                  color: Theme.of(context).colorScheme.secondary,
                  child: BlocBuilder<DataBloc, DataState>(
                    bloc: userDataBloc,
                    builder: (context, state) {
                      if (state is DataLoadingState) {
                        // Use addPostFrameCallback to ensure dialog is shown after build is done
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          ShowAllDialog.showLoadiingDialog(size.width);
                        });
                      }

                      if (state is DataSuccessState) {
                        // Hide dialog after data is loaded
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          ShowAllDialog.hideDialog();
                        });
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Center(
                              child: Text(
                                  "${state.userDataModel.firstName!} ${state.userDataModel.lastName!}"),
                            )
                          ],
                        );
                      }

                      if (state is DataFailedState) {
                        // Hide dialog if loading failed
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          ShowAllDialog.hideDialog();
                        });
                      }

                      return Container(); // Update with actual UI if necessary
                    },
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
