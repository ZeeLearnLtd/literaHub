import 'dart:async';

import 'package:flutter/material.dart';

import '../core/responsive.dart';
import '../core/theme/hex.dart';
import '../core/theme/light_colors.dart';


class ZeeDropDown<T> extends StatefulWidget {
  final List<T> items;
  final String Function(T) displayFunction;
  final void Function(T?) onChanged;
  final TextEditingController? textController;
  final String? hintText;
  final String? backgroundColor;
  final String title;
  final bool? enable;
  final TextStyle? textStyle;

  const ZeeDropDown(
      {Key? key,
        required this.title,
        required this.textController,
        required this.hintText,
        required this.items,
        required this.displayFunction,
        required this.onChanged,
        this.textStyle,
        this.backgroundColor,
        this.enable})
      : super(key: key);

  @override
  SimpleAccountMenuState<T> createState() => SimpleAccountMenuState<T>();
}

class SimpleAccountMenuState<T> extends State<ZeeDropDown<T>>
    with SingleTickerProviderStateMixin {
  final ScrollController _scrollController =
  ScrollController(initialScrollOffset: 0, keepScrollOffset: true);
  late GlobalKey _key;
  bool isMenuOpen = false;
  late Offset buttonPosition;
  late Size buttonSize;
  late OverlayEntry _overlayEntry;
  late OverlayEntry _overlayFullBuilder;
  late BorderRadius _borderRadius;
  late AnimationController _animationController;

  List<T> _filteredList = [];
  List<T> _subFilteredList = [];

  Timer? _debounce;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    );

    _filteredList = widget.items;
    _subFilteredList = _filteredList;
    _borderRadius = BorderRadius.circular(4);
    _key = LabeledGlobalKey("button_icon");
    super.initState();

    
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _animationController.dispose();
    super.dispose();
  }

  findButton() {
    RenderBox renderBox = _key.currentContext?.findRenderObject() as RenderBox;
    buttonSize = renderBox.size;
    buttonPosition = renderBox.localToGlobal(Offset.zero);
  }

  void closeMenu() {
    _overlayEntry.remove();
    _overlayFullBuilder.remove();
    _animationController.reverse();
    isMenuOpen = !isMenuOpen;
  }

  void openMenu() {
    findButton();
    _animationController.forward();
    _overlayEntry = _overlayEntryBuilder();
    _overlayFullBuilder = _overlayBuilder();
    Overlay.of(context).insert(_overlayFullBuilder);
    Overlay.of(context).insert(_overlayEntry);
    isMenuOpen = !isMenuOpen;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (widget.enable != null && widget.enable!) {
          if (isMenuOpen) {
            closeMenu();
          } else {
            openMenu();
          }
        }
      },
      child: Container(
          height: Responsive.isMobile(context) ? 55 : 30,
          //width: 80,
          padding: const EdgeInsets.only(left: 10, top: 0),
          key: _key,
          decoration: BoxDecoration(
            color: widget.backgroundColor == null ||
                widget.backgroundColor!.isEmpty
                ? LightColors.kLightGray
                : HexColor.fromHex(widget.backgroundColor!).withOpacity(0.5),
            borderRadius: _borderRadius,
          ),
          child: /* true
            ?  */
          Container(
            child: TextFormField(
              enabled: widget.enable,
              style: widget.textStyle ?? LightColors.subtitleStyle10,
              controller: widget.textController,
              onChanged: (val) {
                debugPrint(
                    'OnChanged for search in dropdown is - $val  ${widget.displayFunction(_subFilteredList[0])} ');

                if (_debounce?.isActive ?? false) _debounce?.cancel();
                _debounce = Timer(const Duration(milliseconds: 500), () {
                  setState(() {
                    _filteredList = _subFilteredList.where((element) {
                      return widget
                          .displayFunction(element)
                          .toLowerCase()
                          .contains(widget.textController!.text.toLowerCase());
                    }).toList();

                    closeMenu();
                    openMenu();
                  });
                });
              },
              validator: (val) => val!.isEmpty ? 'Field can\'t empty' : null,
              onTap: () => openMenu(),
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: widget.hintText ?? "Write here...",
                hintStyle:
                const TextStyle(fontSize: 10.0, color: Colors.black38),
                suffixIcon: Icon(Icons.arrow_drop_down,
                    color: Colors.grey.withOpacity(0.5), size: 25),
                contentPadding:
                const EdgeInsets.symmetric(vertical: 10, horizontal: 0),
                isDense: true,
                /* suffixIconConstraints:
                      BoxConstraints.loose(MediaQuery.of(context).size),
                  suffix: InkWell(
                      onTap: () {
                        widget.textController!.clear();
                        openMenu();
                        setState(() => _filteredList = widget.items);
                      },
                      child: Icon(Icons.clear,
                          size: 12, color: Colors.grey.withOpacity(0.5))) */
              ),
            ),
          )),
    );
  }

  OverlayEntry _overlayEntryBuilder() {
    return OverlayEntry(
      builder: (context) {
        return Positioned(
          top: buttonPosition.dy > 250
              ? buttonPosition.dy -
              buttonSize.height / 2 -
              (_filteredList.length > 10 ? 7 : _filteredList.length) * 30
              : buttonPosition.dy + buttonSize.height,
          left: buttonPosition.dx,
          width: buttonSize.width,
          child: Material(
            color: Colors.white,
            child: Stack(
              children: <Widget>[
                _filteredList.isEmpty
                    ? const SizedBox(
                  height: 50,
                  child: Center(child: Text('No Data Available')),
                )
                    : Container(
                  height: _filteredList.length < 10
                      ? _filteredList.length * 30
                      : MediaQuery.of(context).size.height / 3,
                  // height: _filteredList.length * 47,
                  //color: widget.dropdownBgColor ?? Colors.grey.shade200,
                  padding: const EdgeInsets.all(0),
                  margin: const EdgeInsets.all(0),
                  child: Scrollbar(
                    controller: _scrollController,
                    // thickness: 40,
                    thumbVisibility: true,
                    trackVisibility: true,
                    child: ListView.builder(
                      itemExtent: _filteredList.length > 50 ? 40 : 30,
                      controller: _scrollController,
                      // physics: CustomScrollPhysics(),
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      itemCount: _filteredList.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            closeMenu();

                            widget.textController!.text = widget
                                .displayFunction(_filteredList[index]);

                            widget.onChanged(_filteredList[index]);
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Container(
                                  padding: const EdgeInsets.only(
                                      left: 10, right: 10, top: 5),
                                  child: Text(
                                      widget.displayFunction(
                                          _filteredList[index]),
                                      textAlign: TextAlign.center,
                                      style: LightColors.subtitleStyle10,
                                      overflow: TextOverflow.ellipsis),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  OverlayEntry _overlayBuilder() {
    return OverlayEntry(
      builder: (context) {
        return Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {
              widget.textController?.text = '';
              // _filteredList.clear();
              _filteredList = widget.items;
               widget.onChanged(null);
              closeMenu();
            },
            child: Container(
              margin: const EdgeInsets.all(10),
              color: Colors.black87.withOpacity(0.1),
            ),
          ),
        );
      },
    );
  }
}
