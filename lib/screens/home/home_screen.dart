import 'dart:convert';

import 'package:device_apps/device_apps.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:literahub/apis/response/user_response.dart';
import 'package:literahub/globals.dart';
import 'package:literahub/iface/onClick.dart';
import 'package:literahub/model/FredomModel.dart';
import 'package:literahub/model/menuitem.dart';
import 'package:literahub/screens/home/home_screen.dart';
import 'package:literahub/screens/login/login_screen.dart';
import 'package:literahub/widgets/myweb.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../apis/ServiceHandler.dart';
import '../../apis/request/fradomdeeplink.dart';
import '../../apis/response/fradom_response.dart';
import '../../core/constant/LocalConstant.dart';
import '../../core/theme/light_colors.dart';
import '../../core/utility.dart';
import '../../iface/onResponse.dart';
import '../../model/user.dart';
import '../../widgets/dropdown.dart';

class HomePage extends StatefulWidget {
  final UserResponse userInfo;

  HomePage({
    super.key,
    required this.userInfo,
  });

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<HomePage>
    with TickerProviderStateMixin, WidgetsBindingObserver
    implements onClickListener, onResponse {
  final int MYSCHOOLiNDEX = 0;
  final int TEACHER_OPERATION_iNDEX = 1;
  final int SCHOOL_OPERATION_iNDEX = 2;
  final int EXTENDED_CLASSROOM_iNDEX = 3;
  final int STUDENT_ANALYTICS_iNDEX = 4;
  final int PENTEMIND_iNDEX = 8;
  final int MLZS_READING_iNDEX = 5;
  final int ZLL_SAATHI_iNDEX = 6;
  final int ZLL_TRANSACTION_iNDEX = 7;

  final String MYSCHOOL = "My School​";
  final String TEACHER_OPERATION = "Teaching Operations";
  final String SCHOOL_OPERATION = "School ​Management​";
  final String EXTENDED_CLASSROOM = "Extended Classroom​";
  final String STUDENT_ANALYTICS = "Student Analytics​";
  final String PENTEMIND = "Pentemind";
  final String MLZS_READING = "MLZS ​Reading";
  final String ZLL_SAATHI = "ZLL​ SAATHI​";
  final String ZLL_TRANSACTION = "ZLL​ Transaction​​";

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  List<HomeMenuItem> menuItems = [];
  UserResponse? userinfo;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    generateMenu();
    getUserInfo();
  }
  getUserInfo() async{
    var box = await Utility.openBox();
    String json = box.get(LocalConstant.KEY_LOGIN_RESPONSE);
    userinfo  = UserResponse.fromJson(jsonDecode(json));
    print(userinfo!.toJson());
  }

  generateMenu() {
    if (widget.userInfo.root!.subroot!.userRole == 'S-1-12') {
      getStudent1to12Menu();
    } else if (widget.userInfo.root!.subroot!.userRole == 'S-Pre-primary') {
      getStudentPrePrimaryMenu();
    } else if (widget.userInfo.root!.subroot!.userRole == 'TEACH-1-12') {
      getTeacher1to12Menu();
    } else if (widget.userInfo.root!.subroot!.userRole == 'TEACH-Pre-primary') {
      getTeacherPrePrimaryMenu();
    }else if (Utility.getUserRole(widget.userInfo.root!.subroot!.userRole!).isNotEmpty) {
      getSystemAdminMenu();
    }else{
      getSystemAdminMenu();
    }
  }

  Future<void> applaunchUrl(url) async {
    print('url status ${url}');
    bool isFound = await launchUrl(url);
    print('is Found $isFound');
    if (!isFound) {
      //https://apps.apple.com/in/app/kidzeeapp/id1338356944
      await launchUrl(Uri.parse(url));
      print('app store');
    } else {
      print('App Found');
    }
  }

  @override
  Widget build(BuildContext context) {
    EasyLoading.init();
    ScreenUtil.init(context);
    return WillPopScope(
      onWillPop: () async {
        onBackClickListener();
        return false;
      },
      child: Scaffold(
        key: _scaffoldKey,
        appBar: /*_selectedDestination == MENU_LEARNING_GOAL ? null :*/
            getAppbar(),
        bottomNavigationBar: footer(),
        body: getScreen(),
      ),
    );
  }

  getStudent1to12Menu() {
    menuItems.clear();
    menuItems.add(HomeMenuItem(MYSCHOOLiNDEX, MYSCHOOL, MYSCHOOL, 'myclass'));
    menuItems.add(HomeMenuItem(EXTENDED_CLASSROOM_iNDEX, EXTENDED_CLASSROOM,
        EXTENDED_CLASSROOM, 'exclassroom'));
    menuItems.add(HomeMenuItem(
        MLZS_READING_iNDEX, MLZS_READING, MLZS_READING, 'mlzsreading'));
    //menuItems.add(HomeMenuItem(MLZS_READING_iNDEX, MLZS_READING, MLZS_READING, 'mlzsreading'));
  }

  getTeacher1to12Menu() {
    menuItems.clear();
    menuItems.add(HomeMenuItem(TEACHER_OPERATION_iNDEX, TEACHER_OPERATION,
        TEACHER_OPERATION, 'teachingoperation'));
    menuItems.add(HomeMenuItem(EXTENDED_CLASSROOM_iNDEX, EXTENDED_CLASSROOM,
        EXTENDED_CLASSROOM, 'exclassroom'));
    menuItems.add(HomeMenuItem(STUDENT_ANALYTICS_iNDEX, STUDENT_ANALYTICS,
        STUDENT_ANALYTICS, 'studentanalytis'));
    menuItems.add(HomeMenuItem(
        MLZS_READING_iNDEX, MLZS_READING, MLZS_READING, 'mlzsreading'));
  }

  getStudentPrePrimaryMenu() {
    menuItems.clear();
    menuItems.add(HomeMenuItem(MYSCHOOLiNDEX, MYSCHOOL, MYSCHOOL, 'myclass'));
    menuItems
        .add(HomeMenuItem(PENTEMIND_iNDEX, PENTEMIND, PENTEMIND, 'pentemind'));
    menuItems.add(HomeMenuItem(EXTENDED_CLASSROOM_iNDEX, EXTENDED_CLASSROOM,
        EXTENDED_CLASSROOM, 'exclassroom'));
  }

  getTeacherPrePrimaryMenu() {
    menuItems.clear();
    menuItems.add(HomeMenuItem(TEACHER_OPERATION_iNDEX, TEACHER_OPERATION,
        TEACHER_OPERATION, 'teachingoperation'));
    menuItems.add(HomeMenuItem(EXTENDED_CLASSROOM_iNDEX, EXTENDED_CLASSROOM,
        EXTENDED_CLASSROOM, 'exclassroom'));
    menuItems.add(HomeMenuItem(STUDENT_ANALYTICS_iNDEX, STUDENT_ANALYTICS,
        STUDENT_ANALYTICS, 'studentanalytis'));
    menuItems.add(HomeMenuItem(PENTEMIND_iNDEX, PENTEMIND, PENTEMIND, 'pentemind'));
    menuItems.add(HomeMenuItem(MLZS_READING_iNDEX, MLZS_READING, MLZS_READING, 'mlzsreading'));
  }

  getSystemAdminMenu() {
    menuItems.clear();
    menuItems.add(HomeMenuItem(TEACHER_OPERATION_iNDEX, TEACHER_OPERATION,
        TEACHER_OPERATION, 'teachingoperation'));
    menuItems.add(HomeMenuItem(EXTENDED_CLASSROOM_iNDEX, EXTENDED_CLASSROOM,
        EXTENDED_CLASSROOM, 'exclassroom'));
    menuItems.add(HomeMenuItem(STUDENT_ANALYTICS_iNDEX, STUDENT_ANALYTICS,
        STUDENT_ANALYTICS, 'studentanalytis'));
    menuItems.add(HomeMenuItem(PENTEMIND_iNDEX, PENTEMIND, PENTEMIND, 'pentemind'));
    menuItems.add(HomeMenuItem(MLZS_READING_iNDEX, MLZS_READING, MLZS_READING, 'mlzsreading'));
    menuItems.add(HomeMenuItem(ZLL_SAATHI_iNDEX, ZLL_SAATHI, ZLL_SAATHI, 'zllsaathi'));
  }

  getScreen() {
    return Container(
      child: GridView.builder(
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        itemCount: menuItems.length,
        itemBuilder: (context, index) => getMenuUi(menuItems[index]),
        gridDelegate: Utility.getGridViewStyle(),
      ),
    );
  }

  Widget getMenuUi(HomeMenuItem item) {
    final Color color = Colors.primaries[item.index % Colors.primaries.length];
    return Padding(
        padding: const EdgeInsets.all(4.0),
        child: Card(
          color: kPrimaryLightColor,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            //set border radius more than 50% of height and width to make circle
          ),
          child: InkWell(
            mouseCursor: SystemMouseCursors.click,
            highlightColor: Colors.yellow.withOpacity(0.3),
            splashColor: Colors.red.withOpacity(0.8),
            focusColor: Colors.green.withOpacity(0.0),
            hoverColor: Colors.yellow.withOpacity(0.3),
            onTap: () {
              onClick(item.index, item);
            },
            child: Container(
              child: ListTile(
                title: MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: Text(
                      item.title,
                      style: LightColors.menuStyle,
                    )),
                // trailing: Image.asset(
                //   '/assets/icons/${item.assetlocation}.png',
                //   width: kIsWeb ? 50 : 24,
                // ),
              ),
            ),
          ),
        ));
  }

  AppBar getAppbar() {
    return AppBar(
        backgroundColor: kPrimaryColor,
        title: widget.userInfo.root!.subroot!.userName == 'P'
            ? Text(
                widget.userInfo.root!.subroot!.userName!,
                style: GoogleFonts.inter(
                  fontSize: 14.0,
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  height: 1.5,
                ),
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.userInfo.root!.subroot!.userName!,
                    style: GoogleFonts.inter(
                      fontSize: 14.0,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      height: 1.5,
                    ),
                  ),
                  Text(
                    widget.userInfo.root!.subroot!.userRole!,
                    style: GoogleFonts.inter(
                      fontSize: 10.0,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
        actions: [
          InkWell(
            onTap: () {
              showClassSelection();
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Text('Class '),
                  Icon(Icons.arrow_drop_down)
                ],
              ),
            ),
          ),
          InkWell(
            onTap: () {
              signOut();
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(Icons.logout),
            ),
          )
        ]);
  }
  TextEditingController batchController = TextEditingController();
  TextEditingController branchController = TextEditingController();
  showClassSelection(){
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            margin: EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text('Select School'),
                ZeeDropDown(
                  title: 'Select School',
                  textController: batchController,
                  hintText: 'Select School',
                  enable: false,
                  items: userinfo!.root!.subroot!.branchList!,
                  displayFunction: (p0) =>
                  '${p0.branchName ?? ''}}',
                  onChanged: (p0) {
                    if (p0 != null) {
                      batchController.text = p0!.branchName!;
                    } else {
                      //selectedFilterFranchisee = p0;
                    }
                  },
                ),
                ZeeDropDown(
                  title: 'Select Branch',
                  textController: branchController,
                  hintText: 'Select Branch',
                  enable: false,
                  items: userinfo!.root!.subroot!.branchList!,
                  displayFunction: (p0) =>
                  '${p0.branchName ?? ''}}',
                  onChanged: (p0) {
                    if (p0 != null) {
                      batchController.text = p0!.branchName!;
                    } else {
                      //selectedFilterFranchisee = p0;
                    }
                  },
                ),
              ],
            ),
          );
        });
  }

  signOut() async{
    var box = await Utility.openBox();
    box.clear();
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => LoginScreen(),
        ));
  }

  getBranch(){

  }

  void onBackClickListener() async {
    // print('Back click listen $_selectedDestination ${_currentPentemind}');
    // if (!isLoading) {
    //   if (_currentPentemind == 'HOME') {
    //     showExitConfirmation();
    //   } else {
    //     _currentPentemind = 'HOME';
    //     setState(() {
    //       _selectedDestination = MENU_LEARNING_GOAL;
    //     });
    //   }
    // }
  }

  @override
  void onClick(int action, value) {
    if (action == ZLL_SAATHI_iNDEX) {
      //lunchExternalApp('com.zeelearn.zllsaathi');
      String userRole = Utility.getUserRole(widget.userInfo.root!.subroot!.userRole!);
      if(false && userRole.isEmpty){
        print('URL https://zllsaathi.zeelearn.com/dashboard?bu_id=${widget.userInfo!.root!.subroot!.uid}&b_id=2&r=${widget.userInfo.root!.subroot!.userRole!}&u_id=0');
        Utility.showAlert(context, 'Zll Saathi currently not acciciable for your Role(${widget.userInfo.root!.subroot!.userRole})...');
      }else{
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => MyWebViewScreen(url: 'https://intranet-9fda2.web.app//dashboard?u_name=F2354', title: 'ZllSaathi',)));
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //       builder: (context) => MyWebViewScreen(url: 'https://zllsaathi.zeelearn.com/dashboard?bu_id=${widget.userInfo!.root!.subroot!.uid}&b_id=2&r=${userRole}&u_id=0', title: 'ZllSaathi',)));
      }
    } else if (action == MLZS_READING_iNDEX) {
      Subroot userinfo = widget.userInfo.root!.subroot!;
      //String school_class  = userinfo.branchList![0].batchList!.batchName!.split('/')[0].trim();
      String grade  = userinfo.branchList![0].batchList!.batchName!.split('/')[1].trim();

      GetFradomDeepLink request = GetFradomDeepLink(name:userinfo.userName!,grade:'Grade ${getGrade(grade)}',schoolCode:'mxxbjk',deviceType: 'Android',description:'MH',schoolClass:grade.toUpperCase(),countryCode:'+91',email:'test@zeelearn.com',age:'',siblings:[], contactNo: lettersToIndex(userinfo.userId!).toString(), userType: userinfo.userType!, schoolClassList: [SchoolClass(schoolClass: grade.toUpperCase())]);
      /*FredomModel model =  FredomModel('+91', userinfo.userName!, userinfo.userId!, 'Android', userinfo.userType!='TEACH' ? true : false, userinfo.branchList![0].branchName!, school_class);
      print('original Data ${model.toJson()}');
      print('encoded Data ${utf8.encode(model.toJson())}');
      applaunchUrl(Uri.parse("freadomapp://?data=${utf8.encode(model.toJson())}"));*/
      print(request.toJson());
      ApiServiceHandler().getFradomLink(request, this);

    } else if (action == MYSCHOOLiNDEX) {
      lunchExternalApp('com.innova.students_mlz_epfuture');
    } else if (action == TEACHER_OPERATION_iNDEX) {
      lunchExternalApp('epfuture.innova.com.teacher_mlz');
    } else if (action == EXTENDED_CLASSROOM_iNDEX) {
      lunchExternalApp('com.innova.studentsmlz');
    } else if (action == PENTEMIND_iNDEX) {
      lunchExternalApp('com.zeelearn.ekidzee');
    } else if (action == SCHOOL_OPERATION_iNDEX) {
      lunchExternalApp('com.innova.mis_ep_future');
    } else if (action == STUDENT_ANALYTICS_iNDEX) {
      lunchExternalApp('epfuture.innova.com.teacher_mlz');
    } else {
      lunchExternalApp('com.zeelearn.saarthi');
    }
  }

  int getGrade(String value){
    switch(value.toLowerCase()){
      case "a":
        return 1;
      case "b":
        return 2;
      case "c":
        return 3;
      case "d":
        return 4;
    }
    return 0;
  }

  int lettersToIndex(String letters) {
    var result = 0;
    for (var i = 0; i < letters.length; i++) {
      result = result * 10 + (letters.codeUnitAt(i) & 0x1f);
    }
    return result;
  }

  lunchExternalApp(String package) async {
    try {
      ///checks if the app is installed on your mobile device
      print(package);
      bool isInstalled = await DeviceApps.isAppInstalled(package);
      if (isInstalled) {
        DeviceApps.openApp(package);
      } else {
        print('app not found');

        ///if the app is not installed it lunches google play store so you can install it from there
        launch("market://details?id=" + package);
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void onError(int action, value) {
    Navigator.of(context).pop();
  }

  @override
  void onStart() {
    Utility.showLoaderDialog(context);
  }

  openFradomApp(String url) async{
    // Check if Spotify is installed
    if (await canLaunchUrl(Uri.parse(url))) {
    // Launch the url which will open Spotify
    launchUrl(Uri.parse(url));
    }
  }

  @override
  void onSuccess(value) {
    Navigator.of(context).pop();
    if(value is FradomLinkResponse){
      FradomLinkResponse response = value;
      if(response!=null && response.result!=null && response.result!.data!=null){
        openFradomApp(response.result!.data!);
      }
    }
  }
}
