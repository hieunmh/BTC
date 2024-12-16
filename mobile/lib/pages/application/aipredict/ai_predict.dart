import 'package:btc/controllers/app/ai_predict_controller.dart';
import 'package:btc/pages/application/aipredict/ai_text_input.dart';
import 'package:btc/theme/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class AiPredictPage extends StatelessWidget {
  const AiPredictPage({super.key});

  @override
  Widget build(BuildContext context) {

    final ThemeController themecontroller = Get.find<ThemeController>();
    final AiPredictController aipredictcontroller = Get.find<AiPredictController>();

    return Obx(() =>
      Scaffold(
        backgroundColor: themecontroller.theme.value == 'light' ? const Color(0xfff6f6f6) : const Color(0xff1b2129),
        appBar: AppBar(
          title: const Text('AI Predict'),
          backgroundColor: themecontroller.theme.value == 'light' ? const Color(0xfff6f6f6) : const Color(0xff1b2129),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  height: 30,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: aipredictcontroller.algoList.length,
                    separatorBuilder: (context, index) => const SizedBox(width: 15), 
                    itemBuilder: (context, index) {
                      final item = aipredictcontroller.algoList[index];
                      return GestureDetector(
                        onTap: () {
                          aipredictcontroller.selectedAlgo.value = item;
                        },
                        child: Container(
                          width: (Get.width - 60) / 3,
                          decoration: BoxDecoration(
                            color: aipredictcontroller.selectedAlgo.value == item ? const Color(0xfffbc700) : Colors.transparent,
                            border: Border.all(
                              color: const Color(0xfffbc700),
                              width: 1
                            ),
                            borderRadius: BorderRadius.circular(5)
                          ),
                          child: Center(
                            child: Text(
                              item,
                              style: TextStyle(
                                color: aipredictcontroller.selectedAlgo.value == item ? Colors.white : const Color(0xfffbc700),
                                fontWeight: aipredictcontroller.selectedAlgo.value == item ? FontWeight.bold : FontWeight.w500
                              ),
                            ),
                          ),
                        )
                      );
                    } 
                  ),
                ),

                Text(
                  aipredictcontroller.selectedAlgo.value, 
                  style: const TextStyle(
                    color: Colors.transparent
                  )
                ),


                AITextInput(
                  hintText: 'Open Price', 
                  placeholder: '\$0', 
                  obscureText: false, 
                  ctrler: aipredictcontroller.openPriceController, 
                  borderColor: Colors.transparent, 
                  errorMsg: '',
                  theme: themecontroller.theme.value
                ),
      
                const SizedBox(height: 10),
      
                AITextInput(
                  hintText: 'High Price', 
                  placeholder: '\$0', 
                  obscureText: false, 
                  ctrler: aipredictcontroller.highPriceController, 
                  borderColor: Colors.transparent, 
                  errorMsg: '',
                  theme: themecontroller.theme.value
                ),
      
                const SizedBox(height: 10),
      
                AITextInput(
                  hintText: 'Low Price', 
                  placeholder: '\$0', 
                  obscureText: false, 
                  ctrler: aipredictcontroller.lowPriceController, 
                  borderColor: Colors.transparent, 
                  errorMsg: '',
                  theme: themecontroller.theme.value
                ),
      
                const SizedBox(height: 10),
      
                AITextInput(
                  hintText: 'Close Price', 
                  placeholder: '\$0', 
                  obscureText: false, 
                  ctrler: aipredictcontroller.closePriceController, 
                  borderColor: Colors.transparent, 
                  errorMsg: '',
                  theme: themecontroller.theme.value
                ),

                const SizedBox(height: 5),

                Text(
                  aipredictcontroller.errorMsg.value,
                  style: const TextStyle(
                    color: Colors.red,
                    fontSize: 14,
                    fontWeight: FontWeight.bold
                  ),
                ),

                const SizedBox(height: 10),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        aipredictcontroller.reset();
                      },
                      child: Container(
                        width: (Get.width - 45) / 2,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(
                            color: const Color(0xfffbc700),
                            width: 1
                          )
                        ),
                        child: const Center(
                            child: Text(
                              'Reset',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                      ),
                    ),


                    GestureDetector(
                      onTap: () {
                        aipredictcontroller.predict();
                      },
                      child: Container(
                        height: 50,
                        width: (Get.width - 45) / 2,
                        decoration: BoxDecoration(
                          color: const Color(0xfffbc700),
                          borderRadius: BorderRadius.circular(5)
                        ),
                        child: Center(
                          child: aipredictcontroller.isLoading.value ? 
                          LoadingAnimationWidget.staggeredDotsWave(
                            color: Colors.white, 
                            size: 24
                          ) : const Text(
                            'Predict',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                )

                
              ],
            ),
          ),
        )
      ),
    );
  }
}