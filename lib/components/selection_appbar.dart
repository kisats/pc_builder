import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pc_builder/components/icons/pop_icon.dart';
import 'package:pc_builder/components/icons/soft_icon_button.dart';
import 'package:pc_builder/components/soft_container.dart';
import 'package:pc_builder/providers/cpu/cpu_selection_provider.dart';
import 'package:pc_builder/providers/filter_provider.dart';
import 'package:pc_builder/providers/selection_provider.dart';
import 'package:provider/provider.dart';

class SelectionAppbar extends StatelessWidget implements PreferredSizeWidget {
/*   final Color filterIconColor;
  final bool canOpenFilter;
  final FocusNode focus;
  final TextEditingController controller;
  final String hint; */

/*   const SelectionAppbar(
      {Key key, this.filterIconColor, this.canOpenFilter, this.focus, this.controller, this.hint})
      : super(key: key); */

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return AppBar(
        toolbarHeight: 70,
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        leading: PopIcon(),
        actions: [
          Consumer<FilterProvider>(
            builder: (_, state, __) => SoftIconButton(
              icon: FontAwesomeIcons.filter,
              iconSize: 21,
              padding: const EdgeInsets.only(right: 15),
              color: state.canBeOpened
                  ? state.canClear && state.wasApplied
                      ? theme.textTheme.headline1.color
                      : theme.iconTheme.color
                  : theme.iconTheme.color.withOpacity(0.5),
              onTap: state.canBeOpened
                  ? () {
                      final FocusScopeNode currentScope = FocusScope.of(context);
                      if (!currentScope.hasPrimaryFocus && currentScope.hasFocus) {
                        FocusManager.instance.primaryFocus.unfocus();
                      }
                      Scaffold.of(context).openEndDrawer();
                    }
                  : null,
            ),
          ),
        ],
        title: SoftContainer(
          margin: const EdgeInsets.only(bottom: 5, left: 5, right: 5, top: 2),
          height: 43,
          child: Consumer<SelectionProvider>(
            builder: (_, state, __) => Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SoftIconButton(
                  icon: FontAwesomeIcons.search,
                  iconSize: 21,
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  color: state.textController.text.isNotEmpty
                      ? theme.textTheme.headline2.color
                      : theme.inputDecorationTheme.hintStyle.color,
                  onTap: state.textController.text.isEmpty
                      ? () {
                          state.focus.requestFocus();
                        }
                      : null,
                ),
                Expanded(
                  child: TextField(
                    focusNode: state.focus,
                    controller: state.textController,
                    cursorRadius: Radius.circular(5),
                    cursorWidth: 1.8,
                    style: theme.textTheme.headline2,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.only(bottom: 4),
                      hintText: "Search",
                    ),
                  ),
                ),
                state.textController.text.isNotEmpty
                    ? SoftIconButton(
                        icon: FontAwesomeIcons.times,
                        onTap: () {
                          state.textController.clear();
                          final FocusScopeNode currentScope = FocusScope.of(context);
                          if (!currentScope.hasPrimaryFocus && currentScope.hasFocus) {
                            FocusManager.instance.primaryFocus.unfocus();
                          }
                        },
                      )
                    : Container(),
              ],
            ),
          ),
        ));
  }

  @override
  Size get preferredSize => Size.fromHeight(70);
}
