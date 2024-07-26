import 'dart:convert';
import 'dart:io';

import 'package:device_apps/device_apps.dart';
import 'package:external_app_launcher/external_app_launcher.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:literahub/apis/response/user_response.dart';
import 'package:literahub/globals.dart';
import 'package:literahub/iface/onClick.dart';
import 'package:literahub/model/MllModel.dart';
import 'package:literahub/model/menuitem.dart';
import 'package:literahub/screens/auth/views/login.dart';
import 'package:literahub/screens/login/login_screen.dart';
import 'package:saathi/zllsaathi.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../apis/ServiceHandler.dart';
import '../../apis/request/fradomdeeplink.dart';
import '../../apis/response/fradom_response.dart';
import '../../core/constant/LocalConstant.dart';
import '../../core/theme/light_colors.dart';
import '../../core/utility.dart';
import '../../iface/onResponse.dart';
import '../../widgets/dropdown.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  BranchList? _selectedBranch = null;
  String userPassword = '';
  String userName = '';

  @override
  void initState() {
    super.initState();
    getUserInfo();
  }

  getUserInfo() async {
    var box = await Utility.openBox();
    String json = box.get(LocalConstant.KEY_LOGIN_RESPONSE);
    userName = box.get(LocalConstant.KEY_LOGIN_USERNAME);
    userPassword = box.get(LocalConstant.KEY_LOGIN_PASSWORD);
    userinfo = UserResponse.fromJson(jsonDecode(json));
    if (userinfo != null &&
        userinfo!.root != null &&
        userinfo!.root!.subroot != null &&
        userinfo!.root!.subroot!.branchList != null) {
      _selectedBranch = userinfo!.root!.subroot!.branchList![0];
    }
    //print(userinfo!.toJson());
    generateMenu();
  }

  generateMenu() {
    print('User Role ${widget.userInfo.root!.subroot!.userRole}');
    menuItems.clear();
    if (LocalConstant.flavor == 'Fradom') {
      menuItems.add(HomeMenuItem(
          MLZS_READING_iNDEX, MLZS_READING, MLZS_READING, 'mlzsreading'));
    } else if (Platform.isIOS) {
      menuItems.add(
          HomeMenuItem(ZLL_SAATHI_iNDEX, ZLL_SAATHI, ZLL_SAATHI, 'zllsaathi'));
      menuItems.add(
          HomeMenuItem(PENTEMIND_iNDEX, PENTEMIND, PENTEMIND, 'pentemind'));
      //menuItems.add(HomeMenuItem(EXTENDED_CLASSROOM_iNDEX, EXTENDED_CLASSROOM,EXTENDED_CLASSROOM, 'exclassroom'));
      //menuItems.add(HomeMenuItem(STUDENT_ANALYTICS_iNDEX, STUDENT_ANALYTICS,STUDENT_ANALYTICS, 'studentanalytis'));
    } else if (widget.userInfo.root!.subroot!.userRole!
        .toLowerCase()
        .contains('principal')) {
      getPrincipalMenu();
    } else if (widget.userInfo.root!.subroot!.userRole!.toLowerCase() == 'f' ||
        widget.userInfo.root!.subroot!.userRole!.toLowerCase() ==
            'business partner') {
      getBusinessPartnerMenu();
    } else if (widget.userInfo.root!.subroot!.userRole!
        .toLowerCase()
        .contains('teach')) {
      print('in 94 teacher found');
      if (_selectedBranch != null) {
        if (_selectedBranch!.schoolgroup!.toLowerCase().contains('k5') ||
            _selectedBranch!.schoolgroup!.toLowerCase().contains('k12')) {
          //1 to 12 class
          getTeacher1to12Menu();
        } else {
          //pre-primary
          getTeacherPrePrimaryMenu();
        }
      } else {
        print('in 104 batch not selected');
        //Dashboard menu not for your role
      }
    } else if (widget.userInfo.root!.subroot!.userRole!
        .toLowerCase()
        .contains('stud')) {
      if (_selectedBranch != null) {
        if (_selectedBranch!.schoolgroup!.toLowerCase().contains('k5') ||
            _selectedBranch!.schoolgroup!.toLowerCase().contains('k12')) {
          //1 to 12 class
          getStudent1to12Menu();
        } else {
          //pre-primary
          getStudentPrePrimaryMenu();
        }
      } else {
        //Dashboard menu not for your role
      }
    } else if (widget.userInfo.root!.subroot!.userRole == 'S-1-12') {
      getStudent1to12Menu();
    } else if (widget.userInfo.root!.subroot!.userRole == 'S-Pre-primary') {
      getStudentPrePrimaryMenu();
    } else if (widget.userInfo.root!.subroot!.userRole == 'TEACH-1-12') {
      getTeacher1to12Menu();
    } else if (widget.userInfo.root!.subroot!.userRole == 'TEACH-Pre-primary' ||
        widget.userInfo.root!.subroot!.userRole == 'staff') {
      getTeacherPrePrimaryMenu();
    } else if (Utility.getUserRole(widget.userInfo.root!.subroot!.userRole!)
        .isNotEmpty) {
      getSystemAdminMenu();
    } else {
      print('in else ');
      getSystemAdminMenu();
    }
    setState(() {});
  }

  Future<void> applaunchUrl(url) async {
    print('url status ${url}');
    bool isFound = await launchUrl(url);
    print('is Found $isFound');
    if (!isFound) {
      //https://apps.apple.com/in/app/kidzeeapp/id1338356944
      await launchUrl(
        Uri.parse(url),
        mode: LaunchMode.externalApplication,
      );
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
        resizeToAvoidBottomInset: true,
        body: getScreen(),
      ),
    );
  }

  getStudent1to12Menu() {
    menuItems.clear();
    print('getStudent1to12Menu menu');
    if (Platform.isIOS) {
      menuItems.add(HomeMenuItem(EXTENDED_CLASSROOM_iNDEX, EXTENDED_CLASSROOM,
          EXTENDED_CLASSROOM, 'exclassroom'));
    } else if (LocalConstant.flavor == 'MLL') {
      menuItems.add(HomeMenuItem(EXTENDED_CLASSROOM_iNDEX, EXTENDED_CLASSROOM,
          EXTENDED_CLASSROOM, 'exclassroom'));
    } else {
      menuItems.add(HomeMenuItem(MYSCHOOLiNDEX, MYSCHOOL, MYSCHOOL, 'myclass'));
      menuItems.add(HomeMenuItem(EXTENDED_CLASSROOM_iNDEX, EXTENDED_CLASSROOM,
          EXTENDED_CLASSROOM, 'exclassroom'));
      menuItems.add(HomeMenuItem(
          MLZS_READING_iNDEX, MLZS_READING, MLZS_READING, 'mlzsreading'));
      //menuItems.add(HomeMenuItem(MLZS_READING_iNDEX, MLZS_READING, MLZS_READING, 'mlzsreading'));
    }
  }

  getGPMenu() {
    menuItems.clear();
    menuItems.add(
        HomeMenuItem(ZLL_SAATHI_iNDEX, ZLL_SAATHI, ZLL_SAATHI, 'zllsaathi'));
  }

  getTeacher1to12Menu() {
    print('getTeacher1to12Menu menu');
    menuItems.clear();
    if (Platform.isIOS) {
      menuItems.add(
          HomeMenuItem(PENTEMIND_iNDEX, PENTEMIND, PENTEMIND, 'pentemind'));
      menuItems.add(
          HomeMenuItem(ZLL_SAATHI_iNDEX, ZLL_SAATHI, ZLL_SAATHI, 'zllsaathi'));
      menuItems.add(HomeMenuItem(EXTENDED_CLASSROOM_iNDEX, EXTENDED_CLASSROOM,
          EXTENDED_CLASSROOM, 'exclassroom'));
      menuItems.add(HomeMenuItem(STUDENT_ANALYTICS_iNDEX, STUDENT_ANALYTICS,
          STUDENT_ANALYTICS, 'studentanalytis'));
    } else if (LocalConstant.flavor == 'MLL') {
      menuItems.add(HomeMenuItem(STUDENT_ANALYTICS_iNDEX, STUDENT_ANALYTICS,
          STUDENT_ANALYTICS, 'studentanalytis'));
    } else {
      menuItems.add(HomeMenuItem(TEACHER_OPERATION_iNDEX, TEACHER_OPERATION,
          TEACHER_OPERATION, 'teachingoperation'));
      menuItems.add(HomeMenuItem(EXTENDED_CLASSROOM_iNDEX, EXTENDED_CLASSROOM,
          EXTENDED_CLASSROOM, 'exclassroom'));
      menuItems.add(HomeMenuItem(STUDENT_ANALYTICS_iNDEX, STUDENT_ANALYTICS,
          STUDENT_ANALYTICS, 'studentanalytis'));
      menuItems.add(HomeMenuItem(
          MLZS_READING_iNDEX, MLZS_READING, MLZS_READING, 'mlzsreading'));
    }
  }

  getStudentPrePrimaryMenu() {
    menuItems.clear();
    print('getStudentPrePrimaryMenu menu');
    if (Platform.isIOS) {
      menuItems.add(
          HomeMenuItem(PENTEMIND_iNDEX, PENTEMIND, PENTEMIND, 'pentemind'));
    }
    if (LocalConstant.flavor == 'MLL') {
      menuItems.add(HomeMenuItem(EXTENDED_CLASSROOM_iNDEX, EXTENDED_CLASSROOM,
          EXTENDED_CLASSROOM, 'exclassroom'));
    } else {
      menuItems.add(HomeMenuItem(MYSCHOOLiNDEX, MYSCHOOL, MYSCHOOL, 'myclass'));
      menuItems.add(
          HomeMenuItem(PENTEMIND_iNDEX, PENTEMIND, PENTEMIND, 'pentemind'));
      menuItems.add(HomeMenuItem(
          MLZS_READING_iNDEX, MLZS_READING, MLZS_READING, 'mlzsreading'));
    }
  }

  getTeacherPrePrimaryMenu() {
    menuItems.clear();
    print('getTeacherPrePrimaryMenu menu');
    if (Platform.isIOS) {
      menuItems.add(
          HomeMenuItem(PENTEMIND_iNDEX, PENTEMIND, PENTEMIND, 'pentemind'));
      menuItems.add(HomeMenuItem(EXTENDED_CLASSROOM_iNDEX, EXTENDED_CLASSROOM,
          EXTENDED_CLASSROOM, 'exclassroom'));
      menuItems.add(HomeMenuItem(STUDENT_ANALYTICS_iNDEX, STUDENT_ANALYTICS,
          STUDENT_ANALYTICS, 'studentanalytis'));
    } else if (LocalConstant.flavor == 'MLL') {
      menuItems.add(HomeMenuItem(EXTENDED_CLASSROOM_iNDEX, EXTENDED_CLASSROOM,
          EXTENDED_CLASSROOM, 'exclassroom'));
      menuItems.add(HomeMenuItem(STUDENT_ANALYTICS_iNDEX, STUDENT_ANALYTICS,
          STUDENT_ANALYTICS, 'studentanalytis'));
    } else {
      menuItems.add(HomeMenuItem(TEACHER_OPERATION_iNDEX, TEACHER_OPERATION,
          TEACHER_OPERATION, 'teachingoperation'));
      menuItems.add(HomeMenuItem(EXTENDED_CLASSROOM_iNDEX, EXTENDED_CLASSROOM,
          EXTENDED_CLASSROOM, 'exclassroom'));
      menuItems.add(HomeMenuItem(STUDENT_ANALYTICS_iNDEX, STUDENT_ANALYTICS,
          STUDENT_ANALYTICS, 'studentanalytis'));
      menuItems.add(
          HomeMenuItem(PENTEMIND_iNDEX, PENTEMIND, PENTEMIND, 'pentemind'));
      menuItems.add(HomeMenuItem(
          MLZS_READING_iNDEX, MLZS_READING, MLZS_READING, 'mlzsreading'));
    }
  }

  getPrincipalMenu() {
    menuItems.clear();
    print('principle menu');
    if (!kIsWeb && Platform.isIOS) {
      menuItems.add(
          HomeMenuItem(ZLL_SAATHI_iNDEX, ZLL_SAATHI, ZLL_SAATHI, 'zllsaathi'));
      menuItems.add(
          HomeMenuItem(PENTEMIND_iNDEX, PENTEMIND, PENTEMIND, 'pentemind'));
      menuItems.add(HomeMenuItem(EXTENDED_CLASSROOM_iNDEX, EXTENDED_CLASSROOM,
          EXTENDED_CLASSROOM, 'exclassroom'));
      menuItems.add(HomeMenuItem(STUDENT_ANALYTICS_iNDEX, STUDENT_ANALYTICS,
          STUDENT_ANALYTICS, 'studentanalytis'));
    } else {
      menuItems.add(HomeMenuItem(TEACHER_OPERATION_iNDEX, TEACHER_OPERATION,
          TEACHER_OPERATION, 'teachingoperation'));
      menuItems.add(HomeMenuItem(SCHOOL_OPERATION_iNDEX, SCHOOL_OPERATION,
          SCHOOL_OPERATION, 'schooloperation'));
      menuItems.add(HomeMenuItem(EXTENDED_CLASSROOM_iNDEX, EXTENDED_CLASSROOM,
          EXTENDED_CLASSROOM, 'exclassroom'));
      menuItems.add(HomeMenuItem(STUDENT_ANALYTICS_iNDEX, STUDENT_ANALYTICS,
          STUDENT_ANALYTICS, 'studentanalytis'));
      menuItems.add(
          HomeMenuItem(PENTEMIND_iNDEX, PENTEMIND, PENTEMIND, 'pentemind'));
      menuItems.add(
          HomeMenuItem(ZLL_SAATHI_iNDEX, ZLL_SAATHI, ZLL_SAATHI, 'zllsaathi'));
    }
    setState(() {});
  }

  getBusinessPartnerMenu() {
    menuItems.clear();
    if (Platform.isIOS) {
      menuItems.add(
          HomeMenuItem(PENTEMIND_iNDEX, PENTEMIND, PENTEMIND, 'pentemind'));
      menuItems.add(
          HomeMenuItem(ZLL_SAATHI_iNDEX, ZLL_SAATHI, ZLL_SAATHI, 'zllsaathi'));
      menuItems.add(HomeMenuItem(EXTENDED_CLASSROOM_iNDEX, EXTENDED_CLASSROOM,
          EXTENDED_CLASSROOM, 'exclassroom'));
      menuItems.add(HomeMenuItem(STUDENT_ANALYTICS_iNDEX, STUDENT_ANALYTICS,
          STUDENT_ANALYTICS, 'studentanalytis'));
    } else {
      menuItems.add(HomeMenuItem(SCHOOL_OPERATION_iNDEX, SCHOOL_OPERATION,
          SCHOOL_OPERATION, 'schooloperation'));
      menuItems.add(HomeMenuItem(EXTENDED_CLASSROOM_iNDEX, EXTENDED_CLASSROOM,
          EXTENDED_CLASSROOM, 'exclassroom'));
      menuItems.add(HomeMenuItem(STUDENT_ANALYTICS_iNDEX, STUDENT_ANALYTICS,
          STUDENT_ANALYTICS, 'studentanalytis'));
      menuItems.add(HomeMenuItem(
          MLZS_READING_iNDEX, MLZS_READING, MLZS_READING, 'mlzsreading'));
      menuItems.add(
          HomeMenuItem(PENTEMIND_iNDEX, PENTEMIND, PENTEMIND, 'pentemind'));
      menuItems.add(
          HomeMenuItem(ZLL_SAATHI_iNDEX, ZLL_SAATHI, ZLL_SAATHI, 'zllsaathi'));
    }
    setState(() {});
  }

  getSystemAdminMenu() {
    menuItems.clear();
    if (LocalConstant.flavor == 'MLL') {
      menuItems.add(HomeMenuItem(EXTENDED_CLASSROOM_iNDEX, EXTENDED_CLASSROOM,
          EXTENDED_CLASSROOM, 'exclassroom'));
      menuItems.add(HomeMenuItem(STUDENT_ANALYTICS_iNDEX, STUDENT_ANALYTICS,
          STUDENT_ANALYTICS, 'studentanalytis'));
    } else {
      // menuItems.add(HomeMenuItem(TEACHER_OPERATION_iNDEX, TEACHER_OPERATION,
      //     TEACHER_OPERATION, 'teachingoperation'));
      // menuItems.add(HomeMenuItem(EXTENDED_CLASSROOM_iNDEX, EXTENDED_CLASSROOM,
      //     EXTENDED_CLASSROOM, 'exclassroom'));
      // menuItems.add(HomeMenuItem(STUDENT_ANALYTICS_iNDEX, STUDENT_ANALYTICS,
      //     STUDENT_ANALYTICS, 'studentanalytis'));
      // menuItems.add(
      //     HomeMenuItem(PENTEMIND_iNDEX, PENTEMIND, PENTEMIND, 'pentemind'));
      menuItems.add(HomeMenuItem(
          MLZS_READING_iNDEX, MLZS_READING, MLZS_READING, 'mlzsreading'));
      menuItems.add(
          HomeMenuItem(ZLL_SAATHI_iNDEX, ZLL_SAATHI, ZLL_SAATHI, 'zllsaathi'));
    }
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
        automaticallyImplyLeading: false,
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
                  Text(
                    branchController.text.toString().isNotEmpty
                        ? branchController.text.toString()
                        : 'Class ',
                    style: LightColors.headerBoldStyle,
                  ),
                  Icon(
                    Icons.arrow_drop_down,
                    color: Colors.white,
                  )
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
              child: Icon(
                Icons.logout,
                color: Colors.white,
              ),
            ),
          )
        ]);
  }

  TextEditingController batchController = TextEditingController();
  TextEditingController branchController = TextEditingController();
  showClassSelection() {
    print(userinfo!.root!.subroot!.branchList!.length);
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            margin: EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text('Select School'),
                ZeeDropDown(
                  textStyle: LightColors.textHeaderStyle,
                  title: 'Select School',
                  textController: batchController,
                  hintText: 'Select School',
                  items: userinfo!.root!.subroot!.branchList!,
                  displayFunction: (p0) => '${p0.branchName ?? ''}}',
                  onChanged: (p0) {
                    if (p0 != null) {
                      _selectedBranch = p0!;
                      print(_selectedBranch!.batchList);
                      batchController.text = p0!.branchName!;
                      setState(() {});
                    } else {
                      //selectedFilterFranchisee = p0;
                    }
                  },
                ),
                if (_selectedBranch != null &&
                    _selectedBranch!.batchList != null)
                  ZeeDropDown(
                    title: 'Select Branch',
                    textController: branchController,
                    hintText: 'Select Branch',
                    items: _selectedBranch!.batchList!,
                    displayFunction: (p0) => '${p0!.batchName ?? ''}}',
                    onChanged: (p0) {
                      if (p0 != null) {
                        branchController.text = p0!.batchName!;
                      } else {
                        //selectedFilterFranchisee = p0;
                      }
                    },
                  ),
                SizedBox(
                  height: 100,
                )
              ],
            ),
          );
        });
  }

  signOut() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
    var box = await Utility.openBox();
    await box.clear();
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => LiteriaHubLoginPage(),
        ));
  }

  getBranch() {}

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

  openmlzs(String packageName, String schema, String appleId) async {
    Subroot userinfo = widget.userInfo.root!.subroot!;
    //String school_class  = userinfo.branchList![0].batchList!.batchName!.split('/')[0].trim();
    if (userinfo.branchList![0].batchList == null ||
        userinfo.branchList![0].batchList!.length == 0) {
      Utility.showAlert(
          context, 'Batch not configured, Please connect with your center ');
    } else {
      String grade = userinfo.branchList![0].batchList![0]!.batchName!
          .split('/')[1]
          .trim();

      MLLModel model = MLLModel(
          userinfo.userId!,
          userinfo.userName!,
          userName,
          '',
          '',
          '',
          '',
          userinfo.branchList![0].branchName!,
          grade,
          userPassword);
      print(model.toJson());
      //bool isInstalled = await DeviceApps.isAppInstalled(packageName);
      String encoded = base64
          .encode(utf8.encode(model.toJson())); // dXNlcm5hbWU6cGFzc3dvcmQ=
      String decoded = utf8.decode(base64.decode(encoded));
      bool isAvaliable = await LaunchApp.isAppInstalled(
          androidPackageName: packageName,
          iosUrlScheme: 'https://${schema}://');
      print('App Found Status ${isAvaliable}');
      if (isAvaliable && Platform.isAndroid) {
        applaunchUrl(Uri.parse("https://${schema}://?data=${encoded}"));
        // }else{
        //   final url = Uri.parse(
        //     Platform.isAndroid
        //         ? "https://play.google.com/store/apps/details?id=com.zeelearn.ekidzee&hl=en_IN"
        //         : "https://apps.apple.com/app/id$appleId",
        //   );
        //   ///if the app is not installed it lunches google play store so you can install it from there
        //   launchUrl(url,mode: LaunchMode.externalApplication);
      } else if (isAvaliable) {
        if (isAvaliable) {
          await LaunchApp.openApp(
              androidPackageName: packageName,
              iosUrlScheme:
                  'https://${schema}://?data=${encoded}', //'https://kidzee.com/login/?username=F2354&password=Kidzee#123',
              appStoreLink:
                  'https://${schema}://?data=${encoded}', //'https://apps.apple.com/in/app/kidzeeapp/id$appleId',
              openStore: false);
        } else {
          await LaunchApp.openApp(
              androidPackageName: '${packageName}',
              iosUrlScheme: 'https://${schema}://?data=${encoded}',
              appStoreLink:
                  'https://${schema}://?data=${encoded}', //'https://apps.apple.com/in/app/kidzeeapp/id$appleId',
              openStore: false);
        }
      } else {
        print('app not found');
        //launch("market://details?id=${packageName}?" + model.toJson());
        final url = Uri.parse(
          Platform.isAndroid
              ? "https://play.google.com/store/apps/details?id=${packageName}&hl=en_IN"
              : "https://apps.apple.com/app/id$appleId",
        );

        ///if the app is not installed it lunches google play store so you can install it from there
        launchUrl(url, mode: LaunchMode.externalApplication);
      }
    }
  }

  openPentemind() async {
    bool isAvaliable = await LaunchApp.isAppInstalled(
        androidPackageName: 'com.zeelearn.mlzsv1',
        iosUrlScheme: 'kidzeeApp://');
    if (Platform.isIOS) {
      print('isAvaliable ${isAvaliable}');
      if (isAvaliable) {
        //launchUrl(Uri.parse('https://www.kidzee.com'));
        await LaunchApp.openApp(
            androidPackageName: 'com.zeelearn.mlzsv1',
            iosUrlScheme:
                'https://zllsaathi.zeelearn.com/', //'kidzeeApp://?login=true&username=F2354&password=Kidzee#123',
            appStoreLink:
                'https://apps.apple.com/in/app/kidzeeapp/id1338356944',
            openStore: true);
      } else {
        await LaunchApp.openApp(
            androidPackageName: 'com.zeelearn.mlzsv1',
            iosUrlScheme: 'kidzeeApp://',
            appStoreLink:
                'https://apps.apple.com/in/app/kidzeeapp/id1338356944',
            openStore: true);
      }
    } else {
      await LaunchApp.openApp(
          androidPackageName: "com.zeelearn.mlzsv1",
          iosUrlScheme: 'http://kidzee.com',
          appStoreLink: 'https://apps.apple.com/in/app/kidzeeapp/id1338356944',
          openStore: false);
    }
  }

  openMllApp(String packageName) async {
    Subroot userinfo = widget.userInfo.root!.subroot!;
    //String school_class  = userinfo.branchList![0].batchList!.batchName!.split('/')[0].trim();
    if (userinfo.branchList![0].batchList == null ||
        userinfo.branchList![0].batchList!.length == 0) {
      Utility.showAlert(
          context, 'Batch not configured, Please connect with your center ');
    } else {
      String grade = userinfo.branchList![0].batchList![0]!.batchName!
          .split('/')[1]
          .trim();

      MLLModel model = MLLModel(
          userinfo.userId!,
          userinfo.userName!,
          userName,
          '',
          '',
          '',
          '',
          userinfo.branchList![0].branchName!,
          grade,
          userPassword);
      bool isInstalled = await DeviceApps.isAppInstalled(packageName);
      if (isInstalled) {
        String encoded = base64
            .encode(utf8.encode(model.toJson())); // dXNlcm5hbWU6cGFzc3dvcmQ=
        //String decoded = utf8.decode(base64.decode(encoded));
        applaunchUrl(Uri.parse(
            "epfapp://open?username=$userName,password=$userPassword"));
      } else {
        await LaunchApp.openApp(
            androidPackageName: packageName,
            iosUrlScheme: '',
            appStoreLink: '',
            openStore: true);
        //launchUrl(Uri.parse("market://details?id=${packageName}?" + model.toJson()));
      }
    }
  }

  @override
  void onClick(int action, value) {
    if (action == ZLL_SAATHI_iNDEX) {
      Subroot userinfo = widget.userInfo.root!.subroot!;
      ZllSaathi(context, '14002035', null);
      //ZllSaathiNative(context, userName, '2',getUserRole(userinfo.userType!) , '0', kPrimaryLightColor, null);
    } else if (action == MLZS_READING_iNDEX) {
      Subroot userinfo = widget.userInfo.root!.subroot!;
      print(userinfo.toJson());
      if (userinfo.branchList![0].batchList == null ||
          userinfo.branchList![0].batchList!.length == 0) {
        Utility.showAlert(
            context, 'Batch not configured, Please connect with your center ');
      } else {
        try {
          String grade = userinfo.userType == 'Teacher'
              ? userinfo.branchList![0].batchList![0]!.batchName!
                  .split('/')[0]
                  .trim()
              : userinfo.branchList![0].batchList![0]!.batchName!
                  .split('/')[1]
                  .trim();
          String className = userinfo.branchList![0].batchList![0]!.batchName!
              .split('/')[1]
              .trim();
          // print('Grade is ${grade}  ${className}');
          grade = grade.replaceAll('CLASS', '');
          String mGrade = userinfo.branchList![0].batchList![0]!.batchName!
              .split('/')[0]
              .trim();
          mGrade = mGrade.replaceAll('CLASS', '');
          GetFradomDeepLink request = GetFradomDeepLink(
              name: userinfo.userName!,
              grade: /*userinfo.userType=='Teacher' ? */
                  'Grade ${mGrade.trim()}' /* : 'Grade ${grade.trim()}'*/,
              schoolCode: getSchoolCode(userinfo.branchList![0].branchName!),
              deviceType: 'Android',
              description: 'MH',
              schoolClass: userinfo.userType == 'Teacher' ? className : grade,
              countryCode: '+91',
              email: 'test@zeelearn.com',
              age: '',
              siblings: [],
              isTeacher: userinfo.userType == 'Teacher' ? true : false,
              contactNo: lettersToIndex(userinfo.userId!).toString(),
              userType: userinfo.userType!,
              schoolClassList: [
                SchoolClass(
                    schoolClass:
                        userinfo.userType == 'Teacher' ? className : grade),
              ]);
          ApiServiceHandler().getFradomLink(request, this);
        } catch (e) {
          debugPrint(e.toString());
        }
      }
    } else if (action == MYSCHOOLiNDEX) {
      openMllApp('com.innova.students_mlz_epfuture');
    } else if (action == TEACHER_OPERATION_iNDEX) {
      lunchExternalApp('eplusreg.innova.com.teacher_epfuture');
    } else if (action == EXTENDED_CLASSROOM_iNDEX) {
      openmlzs("com.zeelearn.mlzsapp", "mlzsapp", "6463385772");
    } else if (action == PENTEMIND_iNDEX) {
      openPentemind();
    } else if (action == SCHOOL_OPERATION_iNDEX) {
      openMllApp('com.innova.mis_ep_future');
    } else if (action == STUDENT_ANALYTICS_iNDEX) {
      openmlzs("com.zeelearn.mlzstapp", "mlzstapp", "6504000882");
    } else {
      lunchExternalApp('com.zeelearn.saarthi');
    }
  }

  String getSchoolCode(String school) {
    String code = "";
    if (school.toLowerCase().contains('goa')) {
      code = 'mxxbjk';
    } else if (school.toLowerCase().contains('nagpur')) {
      code = 'skttcj';
    } else if (school.toLowerCase().contains('patiala')) {
      code = 'gwqfhm';
    } else if (school.toLowerCase().contains('karnal')) {
      code = 'unbhzy';
    } else if (school.toLowerCase().contains('bathinda')) {
      code = 'mawjwn';
    }
    return code;
  }

  int lettersToIndex(String letters) {
    var result = 0;
    for (var i = 0; i < letters.length; i++) {
      result = result * 10 + (letters.codeUnitAt(i) & 0x1f);
    }
    return result;
  }

  String getUserRole(String type) {
    String userRole = type;
    switch (type) {
      case 'School Admin':
        userRole = 'School Admin';
        break;
      case 'School IT Admin':
        userRole = 'School Admin';
        break;
      case 'Staff':
        userRole = 'Teacher';
        break;
      case 'Head Teacher':
        userRole = 'Principal';
        break;
      case 'Principal':
        userRole = 'Principal';
        break;
    }
    ;
    return userRole;
  }

  lunchExternalApp(String package) async {
    // await LaunchApp.openApp(
    //               androidPackageName: package,
    //               iosUrlScheme: 'http://kidzee.com',
    //               appStoreLink: 'https://apps.apple.com/in/app/kidzeeapp/id1338356944',
    //               openStore: false
    //             );
    try {
      ///checks if the app is installed on your mobile device
      print(package);
      bool isInstalled = await DeviceApps.isAppInstalled(package);
      if (isInstalled) {
        print('app found ${package}');
      } else {
        print('app not found ${package}');
        final url = Uri.parse(
          Platform.isAndroid
              ? "https://play.google.com/store/apps/details?id=${package}&hl=en_IN"
              : "https://apps.apple.com/app/id$package",
        );

        ///if the app is not installed it lunches google play store so you can install it from there
        launchUrl(url, mode: LaunchMode.externalApplication);
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

  openFradomApp(String url) async {
    // Check if Spotify is installed
    if (await canLaunchUrl(Uri.parse(url))) {
      // Launch the url which will open Spotify
      launchUrl(Uri.parse(url));
    }
  }

  @override
  void onSuccess(value) {
    Navigator.of(context).pop();
    if (value is FradomLinkResponse) {
      FradomLinkResponse response = value;
      if (response != null &&
          response.result != null &&
          response.result!.data != null) {
        openFradomApp(response.result!.data!);
      }
    }
  }
}
