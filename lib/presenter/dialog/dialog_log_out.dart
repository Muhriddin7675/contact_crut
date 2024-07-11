import 'package:flutter/material.dart';

Widget dialogLogOut(BuildContext context, VoidCallback logOutClick,
    VoidCallback unRegisterClick) {
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
            const Icon(Icons.logout_outlined,
                color: Color(0xffe95757), size: 36),
            const SizedBox(
              width: 24,
            ),
            const Padding(
              padding: EdgeInsets.only(top: 4.0),
              child: Text(
                'Sign Out',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.black45,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            const Spacer(),
            InkWell(
              onTap: () {
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
        const Text(
          'Do you want unregister or logout?',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 16.0),
        ),
        const SizedBox(height: 24.0),
        Row(
          children: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Container(
                  decoration: BoxDecoration(
                      border:
                          Border.all(width: 2, color: const Color(0xffe95757)),
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                    child: InkWell(
                      onTap: unRegisterClick,
                      child: const Text(
                        'UnRegister',
                        style:
                            TextStyle(color: Color(0xffe95757), fontSize: 16),
                      ),
                    ),
                  )),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Container(
                  decoration: BoxDecoration(
                      color: const Color(0xffe95757),
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 30, vertical: 8),
                    child: InkWell(
                      onTap: logOutClick,
                      child: const Text(
                        'Logout',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                  )),
            ),
          ],
        ),
      ],
    ),
  );
}
