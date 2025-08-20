import 'package:athkari/app/core/ModelBottomSheet/add_esnad_modelbottomsheet.dart';
import 'package:athkari/app/core/methods/build_appbar_method.dart';
import 'package:athkari/app/core/methods/build_searchbae_method.dart';
import 'package:athkari/app/core/methods/success_snackbar.dart';
import 'package:athkari/app/features/esnaad/presentation/cubit/Esnads_cubit.dart';
import 'package:athkari/app/features/esnaad/presentation/cubit/Esnads_cubit_state.dart';
import 'package:athkari/app/features/esnaad/presentation/widgets/esnad_card_widget.dart';
import 'package:athkari/app/features/home/presentation/pages/drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EsnaadsPage extends StatelessWidget {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController esnadValue = TextEditingController();
  final TextEditingController esnadUpdatedValue = TextEditingController();

  EsnaadsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: buildAppBar(context, "الإسنادات"),
    //  drawer: DrawerWidget(),
      floatingActionButton:  buildFloatingActionMethodTemp(context),
      
     // newMethod(context),
      body: Column(
        children: [
          buildSearchBar(
            context,
            (query) {
              if (query.isNotEmpty) {
                context.read<EsnadsCubit>().search(query);
              } else {
                context.read<EsnadsCubit>().fetchData();
              }
            },
          ),
          Expanded(
              // Ensure the ListView takes the remaining space
              child: BlocListener<EsnadsCubit, EsnadState>(
            listener: (context, state) {
              if (state is NotifeyEsnadState) {
                successToastMessage(context, state.message);
              }
            },
            child: BlocBuilder<EsnadsCubit, EsnadState>(
              builder: (context, state) {
                if (state is LoadingEsnadState) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is DoneEsnadState) {
                  return ListView.builder(
                    itemCount: state.esnads.length,
                    itemBuilder: (context, index) {
                      final item = state.esnads[index];
                      final esnadUpdatedValue =
                          TextEditingController(text: item.name);

                      return EsnadCardWidget(
                        esnad: item,
                        formKey: formKey,
                        esnadUpdatedValueController: esnadUpdatedValue,
                      );
                    },
                  );
                } else if (state is EmptyEsnadState) {
                  return Center(
                    child: Text(state.message),
                  );
                } else {
                  return Center(
                    child: ElevatedButton(
                      onPressed: () {
                        // Trigger a specific event
                        context.read<EsnadsCubit>().fetchData();
                      },
                      child: Text('إعاده المحاولة'),
                    ),
                  );
                }
              },
            ),
          )),
        ],
      ),
  
  
    );



  }
    FloatingActionButton buildFloatingActionMethodTemp(BuildContext context) {
    return FloatingActionButton(
      foregroundColor: Colors.white,
      backgroundColor: Color.fromARGB(255, 128, 188, 189),
      child: Center(
        child: Icon(Icons.add),
      ),
      onPressed: () {
        buildAddEsnadModalBottomSheet(context, formKey, esnadValue);
        
      },
    );
  }
  
}
