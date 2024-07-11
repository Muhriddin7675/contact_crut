import 'package:flutter/material.dart';

class ItemContact extends StatelessWidget {
  final String name;
  final String phoneNumber;
  final VoidCallback onClickItem;
  final VoidCallback onClickMore;

  const ItemContact({
    super.key,
    required this.name,
    required this.phoneNumber,
    required this.onClickItem,
    required this.onClickMore,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onLongPress: onClickItem,
      child: SizedBox(
        height: 72,
        child: Column(
          children: [
            Spacer(),
            Row(
              children: [
                const SizedBox(
                  height: 50,
                  width: 50,
                  child: CircleAvatar(
                    backgroundImage: AssetImage("assets/person_2.jpg"),
                  ),
                ),
                SizedBox(width: 16,),
                Column(
                  children: [
                    Text(
                      name,
                      style: const TextStyle(fontSize: 16, color: Colors.black),
                    ),
                    Text(
                      phoneNumber,
                      style: const TextStyle(fontSize: 12, color: Colors.black45),
                    )
                  ],
                ),
                const Spacer(),
                InkWell(
                    onTap: onClickMore,
                    child: const Icon(
                      Icons.more_horiz,
                      color: Colors.black45,
                      size: 36,
                    ))
              ],
            ),
            SizedBox(height: 4,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Container(
                height: 1,
                width: double.infinity,
                color: Colors.black45,
              ),
            )
          ],
        ),
      ),
    );
  }
}

