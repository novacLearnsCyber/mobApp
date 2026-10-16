import 'library_item.dart';
import 'user.dart';

class Library {
  final List<LibraryItem> _items = [];

  List<LibraryItem> get items => List.unmodifiable(_items);

  bool addItem(LibraryItem item) {
    if (item.title.trim().isEmpty) return false;
    final exists = _items.any((i) =>
        i.title.toLowerCase() == item.title.toLowerCase() &&
        i.author == item.author);
    if (exists) return false;
    _items.add(item);
    return true;
  }

  List<LibraryItem> searchByTitle(String? query) {
    if (query == null || query.trim().isEmpty) return [];
    final q = query.toLowerCase();
    return _items.where((i) => i.title.toLowerCase().contains(q)).toList();
  }

  List<LibraryItem> getItemsByAuthor(String? author) {
    if (author == null || author.trim().isEmpty) return [];
    final a = author.toLowerCase();
    return _items
        .where((i) => i.author?.toLowerCase().contains(a) ?? false)
        .toList();
  }

  List<LibraryItem> getRecentItems({int days = 365}) {
    final cutoff = DateTime.now().subtract(Duration(days: days));
    return _items.where((i) {
      final d = i.publishDate;
      return d != null && d.isAfter(cutoff);
    }).toList();
  }

  bool borrowItem(LibraryItem? item, User? user, {int loanDays = 14}) {
    if (item == null || user == null) return false;
    if (item.isBorrowed) return false;
    item.borrower = user;
    item.dueDate = DateTime.now().add(Duration(days: loanDays));
    return true;
  }

  bool returnItem(LibraryItem? item) {
    if (item == null || !item.isBorrowed) return false;
    item.borrower = null;
    item.dueDate = null;
    return true;
  }
}