import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpt_mobileapp/TripField/bloc/trip_bloc.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:fpt_mobileapp/model/Trip.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';

class AddTrip extends StatefulWidget {
  const AddTrip({Key? key}) : super(key: key);

  State<AddTrip> createState() => _AddTrip();
}

class _AddTrip extends State<AddTrip> {
  final _userEditTextController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _trip = new Trip();
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Text(
                  'Cancel',
                  style: TextStyle(color: Color(0xFF1a237e)),
                ),
              ),
              Spacer(),
              Text('New Trip',
                  style: TextStyle(color: Color.fromARGB(255, 206, 59, 59))),
              Spacer(),
              InkWell(
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      context.read<TripBloc>().add(AddedTrip(trip: _trip));
                    }
                  },
                  child:
                      Text('Save', style: TextStyle(color: Color(0xFF1a237e))))
            ],
          ),
        ),
        body: SingleChildScrollView(
            child: Column(
          children: [
            const Divider(
              color: Color(0xFF880e4f),
              height: 20,
              thickness: 6,
            ),
            Padding(
              padding: const EdgeInsets.all(13.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Field Trip Information',
                    style: TextStyle(
                        color: Color(0xFF1a237e),
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 12, left: 10),
                    child: Row(
                      children: [
                        Text(
                          "*",
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.red,
                          ),
                        ),
                        Text(
                          "Trip Name",
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 2.0),
                      child: TextFormField(
                        maxLength: 100,
                        validator: (val) {
                          if ((val ?? "").trim().isEmpty) {
                            return "Trip Name must be completed";
                          }
                        },
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 10.0),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFFb0bec5)),
                            borderRadius: BorderRadius.circular(0),
                          ),
                        ),
                        onChanged: (value) {
                          _trip.name = value;
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5, left: 10),
                    child: Row(
                      children: [
                        Text(
                          "*",
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.red,
                          ),
                        ),
                        Text(
                          "Destination",
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10, top: 5),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Color(0xFFb0bec5)),
                        borderRadius: BorderRadius.zero,
                      ),
                      child: DropdownSearch<String>(
                        onChanged: (value) {
                          _trip.destination = value;
                        },
                        items: [
                          "Ha Noi",
                          "Ho Chi Minh",
                          "Da Nang",
                          "Phu Quoc",
                          "Da Lat",
                          "Nha Trang",
                          "Quy Nhon",
                          "Thanh Hoa",
                        ],
                        validator: (val) {
                          if ((val ?? "").trim().isEmpty) {
                            return "Destination must be completed";
                          }
                        },
                        clearButtonProps: ClearButtonProps(isVisible: true),
                        popupProps: PopupPropsMultiSelection.modalBottomSheet(
                          showSelectedItems: true,
                          showSearchBox: true,
                          searchFieldProps: TextFieldProps(
                            controller: _userEditTextController,
                            decoration: InputDecoration(
                              suffixIcon: IconButton(
                                icon: Icon(Icons.clear),
                                onPressed: () {
                                  _userEditTextController.clear();
                                },
                              ),
                            ),
                          ),
                        ),
                        compareFn: (item, selectedItem) => item == selectedItem,
                        dropdownDecoratorProps: DropDownDecoratorProps(
                          dropdownSearchDecoration: InputDecoration(
                            border: InputBorder.none,
                          ),
                        ),
                        //dropdownBuilder: _customDropDownExampleMultiSelection,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5, left: 10),
                    child: Row(
                      children: [
                        Text(
                          "*",
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.red,
                          ),
                        ),
                        Text(
                          "Risk Assesment:",
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                          ),
                        ),
                        Checkbox(
                          checkColor: Colors.white,
                          value: _trip.riskAssessment ?? false,
                          onChanged: (bool? boolean) {
                            setState(() {
                              _trip.riskAssessment = boolean;
                            });
                          },
                        ),
                        Text(
                          "Yes",
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5, left: 10),
                    child: Row(
                      children: [
                        Text(
                          "*",
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.red,
                          ),
                        ),
                        Text(
                          "Date Of The Trip",
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Color(0xFFb0bec5)),
                      borderRadius: BorderRadius.zero,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: DateTimeField(
                        validator: (val) {
                          if (val == "" || val == null) {
                            return "Date must be completed";
                          }
                        },
                        initialValue: _trip.dateTrip != null
                            ? DateTime.parse(_trip.dateTrip ?? "2000-01-01")
                            : null,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                        ),
                        format: DateFormat("yyyy-MM-dd"),
                        onChanged: (value) {
                          _trip.dateTrip = value != null
                              ? DateFormat("yyyy-MM-dd").format(value)
                              : null;
                        },
                        onShowPicker: (context, currentValue) {
                          return showDatePicker(
                              context: context,
                              firstDate: DateTime(1900),
                              initialDate: currentValue ?? DateTime.now(),
                              lastDate: DateTime(2100));
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 12, left: 10),
                    child: Text(
                      "Phone Number",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 2.0),
                      child: TextFormField(
                        maxLength: 11,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 10.0),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFFb0bec5)),
                            borderRadius: BorderRadius.circular(0),
                          ),
                        ),
                        onChanged: (value) {
                          _trip.phone = value;
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 12, left: 10),
                    child: Text(
                      "Organizational Unit",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 2.0),
                      child: TextFormField(
                        maxLength: 100,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 10.0),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFFb0bec5)),
                            borderRadius: BorderRadius.circular(0),
                          ),
                        ),
                        onChanged: (value) {
                          _trip.orgUnit = value;
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 12, left: 10),
                    child: Text(
                      "Description",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Color(0xFFb0bec5)),
                      borderRadius: BorderRadius.zero,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: TextFormField(
                        maxLines: 3,
                        initialValue: _trip.description == null
                            ? ''
                            : _trip.description.toString(),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                        ),
                        onChanged: (value) {
                          _trip.description = value;
                        },
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        )),
      ),
    );
  }
}
