import 'package:athkari/app/features/home/presentation/cubit/today_dekhar_cubit_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TodayDekharCubit extends Cubit<TodayDekharCubitStates> {
  
  TodayDekharCubit() : super(InitialTodayDekharState()) {
   fetchTodayDekhar();
   // fetchData();
   //  getTodayDekhar();
  }

  fetchTodayDekhar(){
    emit(waitingDekkharState());
    Future.delayed(Duration(seconds: 3),(){
      emit(doneDekkharState("بسم الله الذي لا يضر مع اسمه شيء في الأرض ولا في السماء وهو السميع العليم"));
 
    }); }
    
}