import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:location/location.dart';
import 'package:siakad_indra/pages/mahasiswa/widgets/qrcode_page.dart';
import 'package:blinking_text/blinking_text.dart';
import '../../common/constants/colors.dart';
import '../../common/constants/icons.dart';
import '../../common/widgets/buttons.dart';
import '../../common/widgets/custom_scaffold.dart';
import '../../data/datasources/auth_local_datasources.dart';
import '../../data/models/response/auth_response_model.dart';

class AbsensiPage extends StatefulWidget {
  const AbsensiPage({super.key});

  @override
  State<AbsensiPage> createState() => _AbsensiPageState();
}

class _AbsensiPageState extends State<AbsensiPage> {
  final List<TimeOfDay> times = [
    const TimeOfDay(hour: 8, minute: 0),
    const TimeOfDay(hour: 9, minute: 15),
    const TimeOfDay(hour: 10, minute: 30),
    const TimeOfDay(hour: 11, minute: 45),
    const TimeOfDay(hour: 12, minute: 0),
    const TimeOfDay(hour: 13, minute: 30),
    const TimeOfDay(hour: 14, minute: 45),
    const TimeOfDay(hour: 15, minute: 0),
    const TimeOfDay(hour: 16, minute: 15),
    const TimeOfDay(hour: 17, minute: 30),
  ];
  late GoogleMapController mapController;
  double? latitude;
  double? longitude;
  Future<bool> _getPermission(Location location) async {
    late bool serviceEnabled;
    late PermissionStatus permissionGranted;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return false;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return false;
      }
    }
    return true;
  }

  Future<void> getCurrentPosition() async {
    try {
      Location location = Location();

      bool serviceEnabled;
      PermissionStatus permissionGranted;
      LocationData locationData;

      serviceEnabled = await location.serviceEnabled();
      if (!serviceEnabled) {
        serviceEnabled = await location.requestService();
        if (!serviceEnabled) {
          return;
        }
      }

      permissionGranted = await location.hasPermission();
      if (permissionGranted == PermissionStatus.denied) {
        permissionGranted = await location.requestPermission();
        if (permissionGranted != PermissionStatus.granted) {
          return;
        }
      }
      locationData = await location.getLocation();
      latitude = locationData.latitude;
      longitude = locationData.longitude;
      setState(() {});
    } on PlatformException catch (e) {
      if (e.code == 'IO_ERROR') {
        debugPrint(
            'A network error occured trying to lookup the supplied coordinate');
      } else {
        debugPrint('Failed to lookup coordinates: ${e.message}');
      }
    }
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  void initState() {
    getCurrentPosition();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    LatLng center = LatLng(latitude ?? 0, longitude ?? 0);
    Marker marker = Marker(
        markerId: const MarkerId("value"),
        position: LatLng(latitude ?? 0, longitude ?? 0));
    return CustomScaffold(
      // useExtraPadding: true,
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(10.0)),
              color: ColorName.white,
              boxShadow: [
                BoxShadow(
                  blurRadius: 4.0,
                  offset: const Offset(0, 3),
                  spreadRadius: 0,
                  color: ColorName.black.withOpacity(0.25),
                  blurStyle: BlurStyle.outer,
                ),
              ],
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 28.0, vertical: 20.0),
                  child: FutureBuilder(
                      future: AuthLocalDatasource().getUser(),
                      initialData: "Loading",
                      builder: (ctx, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          if (snapshot.hasError) {
                            return Center(
                              child: Text(
                                '${snapshot.error} occurred',
                                style: const TextStyle(fontSize: 18),
                              ),
                            );
                          } else if (snapshot.hasData) {
                            var data = snapshot.data as User;
                            return Row(
                              children: [
                                ClipRRect(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(50.0)),
                                  child: Image.network(
                                    'https://lh3.googleusercontent.com/a/ACg8ocJxpra2ZCN9PFP64VYPlvYTGnu-gjIgtWE0oWC4jzNcZ4U=s389-c-no',
                                    width: 72.0,
                                    height: 72.0,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                const SizedBox(width: 10.0),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 11.0, vertical: 2.0),
                                      decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(16.0)),
                                        border: Border.all(
                                            color: ColorName.primary),
                                      ),
                                      child: Text(
                                        data.roles,
                                        style: const TextStyle(
                                          color: ColorName.primary,
                                          fontSize: 8,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      "${greetingMessage()} \n ${data.name}",
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w700,
                                        color: ColorName.primary,
                                      ),
                                    ),
                                    Text(
                                      getCurrentDate(),
                                      style: const TextStyle(
                                        fontSize: 9,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            );
                          }
                        }
                        return const SizedBox();
                      }),
                ),
                Dash(
                  length: MediaQuery.of(context).size.width - 60.0,
                  dashColor: const Color(0xffD5DFE7),
                ),
                const SizedBox(height: 12.0),
                StreamBuilder(
                  stream: Stream.periodic(const Duration(seconds: 1), (i) => i),
                  builder: (context, snapshot) {
                    final currentTime = DateTime.now();
                    final formattedTime =
                        "${currentTime.hour.toString().padLeft(2, '0')}:${currentTime.minute.toString().padLeft(2, '0')} WIB";

                    return Text(
                      formattedTime,
                      style: const TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.w700,
                        color: Colors.blue, // Ganti dengan warna yang sesuai
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 10.0),
          SizedBox(
            height: 184.0,
            child: latitude == null
                ? const SizedBox()
                : GoogleMap(
                    onMapCreated: _onMapCreated,
                    initialCameraPosition: CameraPosition(
                      target: center,
                      zoom: 18.0,
                    ),
                    markers: {marker},
                  ),
          ),
          const SizedBox(height: 20.0),
          Button.filled(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const QrCodePage(),
                ),
              );
            },
            label: 'SCAN',
            icon: const ImageIcon(
              IconName.scan,
              color: ColorName.white,
            ),
            borderRadius: 50.0,
          ),
          const SizedBox(height: 30.0),
          Container(
            padding: const EdgeInsets.all(20.0),
            decoration: const BoxDecoration(
                color: ColorName.primary,
                borderRadius: BorderRadius.all(Radius.circular(10.0))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Riwayat Absensi",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: ColorName.white,
                  ),
                ),
                const SizedBox(height: 5),
                for (int i = 0; i < times.length; i++)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                    child: Text(
                      "JAM ${times[i].format(context)}",
                      style: const TextStyle(
                        fontSize: 16,
                        color: ColorName.white,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String getCurrentDate() {
    var date = DateTime.now().toString();
    var dateParse = DateTime.parse(date);
    return DateFormat('EEEE, d MMM, yyyy').format(dateParse).toString();
  }

  String greetingMessage() {
    var timeNow = DateTime.now().hour;

    if (timeNow <= 11.59) {
      return 'Good Morning';
    } else if (timeNow > 12 && timeNow <= 16) {
      return 'Good Afternoon';
    } else if (timeNow > 16 && timeNow < 20) {
      return 'Good Evening';
    } else {
      return 'Good Night';
    }
  }
}
