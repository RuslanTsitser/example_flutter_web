# Адаптивный дизайн для Web

Простые примеры адаптивной вёрстки: LayoutBuilder, OrientationBuilder, сетка, навигация, ограничение ширины.

## Запуск

```bash
flutter run -d chrome
```

## Примеры

1. **LayoutBuilder + OrientationBuilder** — по `constraints` (узко/широко) и по ориентации (портрет/ландшафт). Один экран, два чипа с подписью.

2. **Адаптивная сетка** — `LayoutBuilder` + `GridView.count`: 1 колонка при ширине &lt; 600px, 2 при &lt; 900px, иначе 3.

3. **Ограниченный контент** — `ConstrainedBox(maxWidth: 600)` по центру.

4. **Адаптивная навигация** — при ширине ≥ 600px показывается `NavigationRail`, иначе `Drawer`.

## Структура

```
lib/
  main.dart
  breakpoints.dart       # опционально, в примерах не используется
  examples/
    layout_orientation_example.dart  # LayoutBuilder + OrientationBuilder
    responsive_grid_example.dart
    constrained_content_example.dart
    adaptive_navigation_example.dart
```

Реализации максимально короткие; проверка ширины через `constraints` или `MediaQuery.sizeOf(context)`.
