part of 'fetch_ads_cubit.dart';

sealed class FetchAdsState extends Equatable {
  const FetchAdsState();

  @override
  List<Object> get props => [];
}

final class FetchAdsInitial extends FetchAdsState {}

final class FetchAdsLoading extends FetchAdsState {}

final class FetchAdsFailure extends FetchAdsState {
  final String errMessage;
  const FetchAdsFailure({required this.errMessage});
}

final class FetchAdsSuccess extends FetchAdsState {
  final AdsModel adModel;

  const FetchAdsSuccess(this.adModel);
}
