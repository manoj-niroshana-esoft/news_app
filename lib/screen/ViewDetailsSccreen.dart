import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../model/NewsModel.dart';
import 'package:share/share.dart';

class ViewDetailsScreen extends StatefulWidget {
  final Datum? news;
  const ViewDetailsScreen({super.key, this.news});
  @override
  State<ViewDetailsScreen> createState() => _ViewDetailsScreenState();
}

class _ViewDetailsScreenState extends State<ViewDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orangeAccent,
        title: const Text('News Just In'), // Set the title of the app bar
        automaticallyImplyLeading: false,
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.arrow_back_ios)),
      ),
      body: SizedBox(
          child: Scrollbar(
        thumbVisibility: true,
        child: ListView.builder(
            itemCount: 1,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: [
                    Text(widget.news?.title ?? "",
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: Checkbox.width)),
                    const Padding(
                      padding: EdgeInsets.all(16.0),
                    ),
                    Image.network(widget.news?.urlToImage ??
                        "https://advisorretire.com/wp-content/plugins/pl-platform/engine/ui/images/default-landscape.png"),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            // Share button
                            Share.share('Link : ${widget.news?.url ?? ""} ',
                                subject: 'Link :');
                          },
                          child: const Icon(Icons.share_outlined),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            // Copy to clipboard button
                            Clipboard.setData(
                              ClipboardData(text: widget.news!.url!),
                            );
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Text copied to clipboard'),
                              ),
                            );
                          },
                          child: const Icon(Icons.copy),
                        ),
                      ],
                    ),
                    const Padding(
                      padding: EdgeInsets.all(12.0),
                    ),
                    Text("Author: ${widget.news?.author ?? ""}"),
                    Text("Published At : ${widget.news?.publishedAt ?? ""}"),
                    const Padding(
                      padding: EdgeInsets.all(12.0),
                    ),
                    Text("Description: ${widget.news?.description ?? ""}"),
                    const Padding(
                      padding: EdgeInsets.all(12.0),
                    ),
                    Text("Content: ${widget.news?.content ?? ""}"),
                  ],
                ),
              );
            }),
      )),
    );
  }
}
