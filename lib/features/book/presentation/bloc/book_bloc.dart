
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_google_book/core/bloc/bloc.dart';
import 'package:flutter_google_book/features/book/models/book_model.dart';
import 'package:flutter_google_book/features/book/presentation/screen/book_detail_screen.dart';
import 'package:flutter_google_book/features/book/repositories/book_repository.dart';

/// MVVM
/// Regra de Depedencia
/// Tela <-> Mediator (Provider, BLoC) <-> Repository <-> DataSource -> Client Http e/ou Client Storage

class BookBloc implements Bloc {
  final IBookRepository _repository;

  final List<BookModel> _books = [];
  bool _isProcessing = false;

  final StreamController<dynamic> _controllerNotify = StreamController<dynamic>.broadcast();
  void Function(dynamic) get _sinkNotify => _controllerNotify.sink.add;
  Stream<dynamic> get streamNotify => _controllerNotify.stream;

  BookBloc(this._repository);

  Future<void> fetchBooks(String keyWordVolume) async {
    try {
      _fetchBookInicialize();
      _books.addAll(await _repository.fetchBooks(keyWordVolume));
      _fetchBookFinalize();
    } catch (_) {
      _updateProcessing();
    }
  }

  void _fetchBookInicialize() {
    _books.clear();
    _updateProcessing();
    _sinkNotify(0);
  }

  void _fetchBookFinalize() {
    _updateProcessing();
    _sinkNotify(0);
  }

  void _updateProcessing() {
    _isProcessing = !_isProcessing;
  }

  void onGoToDetail(BuildContext context, BookModel bookModel) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => BookDetailScreen(bloc: this, bookModel: bookModel),
      ),
    );
  }

  List<BookModel> get books => _books.toList(growable: true);
  bool get isProccessing => _isProcessing;

  @override
  void dispose() async {
    await _controllerNotify.close();
  }
}