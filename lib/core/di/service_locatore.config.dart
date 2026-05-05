// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:movie_app/feature/home/data/api/home_api.dart' as _i61;
import 'package:movie_app/feature/home/data/repo/data_source/home_recommended_remote_data_source_imp.dart'
    as _i580;
import 'package:movie_app/feature/home/data/repo/repository/home_recommended_repository_imp.dart'
    as _i329;
import 'package:movie_app/feature/home/domain/repo/data_source/recommended_data_source_interface.dart'
    as _i99;
import 'package:movie_app/feature/home/domain/repo/repository/recommended_repository_interface.dart'
    as _i175;
import 'package:movie_app/feature/home/domain/use_case/get_recommended_movie_use_case.dart'
    as _i67;
import 'package:movie_app/feature/home/presentation/view_model/home_cubit.dart'
    as _i142;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    gh.singleton<_i61.HomeApi>(() => _i61.HomeApi());
    gh.factory<_i99.RecommendedDataSourceInterface>(
      () => _i580.HomeRecommendedRemoteDataSourceImp(gh<_i61.HomeApi>()),
    );
    gh.lazySingleton<_i175.RecommendedRepositoryInterface>(
      () => _i329.HomeRecommendedRepositoryImp(
        gh<_i99.RecommendedDataSourceInterface>(),
      ),
    );
    gh.factory<_i67.GetRecommendedMovieUseCase>(
      () => _i67.GetRecommendedMovieUseCase(
        gh<_i175.RecommendedRepositoryInterface>(),
      ),
    );
    gh.factory<_i142.HomeCubit>(
      () => _i142.HomeCubit(gh<_i67.GetRecommendedMovieUseCase>()),
    );
    return this;
  }
}
