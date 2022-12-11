class Trips {
 late List<Trip> info;
 late Paginate paginate;

  Trips({required this.info,required this.paginate});

  Trips.fromJson(Map<String, dynamic> json) {
    if (json['info'] != null) {
      info = <Trip>[];
      json['info'].forEach((v) {
        info.add(new Trip.fromJson(v));
      });
    }
    paginate = json['paginate'] != null
        ? new Paginate.fromJson(json['paginate'])
        : Paginate(currentPage: 0, totalPage: 0);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
      data['info'] = this.info.map((v) => v.toJson()).toList();
      data['paginate'] = this.paginate.toJson();
    return data;
  }
}

class Trip {
  int? id;
  String? name;
  String? description;
  bool? riskAssessment;
  String? destination;
  String? dateTrip;
  String? phone;
  String? orgUnit;

  Trip(
      {this.id,
      this.name,
      this.phone,
      this.orgUnit,
      this.description,
      this.riskAssessment,
      this.destination,
      this.dateTrip});

  Trip.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    orgUnit= json['organizational_units'];
    description = json['description'];
    phone = json['phone_number'];
    riskAssessment = json['risk_assessment'];
    destination = json['destination'];
    dateTrip = json['date_trip'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['organizational_units'] = this.orgUnit;
    data['phone_number'] = this.phone;
    data['description'] = this.description;
    data['risk_assessment'] = this.riskAssessment;
    data['destination'] = this.destination;
    data['date_trip'] = this.dateTrip;
    return data;
  }
}

class Paginate {
 late int currentPage;
 late int totalPage;

  Paginate({required this.currentPage,required this.totalPage});

  Paginate.fromJson(Map<String, dynamic> json) {
    currentPage = json['currentPage'];
    totalPage = json['totalPage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['currentPage'] = this.currentPage;
    data['totalPage'] = this.totalPage;
    return data;
  }
}