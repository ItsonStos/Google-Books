import 'package:flutter/material.dart';
import 'package:flutter_google_book/features/book/models/book_model.dart';
import 'package:flutter_google_book/features/book/presentation/bloc/book_bloc.dart';
import 'package:flutter_google_book/features/book/presentation/widget/book_image.dart';

class BookDetailScreen extends StatelessWidget {
  final BookBloc bloc;
  final BookModel bookModel;
  
  const BookDetailScreen({
    super.key,
    required this.bloc,
    required this.bookModel,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          BookImage(
            imageLink: bookModel.imageLink,
            widthImage: MediaQuery.of(context).size.width,
            heigthImage: MediaQuery.of(context).size.height,
          ),
          _FavoriteWidget(bookModel),
          const _BackWidget(),
          Container(
            margin: const EdgeInsets.only(top: 150),
            height: MediaQuery.of(context).size.height,
            decoration: const BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(16),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.white,
                  blurRadius: 0.5,
                ),
              ],
            ),
            child: _BookFormWidget(bookModel),
          ),
        ],
      ),
    );
  }
}

class _FavoriteWidget extends StatefulWidget {
  final BookModel bookModel;
  const _FavoriteWidget(this.bookModel);

  @override
  State<_FavoriteWidget> createState() => _FavoriteWidgetState();
}

class _FavoriteWidgetState extends State<_FavoriteWidget> {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 30,
      right: 10,
      child: IconButton(
        onPressed: _onChangeFavorite,
        icon: Icon(
          widget.bookModel.isFavorite ? Icons.favorite : Icons.favorite_border,
          size: 32,
        ),
      ),
    );
  }

  void _onChangeFavorite() {
    widget.bookModel.isFavorite = !widget.bookModel.isFavorite;
    setState(() {});
  }
}

class _BackWidget extends StatelessWidget {
  const _BackWidget();

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 30,
      left: 10,
      child: IconButton(
        onPressed: Navigator.of(context).pop,
        icon: const Icon(
          Icons.arrow_back,
          size: 26,
        ),
      ),
    );
  }
}

class _BookFormWidget extends StatefulWidget {
  final BookModel bookModel;

  const _BookFormWidget(this.bookModel);

  @override
  State<_BookFormWidget> createState() => __BookFormWidgetState();
}

class __BookFormWidgetState extends State<_BookFormWidget> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(20),
      physics: const BouncingScrollPhysics(),
      children: [
        SizedBox(
          height: 100,
          width: 500,
          child: Row(
            children: [
              BookImage(
                imageLink: widget.bookModel.imageLink,
                heigthImage: 80,
                widthImage: 80,
              ),
              const SizedBox(width: 15),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      widget.bookModel.title,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      widget.bookModel.authorsNormalize,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: const TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      '${widget.bookModel.publisher}, ${widget.bookModel.publishedDate}',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: const TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Text(
            widget.bookModel.description,
            style: const TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 16,
            ),
          ),
        ),
      ],
    );
  }
}

