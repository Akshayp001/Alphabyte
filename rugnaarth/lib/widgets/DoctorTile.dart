import "package:flutter/material.dart";

class DoctorTile extends StatelessWidget {
  const DoctorTile({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.comment,
    this.profileImgUrl,
  }) : super(key: key);

  final String title;
  final String subtitle;
  final String comment;
  final String? profileImgUrl;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white24, borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5, vertical: 15),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
                foregroundImage: NetworkImage(profileImgUrl != null
                    ? profileImgUrl!
                    : "https://firebasestorage.googleapis.com/v0/b/rugnaarth-cc2df.appspot.com/o/assetsForApp%2Fpngtree-doctor-icon-circle-png-image_2055257.jpg?alt=media&token=467037d7-7354-4413-ba00-4f50a94475cc"),
                child: Icon(Icons.account_circle)),
            SizedBox(width: 10),
            Expanded(
              flex: 7,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    subtitle,
                  ),
                  SizedBox(height: 8),
                  Text(comment,
                      style: TextStyle(color: Colors.black87, fontSize: 12))
                ],
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.more_vert_outlined),
                  onPressed: () {},
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
