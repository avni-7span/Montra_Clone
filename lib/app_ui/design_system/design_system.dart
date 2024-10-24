// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:montra_clone/app/image_paths.dart';
// import 'package:montra_clone/app_ui/design_system/design_system_components/color_container.dart';
// import 'package:montra_clone/app_ui/theme/theme.dart';
// import 'package:montra_clone/app_ui/theme/theme_bloc.dart';
// import 'package:montra_clone/app_ui/widgets/atoms/padding.dart';
// import 'package:montra_clone/app_ui/widgets/atoms/spacing.dart';
// import 'package:montra_clone/app_ui/widgets/atoms/text.dart';
// import 'package:montra_clone/app_ui/widgets/molecules/app_button.dart';
// import 'package:montra_clone/app_ui/widgets/molecules/app_dropdown.dart';
// import 'package:montra_clone/app_ui/widgets/molecules/app_textfield.dart';
// import 'package:montra_clone/app_ui/widgets/organisms/app_budget_card.dart';
// import 'package:montra_clone/app_ui/widgets/organisms/app_price_card.dart';
// import 'package:montra_clone/app_ui/widgets/organisms/app_rounded_price_card.dart';
// import 'package:montra_clone/core/widgets/error_text.dart';
//
// void main() {
//   runApp(const _App());
// }
//
// class _App extends StatelessWidget {
//   const _App({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       home: DesignSystemScreen(),
//     );
//   }
// }
//
// class DesignSystemScreen extends StatelessWidget {
//   const DesignSystemScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final colorMap = getColorMap(context);
//     return AppResponsiveTheme(
//       child: BlocProvider(
//         create: (context) => ThemeBloc(),
//         child: BlocBuilder<ThemeBloc, AppThemeColorMode>(
//           builder: (context, themeMode) {
//             return Scaffold(
//               backgroundColor: Colors.grey,
//               body: SafeArea(
//                 child: SingleChildScrollView(
//                   child: Padding(
//                     padding: const EdgeInsets.all(Insets.xsmall8),
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       children: [
//                         /// Text
//                         const AppText.titleX(text: 'AppText.titleX'),
//                         const AppText.title32(text: 'AppText.title1'),
//                         const AppText.title24(text: 'AppText.title2'),
//                         const AppText.title18(text: 'AppText.title3'),
//                         const AppText.regular16(text: 'AppText.regular1'),
//                         const AppText.regular14(text: 'AppText.regular3'),
//                         const AppText.small13(text: 'AppText.small'),
//                         const AppText.tiny12(text: 'AppText.tiny'),
//
//                         const SizedBox(height: 30),
//
//                         /// Colors
//                         GridView.count(
//                           shrinkWrap: true,
//                           physics: const NeverScrollableScrollPhysics(),
//                           crossAxisCount: 5,
//                           childAspectRatio: 1.0,
//                           children: colorMap.entries
//                               .map(
//                                 (entry) => ColorContainer(
//                                     color: entry.value, colorName: entry.key),
//                               )
//                               .toList(),
//                         ),
//                         const SizedBox(height: 30),
//
//                         /// Buttons
//                         AppButton(
//                           onPressed: () {},
//                           text: 'Primary Button',
//                         ),
//                         const SizedBox(height: 15),
//                         AppButton(
//                           onPressed: () {},
//                           text: 'Secondary Button',
//                           backgroundColor: context.colorScheme.violet20,
//                           textColor: context.colorScheme.primary,
//                         ),
//                         const SizedBox(height: 15),
//                         AppButton(
//                           onPressed: () {},
//                           text: 'See the full details',
//                           backgroundColor: context.colorScheme.light100,
//                           textColor: context.colorScheme.primary,
//                         ),
//                         const SizedBox(height: 15),
//                         AppButton(
//                           onPressed: () {},
//                           isLoading: true,
//                           text: '',
//                         ),
//                         const SizedBox(height: 15),
//                         AppButton(
//                           onPressed: () {},
//                           isRounded: true,
//                           textColor: context.colorScheme.primary,
//                           buttonType: ButtonType.outlined,
//                           backgroundColor: context.colorScheme.light100,
//                           textWidget: const GoogleButtonLabel(),
//                         ),
//                         const SizedBox(height: 30),
//
//                         /// TextFields
//                         AppTextField(
//                           label: 'Email',
//                           showLabel: false,
//                           hintText: 'Email',
//                           keyboardType: TextInputType.emailAddress,
//                           onChanged: (value) {},
//                         ),
//                         const SizedBox(height: 15),
//                         AppTextField(
//                           label: 'Name',
//                           showLabel: false,
//                           hintText: 'Name',
//                           keyboardType: TextInputType.text,
//                           onChanged: (value) {},
//                         ),
//                         const SizedBox(height: 15),
//                         AppTextField.password(
//                           label: 'Password',
//                           showLabel: false,
//                           hintText: 'Password',
//                           onChanged: (value) {},
//                           isObscureText: false,
//                         ),
//                         const SizedBox(height: 15),
//                         AppTextField(
//                           label: 'Name',
//                           showLabel: false,
//                           hintText: 'Name',
//                           keyboardType: TextInputType.text,
//                           onChanged: (value) {},
//                           errorText: 'Name is required',
//                         ),
//                         const SizedBox(height: 30),
//                         CategoryDropDown(
//                           isExpense: true,
//                           onChanged: (value) {},
//                         ),
//                         const SizedBox(height: 30),
//                         Row(
//                           children: [
//                             Column(
//                               children: [
//                                 AppPriceCard(
//                                   color: context.colorScheme.red100,
//                                   label: 'Expense',
//                                   price: '\u{20B9}5000',
//                                   iconPath: expenseIcon,
//                                 ),
//                                 const AppText.regular14(
//                                   text: 'AppPriceCard()',
//                                 )
//                               ],
//                             ),
//                             Column(
//                               children: [
//                                 AppPriceCard(
//                                   color: context.colorScheme.green100,
//                                   label: 'Income',
//                                   price: '\u{20B9}4298',
//                                   iconPath: incomeIcon,
//                                 ),
//                                 const AppText.regular14(
//                                   text: 'AppPriceCard()',
//                                 )
//                               ],
//                             ),
//                           ],
//                         ),
//                         const SizedBox(height: 30),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                           children: [
//                             Column(
//                               children: [
//                                 AppRoundedPriceCard(
//                                   backgroundColor: context.colorScheme.red40,
//                                   iconPath: expenseRoundedIcon,
//                                   onTap: () {},
//                                 ),
//                                 VSpace.xsmall8(),
//                                 const AppText.regular14(
//                                   text: 'AppRoundedPriceCard()',
//                                 )
//                               ],
//                             ),
//                             Column(
//                               children: [
//                                 AppRoundedPriceCard(
//                                   backgroundColor: context.colorScheme.green40,
//                                   iconPath: incomeRoundedIcon,
//                                   onTap: () {},
//                                 ),
//                                 VSpace.xsmall8(),
//                                 const AppText.regular14(
//                                   text: 'AppRoundedPriceCard()',
//                                 )
//                               ],
//                             ),
//                           ],
//                         ),
//                         const SizedBox(height: 30),
//                         Column(
//                           children: [
//                             AppBudgetCard(
//                               category: 'Transportation',
//                               isExpense: true,
//                               amount: '500',
//                               description: 'Ola EV charging',
//                               createdAt: '25/07/2024',
//                               onCardTap: () {},
//                             ),
//                             const AppText.regular14(text: 'AppBudgetCard()')
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }
