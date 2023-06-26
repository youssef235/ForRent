import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:for_rent/Constants/Catigories.dart';
import 'package:for_rent/Constants/size_config.dart';
import 'package:for_rent/Providers/selected_value_provider.dart';
import 'package:provider/provider.dart';

class SelectCatigory extends StatelessWidget {
  SelectCatigory({super.key});

  String? selectedValue;

  final TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var selectedValueProvider = Provider.of<ValueProvider>(context);

    return Container(
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 160, 160, 160),
        borderRadius: BorderRadius.circular(15),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton2<String>(
          isExpanded: true,
          hint: const Padding(
            padding: EdgeInsets.only(left: 8.0, top: 10.0, bottom: 10.0),
            child: Text(
              'Select Category',
              style: TextStyle(
                  fontSize: 15,
                  color: Colors.white,
                  fontWeight: FontWeight.w900),
            ),
          ),
          items: Catigories()
              .itemscatigories
              .map((item) => DropdownMenuItem(
                    value: item,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 8.0, top: 8.0, bottom: 8.0),
                      child: Text(
                        item,
                        style: const TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ))
              .toList(),
          value: selectedValueProvider.CategoryValue,
          onChanged: (value) {
            selectedValueProvider.changedvalue(value!);
          },
          buttonStyleData: const ButtonStyleData(
            height: 40,
            width: 150,
          ),
          dropdownStyleData: const DropdownStyleData(
            maxHeight: 200,
          ),
          menuItemStyleData: const MenuItemStyleData(
              height: 40, overlayColor: MaterialStatePropertyAll(Colors.black)),
          dropdownSearchData: DropdownSearchData(
            searchController: textEditingController,
            searchInnerWidgetHeight: 50,
            searchInnerWidget: Container(
              height: 50,
              padding: const EdgeInsets.only(
                top: 8,
                bottom: 4,
                right: 8,
                left: 8,
              ),
              child: TextFormField(
                expands: true,
                maxLines: null,
                controller: textEditingController,
                decoration: InputDecoration(
                  isDense: true,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 8,
                  ),
                  hintText: 'Search for a Category...',
                  hintStyle: const TextStyle(fontSize: 13),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
            searchMatchFn: (item, searchValue) {
              return (item.value
                  .toString()
                  .toLowerCase()
                  .contains(searchValue.toLowerCase()));
            },
          ),
          //This to clear the search value when you close the menu
          onMenuStateChange: (isOpen) {
            if (!isOpen) {
              textEditingController.clear();
            }
          },
        ),
      ),
    );
  }
}
