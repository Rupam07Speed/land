import 'package:collapsible_sidebar/collapsible_sidebar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:land_registration/constant/constraints.dart';
import 'package:land_registration/providers/LandRegisterModel.dart';
import 'package:land_registration/widget/custom_text_form_field.dart';
import 'package:land_registration/widget/menu_item_tile.dart';
import 'package:provider/provider.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';

import '../constant/utils.dart';
import '../providers/MetamaskProvider.dart';

class AddLandInspector extends StatefulWidget {
  const AddLandInspector({Key? key}) : super(key: key);

  @override
  _AddLandInspectorState createState() => _AddLandInspectorState();
}

class _AddLandInspectorState extends State<AddLandInspector> {
  late String address, name, age, desig, city, newaddress;
  var model, model2;
  double width = 490;
  int screen = 0;
  bool isLoading = false;
  final _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  List<Menu> menuItems = [
    Menu(title: 'Add Land Inspector', icon: Icons.person_add),
    Menu(title: 'All Land Inspectors', icon: Icons.group),
    Menu(title: 'Change Contract Owner', icon: Icons.change_circle),
    Menu(title: 'Logout', icon: Icons.logout),
  ];
  late List<CollapsibleItem> _items;

  @override
  void initState() {
    super.initState();
    _items = _generateItems;
  }

  List<CollapsibleItem> get _generateItems {
    return [
      CollapsibleItem(
        text: menuItems[0].title,
        icon: menuItems[0].icon,
        onPressed: () => setState(() => screen = 0),
        isSelected: true,
      ),
      CollapsibleItem(
        text: menuItems[1].title,
        icon: menuItems[1].icon,
        onPressed: () {
          getLandInspectorInfo();
          setState(() => screen = 1);
        },
      ),
      CollapsibleItem(
        text: menuItems[2].title,
        icon: menuItems[2].icon,
        onPressed: () => setState(() => screen = 2),
      ),
      CollapsibleItem(
          text: 'Logout',
          icon: Icons.logout,
          onPressed: () {
            Navigator.pop(context);
            Navigator.of(context).pushNamed(
              '/',
            );
          }),
    ];
  }

  List<List<dynamic>> allLandInspectorInfo = [];

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    model = Provider.of<LandRegisterModel>(context);
    model2 = Provider.of<MetaMaskProvider>(context);
    return Scaffold(
      // backgroundColor: Colors.white,
      // key: _scaffoldKey,
      // appBar: AppBar(
      //   centerTitle: true,
      //   backgroundColor: const Color(0xFF272D34),
      //   leading: isDesktop
      //       ? Container()
      //       : GestureDetector(
      //           child: const Padding(
      //             padding: EdgeInsets.all(8.0),
      //             child: Icon(
      //               Icons.menu,
      //               color: Colors.white,
      //             ), //AnimatedIcon(icon: AnimatedIcons.menu_arrow,progress: _animationController,),
      //           ),
      //           onTap: () {
      //             _scaffoldKey.currentState!.openDrawer();
      //           },
      //         ),
      //   title: const Text(
      //     'Add Land Inspector',
      //   ),
      // ),
      // drawer: drawer2(),
      // drawerScrimColor: Colors.transparent,
      body: CollapsibleSidebar(
        key: _scaffoldKey,
        isCollapsed: false,
        items: _items,
        avatarImg: const AssetImage(avatar),
        title: 'Contract Owner',
        body: _body(size, context),
        backgroundColor: Colors.black,
        selectedTextColor: Colors.limeAccent,
        textStyle: const TextStyle(fontSize: 13),
        iconSize: 30,
        titleStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        toggleTitleStyle:
            const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        toggleButtonIcon: Icons.menu,
        toggleTitle: "Menu",
        sidebarBoxShadow: const [
          BoxShadow(
            color: Colors.indigo,
            blurRadius: 20,
            spreadRadius: 0.01,
            offset: Offset(3, 3),
          ),
          BoxShadow(
            color: Colors.green,
            blurRadius: 50,
            spreadRadius: 0.01,
            offset: Offset(3, 3),
          ),
        ],
      ),
    );
  }

  Widget _body(Size size, BuildContext context) {
    return Container(
      height: size.height,
      width: size.width,
      color: Colors.blueGrey[50],
      child: Row(
        children: [
          if (screen == 0)
            addLandInspector()
          else if (screen == 1)
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(25),
                child: landInspectorList(),
              ),
            )
          else if (screen == 2)
            changeContractOwner()
        ],
      ),
    );
  }

  //     body: Row(
  //       children: [
  //         isDesktop ? drawer2() : Container(),
  //         if (screen == 0)
  //           addLandInspector()
  //         else if (screen == 1)
  //           Expanded(
  //             child: Container(
  //               padding: const EdgeInsets.all(25),
  //               child: landInspectorList(),
  //             ),
  //           )
  //         else if (screen == 2)
  //           changeContractOwner()
  //       ],
  //     ),
  //   );
  // }

  getLandInspectorInfo() async {
    setState(() {
      isLoading = true;
      print(" isLoading $isLoading");
    });
    List<dynamic> landList;
    if (connectedWithMetamask) {
      landList = await model2.allLandInspectorList();
    } else {
      landList = await model.allLandInspectorList();
    }

    List<List<dynamic>> info = [];
    List<dynamic> temp;
    for (int i = 0; i < landList.length; i++) {
      if (connectedWithMetamask) {
        temp = await model2.landInspectorInfo(landList[i]);
      } else {
        temp = await model.landInspectorInfo(landList[i]);
      }
      info.add(temp);
    }
    allLandInspectorInfo = info;
    setState(() {
      isLoading = false;
      print(" isLoading $isLoading");
    });
    print(info);
  }

  Widget landInspectorList() {
    if (isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    return ListView.builder(
      padding: EdgeInsets.only(left: MediaQuery.sizeOf(context).width * 0.2),
      itemCount:
          allLandInspectorInfo == null ? 1 : allLandInspectorInfo.length + 1,
      itemBuilder: (BuildContext context, int index) {
        if (index == 0) {
          return const Column(
            children: [
              Divider(
                height: 15,
              ),
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Text(
                      '#',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Expanded(
                      flex: 5,
                      child: Center(
                        child: Text(
                          'LandInspector\'s Address',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      )),
                  Expanded(
                    flex: 3,
                    child: Center(
                      child: Text('Name',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Center(
                      child: Text('City',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Center(
                      child: Text('Remove',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                  )
                ],
              ),
              Divider(
                height: 15,
              )
            ],
          );
        }
        index -= 1;
        List<dynamic> data = allLandInspectorInfo[index];
        return ListTile(
          title: Row(
            children: [
              Expanded(
                flex: 1,
                child: Text((index + 1).toString()),
              ),
              Expanded(
                  flex: 5,
                  child: Center(
                    child: Text(
                      data[1].toString(),
                      // overflow: TextOverflow.ellipsis,
                    ),
                  )),
              Expanded(
                  flex: 3,
                  child: Center(
                    child: Text(data[2].toString()),
                  )),
              Expanded(
                  flex: 2,
                  child: Center(
                    child: Text(data[5].toString()),
                  )),
              Expanded(
                  flex: 2,
                  child: Center(
                    // child: ElevatedButton(
                    //     style: ElevatedButton.styleFrom(
                    //         backgroundColor: Colors.red),
                    //     onPressed: () async {
                    //       confirmDialog('Are you sure to remove?', context,
                    //           () async {
                    //         SmartDialog.showLoading();
                    //         if (connectedWithMetamask) {
                    //           await model2.removeLandInspector(data[1]);
                    //         } else {
                    //           await model.removeLandInspector(data[1]);
                    //         }
                    //         Navigator.pop(context);
                    //         await getLandInspectorInfo();
                    //         SmartDialog.dismiss();
                    //       });
                    //     },
                    //     child: const Text('Remove')),
                    //remove section
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red),
                        onPressed: () async {
                          confirmDialog('Are you sure to remove?', context,
                              () async {
                            SmartDialog.showLoading();
                            if (connectedWithMetamask) {
                              await model2.removeLandInspector(data[1]);
                            } else {
                              await model.removeLandInspector(data[1]);
                            }
                            Navigator.pop(context);
                            await getLandInspectorInfo();
                            SmartDialog.dismiss();
                          });
                        },
                        child: const Text('Remove')),
                  )),
            ],
          ),
        );
      },
    );
  }

  Widget changeContractOwner() {
    return Container(
      width: MediaQuery.of(context).size.width - 90,
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: <Widget>[
            const Text(
              "Change Contract Owner",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
            ),
            const SizedBox(
              height: 10,
            ),
            // Padding(
            //   padding: const EdgeInsets.all(15),
            //   child: TextFormField(
            //     validator: (value) {
            //       if (value == null || value.isEmpty) {
            //         return 'Please enter some text';
            //       }
            //       return null;
            //     },
            //     onChanged: (val) {
            //       newaddress = val;
            //     },
            //     decoration: const InputDecoration(
            //       border: OutlineInputBorder(),
            //       labelText: 'Address',
            //       hintText: 'Enter new Contract Owner Address',
            //     ),
            //   ),
            // ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.5 - 90,
              child: CustomTextfomField(
                isUnderline: false,
                labeltxt: 'Address',
                hinttxt: 'Enter new Contract Owner Address',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
                onchanged: (val) {
                  newaddress = val;
                },
              ),
            ),
            CustomButton(
                'Change',
                isLoading
                    ? null
                    : () async {
                        setState(() {
                          isLoading = true;
                        });
                        try {
                          if (connectedWithMetamask) {
                            await model2.changeContractOwner(newaddress);
                          } else {
                            await model.changeContractOwner(newaddress);
                          }
                          showToast("Successfully Changed",
                              context: context, backgroundColor: Colors.green);
                        } catch (e) {
                          print(e);
                          showToast("Something Went Wrong",
                              context: context, backgroundColor: Colors.red);
                        }
                        setState(() {
                          isLoading = false;
                        });
                      }),
            isLoading ? const CircularProgressIndicator() : Container()
          ],
        ),
      ),
    );
  }

  Widget addLandInspector() {
    return Container(
      width: MediaQuery.of(context).size.width - 90,
      padding: EdgeInsets.all(15),
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              // Padding(
              //   padding: const EdgeInsets.all(15),
              //   child: TextFormField(
              //     validator: (value) {
              //       if (value == null || value.isEmpty) {
              //         return 'Please enter some text';
              //       }
              //       return null;
              //     },
              //     onChanged: (val) {
              //       address = val;
              //     },
              //     decoration: const InputDecoration(
              //       border: OutlineInputBorder(),
              //       labelText: 'Address',
              //       hintText:
              //           'Enter Land Inspector Address(0xc5aEabE793B923981fc401bb8da620FDAa45ea2B)',
              //     ),
              //   ),
              // ),
              // Padding(
              //   padding: const EdgeInsets.all(15),
              //   child: TextFormField(
              //     validator: (value) {
              //       if (value == null || value.isEmpty) {
              //         return 'Please enter some text';
              //       }
              //       return null;
              //     },
              //     onChanged: (val) {
              //       name = val;
              //     },
              //     //obscureText: true,
              //     decoration: const InputDecoration(
              //       border: OutlineInputBorder(),
              //       labelText: 'Name',
              //       hintText: 'Enter Name',
              //     ),
              //   ),
              // ),
              // Padding(
              //   padding: const EdgeInsets.all(15),
              //   child: TextFormField(
              //     validator: (value) {
              //       if (value == null || value.isEmpty) {
              //         return 'Please enter some text';
              //       }
              //       return null;
              //     },
              //     onChanged: (val) {
              //       age = val;
              //     },
              //     //obscureText: true,
              //     decoration: const InputDecoration(
              //       border: OutlineInputBorder(),
              //       labelText: 'Age',
              //       hintText: 'Enter Age',
              //     ),
              //   ),
              // ),
              // Padding(
              //   padding: const EdgeInsets.all(15),
              //   child: TextFormField(
              //     validator: (value) {
              //       if (value == null || value.isEmpty) {
              //         return 'Please enter some text';
              //       }
              //       return null;
              //     },
              //     onChanged: (val) {
              //       desig = val;
              //     },
              //     //obscureText: true,
              //     decoration: const InputDecoration(
              //       border: OutlineInputBorder(),
              //       labelText: 'Designation',
              //       hintText: 'Enter Designation',
              //     ),
              //   ),
              // ),
              // Padding(
              //   padding: const EdgeInsets.all(15),
              //   child: TextFormField(
              //     validator: (value) {
              //       if (value == null || value.isEmpty) {
              //         return 'Please enter some text';
              //       }
              //       return null;
              //     },
              //     onChanged: (val) {
              //       city = val;
              //     },
              //     //obscureText: true,
              //     decoration: const InputDecoration(
              //       border: OutlineInputBorder(),
              //       labelText: 'City',
              //       hintText: 'Enter City',
              //     ),
              //   ),
              // ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.5,
                child: CustomTextfomField(
                  isUnderline: false,
                  labeltxt: 'Address',
                  hinttxt:
                      'Enter Land Inspector Address(0xc5aEabE793B923981fc401bb8da620FDAa45ea2B)',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                  onchanged: (val) {
                    address = val;
                  },
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.5,
                child: CustomTextfomField(
                  isUnderline: false,
                  labeltxt: 'Name',
                  hinttxt: 'Enter Name',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                  onchanged: (val) {
                    name = val;
                  },
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.5,
                child: CustomTextfomField(
                  isUnderline: false,
                  labeltxt: 'Age',
                  hinttxt: 'Enter Age',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                  onchanged: (val) {
                    age = val;
                  },
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.5,
                child: CustomTextfomField(
                  isUnderline: false,
                  labeltxt: 'Designation',
                  hinttxt: 'Enter Designation',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                  onchanged: (val) {
                    desig = val;
                  },
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.5,
                child: CustomTextfomField(
                  isUnderline: false,
                  labeltxt: 'City',
                  hinttxt: 'Enter City',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                  onchanged: (val) {
                    city = val;
                  },
                ),
              ),
              CustomButton(
                  'Add',
                  isLoading
                      ? null
                      : () async {
                          if (_formKey.currentState!.validate()) {
                            setState(() {
                              isLoading = true;
                            });
                            try {
                              if (connectedWithMetamask) {
                                await model2.addLandInspector(
                                    address, name, age, desig, city);
                              } else {
                                await model.addLandInspector(
                                    address, name, age, desig, city);
                              }
                              showToast("Successfully Added",
                                  context: context,
                                  backgroundColor: Colors.green);
                            } catch (e) {
                              print(e);
                              showToast("Something Went Wrong",
                                  context: context,
                                  backgroundColor: Colors.red);
                            }
                            setState(() {
                              isLoading = false;
                            });
                          }
                        }),
              if (isLoading) const CircularProgressIndicator()
            ],
          ),
        ),
      ),
    );
  }

  // Widget drawer2() {
  //   return Container(
  //     decoration: const BoxDecoration(
  //       boxShadow: [
  //         BoxShadow(blurRadius: 10, color: Colors.black26, spreadRadius: 2)
  //       ],
  //       color: Color(0xFF272D34),
  //     ),
  //     width: 260,
  //     child: Column(
  //       mainAxisAlignment: MainAxisAlignment.center,
  //       crossAxisAlignment: CrossAxisAlignment.center,
  //       children: <Widget>[
  //         const SizedBox(
  //           width: 20,
  //         ),
  //         const Icon(
  //           Icons.person,
  //           size: 50,
  //         ),
  //         const SizedBox(
  //           width: 30,
  //         ),
  //         const Text('Contract Owner',
  //             style: TextStyle(
  //                 color: Colors.white70,
  //                 fontSize: 18,
  //                 fontWeight: FontWeight.bold)),
  //         const SizedBox(
  //           height: 80,
  //         ),
  //         Expanded(
  //           child: ListView.separated(
  //             separatorBuilder: (context, counter) {
  //               return const Divider(
  //                 height: 2,
  //               );
  //             },
  //             itemCount: menuItems.length,
  //             itemBuilder: (BuildContext context, int index) {
  //               return MenuItemTile(
  //                 title: menuItems[index].title,
  //                 icon: menuItems[index].icon,
  //                 isSelected: screen == index,
  //                 onTap: () {
  //                   if (index == 3) {
  //                     Navigator.pop(context);
  //                     // Navigator.push(context,
  //                     //     MaterialPageRoute(builder: (context) => home_page()));
  //                     Navigator.of(context).pushNamed(
  //                       '/',
  //                     );
  //                   }
  //                   if (index == 1) getLandInspectorInfo();

  //                   setState(() {
  //                     screen = index;
  //                   });
  //                 },
  //               );
  //             },
  //           ),
  //         ),
  //         const SizedBox(
  //           height: 20,
  //         )
  //       ],
  //     ),
  //   );
  // }
}
