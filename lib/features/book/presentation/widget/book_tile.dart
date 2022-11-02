import 'package:flutter/material.dart';
import 'package:flutter_google_book/features/book/models/book_model.dart';
import 'package:flutter_google_book/features/book/presentation/bloc/book_bloc.dart';
import 'package:flutter_google_book/features/book/presentation/widget/book_image.dart';

class BookTile extends StatefulWidget {
  final BookBloc bloc;
  final BookModel bookModel;

  const BookTile({
    super.key,
    required this.bloc,
    required this.bookModel,
  });

  @override
  State<BookTile> createState() => _BookTileState();
}

class _BookTileState extends State<BookTile> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: _onTap,
        child: Container(
          height: 90,
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
          child: Row(
            children: [
              BookImage(
                imageLink: widget.bookModel.imageLink,
              ),
              const SizedBox(width: 12),
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
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      widget.bookModel.authorsNormalize,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: const TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 11,
                      ),
                    ),
                    Text(
                      widget.bookModel.descriptionMinimized,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: const TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 9,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _onTap() {
    widget.bloc.onGoToDetail(context, widget.bookModel);
  }
}