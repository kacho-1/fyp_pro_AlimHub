import 'package:flutter/material.dart';

import '../../CommonFeatures/Customs/CustomColor.dart';

class DuasScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Duas',
          style: Theme.of(context).textTheme.headlineMedium!.apply(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: TColors.primary,
      ),
      body: ListView(
        padding: const EdgeInsets.all(10.0),
        children: [
          themedBlock(
            context,
            Icons.bed,
            'Sleeping',
            [
              duaListTile(
                'دُعَاء قَبْلَ النَّوْمِ',
                'Allahumma bismika amuutu wa ahyaa',
                'اَللَّهُمَّ بِاسْمِكَ أَمُوتُ وَأَحْيَا',
                'اے اللہ! میں تیری نام سے مرنے اور جینے کا ارادہ کرتا ہوں۔',
              ),
              duaListTile(
                'دُعَاء بَعْدَ الْاستِيقَاظِ',
                'Alhamdulillahilladhi ahyana ba‘da ma amatana wa ilayhin-nushur',
                'اَلْحَمْدُ لِلَّهِ الَّذِي أَحْيَانَا بَعْدَ مَا أَمَاتَنَا وَإِلَيْهِ النُّشُورُ',
                'تمام تعریفیں اللہ کے لئے ہیں، جس نے ہمیں مرنے کے بعد زندہ کیا اور اسی کی طرف لوٹ کر جانا ہے۔',
              ),
            ],
          ),
          themedBlock(
            context,
            Icons.wc,
            'Toilet',
            [
              duaListTile(
                'دُعَاء قَبْلَ الدُّخُولِ',
                'Bismik Allahumma ajlil-laahum (entering the toilet)',
                'بِسْمِكَ اللَّهُمَّ (دستشوی کرنے سے پہلے)',
                'اے اللہ! میں تیرے نام سے داخل ہوتا ہوں۔',
              ),
              duaListTile(
                'دُعَاء بَعْدَ الْخُرُوجِ',
                'غُفْرَانَكَ',
                'غُفْرَانَكَ',
                'اے اللہ! میں تیرے دربار سے معافی مانگتا ہوں۔',
              ),
            ],
          ),
          themedBlock(
            context,
            Icons.opacity,
            'Ablution (Wudu)',
            [
              duaListTile(
                'دُعَاء لِلْوُضُوءِ',
                'Bismillah',
                'بِسْمِ اللَّه',
                'اللہ کے نام سے شروع کرتا ہوں۔',
              ),
              duaListTile(
                'دُعَاء بَعْدَ الْوُضُوءِ',
                'Ashhadu an la ilaha illa Allah wahdahu la sharika lahu, wa ashhadu anna Muhammadur rasoolullah',
                'أَشْهَدُ أَنْ لَا إِلَٰهَ إِلَّا اللَّهُ وَحْدَهُ لَا شَرِيكَ لَهُ، وَأَشْهَدُ أَنَّ مُحَمَّدًا رَسُولُ اللَّهِ',
                'میں گواہی دیتا ہوں کہ اللہ کے سوا کوئی معبود نہیں، وہ اکیلا ہے، اس کا کوئی شریک نہیں، اور میں گواہی دیتا ہوں کہ محمد (ص) اللہ کے رسول ہیں۔',
              ),
            ],
          ),
          themedBlock(
            context,
            Icons.mosque,
            'Mosque',
            [
              duaListTile(
                'دُعَاء قَبْلَ الدُّخُولِ',
                'Allahumma iftah li abwaba rahmatik',
                'اللَّهُمَّ افتَحْ لِي أَبْوَابَ رَحْمَتِكَ',
                'اے اللہ! میرے لئے اپنی رحمت کے دروازے کھول دے۔',
              ),
              duaListTile(
                'دُعَاء بَعْدَ الْخُرُوجِ',
                'Allahumma inni as’aluka min fadlik',
                'اللَّهُمَّ إِنِّي أَسْأَلُكَ مِنْ فَضْلِكَ',
                'اے اللہ! میں تیرے فضل کا سوال کرتا ہوں۔',
              ),
            ],
          ),
          themedBlock(
            context,
            Icons.self_improvement,
            'Prayer',
            [
              duaListTile(
                'دُعَاء قَبْلَ الصَّلَاةِ',
                'Subhanaka Allahumma wa bihamdiKa wa tabaarak asmuKa wa ta‘aala jadduKa wa la ilaaha ghayruK',
                'سُبْحَانَكَ اللَّهُمَّ وَبِحَمْدِكَ وَتَبَارَكَ اسْمُكَ وَتَعَالَى جَدُّكَ وَلَا إِلَٰهَ غَيْرُكَ',
                'اے اللہ! میں تیری پاکیزگی بیان کرتا ہوں اور تیری تعریف کرتا ہوں، تیرے نام کو برکت دی گئی ہے اور تیری عظمت ہے، تیرے سوا کوئی معبود نہیں۔',
              ),
              duaListTile(
                'دُعَاء بَعْدَ الصَّلَاةِ',
                'Astaghfirullah, Astaghfirullah, Astaghfirullah',
                'أَسْتَغْفِرُ اللَّهَ، أَسْتَغْفِرُ اللَّهَ، أَسْتَغْفِرُ اللَّهَ',
                'میں اللہ سے مغفرت طلب کرتا ہوں، میں اللہ سے مغفرت طلب کرتا ہوں، میں اللہ سے مغفرت طلب کرتا ہوں۔',
              ),
            ],
          ),
          themedBlock(
            context,
            Icons.home,
            'Home',
            [
              duaListTile(
                'دُعَاء قَبْلَ الدُّخُولِ',
                'Allahumma inni as’aluka khayra ad-dakhooli wa khayra al-khuruj',
                'اللَّهُمَّ إِنِّي أَسْأَلُكَ خَيْرَ الدُّخُولِ وَخَيْرَ الْخُرُوجِ',
                'اے اللہ! میں تجھ سے بہترین داخلے اور بہترین خروج کا سوال کرتا ہوں۔',
              ),
              duaListTile(
                'دُعَاء بَعْدَ الْخُرُوجِ',
                'Bismillah, tawakkaltu ‘ala Allah',
                'بِسْمِ اللَّه، تَوَكَّلتُ عَلَى اللَّه',
                'اللہ کے نام سے شروع کرتا ہوں، میں نے اللہ پر توکل کیا۔',
              ),
            ],
          ),
          themedBlock(
            context,
            Icons.checkroom,
            'Garment',
            [
              duaListTile(
                'دُعَاء لِلْمَلَابِسِ',
                'Alhamdulillahilladhi kasaani hadha (new garment)',
                'الْحَمْدُ لِلَّهِ الَّذِي كَسَانِي هَذَا (نیا لباس)',
                'تمام تعریفیں اللہ کے لئے ہیں، جس نے مجھے یہ لباس پہنایا۔',
              ),
            ],
          ),
          themedBlock(
            context,
            Icons.airplanemode_active,
            'Travel',
            [
              duaListTile(
                'دُعَاء قَبْلَ السَّفَرِ',
                'Bismillah, Allahu Akbar',
                'بِسْمِ اللَّه، اللَّهُ أَكْبَرُ',
                'اللہ کے نام سے شروع کرتا ہوں، اللہ سب سے بڑا ہے۔',
              ),
              duaListTile(
                'دُعَاء خِلَالَ السَّفَرِ',
                'Allahumma inna nas’aluka fi safarina hadha al-birra wa at-taqwa, wa min al-amali ma tardha',
                'اللَّهُمَّ إِنَّا نَسْأَلُكَ فِي سَفَرِنَا هَذَا الْبِرَّ وَالتَّقْوَى، وَمِنَ الْأَعْمَالِ مَا تَرْضَى',
                'اے اللہ! ہم تجھ سے اس سفر میں نیکی اور تقویٰ کا سوال کرتے ہیں، اور ان اعمال کا جو تو پسند فرمائے۔',
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget themedBlock(BuildContext context, IconData icon, String title, List<Widget> tiles) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      elevation: 4.0,
      color: Colors.blueGrey, // Dark grey color for the card
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, size: 28.0, color: Colors.white), // White icon color
                SizedBox(width: 10),
                Text(
                  title,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white), // White text color
                ),
              ],
            ),
            Divider(color: Colors.white), // White divider color
            ...tiles,
          ],
        ),
      ),
    );
  }

  Widget duaListTile(String arabic, String transliteration, String arabicUrdu, String translation) {
    return ListTile(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(arabic, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)), // White text color
          SizedBox(height: 4),
          Text(transliteration, style: TextStyle(fontSize: 14, color: Colors.grey[300])), // Light grey color for transliteration
          SizedBox(height: 4),
          Text(arabicUrdu, style: TextStyle(fontSize: 14, color: Colors.grey[300])), // Light grey color for Urdu
          SizedBox(height: 4),
          Text(translation, style: TextStyle(fontSize: 14, color: Colors.grey[200])), // Very light grey color for English
        ],
      ),
    );
  }
}
