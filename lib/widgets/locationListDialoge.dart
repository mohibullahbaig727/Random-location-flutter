import 'package:flutter/material.dart';

class locationListDialog extends StatelessWidget {
  final List<String> lat;
  final List<String> long;

  const locationListDialog({Key? key, required this.lat, required this.long})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    TextStyle font = new TextStyle(
        color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold);

    return Stack(
      children: [
        Dialog(
            backgroundColor: Colors.grey.withOpacity(0.7),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: SingleChildScrollView(
              child: Container(
                alignment: Alignment.center,
                padding: EdgeInsets.all(20),
                height: size.height * 0.6,
                child: Column(
                  children: [
                    Text(
                      'Current Location',
                      style: font,
                    ),
                    SizedBox(height: size.height*0.03),
                    Text(
                      'Latitude: ${lat.last}',
                      style: font,
                    ),
                    Text(
                      'Longitude: ${long.last}',
                      style: font,
                    ),
                    SizedBox(height: size.height*0.07),
                    Text(
                      'Previous',
                      style: font,
                    ),
                    Expanded(
                      child: Container(
                        alignment: Alignment.center,
                        child: ListView.builder(
                          itemCount: lat.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              title: Text(
                                'Lat: ${lat[index]} Lng:${long[index]}',
                                style: font,
                              ),
                            );
                          },
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )),
        Positioned(
            right: 20,
            top: size.height * 0.15,
            child: GestureDetector(
              child: Icon(
                Icons.cancel,
                size: 50,
              ),
              onTap: (){
                Navigator.pop(context);
              },
            )),
      ],
    );
  }
}
