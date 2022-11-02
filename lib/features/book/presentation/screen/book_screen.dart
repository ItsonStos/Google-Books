import 'package:flutter/material.dart';
import 'package:flutter_google_book/core/library/environment_helper.dart';
import 'package:flutter_google_book/core/service/http_client_dio.dart';
import 'package:flutter_google_book/features/book/datasources/book_remote_datasource.dart';
import 'package:flutter_google_book/features/book/presentation/bloc/book_bloc.dart';
import 'package:flutter_google_book/features/book/presentation/widget/book_tile.dart';
import 'package:flutter_google_book/features/book/repositories/book_repository.dart';

class BookScreen extends StatefulWidget {
  const BookScreen({super.key});
  @override
  State<BookScreen> createState() => _BookScreenState();
}

class _BookScreenState extends State<BookScreen> {
  late final BookBloc _bookBloc;
  final TextEditingController _editingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _bookBloc = _createBookBloc();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Livros'),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16), 
        physics: const BouncingScrollPhysics(),
        children: [
          TextField(
            controller: _editingController,
            decoration: const InputDecoration(
              labelText: 'Título',
              hintText: 'Informe o título do livro',
              border: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.white,
                ),
              )
            ),
          ),
          ElevatedButton(
            onPressed: _onPressedSearch, 
            child: const Text('Pesquisar'),
          ),
          _ListViewBookWidget(_bookBloc),
        ],
      ),
    );
  }

  void _onPressedSearch() {
    if (_editingController.text.trim().isNotEmpty) {
      _bookBloc.fetchBooks(_editingController.text);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Informe o titulo do livro')),
      );
    }
  }

  BookBloc _createBookBloc() {
    final HttpClientDio httpClientDio = HttpClientDio(EnvironmentHelper());
    final BookRemoteDataSource dataSource = BookRemoteDataSource(httpClientDio);
    final BookRepository repository = BookRepository(dataSource);
    return BookBloc(repository);
  }

  @override
  void dispose() {
    _bookBloc.dispose();
    super.dispose();
  }
}

class _ListViewBookWidget extends StatelessWidget {
  final BookBloc _bookBloc;
  const _ListViewBookWidget(this._bookBloc);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<dynamic>(
      stream: _bookBloc.streamNotify,
      builder: (context, snapshot) {
        if (_bookBloc.isProccessing) {
          return const Padding(
            padding: EdgeInsets.symmetric(vertical: 30),
            child: Center(child: CircularProgressIndicator.adaptive()),
          );
        }
        return ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: _bookBloc.books.length,
          separatorBuilder: (context, index) => const Padding(padding: EdgeInsets.only(bottom: 12)), 
          itemBuilder: (context, index) {
            return BookTile(
              bloc: _bookBloc,
              bookModel: _bookBloc.books.elementAt(index),
            );
          }, 
        );
      }
    );
  }
}