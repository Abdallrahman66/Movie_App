import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:hive_ce_flutter/hive_ce_flutter.dart';

import 'package:movie_app/core/di/service_locatore.config.dart';
import 'package:movie_app/feature/watch_list/data/data_sources/watch_list_local_data_source.dart';
import 'package:movie_app/feature/watch_list/data/repositories/watch_list_repository_impl.dart';
import 'package:movie_app/feature/watch_list/data/watch_list_storage.dart';
import 'package:movie_app/feature/watch_list/domain/repositories/watch_list_repository.dart';
import 'package:movie_app/feature/watch_list/domain/use_cases/get_watch_list_use_case.dart';
import 'package:movie_app/feature/watch_list/domain/use_cases/remove_watch_list_movie_use_case.dart';
import 'package:movie_app/feature/watch_list/domain/use_cases/toggle_watch_list_use_case.dart';
import 'package:movie_app/feature/watch_list/presentation/view_model/watch_list_cubit.dart';

final getIt = GetIt.instance;

@InjectableInit()
void configureDependencies() {
  getIt.init();

  final box = Hive.box<dynamic>(WatchListStorage.boxName);

  getIt.registerLazySingleton<WatchListLocalDataSource>(
    () => WatchListLocalDataSource(box),
  );

  getIt.registerLazySingleton<WatchListRepository>(
    () => WatchListRepositoryImpl(getIt<WatchListLocalDataSource>()),
  );

  getIt.registerLazySingleton(
    () => GetWatchListUseCase(getIt<WatchListRepository>()),
  );

  getIt.registerLazySingleton(
    () => ToggleWatchListUseCase(getIt<WatchListRepository>()),
  );

  getIt.registerLazySingleton(
    () => RemoveWatchListMovieUseCase(getIt<WatchListRepository>()),
  );

  if (!getIt.isRegistered<WatchListCubit>()) {
    getIt.registerLazySingleton<WatchListCubit>(
      () => WatchListCubit(
        getWatchList: getIt<GetWatchListUseCase>(),
        toggleWatchList: getIt<ToggleWatchListUseCase>(),
        removeWatchListMovie: getIt<RemoveWatchListMovieUseCase>(),
      ),
    );
  }
}
