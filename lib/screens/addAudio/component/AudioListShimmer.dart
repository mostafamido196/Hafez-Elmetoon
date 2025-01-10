import 'package:flutter/material.dart';
import 'package:redacted/redacted.dart';

class AudioListShimmer extends StatelessWidget {
  const AudioListShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 5,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0),
            ),
            elevation: 4,
            child: ListTile(
              contentPadding: const EdgeInsets.all(16.0),
              leading: CircleAvatar(
                radius: 30,
                backgroundColor: Colors.teal.withOpacity(0.2),
                child: Icon(
                  Icons.music_note,
                  color: Colors.teal.withOpacity(0.5),
                  size: 30,
                ),
              ).redacted(
                context: context,
                redact: true,
                configuration: RedactedConfiguration(
                  animationDuration: Duration(milliseconds: 2 * 1000),
                ),
              ),
              title: Container(
                height: 20,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(4),
                ),
              ).redacted(
                context: context,
                redact: true,
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 8),
                  Container(
                    height: 14,
                    width: 120,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ).redacted(
                    context: context,
                    redact: true,
                  ),
                  const SizedBox(height: 4),
                  Container(
                    height: 12,
                    width: 200,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ).redacted(
                    context: context,
                    redact: true,
                  ),
                ],
              ),
              trailing: CircleAvatar(
                radius: 20,
                backgroundColor: Colors.grey[300],
                child: const Icon(
                  Icons.play_arrow,
                  color: Colors.white,
                ),
              ).redacted(
                context: context,
                redact: true,
              ),
            ),
          ),
        );
      },
    );
  }
}
