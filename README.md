# kasim22
# 🌍 Ülkeler Uygulaması
Bu Flutter projesi, REST Countries API kullanarak dünya ülkelerini listeler, detaylarını gösterir ve kullanıcıların favori ülkelerini kaydetmesine olanak tanır. Basit bir API tüketimi, listeleme, detay sayfası, favorilere ekleme ve SharedPreferences ile lokal veri saklama özelliklerini içerir.




restcountries.com API sinden aldığımız ülkeler json verisini uygulamamızda http paketiyle çekiyoruz
https://restcountries.com/v3.1/all?fields=name,flags ,oldukça karışık gözüken bu json dosyasını formatlamak için https://jsonformatter.curiousconcept.com sitesinden , daha düzgün bir formatta düzenleyip uygulamamıza yorum satırı olarak ekliyoruz .Böylece ne yaptığımızı takip ederek Map() yapısı elde edebiliriz.

https://restcountries.com/v3.1/name/turkey?fields=name,flags url si ile sadece o ülkenin bilgilerini görebiliriz.
veri json objesi olarak değil json listesi olarak geliyor.

## 📱 Özellikler
Tüm Ülkeleri Listeleme =
REST Countries API üzerinden alınan ülkeler listelenir.
Ülke adı, başkent, bayrak bilgisi gösterilir.
### Favorilere Ekleme
Her ülkenin sağ tarafındaki kalp ikonu ile favori işlemi yapılabilir.
Favori ülkeler yerel hafızaya kaydedilir (SharedPreferences).
Favoriler sayfasında sadece favori seçilen ülkeler listelenir.
### Ülke Detayları
Bir ülkeye tıklandığında detay sayfası açılır.
Ülke adı
Bayrak
Başkent
Bölge
Nüfus
Dil bilgileri gösterilir.
### SharedPreferences Kullanımı
Favoriler uygulama kapansa bile kaydedilir. 
### Kullanılan Paketler
pubspec.yaml içinde yer alması gereken paketler:
``` 
dependencies:
    flutter:
      sdk: flutter
    http: ^1.6.0
    shared_preferences: ^2.5.3 
```
## Kod Açıklamaları

`ana_sayfa.dart`
API'den ülke verilerini çeker.
Favori ülke kodlarını SharedPreferences üzerinden okur.
Tüm ülkeleri OrtakListe bileşeni ile listeler.
AppBar’daki kalp ikonuna tıklayınca favoriler sayfasına yönlendirir.
`favoriler.dart`
Favorilere eklenen ülkeleri listeler.
Listeleme yine OrtakListe widget’i kullanılarak yapılır.
`ortak_liste.dart`
Hem ana sayfadaki tüm ülke listesini hem favoriler listesini oluşturan ortak widget.
Favoriye ekle / favoriden çıkar butonu burada yönetilir.
Thumbnail olarak bayrak görseli gösterilir.
`ulke.dart` (Model)
API’den gelen JSON verisini Ulke nesnesine dönüştürür.
Ülke kodu, isim, başkent, bölge, nüfus, bayrak URL’si ve dil bilgisini içerir.
`ulke_detay_sayfasi.dart`
Bir ülkenin tüm detaylarını gösteren sayfadır.
Büyük bayrak görseli, ülke bilgileri ve detay satırları yer alır.
## Ekran Görüntüleri