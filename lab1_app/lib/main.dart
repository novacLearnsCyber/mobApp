import 'package:flutter/material.dart';
import 'models/user.dart';
import 'models/bank_account.dart';
import 'models/book.dart';
import 'models/magazine.dart';
import 'models/library.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lab 2 App',
      theme: ThemeData(colorSchemeSeed: Colors.indigo, useMaterial3: true),
      home: const HomePage(title: 'Lab 2: Dart & null safety'),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    
    final users = [
      User(name: 'Ana', age: 21, email: 'ana@example.com'),
      User(name: 'Bogdan', age: 30),
      User(name: 'Corina'), 
    ];

    final accounts = [
      BankAccount(
          holderName: 'Ana', balance: 1500.5, bankBranch: 'Bucuresti Centru')
        ..initializeAccount('RO00TEST0001'),
      BankAccount(holderName: 'Bogdan')..initializeAccount('RO00TEST0002'),
      BankAccount(holderName: 'Corina'), // uninitialized
    ];

    final now = DateTime.now();
    final library = Library();
    final book1 = Book(
      title: 'Dart in Action',
      author: 'Chris Buckett',
      publishDate: now.subtract(const Duration(days: 100)),
      pageCount: 400,
      isbn: '123-456',
    );
    final book2 = Book(title: 'Mystery Book');
    final mag = Magazine(
      title: 'Tech Monthly',
      publishDate: now.subtract(const Duration(days: 20)),
      issueNumber: 42,
    );
    library.addItem(book1);
    library.addItem(book2);
    library.addItem(mag);
    final addDuplicate = library.addItem(book1);
    final borrow1 = library.borrowItem(book1, users[0]);
    final borrow2 = library.borrowItem(book1, users[1]); 
    final byTitle = library.searchByTitle('dart');
    final nullQuery = library.searchByTitle(null);
    final byAuthor = library.getItemsByAuthor('buckett');
    final recent = library.getRecentItems(days: 60);

    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: ListView(
        children: [
          const _Header('Users'),
          for (final u in users)
            ListTile(
              title: Text(u.name),
              subtitle: Text(
                  'Age: ${u.getDisplayAge()} | Email: ${u.email ?? 'Not provided'}'),
            ),
          const _Header('Bank accounts'),
          for (final a in accounts)
            ListTile(
              title: Text(a.holderName),
              subtitle: Text(
                  '${a.displayNumber} | Branch: ${a.bankBranch ?? 'N/A'} | Balance: ${a.balance}'),
            ),
          const _Header('Library items'),
          for (final i in library.items)
            ListTile(
              title: Text(i.title),
              subtitle: Text(
                  '${i.describe()}\nBorrower: ${i.borrower?.name ?? 'Available'}'
                  '${i.dueDate != null ? ' | Due: ${i.dueDate.toString().split(' ').first}' : ''}'),
              isThreeLine: true,
            ),
          const _Header('Library API results'),
          ListTile(title: Text('addItem duplicate -> $addDuplicate')),
          ListTile(title: Text('borrow (free item) -> $borrow1')),
          ListTile(title: Text('borrow (already borrowed) -> $borrow2')),
          ListTile(title: Text('searchByTitle("dart") -> ${byTitle.length}')),
          ListTile(title: Text('searchByTitle(null) -> ${nullQuery.length}')),
          ListTile(title: Text('getItemsByAuthor("buckett") -> ${byAuthor.length}')),
          ListTile(title: Text('getRecentItems(60 days) -> ${recent.length}')),
        ],
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header(this.text);
  final String text;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.fromLTRB(16, 20, 16, 4),
        child: Text(text,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold)),
      );
}