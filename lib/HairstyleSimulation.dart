import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'Home.dart';


class HairstyleSimulation extends StatefulWidget {
  const HairstyleSimulation({super.key});

  @override
  State<HairstyleSimulation> createState() => _HairstyleSimulationState();
}

class _HairstyleSimulationState extends State<HairstyleSimulation> {
  String? currentImagePath;

  @override
  Widget build(BuildContext context) {
    // MaterialApp을 Scaffold로 변경
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF151515), size: 50),
          onPressed: () {
            // Navigator.pop(context)로 뒤로가기 기능 구현
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.download, color: Color(0xFF151515), size: 50),
            onPressed: () {
              if (currentImagePath != null) {
                print(currentImagePath);
                //GallerySaver.saveImage(currentImagePath!);
              }
            },
          ),
        ],
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
      ),
      body: HairStyleAi(
        onImageChanged: (path) {
          setState(() {
            currentImagePath = path;
          });
        },
      ),
    );
  }
}

class HairStyleAi extends StatefulWidget {
  final void Function(String? imagePath)? onImageChanged;
  const HairStyleAi({super.key, this.onImageChanged});

  @override
  State<HairStyleAi> createState() => _HairStyleAiState();
}

class _HairStyleAiState extends State<HairStyleAi> {
  final ImagePicker picker = ImagePicker();
  XFile? image;
  bool showPickerButtons = false; // 버튼 표시 여부

  Future<void> pickImage(ImageSource source) async {
    final XFile? photo = await picker.pickImage(source: source);
    if (photo != null) {
      setState(() {
        image = photo;
        showPickerButtons = false; // 이미지 선택 후 버튼 숨김
      });
      widget.onImageChanged?.call(image!.path);
    }
  }

  int? chosen = 0;

  final List<Map<String, dynamic>> hairstyles = [
    {
      'name': '컷',
      'kind': {
        'assets/hairstyle/cut/cut1.png': '댄디컷',
        'assets/hairstyle/cut/cut2.png': '가르마컷',
        'assets/hairstyle/cut/cut3.png': '포마드컷',
        'assets/hairstyle/cut/cut4.png': '시스루컷',
        'assets/hairstyle/cut/cut5.png': '가일컷',
        'assets/hairstyle/cut/cut6.png': '리젠트컷',
        'assets/hairstyle/cut/cut7.png': '크롭컷',
        'assets/hairstyle/cut/cut8.png': '울프컷',
        'assets/hairstyle/cut/cut9.png': '스왓컷',
        'assets/hairstyle/cut/cut10.png': '버즈컷',
      },
    },
    {
      'name': '펌',
      'kind': {
        'assets/hairstyle/perm/curl1.png': '가르마펌',
        'assets/hairstyle/perm/curl2.png': '스왈로펌',
        'assets/hairstyle/perm/curl3.png': '쉐도우펌',
        'assets/hairstyle/perm/curl4.png': '시스루펌',
        'assets/hairstyle/perm/curl5.png': '아이롱펌',
        'assets/hairstyle/perm/curl6.png': '애즈펌',
        'assets/hairstyle/perm/curl7.png': '히피펌',
        'assets/hairstyle/perm/curl8.png': '베이비펌',
        'assets/hairstyle/perm/curl9.png': '리프펌',
        'assets/hairstyle/perm/curl10.png': '호일펌',
        'assets/hairstyle/perm/curl11.png': '리젠트펌',
      },
    },
    {
      'name': '염색',
      'kind': {
        'assets/hairstyle/color/dye1.png': '기본',
        'assets/hairstyle/color/dye2.png': '금발',
        'assets/hairstyle/color/dye3.png': '백발',
        'assets/hairstyle/color/dye4.png': '블루블랙',
        'assets/hairstyle/color/dye5.png': '애쉬브라운',
        'assets/hairstyle/color/dye6.png': '카키브라운',
        'assets/hairstyle/color/dye7.png': '다크브라운',
        'assets/hairstyle/color/dye8.png': '핑크베이지',
        'assets/hairstyle/color/dye9.png': '오렌지브라운',
        'assets/hairstyle/color/dye10.png': '그레이애쉬',
        'assets/hairstyle/color/dye11.png': '로즈골드',
        'assets/hairstyle/color/dye12.png': '민트블루',
        'assets/hairstyle/color/dye13.png': '와인레드',
        'assets/hairstyle/color/dye14.png': '플레티넘실버',
        'assets/hairstyle/color/dye15.png': '애쉬그린',
      },
    },
    {
      'name': '필터',
      'kind': {
        'assets/icons/premium.png': '임시',
      },
    },
  ];

  bool[] selected=[false]*hairstyles[0]['kind'].length;

  Future<void> ChangeChosen(int num) async {
    setState(() {
      chosen = num;
    });
  }

  @override
  Widget build(BuildContext context) {

    double vw = MediaQuery.of(context).size.width;
    if(500<vw){
      vw=500;
    }
    final double vh =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top - kToolbarHeight; // AppBar 높이;
    return Column(
      children: [
        Expanded(
          child: Container(
            width: vw,
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(color: Colors.white),
            child: Stack(
              children: [
                // footer
                Positioned(
                  left: 0,
                  bottom: 0,
                  child: Container(
                    width: vw,
                    height: vh * 0.141, // 90/640
                    padding: EdgeInsets.only(
                      top: vh * 0.002, // 1/640
                      left: vw * 0.056, // 20/360
                      right: vw * 0.056, // 20/360
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(
                        vw * 0.011, // 4/360
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0x3F1E1E1E),
                          blurRadius: vw * 0.008, // 3/360
                          offset: Offset(0, -vw * 0.008), // 3/360
                          spreadRadius: 0,
                        ),
                      ],
                    ),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ...(hairstyles[chosen!]['kind'] as Map<String, String>).entries
                              .map((entry) => Hairexample(entry.key, entry.value, vw, vh))
                              .toList(),
                          (chosen==3)?Text('d'):Container()
                        ],
                      ),
                    ),
                  ),
                ),
                // chosen style
                Positioned(
                  left: chosen! * vw * 0.250,
                  bottom: vh * 0.141,
                  child: Container(
                    width: vw * 0.250, // 90/360
                    height: vh * 0.061, // 39/640
                    decoration: ShapeDecoration(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(vw * 0.011),
                          topRight: Radius.circular(vw * 0.011),
                        ),
                      ),
                      shadows: [
                        BoxShadow(
                          color: Color(0x3F1E1E1E),
                          blurRadius: vw * 0.008, // 3/360
                          offset: Offset(0, -vw * 0.008), // 3/360
                          spreadRadius: 0,
                        ),
                      ],
                    ),
                  ),
                ),
                // 메뉴 버튼들
                Positioned(
                  left: 0,
                  bottom: vh * 0.141,
                  child: SizedBox(
                    width: vw,
                    height: vh * 0.047, // 30/640
                    child: Stack(
                      children: [
                        ChooseStyle(0, vw, vh),
                        ChooseStyle(1, vw, vh),
                        ChooseStyle(2, vw, vh),
                        ChooseStyle(3, vw, vh),
                      ],
                    ),
                  ),
                ),
                // 이미지 영역
                Positioned(
                  left: 0,
                  top: 0, // 70/640
                  child: SizedBox(
                    width: vw,
                    height: vh * 0.703, // 450/640
                    child: Stack(
                      children: [
                        Positioned(
                          left: 0,
                          top: vh * 0.055, // 35/640
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                showPickerButtons = !showPickerButtons;
                              });
                            },
                            child: Container(
                              width: vw,
                              height: vh * 0.594, // 380/640
                              clipBehavior: Clip.none,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: const Color.fromARGB(255, 21, 21, 21),
                                  width: vw * 0.003, // 1/360
                                ),
                              ),
                              child: _ImageFile(),
                            ),
                          ),
                        ),
                        // 카메라/갤러리 버튼
                        if (showPickerButtons)
                          Positioned(
                            left: 0,
                            bottom: -5,
                            width: vw,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ElevatedButton.icon(
                                  onPressed:(){ Navigator.push(context, MaterialPageRoute(builder: (context) => const Home()));},
                                  icon: Icon(Icons.camera_alt),
                                  label: Text('카메라'),
                                ),
                                SizedBox(width: 20),
                                ElevatedButton.icon(
                                  onPressed: () => pickImage(ImageSource.gallery),
                                  icon: Icon(Icons.photo_library),
                                  label: Text('갤러리'),
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _ImageFile() {
    return image != null
        ? Image.file(File(image!.path), fit: BoxFit.cover)
        : Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: const Color.fromARGB(255, 21, 21, 21),
          width: MediaQuery.of(context).size.width * 0.003, // 1/360
        ),
      ),
      child: Center(child: Text("이미지를 선택해주세요")),
    );
  }

  Widget ChooseStyle(int ChosenNum, double vw, double vh) {
    return Positioned(
      left: ChosenNum * vw / 4,
      top: 0,
      child: InkWell(
        onTap: () => ChangeChosen(ChosenNum),
        child: Container(
          width: vw / 4,
          height: vh * 0.050, // 32/640
          padding: EdgeInsets.only(
            top: vh * 0.013, // 8/640
            left: vw * 0.061, // 22/360
            right: vw * 0.061, // 22/360
            bottom: vh * 0.016, // 10/640
          ),
          clipBehavior: Clip.none,
          child: Center(
            child: Text(
              hairstyles[ChosenNum]['name'],
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: Colors.black,
                fontSize: vw * 0.028, // 10/360
                fontFamily: 'CookieRun',
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget Hairexample(String filename, String hairname, double vw, double vh) {
    return Container(
      width: 1.1 / 6 * vw,
      height: vh * 0.094, // 60/640
      margin:EdgeInsets.fromLTRB(0, 0, vw*0.03, 0),
      child: GestureDetector(
        child: Stack(
          children: [
            Positioned(
              left: 0,
              top: 0,
              child: Container(
                width: vw * 0.167, // 60/360
                height: vh * 0.094, // 60/640
                decoration: ShapeDecoration(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(vw * 0.025), // 9/360
                  ),
                  shadows: [
                    BoxShadow(
                      color: Color(0x3F3B3434),
                      blurRadius: vw * 0.026, // 9.4/360
                      offset: Offset(0, 0),
                      spreadRadius: vw * 0.006, // 2/360
                    )
                  ],
                ),
              ),
            ),
            Positioned(
              left: vw * 0.022, // 8/360
              top: vh * 0.011, // 7/640
              child: Container(
                width: vw * 0.122, // 44/360
                height: vh * 0.055, // 35/640
                child: Image.asset(
                  filename,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              top: vh * 0.070, // 45/640
              width: vw * 0.167, // 60/360
              child: Text(
                hairname,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize:(hairname.length > 5)?vw * 0.022:vw * 0.028, // 10/360
                  fontFamily: 'CookieRun',
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}