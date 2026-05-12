import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

const _newsUrl =
    'https://kubsau.ru/api/getNews.php?key=6df2f5d38d4e16b5a923a6d4873e2ee295d0ac90';

void main() {
  HttpOverrides.global = KubSauHttpOverrides();
  runApp(const MyApp());
}

class KubSauHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

Future<List<NewsItem>> fetchNews(http.Client client) async {
  final response = await client.get(Uri.parse(_newsUrl));
  if (response.statusCode != 200) {
    throw Exception('Failed to load news');
  }
  return compute(parseNews, response.body);
}

List<NewsItem> parseNews(String responseBody) {
  final parsed = jsonDecode(responseBody) as List<dynamic>;
  return parsed
      .map((json) => NewsItem.fromJson(json as Map<String, dynamic>))
      .toList();
}

String normalizeText(String value) {
  final stripped = Bidi.stripHtmlIfNeeded(value);
  return stripped.replaceAll(RegExp(r'\s+'), ' ').trim();
}

class NewsItem {
  final String id;
  final String title;
  final String previewText;
  final String imageUrl;
  final String dateTime;

  const NewsItem({
    required this.id,
    required this.title,
    required this.previewText,
    required this.imageUrl,
    required this.dateTime,
  });

  factory NewsItem.fromJson(Map<String, dynamic> json) {
    final rawTitle = json['TITLE']?.toString() ?? '';
    final rawPreview = json['PREVIEW_TEXT']?.toString() ?? '';
    return NewsItem(
      id: json['ID']?.toString() ?? '',
      title: normalizeText(rawTitle),
      previewText: normalizeText(rawPreview),
      imageUrl: json['PREVIEW_PICTURE_SRC']?.toString() ?? '',
      dateTime: json['ACTIVE_FROM']?.toString() ?? '',
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    const appTitle = 'Лента новостей КубГАУ';

    return MaterialApp(
      title: appTitle,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        scaffoldBackgroundColor: Colors.green.shade50,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.green.shade700,
          foregroundColor: Colors.white,
        ),
      ),
      home: const NewsHomePage(title: appTitle),
    );
  }
}

class NewsHomePage extends StatefulWidget {
  const NewsHomePage({super.key, required this.title});

  final String title;

  @override
  State<NewsHomePage> createState() => _NewsHomePageState();
}

class _NewsHomePageState extends State<NewsHomePage> {
  final http.Client _client = http.Client();
  late final Future<List<NewsItem>> _newsFuture;

  @override
  void initState() {
    super.initState();
    _newsFuture = fetchNews(_client);
  }

  @override
  void dispose() {
    _client.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: FutureBuilder<List<NewsItem>>(
        future: _newsFuture,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(child: Text('Ошибка запроса!'));
          }
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          return NewsList(items: snapshot.data!);
        },
      ),
    );
  }
}

class NewsList extends StatelessWidget {
  const NewsList({super.key, required this.items});

  final List<NewsItem> items;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: items.length,
      itemBuilder: (context, index) {
        return NewsCard(item: items[index]);
      },
    );
  }
}

class NewsCard extends StatelessWidget {
  const NewsCard({super.key, required this.item});

  final NewsItem item;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _NewsImage(imageUrl: item.imageUrl),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.dateTime,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: Colors.green.shade800,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  item.title,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  item.previewText,
                  style: theme.textTheme.bodyMedium,
                  maxLines: 4,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _NewsImage extends StatelessWidget {
  const _NewsImage({required this.imageUrl});

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    if (imageUrl.isEmpty) {
      return _ImagePlaceholder();
    }

    return ClipRRect(
      child: AspectRatio(
        aspectRatio: 16 / 9,
        child: Image.network(
          imageUrl,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return _ImagePlaceholder();
          },
        ),
      ),
    );
  }
}

class _ImagePlaceholder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      decoration: BoxDecoration(
        color: Colors.green.shade100,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
      ),
      child: const Center(
        child: Icon(Icons.image, size: 48, color: Colors.green),
      ),
    );
  }
}
