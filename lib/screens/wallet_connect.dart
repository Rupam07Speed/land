import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:land_registration/constant/app_color.dart';
import 'package:land_registration/constant/constraints.dart';
import 'package:land_registration/providers/MetamaskProvider.dart';
import 'package:land_registration/constant/loadingScreen.dart';
import 'package:land_registration/screens/registerUser.dart';
import 'package:provider/provider.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import '../providers/LandRegisterModel.dart';
import '../constant/utils.dart';

class CheckPrivateKey extends StatefulWidget {
  final String val;
  const CheckPrivateKey({Key? key, required this.val}) : super(key: key);

  @override
  _CheckPrivateKeyState createState() => _CheckPrivateKeyState();
}

class _CheckPrivateKeyState extends State<CheckPrivateKey> {
  String privatekey = "";
  String errorMessage = "";
  bool isDesktop = false;
  double width = 590;
  bool _isObscure = true;
  bool isLoading = false;
  final _formKey = GlobalKey<FormState>();
  TextEditingController keyController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    var model = Provider.of<LandRegisterModel>(context);
    var model2 = Provider.of<MetaMaskProvider>(context);

    // if (width > 600) {
    //   isDesktop = true;
    //   width = 590;
    // }
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          //width: 500,
          alignment: Alignment.topCenter,
          child: Stack(
            children: [
              Image.asset(
                formBackground,
                height: h,
                width: w,
                fit: BoxFit.fill,
              ),
              // Image.asset(
              //   'assets/authenticate.png',
              //   height: 280,
              //   width: 520,
              // ),
              Positioned(
                left: 0,
                right: 0,
                top: 0,
                bottom: 0,
                child: Center(
                  child: Container(
                    height: h * 0.65,
                    width: w * 0.5,
                    padding:
                        EdgeInsets.symmetric(horizontal: w / 20, vertical: 30),
                    decoration: BoxDecoration(
                        color: AppColors.whiteColor,
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: [
                          BoxShadow(
                              color: AppColors.greyColor,
                              offset: Offset(2, 2),
                              blurRadius: 10),
                          BoxShadow(
                              color: AppColors.greyColor,
                              offset: Offset(-2, -2),
                              blurRadius: 10)
                        ]),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const Text(
                            'You can enter private key of your wallet Or you connect Metamask wallet'),
                        SizedBox(height: h * 0.05),
                        Form(
                          key: _formKey,
                          child: TextFormField(
                            controller: keyController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter private key';
                              }
                              return null;
                            },
                            obscureText: _isObscure,
                            onChanged: (val) {
                              privatekey = val;
                            },
                            decoration: InputDecoration(
                              suffixIcon: MaterialButton(
                                padding: const EdgeInsets.all(0),
                                onPressed: () async {
                                  final clipPaste = await Clipboard.getData(
                                      Clipboard.kTextPlain);
                                  keyController.text = clipPaste!.text!;
                                  privatekey = keyController.text;
                                  setState(() {});
                                },
                                child: const Text(
                                  "Paste",
                                  style: TextStyle(color: Colors.deepOrange),
                                ),
                              ),
                              suffix: IconButton(
                                  iconSize: 20,
                                  constraints: const BoxConstraints.tightFor(
                                      height: 15, width: 15),
                                  padding: const EdgeInsets.all(0),
                                  icon: Icon(
                                    _isObscure
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _isObscure = !_isObscure;
                                    });
                                  }),
                              // border: const OutlineInputBorder(),
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: AppColors.primaryColor),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: AppColors.primaryColor),
                              ),
                              labelText: 'Private Key',
                              hintText: 'Enter Your PrivateKey',
                              labelStyle: TextStyle(
                                color: AppColors.blackColor,
                              ),
                            ),
                            style: TextStyle(
                              color: AppColors.blackColor,
                            ),
                            cursorColor: AppColors.blackColor,
                          ),
                        ),
                        Text(
                          errorMessage,
                          style: const TextStyle(color: Colors.red),
                        ),
                        CustomButton(
                            'Continue',
                            isLoading
                                ? null
                                : () async {
                                    if (_formKey.currentState!.validate()) {
                                      privateKey = privatekey;
                                      print(privateKey);
                                      connectedWithMetamask = false;
                                      setState(() {
                                        isLoading = true;
                                      });
                                      try {
                                        await model.initiateSetup();

                                        if (widget.val == "owner") {
                                          bool temp = await model
                                              .isContractOwner(privatekey);
                                          if (temp == false) {
                                            setState(() {
                                              errorMessage =
                                                  "You are not authrosied";
                                            });
                                          } else {
                                            Navigator.pop(context);
                                            Navigator.pop(context);
                                            // Navigator.push(
                                            //     context,
                                            //     MaterialPageRoute(
                                            //         builder: (context) =>
                                            //             const AddLandInspector()));
                                            Navigator.of(context).pushNamed(
                                              '/contractowner',
                                            );
                                          }
                                        } else if (widget.val ==
                                            "RegisterUser") {
                                          bool temp =
                                              await model.isUserregistered();
                                          if (temp) {
                                            setState(() {
                                              errorMessage =
                                                  "You already registered";
                                            });
                                          } else {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        const RegisterUser()));
                                          }
                                        } else if (widget.val ==
                                            "LandInspector") {
                                          bool temp = await model
                                              .isLandInspector(privatekey);
                                          if (temp == false) {
                                            setState(() {
                                              errorMessage =
                                                  "You are not authrosied";
                                            });
                                          } else {
                                            Navigator.pop(context);
                                            Navigator.pop(context);
                                            // Navigator.push(
                                            //     context,
                                            //     MaterialPageRoute(
                                            //         builder: (context) =>
                                            //             const LandInspector()));
                                            Navigator.of(context).pushNamed(
                                              '/landinspector',
                                            );
                                          }
                                        } else if (widget.val == "UserLogin") {
                                          bool temp =
                                              await model.isUserregistered();
                                          if (temp == false) {
                                            Navigator.pop(context);
                                            Navigator.pop(context);
                                            // Navigator.push(
                                            //     context,
                                            //     MaterialPageRoute(
                                            //         builder: (context) =>
                                            //             const RegisterUser()));
                                            Navigator.of(context).pushNamed(
                                              '/registeruser',
                                            );
                                          } else {
                                            Navigator.pop(context);
                                            Navigator.pop(context);
                                            // Navigator.push(
                                            //     context,
                                            //     MaterialPageRoute(
                                            //         builder: (context) =>
                                            //             const UserDashBoard()));
                                            Navigator.of(context).pushNamed(
                                              '/user',
                                            );
                                          }
                                        }
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
                        const Text('Or Click to connect Metamask'),
                        ElevatedButton.icon(
                          onPressed: () async {
                            await model2.connect();
                            if (model2.isConnected &&
                                model2.isInOperatingChain) {
                              showToast("Connected",
                                  context: context,
                                  backgroundColor: Colors.green);

                              if (widget.val == "owner") {
                                bool temp = await model2.isContractOwner();
                                if (temp == false) {
                                  setState(() {
                                    errorMessage = "You are not authrosied";
                                  });
                                } else {
                                  Navigator.pop(context);
                                  Navigator.pop(context);
                                  // Navigator.push(
                                  //     context,
                                  //     MaterialPageRoute(
                                  //         builder: (context) => const AddLandInspector()));
                                  Navigator.of(context).pushNamed(
                                    '/contractowner',
                                  );
                                }
                              } else if (widget.val == "UserLogin") {
                                bool temp = await model2.isUserRegistered();
                                if (temp == false) {
                                  Navigator.pop(context);
                                  Navigator.pop(context);
                                  // Navigator.push(
                                  //     context,
                                  //     MaterialPageRoute(
                                  //         builder: (context) => const RegisterUser()));
                                  Navigator.of(context).pushNamed(
                                    '/registeruser',
                                  );
                                } else {
                                  Navigator.pop(context);
                                  Navigator.pop(context);
                                  // Navigator.push(
                                  //     context,
                                  //     MaterialPageRoute(
                                  //         builder: (context) => const UserDashBoard()));
                                  Navigator.of(context).pushNamed(
                                    '/user',
                                  );
                                }
                              } else if (widget.val == "LandInspector") {
                                bool temp = await model2.isLandInspector();
                                if (temp == false) {
                                  setState(() {
                                    errorMessage = "You are not authrosied";
                                  });
                                } else {
                                  Navigator.pop(context);
                                  Navigator.pop(context);

                                  Navigator.of(context).pushNamed(
                                    '/landinspector',
                                  );
                                }
                              }
                              connectedWithMetamask = true;
                            } else if (model2.isConnected &&
                                !model2.isInOperatingChain) {
                              showToast(
                                  "Wrong Netword connected,\nConnect Polygon Testnet",
                                  context: context,
                                  backgroundColor: Colors.red);
                            }
                          },
                          icon: Image.asset(
                            metamasklogo,
                            height: 40,
                            width: 40,
                            fit: BoxFit.fill,
                          ),
                          label: Text("Connect with MetaMask"),
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.deepOrange,
                              minimumSize: Size(100, 50)),
                        ),
                        if (isLoading) spinkitLoader
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
