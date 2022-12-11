import 'package:flutter/material.dart';
import 'package:fpt_mobileapp/model/Trip.dart';
import 'package:fpt_mobileapp/TripField/bloc/trip_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import './TripScreen.dart';

class TripDetails extends StatelessWidget {
  final Trip trip;
  const TripDetails({Key? key, required this.trip}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          title: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Row(children: [
              Container(
                height: 25,
                child: Image(
                  image: AssetImage("assets/back.png"),
                ),
              ),
            ]),
          ),
        ),
        body: BlocBuilder<TripBloc, TripState>(builder: (context, state) {
          return SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  child: Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Row(
                      children: [
                        Text(""),
                        Spacer(),
                        InkWell(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (ctx) => AlertDialog(
                                content: const Text(
                                    "Are you sure you want to delete this field trip?"),
                                actions: <Widget>[
                                  Row(
                                    children: [
                                      Spacer(),
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(ctx).pop();
                                        },
                                        child: Container(
                                          color: Colors.white,
                                          padding: const EdgeInsets.all(14),
                                          child: const Text("Cancel"),
                                        ),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          context
                                              .read<TripBloc>()
                                              .add(DeleteTrip(trip: trip));
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    HomeTripWidget()),
                                          );
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            const SnackBar(
                                              content:
                                                  Text('Deleted Successfully'),
                                              backgroundColor: Color.fromARGB(
                                                  255, 29, 88, 60),
                                              duration: Duration(seconds: 5),
                                            ),
                                          );
                                        },
                                        child: Container(
                                          color: Colors.white,
                                          padding: const EdgeInsets.all(14),
                                          child: const Text("Delete"),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            );
                          },
                          child: Column(
                            children: [
                              Container(
                                height: 40,
                                child: Image(
                                  image: AssetImage("assets/delete.png"),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 5.0),
                                child: Text(
                                  'Delete',
                                  style: TextStyle(
                                      color: Color(0xFF1a237e),
                                      fontWeight: FontWeight.bold),
                                ),
                              )
                            ],
                          ),
                        ),
                        Spacer(),
                        Text("")
                      ],
                    ),
                  ),
                ),
                Container(
                    width: MediaQuery.of(context).size.width,
                    padding:
                        const EdgeInsets.only(top: 12.0, bottom: 12, left: 17),
                    decoration: BoxDecoration(
                      color: Color(0xFFf5f5f5),
                      border: Border.all(
                        color: Color(
                            0xFFe0e0e0), //                   <--- border color
                        width: 1.0,
                      ),
                    ), //       <--- BoxDecoration here
                    child: Row(
                      children: [
                        Container(
                          height: 55,
                          child: Image(
                            image: AssetImage("assets/trip.png"),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 15.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Field Trip',
                                  style: TextStyle(
                                      color: Color(0xFF1a237e),
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold)),
                              Container(
                                  margin: const EdgeInsets.only(top: 3.0),
                                  child: Text(trip.name.toString(),
                                      style: TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold,
                                      )))
                            ],
                          ),
                        )
                      ],
                    )),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Trip Information',
                        style: TextStyle(
                            color: Color(0xFF1a237e),
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 17.0, left: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Field Trip Name',
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w500),
                          ),
                          Container(
                              child: Padding(
                            padding: const EdgeInsets.only(top: 6.0),
                            child: Text(
                                trip.name == null ? "" : trip.name.toString(),
                                style: TextStyle(
                                    color: Color(0xFF29b6f6),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500)),
                          )),
                          const Divider(
                            color: Color(0xFFe0e0e0),
                            height: 20,
                            thickness: 1,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 5, left: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Destination ',
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w500),
                          ),
                          Container(
                              child: Padding(
                            padding: const EdgeInsets.only(top: 6.0),
                            child: Text(
                                trip.destination == null
                                    ? ""
                                    : trip.destination.toString(),
                                style: TextStyle(fontSize: 14)),
                          )),
                          const Divider(
                            color: Color(0xFFe0e0e0),
                            height: 20,
                            thickness: 1,
                          ),
                        ],
                      ),
                    ),
                     Padding(
                      padding: const EdgeInsets.only(top: 5, left: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Phone Number ',
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w500),
                          ),
                          Container(
                              child: Padding(
                            padding: const EdgeInsets.only(top: 6.0),
                            child: Text(
                                trip.phone == null
                                    ? ""
                                    : trip.phone.toString(),
                                style: TextStyle(fontSize: 14)),
                          )),
                          const Divider(
                            color: Color(0xFFe0e0e0),
                            height: 20,
                            thickness: 1,
                          ),
                        ],
                      ),
                    ),
                     Padding(
                      padding: const EdgeInsets.only(top: 5, left: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Organizational Unit ',
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w500),
                          ),
                          Container(
                              child: Padding(
                            padding: const EdgeInsets.only(top: 6.0),
                            child: Text(
                                trip.orgUnit == null
                                    ? ""
                                    : trip.orgUnit.toString(),
                                style: TextStyle(fontSize: 14)),
                          )),
                          const Divider(
                            color: Color(0xFFe0e0e0),
                            height: 20,
                            thickness: 1,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 5, left: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Date Trip ',
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w500),
                          ),
                          Container(
                              child: Padding(
                            padding: const EdgeInsets.only(top: 6.0),
                            child: Text(
                                trip.dateTrip == null
                                    ? ""
                                    : trip.dateTrip.toString(),
                                style: TextStyle(fontSize: 14)),
                          )),
                          const Divider(
                            color: Color(0xFFe0e0e0),
                            height: 20,
                            thickness: 1,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                'Risk Assesment ',
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.w500),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 7.0),
                                child: Checkbox(
                                    value: trip.riskAssessment ?? false,
                                    onChanged: (value) {}),
                              ),
                            ],
                          ),
                          const Divider(
                            color: Color(0xFFe0e0e0),
                            height: 20,
                            thickness: 1,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 5, left: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Description ',
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w500),
                          ),
                          Container(
                              child: Padding(
                            padding: const EdgeInsets.only(top: 6.0),
                            child: Text(
                                trip.description == null
                                    ? ""
                                    : trip.description.toString(),
                                style: TextStyle(fontSize: 14)),
                          )),
                          const Divider(
                            color: Color(0xFFe0e0e0),
                            height: 20,
                            thickness: 1,
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
          );
        }));
  }
}
