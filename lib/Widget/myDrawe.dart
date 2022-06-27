import 'package:flutter/material.dart';

class MyDrawer extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MyDrawerState();
}

class _MyDrawerState extends State {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          DrawerHeader(
            child: Align(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset('assets/Logobeyaz.png', width: 100,color: Colors.white,),
                  Text(
                    "Mobil Muhasebe",
                    style: TextStyle(color: Colors.white, fontSize: 25.0),
                  ),
                ],
              ),
            ),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [
                    Colors.blueAccent,
                    Colors.blueGrey,
                  ]),
            ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text("Anasayfa"),
            trailing: Icon(Icons.arrow_right),
            onTap: () {
              Navigator.pushNamed(context, "/mainpage");
            },
          ),
          ExpansionTile(
            leading: Icon(Icons.account_balance_wallet_outlined),
            title: Text('Gelir'),
            trailing: Icon(Icons.arrow_drop_down),
            children: <Widget>[
              /*  ListTile(
                title: Text('Düzenli Gelir'),
                trailing: Icon(Icons.arrow_right),
                onTap: () {
                  Navigator.pushNamed(context, "/duzenli_gelir");
                },
              ),*/

              ListTile(
                title: Text('Düzensiz Gelir'),
                trailing: Icon(Icons.arrow_right),
                onTap: () {
                  Navigator.pushNamed(context, "/duzensiz_gelir");
                },
              ),
            ],
          ),
          ExpansionTile(
            leading: Icon(Icons.account_balance_wallet_rounded),
            title: Text('Gider'),
            trailing: Icon(Icons.arrow_drop_down),
            children: <Widget>[
              ListTile(
                title: Text('Düzenli Gider'),
                trailing: Icon(Icons.arrow_right),
                onTap: () {
                  Navigator.pushNamed(context, "/duzenli_gider");
                },
              ),
              ListTile(
                title: Text('Düzensiz Gider'),
                trailing: Icon(Icons.arrow_right),
                onTap: () {
                  Navigator.pushNamed(context, "/duzensiz_gider");
                },
              ),
            ],
          ),
          ListTile(
            leading: Icon(Icons.content_copy_sharp),
            title: Text('Rapor'),
            trailing: Icon(Icons.arrow_right),
            onTap: () {
              Navigator.pushNamed(context, "/rapor");
            },
          ),
          ExpansionTile(
            leading: Icon(Icons.perm_device_information),
            title: Text('Kurumsal'),
            trailing: Icon(Icons.arrow_drop_down),
            children: <Widget>[
              ListTile(
                title: Text('Hakkımızda'),
                trailing: Icon(Icons.arrow_right),
                onTap: () {
                  Navigator.pushNamed(context, "/hakkimizda");
                },
              ),
              ListTile(
                title: Text('Vizyonumuz/Misyonumuz'),
                trailing: Icon(Icons.arrow_right),
                onTap: () {
                  Navigator.pushNamed(context, "/vizyonumuzmisyonumuz");
                },
              ),
            ],
          ),
          ListTile(
            leading: Icon(Icons.contact_phone_outlined),
            title: Text('iletişim'),
            trailing: Icon(Icons.arrow_right),
            onTap: () {
              Navigator.pushNamed(context, "/iletisim");
            },
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text('Çıkış Yap'),
            trailing: Icon(Icons.arrow_right),
            onTap: () {
              Navigator.pushNamed(context, "/login_page");
            },
          )
        ],
      ),
    );
  }
}
