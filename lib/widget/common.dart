import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:mc_plugin3/util/validate_util.dart';
import 'package:velocity_x/velocity_x.dart';

// extension ShimmerExtension on Widget {
//   Widget shimmerList(bool loading, double? itemHeight, int count) =>
//       ShimmerList(loading: loading, itemHeight: itemHeight, count: count, child: this);
// }

extension MyScrollExtension on Widget {
  Widget scrollV({Key? key, ScrollController? controller, EdgeInsetsGeometry? padding}) => SingleChildScrollView(
      key: key,
      scrollDirection: Axis.vertical,
      controller: controller,
      physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
      padding: padding,
      child: this);
}

extension FormExtension<T> on String {
  // you may do this:
  // 'Bertemu Dengan:'.dropDown(...)
  MyFormBuilderDropDown dropDown(
          String field, List<T> list, String Function(T) rowLabel, String Function(T) rowValue) =>
      MyFormBuilderDropDown(
        field,
        this,
        items: list
            .map((o) => DropdownMenuItem(
                  value: rowValue(o),
                  child: rowLabel(o).text.make(),
                ))
            .toList(),
        validator: ValidateUtil.notEmpty,
      );
  // 'Keterangan:'.dropDown(...)
  FormBuilderTextField textField(String field, {int maxLines = 1}) => FormBuilderTextField(
      name: field,
      maxLines: maxLines,
      decoration: InputDecoration(label: text.make()),
      validator: ValidateUtil.notEmpty);
}

class TopRoundEdge extends StatelessWidget {
  final Color? backColor;
  const TopRoundEdge({Key? key, this.backColor = Colors.indigo}) : super(key: key);

  @override
  Widget build(BuildContext context) => [
        Container(color: backColor),
        // Container(color: clientTheme?.colorMain ?? Colors.indigo),
        Container(
            decoration: const BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.vertical(top: Radius.circular(50)))),
      ].stack().h(20);
}

class KeyValVertical extends StatelessWidget {
  final Widget label;
  final Widget value;
  const KeyValVertical(this.label, this.value, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => [
        label,
        8.heightBox,
        value,
      ].column().p8().card.rounded.elevation(4).make();
}

class KeyVal extends StatelessWidget {
  final String ky;
  final String val;
  final bool white;
  const KeyVal(this.ky, this.val, {Key? key, this.white = false}) : super(key: key);

  @override
  Widget build(context) => [
        Flexible(child: ky.text.sm.color(white ? Colors.white : Colors.black).make().opacity50()),
        val.selectableText.sm.color(white ? Colors.white : Colors.black).end.make().expand(),
      ].row(axisSize: MainAxisSize.max, alignment: MainAxisAlignment.spaceBetween);
}

class KeyValNormalSize extends StatelessWidget {
  final String ky;
  final String val;
  final bool white;
  const KeyValNormalSize(this.ky, this.val, {Key? key, this.white = false}) : super(key: key);

  @override
  Widget build(context) => [
        Flexible(child: ky.text.color(white ? Colors.white : Colors.black).make()),
        val.selectableText.color(white ? Colors.white : Colors.black).end.make().expand(),
      ].row(axisSize: MainAxisSize.max, alignment: MainAxisAlignment.spaceBetween);
}

class KeyValChip extends StatelessWidget {
  final String ky;
  final String val;
  final bool white;
  const KeyValChip(this.ky, this.val, {Key? key, this.white = false}) : super(key: key);

  @override
  Widget build(context) => [
        ky.text.sm.color(white ? Colors.white : Colors.black).make().expand(),
        Chip(label: val.text.xl.bold.color(white ? Colors.white : Colors.black).end.make().p8()),
      ].row(axisSize: MainAxisSize.max, alignment: MainAxisAlignment.spaceBetween);
}

class TextIcon extends StatelessWidget {
  final IconData icon;
  final String text;
  final double? iconSize;
  final double? textSize;
  final bool white;
  final int? maxLines;
  const TextIcon(this.icon, this.text,
      {Key? key, this.iconSize = 14, this.textSize = 11, this.white = false, this.maxLines})
      : super(key: key);

  @override
  Widget build(context) => [
        Icon(icon, color: white ? Colors.white : Colors.indigo, size: iconSize).w(18),
        8.widthBox,
        // text.text.size(textSize).maxLines(1).ellipsis.color(white ? Colors.white : Colors.black).make().expand(),
        // size ga bisa pake velocityx
        Text(
          text,
          style: TextStyle(
              fontSize: textSize, color: white ? Colors.white : Colors.black, overflow: TextOverflow.ellipsis),
          maxLines: maxLines,
        ).expand()
      ].row();
}

class MyButton extends StatelessWidget {
  final String label;
  final double height;
  final VoidCallback onTap;
  const MyButton(this.label, {Key? key, required this.onTap, this.height = 56.0}) : super(key: key);

  @override
  Widget build(context) => Material(
      borderRadius: BorderRadius.circular(10.0),
      elevation: 5.0,
      color: Colors.purple,
      child: MaterialButton(
          onPressed: onTap,
          minWidth: double.infinity,
          height: height,
          child: Text(label, style: const TextStyle(color: Colors.white))));
}

// DropDown Form
class MyFormBuilderDropDown<T> extends StatelessWidget {
  final String name;
  final String label;
  final List<DropdownMenuItem<T>> items;
  final FormFieldValidator<T>? validator;
  final ValueChanged<T?>? onChanged;
  final DropdownButtonBuilder? selectedItemBuilder;
  const MyFormBuilderDropDown(this.name, this.label,
      {Key? key, required this.items, this.validator, this.onChanged, this.selectedItemBuilder})
      : super(key: key);

  @override
  Widget build(context) => FormBuilderDropdown<T>(
      name: name,
      decoration: InputDecoration(
          labelText: label,
          contentPadding: const EdgeInsets.all(12),
          filled: true,
          border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(12)), borderSide: BorderSide.none),
          errorBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)), borderSide: BorderSide(color: Colors.red, width: 1)),
          fillColor: Colors.blueGrey.shade50),
      items: items,
      validator: validator,
      onChanged: onChanged,
      // style: const TextStyle(fontSize: 12),
      selectedItemBuilder: selectedItemBuilder,
      valueTransformer: (val) => val?.toString());
}

/// 15mar23 dont use. bug. better use FormBuilderTextField
class MyFormBuilderTextField extends StatelessWidget {
  final String name;
  final String label;
  final bool readOnly;
  final bool hideCounter;
  final int? maxLength;
  final int maxLines;
  final FormFieldValidator<String>? validator;
  final ValueChanged<String?>? onChanged;
  final VoidCallback? onReset;
  const MyFormBuilderTextField(
    this.name,
    this.label, {
    Key? key,
    this.readOnly = false,
    this.hideCounter = false,
    this.maxLength,
    this.maxLines = 1,
    this.validator,
    this.onChanged,
    this.onReset,
  }) : super(key: key);

  @override
  Widget build(context) => FormBuilderField<String>(
        name: name,
        builder: (field) => MyTextFormField(
          label,
          hideCounter: hideCounter,
          readOnly: readOnly,
          maxLength: maxLength,
          maxLines: maxLines,
          initialValue: field.value,
          errorText: field.errorText,
          onChanged: (value) => field.didChange(value),
        ),
        onChanged: onChanged,
        validator: validator,
        onReset: onReset,
      );
}

/// better use one textformfield to change all appearance
class MyTextFormField extends StatelessWidget {
  final bool hideCounter;
  final String? hintText;
  final String? errorText;
  final AutovalidateMode? autovalidateMode;
  final int? maxLength;
  final int maxLines;
  final bool readOnly;
  final String? initialValue;
  final ValueChanged<String>? onChanged;
  final TextEditingController? controller;
  final String label;
  final FormFieldSetter<String>? onSaved;
  final FormFieldValidator<String>? validator;
  final bool obscureText;
  final Widget? suffixIcon;
  const MyTextFormField(this.label,
      {Key? key,
      this.errorText,
      this.hintText,
      this.onChanged,
      this.hideCounter = false,
      this.autovalidateMode,
      this.maxLength,
      this.maxLines = 1,
      this.readOnly = false,
      this.initialValue,
      this.controller,
      this.onSaved,
      this.validator,
      this.suffixIcon,
      this.obscureText = false})
      : super(key: key);

  @override
  Widget build(context) => TextFormField(
      autovalidateMode: autovalidateMode,
      maxLength: maxLength,
      maxLines: maxLines,
      readOnly: readOnly,
      initialValue: initialValue,
      controller: controller,
      // textAlign: TextAlign.center,
      validator: validator,
      onSaved: onSaved,
      onChanged: onChanged,
      // style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.blueGrey.shade50,
        hintText: hintText,
        errorText: errorText,
        counterText: hideCounter ? '' : null,
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
          borderSide: BorderSide.none,
          // borderSide: BorderSide(
          //   color: Colors.blueGrey.shade50,
          //   width: 1,
          // ),
        ),
        errorBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)), borderSide: BorderSide(color: Colors.red, width: 1)),
        errorStyle: const TextStyle(fontSize: 11),
        labelText: label,
        suffixIcon: suffixIcon,
        contentPadding: const EdgeInsets.fromLTRB(10.0, 20.0, 20.0, 10.0),
        focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(
              color: Colors.orangeAccent,
              width: 2,
            )),
      ),
      obscureText: obscureText);
}

class MyAppBarTitleWithIcon extends StatelessWidget {
  final IconData icon;
  final String title;
  const MyAppBarTitleWithIcon(this.title, {Key? key, required this.icon}) : super(key: key);

  @override
  Widget build(context) => [
        Icon(icon, color: Colors.white),
        10.widthBox,
        Text(title, overflow: TextOverflow.fade).expand()
      ].row(axisSize: MainAxisSize.max);
}

class MyScaffold extends StatelessWidget {
  final Widget title;
  // final IconData icon;
  final Widget? body;
  final List<Widget>? actions;
  const MyScaffold(
    this.title, {
    Key? key,
    // required this.icon,
    this.body,
    this.actions,
  }) : super(key: key);

  @override
  Widget build(context) => Scaffold(
          body: [
        //appbar
        [
          const BackButton().p8(),
          title.p12().objectCenter(),
          actions?.row().objectCenterRight() ?? const SizedBox(),
        ].stack().safeArea(),
        body?.expand() ?? const SizedBox(),
      ].column(crossAlignment: CrossAxisAlignment.start));
}

// class MyScaffoldForm extends StatelessWidget {
//   final Widget title;
//   // final IconData icon;
//   final Widget? body;
//   final Widget? bottom;
//   final List<Widget>? actions;
//   const MyScaffoldForm(
//     this.title, {
//     Key? key,
//     // required this.icon,
//     this.body,
//     this.bottom,
//     this.actions,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) => Scaffold(
//         // appBar: AppBar(
//         //     title: MyAppBarTitleWithIcon(title, icon: icon),
//         //     actions: actions,
//         //     elevation: 0),
//         body: [
//           //appbar
//           [
//             const BackButton().p8(),
//             title.expand(),
//             IconButton(onPressed: () => Get.toNamed(Routes.developer), icon: const Icon(Icons.tiktok_outlined))
//                 .hide(isVisible: kDebugMode),
//             actions?.row() ?? const SizedBox(),
//           ].row(axisSize: MainAxisSize.max).safeArea(),
//           body?.expand() ?? const SizedBox(),
//           bottom ?? const SizedBox(),
//         ].column(crossAlignment: CrossAxisAlignment.start),
//       );
// }

// class ShimmerThis extends StatelessWidget {
//   final double? height;
//   final Widget child;
//   final bool loading;
//   const ShimmerThis({Key? key, this.loading = true, required this.child, this.height}) : super(key: key);

//   @override
//   Widget build(BuildContext context) => loading
//       ? Shimmer.fromColors(
//           baseColor: Colors.black12,
//           highlightColor: Colors.white30,
//           child: const SizedBox.shrink().card.make().wh(double.maxFinite, height ?? 40))
//       : child;
// }

// class ShimmerList extends StatelessWidget {
//   final double? itemHeight;
//   final Widget child;
//   final bool loading;
//   final int count;
//   const ShimmerList({Key? key, this.loading = true, required this.child, this.itemHeight, this.count = 4})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) => loading
//       ? Shimmer.fromColors(
//           baseColor: Colors.black12,
//           highlightColor: Colors.white30,
//           child: List.generate(
//                   count, (index) => const SizedBox.shrink().card.make().wh(double.maxFinite, itemHeight ?? 36).p4())
//               .column())
//       : child;
// }

class ProgressThis extends StatelessWidget {
  final Widget child;
  final bool loading;
  const ProgressThis({Key? key, this.loading = true, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) => loading ? const CircularProgressIndicator().centered() : child;
}
