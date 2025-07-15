import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';

class CustomMultipleSelectorDropdown extends StatefulWidget {
  final String? hintText;
  final List<String> item;
  final List<String>? intData;
  final Function(List<String>)? onSelectionChanged;

  const CustomMultipleSelectorDropdown({
    super.key,
    required this.item,
    this.onSelectionChanged,
    this.hintText,
    this.intData,
  });

  @override
  State<CustomMultipleSelectorDropdown> createState() =>
      _CustomMultipleSelectorDropdownState();
}

class _CustomMultipleSelectorDropdownState
    extends State<CustomMultipleSelectorDropdown> {
  List<String> selectedItems = [];
  @override
  void initState() {
    super.initState();
    selectedItems = widget.intData ?? [];
  }

  void _showPopupMenu(BuildContext context) async {
    final RenderBox renderBox = context.findRenderObject() as RenderBox;
    final Offset position = renderBox.localToGlobal(
      Offset(0, -renderBox.size.height - 8),
    );
    final selected = await showMenu(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.sizeOf(context).height * 0.25,
      ),
      color: Colors.white,
      menuPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 4),
      context: context,
      position: RelativeRect.fromLTRB(
        position.dx,
        position.dy + renderBox.size.height,
        position.dx + renderBox.size.width,
        position.dy + renderBox.size.height + 8,
      ),
      items: [
        PopupMenuItem(
          enabled: false,
          value: null,
          height: 40,
          child: InkWell(
            onTap: () {
              context.pop();
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('select_items'.tr(), style: AppTextStyles.headline6),
                  Container(
                    padding: const EdgeInsets.all(4),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('hide'.tr(), style: AppTextStyles.bodyText3),
                        const SizedBox(width: 4),
                        const Icon(
                          Icons.keyboard_arrow_up_outlined,
                          color: AppColors.primary,
                          size: 20,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        // Divider
        const PopupMenuItem(
          enabled: false,
          value: null,
          height: 1,
          child: Divider(
            height: 1,
            thickness: 1,
            color: AppColors.primary,
            indent: 8,
            endIndent: 8,
          ),
        ),

        // Menu items
        ...widget.item.map((item) {
          return PopupMenuItem(
            value: item,
            enabled: true,
            child: StatefulBuilder(
              builder: (context, setStateMenu) {
                return ListTile(
                  hoverColor: AppColors.primary,
                  onTap: () {
                    setState(() {
                      if (selectedItems.contains(item)) {
                        selectedItems.remove(item);
                      } else {
                        selectedItems.add(item);
                      }
                      if (widget.onSelectionChanged != null) {
                        widget.onSelectionChanged!(selectedItems);
                      }
                    });
                    setStateMenu(() {}); // Update checkbox state in menu
                  },
                  contentPadding: const EdgeInsets.symmetric(horizontal: 0),
                  title: Row(
                    children: [
                      Text(item, style: AppTextStyles.headline6),
                      Flexible(
                        child: SizedBox(
                          width: double.infinity,
                          // To fill the remaining space
                        ),
                      ),
                    ],
                  ),
                  leading: CustomCheckbox(
                    initialValue: selectedItems.contains(item),
                    onChanged: (value) {
                      setState(() {
                        if (selectedItems.contains(item)) {
                          selectedItems.remove(item);
                        } else {
                          selectedItems.add(item);
                        }
                        if (widget.onSelectionChanged != null) {
                          widget.onSelectionChanged!(selectedItems);
                        }
                      });
                      setStateMenu(() {}); // Update checkbox state in menu
                    },
                  ),
                );
              },
            ),
          );
        }),
      ],
    ).then((value) {
      if (widget.onSelectionChanged != null) {
        widget.onSelectionChanged!(selectedItems);
      }
      return value;
    });

    if (selected != null) {
      setState(() {
        if (selectedItems.contains(selected)) {
          selectedItems.remove(selected);
        } else {
          selectedItems.add(selected);
        }

        if (widget.onSelectionChanged != null) {
          widget.onSelectionChanged!(selectedItems);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      hoverColor: AppColors.primary,
      borderRadius: BorderRadius.circular(12),
      onTap: () => _showPopupMenu(context),
      child: CustomContainer(
        shapeBorderRadius: 12,
        padding: 0,
        paddingH: 8,
        paddingV: 10,
        child: Row(
          children: [
            Expanded(
              child: SizedBox(
                height: 30,
                child:
                selectedItems.isNotEmpty
                    ? ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                      ),
                      alignment: Alignment.centerLeft,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.amberAccent,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(right: 4.0),
                        child: Text(
                          selectedItems[index],
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Colors.amber,
                          ),
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const SizedBox(width: 8);
                  },
                  itemCount: selectedItems.length,
                )
                    : Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: Text(
                    widget.hintText ?? 'filter_by_category'.tr(),
                    style: AppTextStyles.headline6,
                  ),
                ),
              ),
            ),
            Icon(Icons.keyboard_arrow_down_outlined, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}

class CustomContainer extends StatelessWidget {
  final Widget child;
  final double? padding;
  final double? paddingH;
  final double? paddingV;
  final double? width;
  final double? height;
  final double? shapeBorderRadius;
  final Color? color;
  final Color? borderColor;
  final BoxShadow? boxShadow;
  final bool hasBorder;

  const CustomContainer({
    super.key,
    required this.child,
    this.padding,
    this.paddingH,
    this.paddingV,
    this.width,
    this.hasBorder = true,
    this.shapeBorderRadius,
    this.color,
    this.height,
    this.borderColor,
    this.boxShadow,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      padding:
      paddingH != null || paddingV != null
          ? EdgeInsets.symmetric(
        horizontal: paddingH ?? 0,
        vertical: paddingV ?? 0,
      )
          : EdgeInsets.all(padding ?? 12),
      decoration: ShapeDecoration(
        color: color ?? Colors.white,
        shadows: boxShadow != null ? [boxShadow!] : [],
        shape: RoundedRectangleBorder(
          side:
          hasBorder
              ? BorderSide(
            width: 1,
            color: borderColor ?? AppColors.primary,
          )
              : BorderSide.none,
          borderRadius: BorderRadius.circular(shapeBorderRadius ?? 16),
        ),
      ),
      child: child,
    );
  }
}



class CustomCheckbox extends StatefulWidget {
  bool initialValue;
  bool isViewOnly;
  final ValueChanged<bool> onChanged;

  CustomCheckbox({
    super.key,
    this.initialValue = false,
    this.isViewOnly = false,
    required this.onChanged,
  });

  @override
  State<CustomCheckbox> createState() => _CustomCheckboxState();
}

class _CustomCheckboxState extends State<CustomCheckbox> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (widget.isViewOnly) return;
        setState(() {
          widget.initialValue = !widget.initialValue;
        });
        widget.onChanged(widget.initialValue);
      },
      child: Container(
        height: 20, // حجم المربع
        width: 20,
        decoration: BoxDecoration(
          color: widget.initialValue ? Colors.amber : AppColors.primary,
          border: Border.all(

            color: widget.initialValue
                ? Colors.transparent
                : AppColors.primary,
            width: 2, // سماكة الإطار
          ),
          borderRadius: BorderRadius.circular(6),
        ),
        child: widget.initialValue
            ? const Icon(
          Icons.check,
          color: Colors.white,
          size: 14,
        )
            : null,
      ),
    );
  }
}
