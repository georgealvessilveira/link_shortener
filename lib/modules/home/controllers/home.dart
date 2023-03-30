import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:link_shortener/modules/link/models/link_alias.dart';
import 'package:link_shortener/modules/link/repositories/link.dart';

enum HomeStatus {
  initial,
  loading,
  loaded,
  error,
  noInternetConnection,
}

class HomeState extends Equatable {
  final HomeStatus status;
  final List<LinkAlias> links;

  const HomeState({
    this.status = HomeStatus.initial,
    this.links = const [],
  });

  HomeState copyWith({
    HomeStatus? status,
    List<LinkAlias>? links,
  }) {
    return HomeState(
      status: status ?? this.status,
      links: links ?? this.links,
    );
  }

  @override
  List<Object?> get props => [status, links];
}

class HomeController extends Cubit<HomeState> implements IHomeController {
  final ILinkRepository linkRepository;

  HomeController({required this.linkRepository}) : super(const HomeState());

  set internetConnection(bool internetConnection) {
    if (!internetConnection) {
      emit(state.copyWith(status: HomeStatus.noInternetConnection));
    }
  }

  @override
  Future<void> fetchRecentlyLinks() async {
    try {
      emit(state.copyWith(status: HomeStatus.loading));
      final links = await linkRepository.fetchLinks(limit: 10);
      emit(state.copyWith(
        status: HomeStatus.loaded,
        links: links,
      ));
    } catch (e) {
      emit(state.copyWith(status: HomeStatus.error));
      rethrow;
    }
  }

  @override
  Future<void> shortenUrl(String url) async {
    try {
      emit(state.copyWith(status: HomeStatus.loading));
      final link = await linkRepository.shortenUrl(url);
      emit(state.copyWith(
        status: HomeStatus.loaded,
        links: await addLink(link),
      ));
    } catch (e) {
      emit(state.copyWith(status: HomeStatus.error));
      rethrow;
    }
  }

  Future<List<LinkAlias>> addLink(LinkAlias linkAlias) async {
    final links = state.links.toList(growable: true);
    links.insert(0, linkAlias);
    return links;
  }
}

abstract class IHomeController {
  Future<void> fetchRecentlyLinks();

  Future<void> shortenUrl(String url);
}
