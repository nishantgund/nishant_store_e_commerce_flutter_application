import 'package:flutter/material.dart';

import '../../../../utils/helpers/helper_functions.dart';


class TCouponCode extends StatelessWidget {
  const TCouponCode({
    super.key,
  });


  @override
  Widget build(BuildContext context) {
    bool dark = THelperFunction.isDarkMode(context);
    return Container(
      decoration: BoxDecoration(
        color: dark ? Colors.black : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: dark ? Colors.white.withOpacity(0.5) : Colors.black.withOpacity(0.3) ),
      ),
      padding: EdgeInsets.only(top: 8,bottom: 8,right: 8,left: 16),
      child: Row(
        children: [
          Flexible(
            child: TextFormField(
              decoration: InputDecoration(
                hintText: 'Have a promo code? Enter here',
                focusedBorder: InputBorder.none,
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
              ),
            ),
          ),

          // Button
          SizedBox(
              width : 80,
              child: ElevatedButton(
                onPressed: (){},
                style: ElevatedButton.styleFrom(
                    foregroundColor: dark ? Colors.white : Colors.black.withOpacity(0.5),
                    backgroundColor: Colors.grey.withOpacity(0.3),
                    side: BorderSide(color: Colors.grey.withOpacity(0.1))
                ),
                child: Text('Apply'),
              )
          )
        ],
      ),
    );
  }
}