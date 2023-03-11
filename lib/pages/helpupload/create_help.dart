import 'dart:ffi';
import 'dart:io';

import 'package:bantuin/functions/global_func.dart';
import 'package:bantuin/pages/helpupload/create_summary.dart';
import 'package:bantuin/shared/textstyle.dart';
import 'package:bantuin/widgets/buttons/main_button_custom.dart';
import 'package:bantuin/widgets/buttons/mini_button_icon_custom.dart';
import 'package:bantuin/widgets/buttons/raw_button_custom.dart';
import 'package:bantuin/widgets/category_input_item.dart';
import 'package:bantuin/widgets/headers/main_header.dart';
import 'package:bantuin/widgets/image_custom.dart';
import 'package:bantuin/widgets/modals/dialog_modal.dart';
import 'package:bantuin/widgets/price_items/row_price_item.dart';
import 'package:bantuin/widgets/text_inputs/input_with_button_custom.dart';
import 'package:bantuin/widgets/text_inputs/main_input_custom.dart';
import 'package:bantuin/widgets/title_descs/drawer_title_desc.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import '../../shared/constatns.dart';

class CreateHelpPage extends StatefulWidget {
  @override
  State<CreateHelpPage> createState() => _CreateHelpPageState();
}

class _CreateHelpPageState extends State<CreateHelpPage> {

  // Main Content State And Functions
  TextEditingController titleController = TextEditingController(text: "");
  TextEditingController priceController = TextEditingController(text: "");
  TextEditingController descController = TextEditingController(text: "");
  var currentPrice = 0;
  var prices = [
    [50000, 100000], [200000, 300000], [500000, 1000000]
  ];
  var category = 'Lainnya';
  var categories = [
    'Game', 'Pembangunan', 'Kebersihan', 'Lainnya'
  ];
  File? pickedImage = null;
  var choosePickImage = false;

  void setFastPrice(price, setState) {
    this.priceController.text = price.toString();
    setState(() {
      currentPrice = price;
    });
    Navigator.pop(context);
  }

  bool isPriceActive(price) {
    return currentPrice == price;
  }

  void setCategory(cat, setState) {
    this.setState(() {
      category = cat;
    });
    setState(() {
      category = cat;
    });
    Navigator.pop(context);
  }

  bool isCategoryActive(cat) {
    return category == cat;
  }
  
  Future pickImage(ImageSource source) async {
    try {
      XFile? image = await ImagePicker().pickImage(source: source);
      if (image == null) {
        return showGLobalAlert('danger', 'Batal Mengambil Gambar?', context);
      }
      File img = File(image.path);
      this.setState(() {
        pickedImage = img;
      });
      this.setState(() {
        choosePickImage = false;
      });
      showGLobalAlert('info', 'Berhasil Mengambil Gambar', context);
    } catch (e) {
      showGLobalAlert('danger', 'Terjadi Kesalahan, Coba Lagi Beberapa Saat', context);
    }
  }
  
  bool getDisable() {
    return pickedImage != null &&
    titleController.text != "" &&
    priceController.text != "" &&
    descController.text != "" &&
    category != "" &&
    location != null &&
    locationLatLng != null;
  }
  // Main Content State And Functions

  // Main Content Widgets
  Widget PriceDrawerContent() {
    return StatefulBuilder(
      builder: ((BuildContext context, StateSetter setState) {
        return Container(
          margin: EdgeInsets.only(
            top: 32,
            left: 24,
            right: 24
          ),
          child: ListView(
            children: [
              DrawerTitleDesc(
                title: 'Pilih Harga Cepat',
                desc: 'Pilih harga dengan cepat untuk mempermudah penginputan harga',
              ),
              SizedBox(height: 24,),
              Column(
                children: prices.map((price) {
                  return RowPriceItem(
                    leftPrice: price[0],
                    rightPrice: price[1],
                    onLeft: (){
                      setFastPrice(price[0], setState);
                    },
                    onRight: (){
                      setFastPrice(price[1], setState);
                    },
                    leftActive: isPriceActive(price[0]),
                    rightActive: isPriceActive(price[1]),
                  );
                }).toList(),
              ),
            ],
          ),
        );
      })
    );
  }

  Widget CategoryDrawerContent() {
    return StatefulBuilder(
      builder: ((BuildContext context, StateSetter setState) {
        return Container(
          child: ListView(
            children: [
              Container(
                margin: EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 32
                ),
                child: DrawerTitleDesc(
                  title: 'Pilih Kategori',
                  desc: 'Pilih kategori dari bantuan yang ingin kamu upload agar memudahkan helper',
                ),
              ),
              Column(
                children: categories.map((cat) {
                  return CategoryInputItem(
                    title: cat,
                    onPress: (){
                      setCategory(cat, setState);
                    },
                    active: isCategoryActive(cat),
                  );
                }).toList(),
              )
            ],
          ),
        );
      })
    );
  }

  Widget ChooseImagePicker() {
    return choosePickImage ?
    GestureDetector(
      onTap: (){
        this.setState(() {
          choosePickImage = false;
        });
      },
      child: Container(
        color: black.withOpacity(0.5),
        width: double.infinity,
        height: double.infinity,
        child: SimpleDialog(
          children: [
            Container(
              margin: EdgeInsets.symmetric(
                horizontal: 12
              ),
              child: Column(
                children: [
                  Text(
                    'Pilih Pengambilan Gambar',
                    style: mediumBlackSemibold
                  ),
                  SizedBox(height: 8,),
                  Text(
                    'Pilih Dari Mana Kamu Ingin Mengambil Gambar Kamu',
                    style: poppinsText.copyWith(
                      fontSize: 13,
                      fontWeight: regular,
                      color: black1
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 12,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      MiniButtonIconCustom(
                        icon: Icons.folder,
                        title: 'Library',
                        onPress: (){
                          pickImage(ImageSource.gallery);
                        },
                      ),
                      SizedBox(width: 8,),
                      MiniButtonIconCustom(
                        icon: Icons.camera_alt,
                        title: 'Camera',
                        onPress: (){
                          pickImage(ImageSource.camera);
                        },
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    )
    :
    SizedBox();
  }

  Widget PickedImageRender() {
    return GestureDetector(
      onTap: (){
        this.setState(() {
          choosePickImage = true;
        });
      },
      child: ImageCustom(
        height: 132,
        width: double.infinity,
        image: FileImage(pickedImage!),
        fit: BoxFit.cover,
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }

  Widget NullImageRender() {
    return Container(
      height: 132,
      decoration: BoxDecoration(
        border: Border.all(
          color: green3
        ),
        borderRadius: BorderRadius.circular(8)
      ),
      child: Center(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: green1
          ),
          width: 40,
          height: 40,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent,
              shadowColor: Colors.transparent.withOpacity(0.1),
              padding: EdgeInsets.all(0)
            ),
            onPressed: (){
              this.setState(() {
                choosePickImage = true;
              });
            },
            child: ImageCustom(
              height: 18,
              width: 18,
              image: AssetImage('assets/icons/ic_plus_big.png'),
            ),
          ),
        ),
      ),
    );
  }

  Widget ImageInput() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Gambar Bantuan',
            style: regularBlackRegular
          ),
          SizedBox(height: 6,),
          pickedImage != null ? PickedImageRender() : NullImageRender()
        ],
      ),
    );
  }

  Widget CategoryInput(context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Kategori Bantuan',
            style: regularBlackRegular
          ),
          GestureDetector(
            onTap: (){
              showDrawer(context, Platform.isIOS ? 361 : 341, CategoryDrawerContent());
            },
            child: Container(
              height: 50,
              margin: EdgeInsets.only(
                top: 6
              ),
              padding: EdgeInsets.symmetric(
                horizontal: 20
              ),
              decoration: BoxDecoration(
                border: Border.all(
                  color: green3
                ),
                borderRadius: BorderRadius.circular(8)
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    category,
                    style: mediumBlackRegular
                  ),
                  ImageCustom(
                    height: 8,
                    width: 16,
                    image: AssetImage('assets/icons/ic_down.png'),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget LocationInput() {
    return GestureDetector(
      onTap: () async {
        if (locationLatLng == null) {
          this.setState(() {
            loadingMap = true;
          });
          await getCurrentLocation();
          await getCurrentAddress(locationLatLng!);
          this.setState(() {
            loadingMap = false;
          });
        }
        this.setState(() {
          openMap = true;
        });
      },
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Lokasi Bantuan',
              style: regularBlackRegular,
            ),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: 20
              ),
              width: double.infinity,
              height: 50,
              margin: EdgeInsets.only(
                top: 6
              ),
              decoration: BoxDecoration(
                border: Border.all(
                  color: green3
                ),
                borderRadius: BorderRadius.circular(8)
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      location != null ? location : 'Pilih Lokasi',
                      style: mediumBlackRegular,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget GettingReadyLoading() {
    return loadingMap ? Container(
      color: black.withOpacity(0.5),
      width: double.infinity,
      height: double.infinity,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 6,),
            Text(
              'Menyiapkan Lokasi...',
              style: mediumWhiteSemibold
            )
          ],
        ),
      ),
    ) : SizedBox();
  }

  Widget MainContent(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              child: Column(
                children: [
                  MainHeader(
                    title: 'Cari Bantuan',
                    onBack: () {
                      Navigator.pop(context);
                    },
                  ),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(
                        left: 24,
                        right: 24,
                      ),
                      child: ListView(
                        children: [
                          SizedBox(
                            height: 12,
                          ),
                          ImageInput(),
                          SizedBox(
                            height: 20,
                          ),
                          MainInputCustom(
                            title: "Judul Bantuan",
                            hint: "Masukkan Judul Bantuan",
                            controller: titleController,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          InputWithButtonCustom(
                            onChanged: (value) {
                              this.setState(() {
                                currentPrice = int.parse(value);
                              });
                            },
                            inputType: TextInputType.number,
                            title: "Harga Bantuan",
                            hint: "Masukkan Judul Bantuan",
                            controller: priceController,
                            onPress: () {
                              showDrawer(context, Platform.isIOS ? 361 : 341,
                                  PriceDrawerContent());
                            },
                            iconContent: ImageCustom(
                              height: 21,
                              width: 21,
                              image: AssetImage('assets/icons/ic_money.png'),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          CategoryInput(context),
                          SizedBox(
                            height: 20,
                          ),
                          MainInputCustom(
                            title: "Deskripsi Bantuan",
                            hint: "Masukkan Deskripsi Bantuan",
                            controller: descController,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          LocationInput(),
                          SizedBox(height: 32,),
                          MainButtonCustom(
                            title: 'Cari Bantuan',
                            onPressed: () {
                              Navigator.push(
                                context, MaterialPageRoute(
                                  builder: (context) => CreateSummaryPage(
                                    pickedImage,
                                    titleController.text,
                                    descController.text,
                                    category,
                                    location,
                                    currentPrice,
                                    locationLatLng!
                                  )
                                )
                              );
                            },
                            disabled: !(getDisable()),
                          ),
                          SizedBox(height: 120,)
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            ChooseImagePicker(),
            GettingReadyLoading(),
          ]
        ),
      ),
    );
  }
  // Main Content Widgets

  // Gmap Content State And Functions
  var openMap = false;
  var location = null;
  LatLng? locationLatLng = null;
  var loadingChange = false;
  var loadingMap = false;
  var info = true;

  Future getCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error("Location Unable");
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error("Location permissions are denied");
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          "Location permissions are permanently denied, we cannot continue your request");
    }

    var geo = await Geolocator.getCurrentPosition();
    this.setState(() {
      locationLatLng = LatLng(geo.latitude, geo.longitude);
    });
  }

  Future getCurrentAddress(LatLng latLngParams) async {
    this.setState(() {
      loadingChange = true;
    });
    try {
      List<Placemark> placemakrs = await placemarkFromCoordinates(latLngParams.latitude, latLngParams.longitude);
      Placemark place = placemakrs[0];
      this.setState(() {
        location = '${place.street}, ${place.subLocality}, ${place.subAdministrativeArea}, ${place.postalCode}';
      });
    } catch (e) {
      showGLobalAlert('danger', 'Oops!, Terjadi Kesalahan Coba Lagi Beberapa Saat', context);
      this.setState(() {
        openMap = false;
      });
    }
    this.setState(() {
      loadingChange = false;
    });
  }
  // Gmap Content State And Functions

  // GMap Content Widgets
  Widget GmapBottomContent() {
    return Align(
      alignment: Alignment.bottomLeft,
      child: Container(
        padding: EdgeInsets.all(12),
        width: MediaQuery.of(context).size.width * 0.8,
        height: 120,
        decoration: BoxDecoration(
          color: white,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(30)
          )
        ),
        child: Column(
          children: [
            Text(
              location != null ? location : 'Pilih Map',
              style: regularBlackSemibold,
              maxLines: 2,
            ),
            Spacer(),
            RawButtonCustom(
              height: 40,
              onPress: (){
                showGLobalAlert('info', 'Berhasil Menentukan Lokasi', context);
                this.setState(() {
                  openMap = false;
                });
              },
              title: 'Pilih Lokasi & Selesai',
            )
          ],
        ),
      ),
    );
  }

  Widget ChangeLoadingRender() {
    return loadingChange ? 
    Container(
      width: double.infinity,
      height: double.infinity,
      color: black.withOpacity(0.5),
      child: Center(
        child: CircularProgressIndicator(),
      ),
    )
    : 
    SizedBox();
  }

  Widget InfoDialogRender() {
    return info ?
    DialogModal(
      children: [
        Container(
          margin: EdgeInsets.symmetric(
            horizontal: 12
          ),
          child: Column(
            children: [
              Text(
                'Pemberitahuan',
                style: mediumBlackSemibold,
              ),
              SizedBox(height: 8,),
              Text(
                'Untuk menentukan lokasi kamu, tekan marker berwarna biru, lalu seret ke lokasi yang kamu mau',
                style: poppinsText.copyWith(
                  fontSize: 13,
                  fontWeight: regular,
                  color: black1
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 12,),
              RawButtonCustom(
                height: 40,
                onPress: (){
                  this.setState(() {
                      info = false;
                  });
                },
                title: 'Mengerti',
              )
            ],
          ),
        )
      ],
    )
    :
    SizedBox();
  }

  Widget OpenMap(BuildContext context) {
    return locationLatLng != null ?
    Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            GoogleMap(
              myLocationEnabled: true,
              initialCameraPosition: CameraPosition(
                target: locationLatLng!,
                zoom: 14.5,
              ),
              markers: {
                Marker(
                  draggable: true,
                  onDragEnd: (newLatLng) {
                    this.setState(() {
                      locationLatLng = newLatLng;
                    });
                    getCurrentAddress(newLatLng);
                  },
                  markerId: MarkerId("source"),
                  position: locationLatLng!,
                  icon: BitmapDescriptor.defaultMarkerWithHue(
                    BitmapDescriptor.hueAzure
                  ),
                ),
              },
            ),
            GmapBottomContent(),
            InfoDialogRender(),
            ChangeLoadingRender()
          ], 
        ),
      ),
    ) 
    : 
    Scaffold(
      backgroundColor: white,
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
  // GMap Content Widgets

  @override
  Widget build(BuildContext context) {
    return openMap ? OpenMap(context) : MainContent(context);
  }
}