class JuzModel {
  final int juzNumber;
  final List<JuzAyahs> jusAyahs;
  JuzModel ({required this.juzNumber,required this.jusAyahs});
 factory JuzModel.fromJSON(Map<String,dynamic>json)
 {
   Iterable juzAyahs = json['data']['ayahs'];
   List<JuzAyahs> juzAyahsList = juzAyahs.map((e)=> JuzAyahs.fromJSON(e)).toList();
   return JuzModel(juzNumber: json['data']['number'],
       jusAyahs: juzAyahsList);
 }
}
class JuzAyahs{
  final String ayahsText;
  final int ayahNumber;
  final String surahName;

  JuzAyahs({required this.ayahsText,required this.ayahNumber, required this.surahName});
  factory JuzAyahs.fromJSON(Map<String,dynamic>json){
    return JuzAyahs(
        ayahNumber: json['number'],
        ayahsText: json['text'],
        surahName: json['surah']['name']
    );
  }
}