import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpt_mobileapp/TripField/bloc/trip_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import './AddNewTrip.dart';
import './TripDetails.dart';

class HomeTripWidget extends StatefulWidget {
  const HomeTripWidget({Key? key}) : super(key: key);
  @override
  State<HomeTripWidget> createState() => _HomeTripWidget();
}

class _HomeTripWidget extends State<HomeTripWidget> {
  final _ControllerSmartRefresher = RefreshController(initialRefresh: false);
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              '',
            ),
            Spacer(),
            Text("FPT's Field Trip",
                style: TextStyle(color: Color.fromARGB(255, 206, 59, 59))),
            Spacer(),
            Text('')
          ],
        ),
      ),
      body: Center(
          child: Column(
        children: [
          Container(
              width: width,
              padding: const EdgeInsets.only(top: 12.0, bottom: 12, left: 17),
              decoration: BoxDecoration(
                color: Color(0xFFf5f5f5),
                border: Border.all(
                  color:
                      Color(0xFFe0e0e0), //                   <--- border color
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
                  Spacer(),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => AddTrip()),
                      );
                    },
                    child: Column(
                      children: [
                        Container(
                          height: 25,
                          child: Image(
                            image: AssetImage("assets/new.png"),
                          ),
                        ),
                        Container(
                            margin: const EdgeInsets.only(top: 3.0),
                            child: const Text("Add New Trip",
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                )))
                      ],
                    ),
                  ),
                  Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Container(
                      height: 55,
                      child: Image(
                        image: AssetImage("assets/trip.png"),
                      ),
                    ),
                  ),
                ],
              )),
          BlocBuilder<TripBloc, TripState>(
            builder: (context, state) {
              if (state is TripLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (state is TripLoadSuccess) {
                return BlocListener<TripBloc, TripState>(
                  listener: ((context, state) {
                    if (state is TripAddSuccess) {
                      Navigator.pop(context);
                    }
                  }),
                  child: Expanded(
                    child: SmartRefresher(
                      enablePullDown: true,
                      enablePullUp: true,
                      onRefresh: () async {
                        context.read<TripBloc>().add(TripReloaded());
                        _ControllerSmartRefresher.refreshCompleted();
                      },
                      onLoading: () async {
                        context.read<TripBloc>().add(LoadedTrip());
                        _ControllerSmartRefresher.loadComplete();
                      },
                      controller: _ControllerSmartRefresher,
                      child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          keyboardDismissBehavior:
                              ScrollViewKeyboardDismissBehavior.onDrag,
                          itemCount: state.trip.info.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Column(
                              children: [
                                InkWell(
                                  onTap: (() {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                          builder: (context) => TripDetails(trip:state.trip.info[index])),
                                    );
                                  }),
                                  child: Card(
                                    elevation: 8.0,
                                    margin: new EdgeInsets.symmetric(
                                        horizontal: 10.0, vertical: 6.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color:
                                              Color.fromRGBO(64, 75, 96, .9)),
                                      child: ListTile(
                                          contentPadding: EdgeInsets.symmetric(
                                              horizontal: 20.0, vertical: 10.0),
                                          leading: Container(
                                            padding:
                                                EdgeInsets.only(right: 12.0),
                                            decoration: new BoxDecoration(
                                                border: new Border(
                                                    right: new BorderSide(
                                                        width: 1.0,
                                                        color:
                                                            Colors.white24))),
                                            child: Icon(Icons.autorenew,
                                                color: Colors.white),
                                          ),
                                          title: Text(
                                            state.trip.info[index].name
                                                .toString(),
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          // subtitle: Text("Intermediate", style: TextStyle(color: Colors.white)),

                                          subtitle: Row(
                                            children: <Widget>[
                                              Icon(Icons.linear_scale,
                                                  color: Colors.yellowAccent),
                                              Text(
                                                  " Destination: ${state.trip.info[index].destination}",
                                                  style: TextStyle(
                                                      color: Colors.white))
                                            ],
                                          ),
                                          trailing: Icon(
                                              Icons.keyboard_arrow_right,
                                              color: Colors.white,
                                              size: 30.0)),
                                    ),
                                  ),
                                )
                              ],
                            );
                          }),
                    ),
                  ),
                );
              }
              return Container();
            },
          ),
        ],
      )),
      bottomNavigationBar: Container(
        height: 55.0,
        child: BottomAppBar(
          color: Color.fromRGBO(58, 66, 86, 1.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.home, color: Colors.white),
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(Icons.blur_on, color: Colors.white),
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(Icons.hotel, color: Colors.white),
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(Icons.account_box, color: Colors.white),
                onPressed: () {},
              )
            ],
          ),
        ),
      ),
    );
  }
}
