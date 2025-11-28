class Ulke {
  String ulkeKodu;
  String isim;
  String baskent;
  String bolge;
  int nufus;
  String bayrak;
  String dil;

  Ulke.fromMap(Map<String, dynamic> ulkeMap)
      : ulkeKodu = ulkeMap["cca2"] ?? "",
        isim = ulkeMap["name"]?["common"] ?? "", // eğer name null ise common ı arama boş string ata.
        baskent = (ulkeMap["capital"] as List<dynamic>).isNotEmpty
            ? ulkeMap["capital"][0]
            : "",
        bolge = ulkeMap["region"],
        nufus = ulkeMap["population"],
        bayrak = ulkeMap["flags"]?["png"] ?? "",
        dil = (ulkeMap["languages"] as Map<String, dynamic>).isNotEmpty// dil kısmında liste vermediği için doğrudan ilk elemanı alamıyoruz
            ? (ulkeMap["languages"] as Map<String, dynamic>)          //entries ile ilk değeri almamız için önce map yapısında olduğunu kesin anlaması için as Map<String,dynmaic> ile map yapısına çeviriyoruz
            .entries
            .toList()[0]
            .value
            : "";
}
