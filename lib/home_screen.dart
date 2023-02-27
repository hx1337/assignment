import 'package:flutter/material.dart';
import 'package:toast/toast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:dio/dio.dart';
import 'package:advanced_search/advanced_search.dart';
import 'model/job_designation_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController text = TextEditingController();

  final dio = Dio();

  Designation? designationData;

  List<String> designationsList = [];

  void getDesignation() async {
    final response =
        await dio.get('https://devstaticapi.hire22.co/v1/jobdesignations');

    if (response.statusCode == 200) {
      setState(() {});
      designationData = Designation.fromJson(response.data);
      for (int i = 0; i < designationData!.jobdesignations.length; i++) {
        designationsList.add(designationData!.jobdesignations[i].designation);
      }
      print(designationsList.length);
      // designationsList.add(designationData!.jobdesignations.elementAt(0).designation.toString()) ;

    } else {
      throw Exception('Failed to load');
    }
  }

  @override
  void initState() {
    getDesignation();

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ToastContext().init(context);
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 177,
                ),
                Text(
                  "Job Title",
                  style: GoogleFonts.aleo(
                      fontSize: 17, fontWeight: FontWeight.w600),
                ),
                const SizedBox(
                  height: 7,
                ),
                AdvancedSearch(
                  hintText: "Designation",
                  enabledBorderColor: Colors.black,
                  focusedBorderColor: Colors.lightBlueAccent,
                  disabledBorderColor: Colors.black,
                  searchItems: designationsList,
                  itemsShownAtStart: 10,
                  enabled: true,
                  maxElementsToDisplay: 10,
                  onItemTap: (index, value) {},
                ),
                const SizedBox(
                  height: 30,
                ),
                Text(
                  "Describe yourself",
                  style: GoogleFonts.aleo(
                      fontSize: 17, fontWeight: FontWeight.w600),
                ),
                const SizedBox(
                  height: 7,
                ),
                TextField(
                  controller: text,
                  keyboardType: TextInputType.multiline,
                  maxLines: 4,
                  onChanged: (value) {
                    setState(() {});
                    // print(text.text.length);
                    // print(text.text);
                  },
                  autocorrect: true,
                  decoration: const InputDecoration(
                    hintText: 'Describe yourself (mini 5 characters)',
                    hintStyle: TextStyle(color: Colors.grey),
                    filled: true,
                    fillColor: Colors.white70,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12.0)),
                      borderSide: BorderSide(color: Colors.black, width: 1),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      borderSide: BorderSide(color: Colors.lightBlueAccent),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "${text.text.length} / 200",
                      style: GoogleFonts.aleo(
                          fontSize: 15, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      if (text.text.length > 4) {
                        print("Submited");
                        Toast.show("Submited",
                            duration: Toast.lengthShort, gravity: Toast.bottom);
                      } else {
                        print("Enter mini 5 characters");
                        Toast.show("Enter mini 5 characters",
                            duration: Toast.lengthShort, gravity: Toast.bottom);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 62, vertical: 11),
                        textStyle: const TextStyle(
                          fontSize: 18,
                        )),
                    child: const Text('SUBMIT'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
