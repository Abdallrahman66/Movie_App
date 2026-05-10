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
import 'package:movie_app/feature/home/data/api/home_popolure_api.dart'
    as _i976;
import 'package:movie_app/feature/home/data/api/home_recommended_api.dart'
    as _i668;
import 'package:movie_app/feature/home/data/api/home_releases_api.dart'
    as _i913;
import 'package:movie_app/feature/home/data/repo/data_source/home_popolure_remote_data_source_imp.dart'
    as _i959;
import 'package:movie_app/feature/home/data/repo/data_source/home_recommended_remote_data_source_imp.dart'
    as _i580;
import 'package:movie_app/feature/home/data/repo/data_source/home_releases_remote_data_source_imp.dart'
    as _i787;
import 'package:movie_app/feature/home/data/repo/repository/home_popolure_repository_imp.dart'
    as _i653;
import 'package:movie_app/feature/home/data/repo/repository/home_recommended_repository_imp.dart'
    as _i329;
import 'package:movie_app/feature/home/data/repo/repository/home_releases_repository_imp.dart'
    as _i739;
import 'package:movie_app/feature/home/domain/repo/data_source/popolure_data_source_interface.dart'
    as _i352;
import 'package:movie_app/feature/home/domain/repo/data_source/recommended_data_source_interface.dart'
    as _i99;
import 'package:movie_app/feature/home/domain/repo/data_source/releases_data_source_interface.dart'
    as _i343;
import 'package:movie_app/feature/home/domain/repo/repository/popolure_repository_interface.dart'
    as _i814;
import 'package:movie_app/feature/home/domain/repo/repository/recommended_repository_interface.dart'
    as _i175;
import 'package:movie_app/feature/home/domain/repo/repository/releases_repository_interface.dart'
    as _i1005;
import 'package:movie_app/feature/home/domain/use_case/get_popolure_movie_use_case.dart'
    as _i458;
import 'package:movie_app/feature/home/domain/use_case/get_recommended_movie_use_case.dart'
    as _i67;
import 'package:movie_app/feature/home/domain/use_case/get_releases_movie_use_case.dart'
    as _i179;
import 'package:movie_app/feature/home/presentation/view_model/home_cubit.dart'
    as _i142;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    gh.singleton<_i976.HomePopularApi>(() => _i976.HomePopularApi());
    gh.singleton<_i668.HomeRecommendedApi>(() => _i668.HomeRecommendedApi());
    gh.singleton<_i913.HomeReleasesApi>(() => _i913.HomeReleasesApi());
    gh.factory<_i352.PopolureDataSourceInterface>(
      () => _i959.HomePopolureRemoteDataSourceImp(gh<_i976.HomePopularApi>()),
    );
    gh.lazySingleton<_i814.PopolureRepositoryInterface>(
      () => _i653.HomePopolureRepositoryImp(
        gh<_i352.PopolureDataSourceInterface>(),
      ),
    );
    gh.factory<_i458.GetPopolureMovieUseCase>(
      () => _i458.GetPopolureMovieUseCase(
        gh<_i814.PopolureRepositoryInterface>(),
      ),
    );
    gh.factory<_i99.RecommendedDataSourceInterface>(
      () => _i580.HomeRecommendedRemoteDataSourceImp(
        gh<_i668.HomeRecommendedApi>(),
      ),
    );
    gh.factory<_i343.ReleasesDataSourceInterface>(
      () => _i787.HomeReleasesRemoteDataSourceImp(gh<_i913.HomeReleasesApi>()),
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
    gh.lazySingleton<_i1005.ReleasesRepositoryInterface>(
      () => _i739.HomeReleasesRepositoryImp(
        gh<_i343.ReleasesDataSourceInterface>(),
      ),
    );
    gh.factory<_i179.GetReleasesMovieUseCase>(
      () => _i179.GetReleasesMovieUseCase(
        gh<_i1005.ReleasesRepositoryInterface>(),
      ),
    );
    gh.factory<_i142.HomeCubit>(
      () => _i142.HomeCubit(
        gh<_i67.GetRecommendedMovieUseCase>(),
        gh<_i458.GetPopolureMovieUseCase>(),
        gh<_i179.GetReleasesMovieUseCase>(),
      ),
    );
    return this;
  }
}
