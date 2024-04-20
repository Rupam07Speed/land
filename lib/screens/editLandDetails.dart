import 'package:flutter/material.dart';
import 'package:land_registration/constant/constants.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import '../constant/utils.dart';
import 'package:provider/provider.dart';
import '../providers/MetamaskProvider.dart';

import 'package:land_registration/constant/constraints.dart';
import 'package:land_registration/providers/LandRegisterModel.dart';

class EditLandDetails extends StatefulWidget {
  final String allLatitude;
  final String allLongitude;
  final LandInfo landinfo;
  const EditLandDetails({
    Key? key,
    required this.allLatitude,
    required this.allLongitude,
    required this.landinfo,
  }) : super(key: key);

  @override
  _EditLandDetailsState createState() => _EditLandDetailsState();
}

class _EditLandDetailsState extends State<EditLandDetails> {
  late MapboxMapController mapController;
  late TextEditingController priceController; // Controller to edit price

  bool isSatelliteView = true;

  @override
  void initState() {
    super.initState();
    priceController = TextEditingController(text: widget.landinfo.landPrice);
  }

  @override
  void dispose() {
    priceController.dispose();
    super.dispose();
  }

  void updateLandDetails() async {
    // Assuming you have landId stored in a variable landId
    // First, update the widget's state.
    setState(() {
      widget.landinfo.landPrice = priceController.text;
    });

    // Then update the price in the smart contract.
    try {
      await Provider.of<MetaMaskProvider>(context, listen: false).updateLand(
        landId: int.parse(
            widget.landinfo.propertyPID), // Assuming propertyPID is the landId
        area: int.parse(widget.landinfo.area),
        address: widget.landinfo.landAddress,
        newPrice: int.parse(priceController.text),
        allLatiLongi: "${widget.allLatitude},${widget.allLongitude}",
        propertyPID: int.parse(widget.landinfo.propertyPID),
        surveyNum: widget.landinfo.physicalSurveyNumber,
        document: widget.landinfo.document,
      );

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Land details updated successfully!'),
      ));
    } catch (error) {
      print(error); // This will give more details on what's wrong.
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Failed to update land details. Please try again.'),
      ));
    }
  }

  TableRow _buildPriceRow() {
    return TableRow(children: [
      const Text(
        "Price : ",
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
      ),
      Row(
        children: [
          Expanded(
            child: TextField(
              controller: priceController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                hintText: 'Enter Price',
              ),
            ),
          ),
          const SizedBox(width: 10),
          ElevatedButton(
            onPressed: updateLandDetails,
            child: const Text('Update'),
          ),
        ],
      ),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF272D34),
        title: const Text('Edit Land Details'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 10),
              Container(
                height: 500,
                width: 700,
                child: MapboxMap(
                    accessToken: mapBoxApiKey,
                    styleString:
                        "mapbox://styles/saurabhmw/cky4ce7f61b2414nuh9ng177k",
                    initialCameraPosition: CameraPosition(
                      zoom: 3.0,
                      target: const LatLng(19.663280, 75.300293),
                    ),
                    compassEnabled: false,
                    onMapCreated: (MapboxMapController controller) async {
                      List<double> lati = widget.allLatitude
                          .split(',')
                          .map((a) => double.parse(a))
                          .toList();

                      List<double> longi = widget.allLongitude
                          .split(',')
                          .map((a) => double.parse(a))
                          .toList();
                      mapController = controller;

                      await Future.delayed(const Duration(seconds: 3));
                      mapController.animateCamera(
                          CameraUpdate.newCameraPosition(CameraPosition(
                        zoom: 15.0,
                        target: LatLng(lati[1], longi[0]),
                      )));
                      for (int i = 0; i < lati.length; i++) {
                        mapController.addCircle(CircleOptions(
                            geometry: LatLng(lati[i], longi[i]),
                            circleRadius: 5,
                            circleColor: "#ff0000",
                            draggable: true));
                      }
                      // mapController.addCircles(List.generate(
                      //     lati.length,
                      //     (index) => CircleOptions(
                      //         geometry: LatLng(lati[index], longi[index]),
                      //         circleRadius: 5,
                      //         circleColor: "#ff0000",
                      //         draggable: false)));
                      //
                      mapController.addFill(
                        FillOptions(
                          fillColor: "#2596be",
                          fillOutlineColor: "#2596be",
                          geometry: [
                            List.generate(lati.length,
                                (index) => LatLng(lati[index], longi[index]))
                          ],
                        ),
                      );
                    }),
              ),
              const SizedBox(height: 10),
              const Center(
                  child: Text('Details',
                      style:
                          TextStyle(fontSize: 35, color: Colors.blueAccent))),
              const SizedBox(height: 10),
              const SizedBox(width: 700, child: Divider()),
              const SizedBox(height: 10),
              Container(
                width: 700,
                child: Table(
                  columnWidths: const {
                    0: FractionColumnWidth(0.3),
                    1: FractionColumnWidth(0.7)
                  },
                  children: [
                    TableRow(children: [
                      const Text(
                        "Area : ",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      Text(widget.landinfo.area,
                          style: const TextStyle(fontSize: 20))
                    ]),
                    const TableRow(children: [
                      SizedBox(
                        height: 15,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                    ]),
                    TableRow(children: [
                      const Text(
                        "Owner Address : ",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      Text(widget.landinfo.ownerAddress,
                          style: const TextStyle(fontSize: 20))
                    ]),
                    const TableRow(children: [
                      SizedBox(
                        height: 15,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                    ]),
                    TableRow(children: [
                      const Text(
                        "Address : ",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      Text(widget.landinfo.landAddress,
                          style: const TextStyle(fontSize: 20))
                    ]),
                    const TableRow(children: [
                      SizedBox(
                        height: 15,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                    ]),
                    _buildPriceRow(),
                    const TableRow(children: [
                      SizedBox(
                        height: 15,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                    ]),
                    TableRow(children: [
                      const Text(
                        "Survey Number : ",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      Text(widget.landinfo.physicalSurveyNumber,
                          style: const TextStyle(fontSize: 20))
                    ]),
                    const TableRow(children: [
                      SizedBox(
                        height: 15,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                    ]),
                    TableRow(children: [
                      const Text(
                        "Property Id : ",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      Text(widget.landinfo.propertyPID,
                          style: const TextStyle(fontSize: 20))
                    ]),
                    const TableRow(children: [
                      SizedBox(
                        height: 15,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                    ]),
                    TableRow(children: [
                      const Text(
                        "Document : ",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      MaterialButton(
                        onPressed: () {
                          launchUrl(widget.landinfo.document);
                        },
                        child: const Text('View',
                            style: TextStyle(fontSize: 20, color: Colors.blue)),
                      )
                    ]),
                    const TableRow(children: [
                      SizedBox(
                        height: 15,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                    ])
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  // ... Rest of the rows ...
}
