import 'package:e_shop/domain/utils/constants.dart';
import 'package:e_shop/domain/utils/extensions.dart';
import 'package:e_shop/domain/utils/lists.dart';
import 'package:e_shop/domain/utils/localization.dart';
import 'package:e_shop/domain/utils/styles.dart';
import 'package:e_shop/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DropdownPicker extends StatelessWidget {
  final String? title;
  final String? myValue;
  final List<ListItem>? items;
  final double borderRadius;
  final Function? onChange;
  final Function? onSubmit;
  final Color darkColor;

  const DropdownPicker({
    Key? key,
    this.title,
    this.myValue,
    this.items,
    this.onChange,
    this.onSubmit,
    this.darkColor = const Color(0xFF181818),
    this.borderRadius = 10,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment : CrossAxisAlignment.start,
      children: <Widget> [
        Text(" $title",
          maxLines: 1,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600
          )
        ),
        const SizedBox(height: 4),
        GestureDetector(
          onTap: () => isIosApplication ? _buildCupertinoPicker(context) : null,
          child: InputDecorator(
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
                borderSide: BorderSide(
                  color: Theme.of(context).brightness == Brightness.light
                  ? Colors.black : Colors.white,
                  width: 0.5
                )
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
                borderSide: BorderSide(
                  color: Theme.of(context).brightness == Brightness.light
                  ? Colors.black : Colors.white,
                  width: 0.5
                )
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
                borderSide: BorderSide(
                  color: Theme.of(context).brightness == Brightness.light
                  ? Colors.black : Colors.white,
                  width: 0.5
                )
              ),
              contentPadding: const EdgeInsets.all(10),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: myValue,
                isDense: true,
                isExpanded: true,
                items: items!.map((ListItem item) {
                  return DropdownMenuItem<String>(
                    value: item.value,
                    child: Text(item.title),
                  );
                }).toList(),
                icon: Icon(
                  Icons.arrow_drop_down,
                  color: Theme.of(context).brightness == Brightness.dark ?
                  Colors.white : Colors.black,
                ),
                selectedItemBuilder: (BuildContext ctx) {
                  return items!.map<Widget>((ListItem item) {
                    return DropdownMenuItem(
                      value: item.value,
                      child: Text(
                        item.title,
                        style: TextStyle(
                          color: Theme.of(context).brightness == Brightness.light ?
                          Colors.black : Colors.white
                        )
                      )
                    );
                  }).toList();
                },
                onChanged: !isIosApplication ?
                (val) async => await onChange!(val) : null,
              ),
            ),
          ),
        ),
      ]
    );
  }

  void _buildCupertinoPicker(context){
    showCupertinoModalPopup(context: context, builder: (context){
       return CupertinoActionSheet(
         actions: [
           SizedBox(
            height: MediaQuery.of(context).size.height * 0.25,
            child: NotificationListener<ScrollEndNotification>(
              onNotification: (notification){
                if (notification.metrics is! FixedExtentMetrics) {
                  return false;
                }
                final index = (notification.metrics as FixedExtentMetrics).itemIndex;
                final item = items![index];
                onChange!(item.value);
                // False allows the event to bubble up further
                return false;
              },
              child: CupertinoPicker(
                magnification: 1.5,
                backgroundColor: Theme.of(context).brightness == Brightness.light ?
                Colors.white : const Color(0xFF181818),
                itemExtent: 40,
                scrollController: FixedExtentScrollController(initialItem: items!.indexWhere((element) => element.value == myValue)),
                onSelectedItemChanged: null, //height of each item
                children: List.generate(items!.length, (index) => items![index]).map((item) => Center(
                  child: Text(
                    item.title,
                    style: TextStyle(
                    fontSize: 16,
                    color: accent(context)
                    ),
                  ),
                )).toList(),
               ),
             ),
           ),
           Container(
             decoration: BoxDecoration(
               color: Theme.of(context).brightness == Brightness.light ?
               Colors.white : const Color(0xFF181818),
               borderRadius: BorderRadius.circular(10)
             ),
             child: CupertinoActionSheetAction(
               child: Text(
                 AppLocalizations.of(context, 'choose'),
                 style: TextStyle(
                   fontFamily: appFont,
                   color: prefsProvider.theme.accentColor,
                   fontWeight: FontWeight.w600
                 ),
               ),
               onPressed: () async{
                 Navigator.pop(context);
                 await onSubmit!();
               },
             ),
           ),
         ],
         cancelButton: Container(
           decoration: BoxDecoration(
             color: Theme.of(context).brightness == Brightness.light ?
             Colors.white : const Color(0xFF181818),
             borderRadius: BorderRadius.circular(10)
           ),
           child: CupertinoActionSheetAction(
             child: Text(
               AppLocalizations.of(context, 'cancel'),
               style: const TextStyle(
                 fontFamily: appFont,
                 color: Colors.red,
                 fontWeight: FontWeight.w600
               ),
             ),
             onPressed: () => Navigator.pop(context),
           ),
         ),
       );
    });
  }
}
