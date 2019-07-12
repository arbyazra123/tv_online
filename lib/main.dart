import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'dart:async';
import 'dart:convert';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:url_launcher/url_launcher.dart' as URL;
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      
      builder: (BuildContext context,Widget child) {
        var mQuery = MediaQuery.of(context).orientation;
        double pBottom = 0.0;
        if(mQuery==Orientation.landscape){
          pBottom = 0.0;
        }

        return new Padding(
          child:child,
          padding:  EdgeInsets.only(bottom: pBottom));
      },
      debugShowCheckedModeBanner: false,
      title: 'TV Online Free',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'TV Online Free'),
      routes: <String, WidgetBuilder> {
        "/Main" : (BuildContext context) => new MyHomePage(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}


class _MyHomePageState extends State<MyHomePage> {

  

static final MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
  keywords: <String>['Television', 'TV','Netflix','Iflix','film','cinema'],
  contentUrl: 'https://flutter.io',
  birthday: DateTime.now(),
  childDirected: true,
  designedForFamilies: true,
  gender: MobileAdGender.male, // or MobileAdGender.female, MobileAdGender.unknown
  testDevices: <String>[], // Android emulators are considered test devices
);

BannerAd myBanner = BannerAd(
  // Replace the testAdUnitId with an ad unit id from the AdMob dash.
  // https://developers.google.com/admob/android/test-ads
  // https://developers.google.com/admob/ios/test-ads
  adUnitId: BannerAd.testAdUnitId,
  size: AdSize.banner,
  targetingInfo: targetingInfo,
  listener: (MobileAdEvent event) {
    print("BannerAd event is $event");
  },
);

InterstitialAd myInterstitial = InterstitialAd(

  adUnitId: "<---- GANTI DENGAN INTERSTITIAL ID AGAN ----->",
  targetingInfo: targetingInfo,
  listener: (MobileAdEvent event) {
    print("InterstitialAd event is $event");
  },
);

  Future<void> _initVideo;
  List dataJson;
  List dataJson2;
  bool _load = true;
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
    new GlobalKey<RefreshIndicatorState>();
    final TextEditingController _filter = new TextEditingController();



  Future<String> makeList() async {
    //DISINI DIGANTI SESUAI LINK HOSTING AGAN
    final String url = "http://smeandigitallibrary.000webhostapp.com/tv/read.php";
    final String url2 = "http://smeandigitallibrary.000webhostapp.com/tv/read_other.php";
    http.Response R = await http.get(
      Uri.encodeFull(url),
      headers: {"Accept" : "application/json"}
    );
    http.Response R2 = await http.get(
      Uri.encodeFull(url2),
      headers: {"Accept" : "application/json"}
    );

    dataJson = jsonDecode(R.body);
    dataJson2 = jsonDecode(R2.body);
    setState(() {
          _load = false;
        });
  }
  @override
  void initState() {

    super.initState();



    //ID ADMOB GOOGLE
    //ID ADMOB GOOGLE
    FirebaseAdMob.instance.initialize(appId:"<---- GANTI DENGAN ADMOB ID AGAN ----->" );
    
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
  ]);
    this.makeList();
   
    
  }
  @override
  void dispose(){
    myBanner?.dispose();
    myInterstitial?.dispose();
      
 
    super.dispose();
  }


Widget appBar = new Text("TV ONLINE FREE");
Icon leadBar = Icon(Icons.search);

  @override
  Widget build(BuildContext context) {
    
    myBanner..load()..show();
    final bool isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;
    return Scaffold(
      primary: !isLandscape,
      appBar: AppBar(
        title: appBar,
      ),
      drawer: Drawer(
        child: Column(
          children: <Widget>[
            
            new DrawerHeader(
              padding: EdgeInsets.all(0.0),
              child: SizedBox(
                height: 120.0,
                child: DecoratedBox(
                  child: new Center(child: Text("TV ONLINE FREE",style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold,color: Colors.white),),),
                  decoration: BoxDecoration(gradient: new LinearGradient(
                    colors: [
                      Colors.blue,
                      Colors.blue[300]
                    ]
                  )),
                ),
              ),
            ),
            new ListTile(
              title: Text("Home",style: TextStyle(fontWeight: FontWeight.bold),),
              trailing: Icon(Icons.home),
              onTap: (){
                Navigator.pushNamed(context,"/Main");
              },
            ),
            new Divider(),
            new ListTile(
              title :Text("Donate me",style: TextStyle(fontWeight: FontWeight.normal)),
              trailing: Icon(Icons.monetization_on),
              onTap : (){
                URL.launch("https://www.paypal.me/arbyazra");
                // Navigator.push(context,MaterialPageRoute(
                //   builder: (BuildContext) => new Webview(title: "Donation",link: "https://www.paypal.me/arbyazra",)
                // ));
              }
            ),
            new Divider(),
            new ListTile(
              title: Text("About",style: TextStyle(fontWeight: FontWeight.normal)),
              trailing: Icon(Icons.more),
              onTap: (){
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text("About"),
                          content: new Table(
                          
                          columnWidths: {1: FractionColumnWidth(.60)},
                          
                        children: [
                          
                          TableRow(children: [
                           
                             new Text("Name",style: TextStyle(fontSize: 15.0,color: Colors.grey[500])),
                             new Text(" TV ONLINE FREE",style: TextStyle(fontSize: 15.0,color: Colors.grey[800]))
                          ]),
                          TableRow(children: [
                             new Text("Version",style: TextStyle(fontSize: 15.0,color: Colors.grey[500])),
                             new Text(" 1.0.0",style: TextStyle(fontSize: 15.0,color: Colors.grey[800]))
                          ]),
                          TableRow(children: [
                             new Text("Developer",style: TextStyle(fontSize: 15.0,color: Colors.grey[500]),),
                             new Text(" Zralegies",style: TextStyle(fontSize: 15.0,color: Colors.grey[800])),
                             
                          ]),
                        ],
                      ),
                      actions: <Widget>[
                        new FlatButton(
                          child: Text("Close"),
                          onPressed: (){
                            Navigator.of(context).pop();
                          },
                        )
                      ],
                        );
                      }

                    );
                  },
            )
          ],
        ),
      ),
      body: _load==true? new Center(child: CircularProgressIndicator()):RefreshIndicator(
        key: _refreshIndicatorKey,
        onRefresh: makeList,
        child: new Column(
        children: <Widget>[
         
          DecoratedBox(
            decoration: BoxDecoration(color: Colors.grey[200]),
                      child: SizedBox(
                        height: 37.0,
                                              child: new ListTile(
                          contentPadding:EdgeInsets.only(top:0.0,bottom: 0.0),
              title: Center(child: Text("Indonesian Channels",style: TextStyle(color: Colors.grey),)),
            ),
                      ),
          ),
          new Expanded(
             flex: 2,
                      child: DecoratedBox(
                        decoration: BoxDecoration(color: Colors.grey[200]),
                                              child: GridView.builder(
          itemCount: dataJson.length,
          gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: (MediaQuery.of(context).orientation == Orientation.portrait) ? 3 : 6),
          itemBuilder: (BuildContext context, int index) {
            return new Container(
              padding: EdgeInsets.only(top: 5.0,left: 5.0),
                            child: new Card(
                elevation: 10.0,
                child: new GestureDetector(
                  onTap: (){
                    
                    myInterstitial..load()..show();
                    Navigator.push(context, MaterialPageRoute(
                        builder: (BuildContext) => new Webview(title: dataJson[index]['name'],link: dataJson[index]['link'],)
                    ));
                    
                  },
                                  child: new GridTile(
                    footer: Center(child: new Container(
                      margin: EdgeInsets.only(bottom: 5.0,top:5.0),
                      child: new Text(dataJson[index]['name'].toUpperCase(),style: TextStyle(fontSize: 15.0,),))),
                        child: new Container(
                          margin: EdgeInsets.all(10.0),
                          child: new FadeInImage.assetNetwork(
                            fadeInDuration: Duration(seconds: 1),
                            fadeOutDuration: Duration(seconds: 1),
                            placeholder: "assets/loading_3.gif",
                            image: dataJson[index]['pict'],
                            fit: BoxFit.scaleDown,
                           ))
                  ),
                ),
              ),
            );
          },
    ),
                      )
          ),
          DecoratedBox(
            decoration: BoxDecoration(color: Colors.grey[200]),
                      child: new SizedBox(
                        height: 37.0,
                                              child: new ListTile(
                                                
              title: Center(child: Text("Other Channels",style: TextStyle(color: Colors.grey),)),
            ),
                      ),

          ),
        new Expanded(
             
                      child: DecoratedBox(
                        decoration: BoxDecoration(color: Colors.grey[200]),
                                              child: GridView.builder(
          itemCount: dataJson2!=null ? dataJson2.length : 0,
          gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: (MediaQuery.of(context).orientation == Orientation.portrait) ? 3 : 7),
          itemBuilder: (BuildContext context, int index) {
            return new Container(
              padding: EdgeInsets.only(top: 5.0,left: 5.0),
                            child: new Card(
                elevation: 10.0,
                child: new GestureDetector(
                  onTap: (){
                   
                    Navigator.push(context, MaterialPageRoute(
                        builder: (BuildContext) => new Webview(title: dataJson2[index]['name'],link: dataJson2[index]['link'],)
                    ));
                  },
                                  child: new GridTile(
                    footer: Center(child: new Container(
                      margin: EdgeInsets.only(bottom: 5.0,top: 5.0),
                      child: new Text(dataJson2[index]['name'].toUpperCase(),style: TextStyle(fontSize: 15.0,),))),
                        child: new Container(
                          margin: EdgeInsets.all(10.0),
                          child: new FadeInImage.assetNetwork(
                            image :dataJson2[index]['pict'],
                            placeholder: "assets/loading_3.gif",
                            fit: BoxFit.scaleDown
                          ) )//just for testing, will fill with image later
                  ),
                ),
              ),
            );
          },
    ),
                      )
          ),
          
        ],
              
      ),
      )
      

    );
  }

 
}


class Webview extends StatefulWidget {
  Webview({Key key, this.title,this.link}) : super(key: key);
  final String title;
  final String link;

  @override
  _WebviewState createState() => _WebviewState();
}

class _WebviewState extends State<Webview> {
  double pBottom = 0.0;
  @override
  void initState() {
    // TODO: implement initState

    super.initState();

    
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
  ]);
  
   
    
  }
   @override
  void dispose(){
    SystemChrome.setPreferredOrientations([
  
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
  ]);
 
    super.dispose();
  }

  
  Completer<WebViewController> _controller = Completer<WebViewController>();

  @override
  Widget build(BuildContext context) {
        var mquery = MediaQuery.of(context).orientation;
    if(mquery==Orientation.landscape) {
    
    pBottom = 0.0;

    } 
  
    return new Scaffold(
       
          
        appBar: AppBar(
          title : Text(widget.title)
        ),
        body: DecoratedBox(
            decoration: BoxDecoration(color: Colors.black),
            
                  child: Padding(
                    padding: EdgeInsets.only(bottom:pBottom),
                    child: WebView(
              initialUrl: widget.link,
              onWebViewCreated: (WebViewController webVcontroller){
                _controller.complete(webVcontroller);
              },
            ),
                  ),
        ),
        
      );
    
  }
}

