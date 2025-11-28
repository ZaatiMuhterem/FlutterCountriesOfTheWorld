import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:kasim22/ulke.dart';
import 'package:kasim22/ulke_detay_sayfasi.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'ortak_liste.dart';
import 'favoriler.dart';

class AnaSayfa extends StatefulWidget {
  @override
  State<AnaSayfa> createState() => _AnaSayfaState();
}

class _AnaSayfaState extends State<AnaSayfa> {
  final String _apiUrl =
      "https://restcountries.com/v3.1/all?fields=name,flags,cca2,capital,region,languages,population";
  List<Ulke> _butunUlkeler = [];
  List<String> _favoriUlkeKodlari = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _favorileriCihazHafizasindanCek().then((value){ // önce favorileri hafızadan çekip ardından ülke ekranını çiziyor böylece mevcut ülke içerilip içerilmediği öğreniliyor.
        _ulkeleriInternettenCek();
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: _buildAppBar(context), body: _buildBody());
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(title: Text("Tüm Ülkeler"),
    centerTitle: true,
      actions: [
        IconButton(
        icon: Icon(
          Icons.favorite,
          color: Colors.red,
        ),
        onPressed: (){
          _favorilerSayfasiniAc(context);
        },
        )
      ],
    );
  }
  Widget _buildBody() {
    return _butunUlkeler.isEmpty
        ? Center(child: CircularProgressIndicator())
        : OrtakListe(_butunUlkeler, _favoriUlkeKodlari);

  }
  void _ulkeleriInternettenCek() async {
    Uri uri = Uri.parse(_apiUrl);
    http.Response response = await http.get(uri);

    List<dynamic> parsedResponse = jsonDecode(response.body); // json objelerinden bir liste gelicek ama dart json objelerini otomatik olarak mape dönüştürmediği için
                                                              // dynamic olarak veriyor sonrasında biz elle dönüştürüyoru.
    for (int i = 0; i < parsedResponse.length; i++) {
      Map<String, dynamic> ulkeMap = parsedResponse[i];
      Ulke ulke = Ulke.fromMap(ulkeMap);
      _butunUlkeler.add(ulke);
    }
    setState(() {});
  }
  Future<void> _favorileriCihazHafizasindanCek() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    List<String>? favoriler = prefs.getStringList("favoriler");

    if(favoriler != null){
      for(String ulkeKodu in favoriler){
        _favoriUlkeKodlari.add(ulkeKodu);
      }
    }
  }
  void _favorilerSayfasiniAc(BuildContext context){
    MaterialPageRoute sayfaYolu = MaterialPageRoute(builder:(context){
      return Favoriler(_butunUlkeler,_favoriUlkeKodlari);
    },);
    Navigator.push(context, sayfaYolu);
  }
}




/*
[
   {
      "flags":{
         "png":"https://flagcdn.com/w320/tr.png",
         "svg":"https://flagcdn.com/tr.svg",
         "alt":"The flag of Turkey has a red field bearing a large fly-side facing white crescent and a smaller five-pointed white star placed just outside the crescent opening. The white crescent and star are offset slightly towards the hoist side of center."
      },
      "name":{
         "common":"Turkey",
         "official":"Republic of Turkey",
         "nativeName":{
            "tur":{
               "official":"Türkiye Cumhuriyeti",
               "common":"Türkiye"
            }
         }
      },
      "cca2":"TR",
      "capital":[
         "Ankara"
      ],
      "region":"Asia",
      "languages":{
         "tur":"Turkish"
      },
      "population":85664944
   }
]
*/
