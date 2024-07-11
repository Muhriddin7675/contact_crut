import 'package:flutter/material.dart';

Widget dialogContent(BuildContext context, String name, VoidCallback onClickDelete) {
  return Container(
    padding: const EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Colors.white,
      shape: BoxShape.rectangle,
      borderRadius: BorderRadius.circular(20.0),
      boxShadow: const [
        BoxShadow(
          color: Colors.black26,
          blurRadius: 10.0,
          offset: Offset(0.0, 10.0),
        ),
      ],
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min, // To make the card compact
      children: <Widget>[
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(Icons.delete, color: Color(0xffe95757), size: 36),
            const SizedBox(
              width: 24,
            ),
            const Padding(
              padding: EdgeInsets.only(top: 4.0),
              child: Text(
                'Delete contact',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.black45,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            const Spacer(),
            InkWell(
              onTap: (){
                Navigator.of(context).pop();
              },
              child: const Icon(
                Icons.cancel,
                color: Color(0xffe95757),
                size: 20,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16.0),
        Text(
          'Do you want delete $name?',
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 16.0),
        ),
        const SizedBox(height: 24.0),
        Align(
          alignment: Alignment.bottomRight,
          child: TextButton(
            onPressed:onClickDelete,
            child: Container(
                decoration: BoxDecoration(
                    color: const Color(0xffe95757),
                    borderRadius: BorderRadius.circular(10)),
                child: const Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 32, vertical: 6),
                  child: Text(
                    'Delete',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                )),
          ),
        ),
      ],
    ),
  );
}
