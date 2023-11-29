import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../Widgets/DownloadWidgets.dart';
import '../../Widgets/StatusWidgets.dart';
import '../../Widgets/ToggleButton.dart';
import '../../Widgets/tabbar.dart';


class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with TickerProviderStateMixin {



  bool _isshow=true;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  TabController? _tabcontroller;
  String whtsptreeuri = "content://com.android.externalstorage.documents/document/primary%3AAndroid%2Fmedia%2Fcom.whatsapp%2FWhatsApp%2FMedia%2F.Statuses";
  String bsneswhtspuri = "content://com.android.externalstorage.documents/document/primary%3AAndroid%2Fmedia%2Fcom.whatsapp.w4b%2FWhatsApp Business%2FMedia%2F.Statuses";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _tabcontroller = TabController(length: 2, vsync: this);
  }
  @override
  Widget build(BuildContext context) {
    double screenheight= MediaQuery.of(context).size.height;
    double screenwidth= MediaQuery.of(context).size.width;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        drawer: NavBar(),
        appBar: AppBar(
          title: Text("SideBar"),
        ),

        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(

                height: screenheight * 0.2,
                decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.only(
                        bottomRight:Radius.circular(10),
                        bottomLeft: Radius.circular(10))
                ),

                child: Padding(
                  padding: EdgeInsets.only(bottom: 15.0),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: TabBar(
                      indicatorPadding: EdgeInsets.symmetric(horizontal: 60,vertical: 10),
                      indicatorSize: TabBarIndicatorSize.tab,
                      dividerColor: Colors.transparent,
                      controller: _tabcontroller,
                      labelColor: Colors.white,
                      //
                      // //    isScrollable: true,
                      unselectedLabelColor: Colors.white,

                      labelStyle: TextStyle(
                        color: Colors.white, // White color for the selected tab
                        fontWeight: FontWeight.bold, // Bold text for the selected tab
                      ),

                      // Set the text style for the unselected tab
                      unselectedLabelStyle: TextStyle(
                        color: Colors.grey, // Normal color for unselected tabs
                      ),


                      tabs: [
                        Tab(text: "Status"),
                        Tab(text: "Downloads"),
                      ],

                    ),
                  ),
                ),
              ),

              SizedBox(height: 15,),
              ToggleButtons1(isloadvedio),
              Visibility(
                child: Container(
                  width: screenwidth,
                  height: screenheight * 0.8,
                  child: TabBarView(

                    controller: _tabcontroller,
                    children: [
                      Statuswidgets(isshow:_isshow),
                      Downloadwidgets(isshows:_isshow),
                    ],
                  ),
                ),
              ),



            ],

          ),
        ),
      ),
    );




  }
  isloadvedio(bool val){
    setState(() {
      _isshow=val;
    });
  }

// void _openSettingsDrawer(BuildContext context) {
//   // Open the drawer for settings
//   _scaffoldKey.currentState?.openEndDrawer();
// }

}