import 'library_item.dart';

class Magazine extends LibraryItem {
  final int? issueNumber;
  final String? publisher;

  Magazine({
    required super.title,
    super.author,
    super.publishDate,
    this.issueNumber,
    this.publisher,
  });

  @override
  String describe() =>
      'Magazine · issue ${issueNumber ?? '?'} · ${publisher ?? 'Unknown publisher'}';
}