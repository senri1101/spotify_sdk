import 'dart:convert';

import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';

class RecentlyPlayedPage extends StatelessWidget {
  final String jsonData;

  const RecentlyPlayedPage(this.jsonData, {super.key});

  @override
  Widget build(BuildContext context) {
    final data = jsonDecode(jsonData);
    final items = data['items'] as List<dynamic>;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Recently Played'),
      ),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];
          final track = item['track'];
          final playedAt = item['played_at'];

          final albumName = track['album']['name'];
          final artistName = track['artists'][0]['name'];
          final trackName = track['name'];
          final imageUrl = track['album']['images'][0]['url'];

          final dateFormat = DateFormat('yyyy-MM-dd HH:mm');
          final utcDate = DateTime.parse(playedAt);
          final localDate = utcDate.toLocal();
          final playedAtDate = dateFormat.format(localDate);

          return ListTile(
            leading: Image.network(imageUrl, width: 50, height: 50),
            title: Text(trackName),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(artistName),
                Text(albumName),
                Text(playedAtDate),
              ],
            ),
          );
        },
      ),
    );
  }
}
