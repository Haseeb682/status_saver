import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:statusaver/Constants/constant.dart';

import '../Provider/getStatusProvider.dart';
import 'StatusWidgets.dart';

class NavBar extends StatefulWidget {
  bool isWhatsAppSelected;
  bool isBusinessWhatsAppSelected;

  NavBar({Key? key, bool? isWhatsAppSelected, bool? isBusinessWhatsAppSelected})
      : isWhatsAppSelected = isWhatsAppSelected ?? false,
        isBusinessWhatsAppSelected = isBusinessWhatsAppSelected ?? false,
        super(key: key);

  @override
  _NavBarState createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: Text('Oflutter.com'),
            accountEmail: Text('example@gmail.com'),
            currentAccountPicture: CircleAvatar(
              child: ClipOval(
                child: Image.network(
                  'https://oflutter.com/wp-content/uploads/2021/02/girl-profile.png',
                  fit: BoxFit.cover,
                  width: 90,
                  height: 90,
                ),
              ),
            ),
            decoration: BoxDecoration(
              color: Colors.blue,
              image: DecorationImage(
                  fit: BoxFit.fill,
                  image: NetworkImage(
                      'https://oflutter.com/wp-content/uploads/2021/02/profile-bg3.jpg')),
            ),
          ),
          SwitchListTile(
            title: Text('WhatsaApp'),
            value: AppConstants.whtsptreeuri!.isNotEmpty ? true:false,
            onChanged: (value) {
              setState(() {
                widget.isWhatsAppSelected = value;
                Provider.of<GetStatusProvider>(context, listen: false).getStatus();
                // You can perform any additional actions when the switch is toggled
                Navigator.pop(context);
              });
            },
            secondary: Icon(Icons.favorite),
          ),
          SwitchListTile(
            title: Text('Business Whatsapp'),
            value: AppConstants.bsneswhtspuri!.isNotEmpty ? true:false,

            onChanged: (value) {
              setState(() {
                widget.isBusinessWhatsAppSelected = value;
                Provider.of<GetStatusProvider>(context, listen: false).getbussinessstatus();
                Navigator.pop(context);
                // You can perform any additional actions when the switch is toggled
              });
            },
            secondary: Icon(Icons.person),
          ),
        ],
      ),
    );
  }
}

