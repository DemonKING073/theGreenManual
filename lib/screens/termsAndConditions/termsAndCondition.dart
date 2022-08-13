import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:the_green_manual/constants/constant.dart';
import 'package:the_green_manual/constants/helper.dart';

class TermsAndCondition extends StatelessWidget {
  static const String id = 'TermsAndCondition';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: Center(
            child: Column(
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.08),
                Text('Terms and Condition',style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),),
                LSizedBox(),
                Container(
                  padding: EdgeInsets.all(10),
                  height: MediaQuery.of(context).size.height*0.5,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Color(0xffD9D9D9).withOpacity(0.5)
                ),
                child: Text('Green is the color between cyan and yellow on the visible spectrum. It is evoked by light which has a dominant wavelength of roughly 495–570 nm. In subtractive color systems, used in painting and color printing, it is created by a combination of yellow and cyan; in the RGB color model, used on television and computer screens, it is one of the additive primary colors, along with red and blue, which are mixed in different combinations to create all other colors. By far the largest contributor to green in nature is chlorophyll, the chemical by which plants photosynthesize and convert sunlight into chemical energy. Many creatures have adapted to their green environments by taking on a green hue themselves as camouflage. Several minerals have a green color, including the emerald, which is colored green by its chromium content.During post-classical and early modern Europe, green was the color commonly associated with wealth, merchants, bankers and the gentry, while red was reserved for the nobility. For this reason, the costume of the Mona Lisa by Leonardo da Vinci and the benches in the British House of Commons are green while those in the House of Lords are red.[1] It also has a long historical tradition as the color of Ireland and of Gaelic culture. It is the historic color of Islam, representing the lush vegetation of Paradise. It was the color of the banner of Muhammad, and is found in the flags of nearly all Islamic countries.[2]In surveys made in American, European, and Islamic countries, green is the color most commonly associated with nature, life, health, youth, spring, hope, and envy.[3] In the European Union and the United States, green is also sometimes associated with toxicity and poor health,[4] but in China and most of Asia, its associations are very positive, as the symbol of fertility and happiness.[3] Because of its association with nature, it is the color of the environmental movement. Political groups advocating environmental protection and social justice describe themselves as part of the Green movement, some naming themselves Green parties. This has led to similar campaigns in advertising, as companies have sold green, or environmentally friendly, products. Green is also the traditional color of safety and permission; a green light means go ahead, a green card permits permanent residence in the United States.'),
                ),
                LSizedBox(),
                Button(onTap: (){}, name: 'Accept',),
                LSizedBox(),
                WhiteButtonNoLogo(name: 'Decline', onTap: (){})              
              ],
            ),
          ),
        ),
      ),
    );
  }
}
