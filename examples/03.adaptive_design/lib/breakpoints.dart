import 'package:flutter/material.dart';

/// Брейкпоинты для адаптивного веб-дизайна.
abstract final class Breakpoints {
  static const double compact = 600;
  static const double medium = 840;
  static const double expanded = 1200;
}

/// Возвращает ширину экрана из [BuildContext].
double screenWidth(BuildContext context) =>
    MediaQuery.sizeOf(context).width;

/// Проверяет, что экран в компактном режиме (< 600px).
bool isCompact(BuildContext context) =>
    screenWidth(context) < Breakpoints.compact;

/// Проверяет, что экран средний или больше (>= 600px).
bool isMediumOrWider(BuildContext context) =>
    screenWidth(context) >= Breakpoints.compact;

/// Проверяет, что экран широкий (>= 840px).
bool isWide(BuildContext context) =>
    screenWidth(context) >= Breakpoints.medium;

/// Проверяет, что экран очень широкий (>= 1200px).
bool isExpanded(BuildContext context) =>
    screenWidth(context) >= Breakpoints.expanded;

/// Количество колонок для сетки в зависимости от ширины.
int gridCrossAxisCount(BuildContext context) {
  final w = screenWidth(context);
  if (w >= Breakpoints.expanded) return 4;
  if (w >= Breakpoints.medium) return 3;
  if (w >= Breakpoints.compact) return 2;
  return 1;
}
