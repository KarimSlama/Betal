import 'package:Betal/shared/cubit/states/mode_state.dart';
import 'package:Betal/shared/data/local_storage/cache_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ModeCubit extends Cubit<ModeStates> {
  ModeCubit() : super(ModeInitialState());

  static ModeCubit getContext(context) => BlocProvider.of(context);

  bool isDark = false;

  void changeMode({bool? fromShared}) {
    if (fromShared != null) {
      isDark = fromShared;
    } else {
      isDark = !isDark;
      CacheHelper.saveData(key: 'isDark', value: isDark).then((value) {
        emit(ModeChangeState());
      });
    } //end else
  } //end changeMode()
} //end class
