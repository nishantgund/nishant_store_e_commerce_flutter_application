import 'package:flutter/material.dart';
import 'package:nishant_store/utils/constants/colors.dart';
import 'package:nishant_store/utils/helpers/helper_functions.dart';

import '../../../../utils/constants/colors.dart';

class TChoiceChip extends StatelessWidget {
  const TChoiceChip({
    super.key,
    required this.text,
    required this.selected,
    this.onSelected,
  });

  final String text;
  final bool selected;
  final void Function(bool)? onSelected;
  

  Color? getColor(String value){
    if( value == 'Green'){
      return Colors.green;
    }
    else if(value == 'Blue'){
      return ColorsData.blue;
    }
    else if(value == 'Black'){
      return Colors.black;
    }
    else if(value == 'Yellow'){
      return Colors.yellow;
    }
    else if(value == 'White'){
      return Colors.white;
    }
    else if(value == 'Red'){
      return Colors.red;
    }
    else{
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    bool dark = THelperFunction.isDarkMode(context);
    final isColor = getColor(text) != null;
    return Theme(
      data: Theme.of(context).copyWith(canvasColor: Colors.transparent),
      child: ChoiceChip(
        label: isColor ? SizedBox() : Text(text),
        selected: selected,
        onSelected: onSelected,
        labelStyle: TextStyle(fontWeight: FontWeight.bold, color: dark ? Colors.white : Colors.black ),
        avatar: isColor ? Container( width: 50, height: 50, decoration: BoxDecoration(borderRadius: BorderRadius.circular(100),color: getColor(text)),) : null,
        shape: isColor ? CircleBorder() : null,
        labelPadding: isColor ? EdgeInsets.all(0) : null,
        padding: isColor ? EdgeInsets.all(0) : null,
        selectedColor: ColorsData.blue,
        backgroundColor: isColor ? ColorsData.blue: null,
      ),
    );
  }
}
