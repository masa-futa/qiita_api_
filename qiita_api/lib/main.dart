import 'package:flutter/material.dart';
import 'package:qiita_api/model/entity/article.dart';
import 'package:qiita_api/service/qiita_client.dart';

import 'article_detail_page.dart';

void main() {
  runApp(ArticleListPage());
}

class ArticleListPage extends StatelessWidget {
  final Future<List<Article>> articles = QiitaClient.fetchArticle();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fetch Data Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Qiita API '),
        ),
        body: Center(
          child: FutureBuilder<List<Article>>(
            future: articles,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ArticleListView(articles: snapshot.data!);
              }
              return CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}

class ArticleListView extends StatelessWidget {
  final List<Article> articles;
  ArticleListView({required this.articles});
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: articles.length,
        itemBuilder: (context, index) {
        return ListTile(
          leading: CircleAvatar(
            /// TODO: 複数imageを取得するためクラッシュする
            // backgroundImage: NetworkImage(articles[index].user.iconUrl),
          ),
          title: Text(articles[index].title),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(builder: (context) {
                  return ArticleDetailPage(article: articles[index]);
                }));
          },
        );
      });
  }
}