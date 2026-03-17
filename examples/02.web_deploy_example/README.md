# web_deploy_example

Пример Flutter-приложения для веб-деплоя с настройкой SEO и доступа по сети.

---

## Настройка для SEO

Чтобы сайт корректно индексировался и красиво отображался в поиске и соцсетях, настройте следующие элементы.

### 1. Иконка (favicon) и мини-иконка во вкладке

- **Файл:** `web/favicon.png`  
  Замените на свою иконку (рекомендуется 32×32 или 48×48 px). Браузер показывает её во вкладке.

- **В `web/index.html`:**

  ```html
  <link rel="icon" type="image/png" href="favicon.png" />
  ```

  При необходимости укажите другой путь или формат (например, `favicon.ico`).

- **Иконки для PWA и «добавить на главный экран»:** в `web/manifest.json` и в `web/index.html` (apple-touch-icon) используются файлы из `web/icons/`. Подставьте свои `Icon-192.png`, `Icon-512.png` и maskable-варианты.

### 2. Название во вкладке браузера

- **В `web/index.html`:**

  ```html
  <title>Ваше название приложения</title>
  ```

  Это же название можно задать в `web/manifest.json` в полях `name` и `short_name`.

### 3. Превью (Open Graph и соцсети)

Чтобы ссылка на сайт показывала картинку и описание в соцсетях и мессенджерах, добавьте в `<head>` в `web/index.html`:

```html
<!-- Open Graph (Facebook, VK, Telegram и др.) -->
<meta property="og:type" content="website" />
<meta property="og:url" content="https://ваш-домен.com/" />
<meta property="og:title" content="Название сайта" />
<meta property="og:description" content="Краткое описание для превью" />
<meta property="og:image" content="https://ваш-домен.com/icons/Icon-512.png" />
<meta property="og:locale" content="ru_RU" />

<!-- Twitter Card -->
<meta name="twitter:card" content="summary_large_image" />
<meta name="twitter:title" content="Название сайта" />
<meta name="twitter:description" content="Краткое описание для превью" />
<meta name="twitter:image" content="https://ваш-домен.com/icons/Icon-512.png" />
```

- **og:url** — канонический URL страницы (важно для SEO и совпадения превью с реальной ссылкой).
- **og:image / twitter:image** — абсолютный URL картинки (рекомендуется не меньше 200×200 px, для «большой» карточки — 1200×630 px).

Также полезно иметь в `<head>`:

```html
<meta name="description" content="Краткое описание для поисковиков" />
```

### 4. URL и базовый путь

- При развёртывании **не в корне** домена (например, `https://site.com/app/`) при сборке задайте базовый путь:

  ```bash
  flutter build web --base-href "/app/"
  ```

  В `web/index.html` плейсхолдер `$FLUTTER_BASE_HREF` будет заменён на этот путь.

- Для SEO и превью всегда используйте **абсолютные URL** в `og:url`, `og:image` и т.п., с учётом этого базового пути.

### Краткий чеклист SEO

| Элемент         | Где настраивать                           |
| --------------- | ----------------------------------------- |
| Мини-иконка     | `web/favicon.png`, `<link rel="icon">`    |
| Название в табе | `<title>` в `web/index.html`              |
| Превью          | Open Graph и Twitter meta в `index.html`  |
| URL             | `og:url`, `--base-href` при сборке        |
| Описание        | `meta name="description"`, og:description |

---

## Запуск с доступом из интернета (по сети)

По умолчанию Flutter web слушает только `localhost`. Чтобы открыть приложение с другого устройства в локальной сети или с интернета, нужно привязать сервер к всем сетевым интерфейсам (`0.0.0.0`).

### Способ 1: Файл `web_dev_config.yaml` (рекомендуется, Flutter 3.41+)

В корне проекта (рядом с `pubspec.yaml`) создайте файл **`web_dev_config.yaml`**:

```yaml
server:
  host: "0.0.0.0" # привязка ко всем интерфейсам — доступ по IP из сети
  port: 8080 # порт (при необходимости измените)
```

После этого запустите:

```bash
flutter run -d web-server
```

Приложение будет доступно:

- локально: `http://localhost:8080`
- с другого устройства в той же сети: `http://<ваш-IP>:8080` (например, `http://192.168.1.10:8080`)

Документация: [Set up a web development configuration file](https://docs.flutter.dev/platform-integration/web/web-dev-config-file).

### Способ 2: Аргументы командной строки

Без конфига можно указать хост и порт вручную:

```bash
flutter run -d web-server --web-hostname 0.0.0.0 --web-port 8080
```

Или с запуском в Chrome:

```bash
flutter run -d chrome --web-hostname 0.0.0.0 --web-port 8080
```

На другом устройстве в сети открывайте: `http://<IP-вашего-компьютера>:8080`.

### Приоритет настроек

1. Значения по умолчанию Flutter
2. Параметры из `web_dev_config.yaml`
3. Аргументы командной строки (`--web-hostname`, `--web-port`) — переопределяют конфиг

### Дополнительно в `web_dev_config.yaml`

В том же файле можно настроить HTTPS, заголовки и прокси:

```yaml
server:
  host: "0.0.0.0"
  port: 8080
  https:
    cert-path: "/path/to/cert.pem"
    cert-key-path: "/path/to/key.pem"
  headers:
    - name: "X-Custom-Header"
      value: "MyValue"
  proxy:
    - target: "http://localhost:5000/"
      prefix: "/api/"
```

---

## Deferred imports (ленивая загрузка)

Deferred-импорты позволяют выносить части приложения в отдельные JS-чанки и подгружать их по требованию. Это уменьшает размер начальной загрузки и ускоряет старт приложения.

### Как использовать

1. **Импорт с ключевым словом `deferred as`:**

   ```dart
   import 'package:my_app/features/admin_panel.dart' deferred as admin;
   ```

2. **Перед использованием — загрузка библиотеки:**

   ```dart
   await admin.loadLibrary();
   ```

3. **Обращение к коду из отложенной библиотеки:**

   ```dart
   Navigator.push(
     context,
     MaterialPageRoute(builder: (_) => admin.AdminPanel()),
   );
   ```

### Важно для web

- На **web** deferred-импорты работают только в **release** и **profile** сборках. В debug они игнорируются, весь код подтягивается сразу.
- При сборке `flutter build web` для каждого deferred-импорта создаётся отдельный `.part.js` файл, который запрашивается только при вызове `loadLibrary()`.
- Имеет смысл выносить в deferred тяжёлые или редко используемые экраны (админка, отчёты, отдельные фичи).

### Пример: кнопка, открывающая отложенный экран

```dart
ElevatedButton(
  onPressed: () async {
    await admin.loadLibrary();
    if (!context.mounted) return;
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => admin.AdminPanel()),
    );
  },
  child: const Text('Открыть админку'),
)
```

Документация: [Deferred components](https://docs.flutter.dev/perf/deferred-components).

---

## URL strategy (стратегия URL)

Во Flutter web можно выбрать, как в адресной строке отображаются пути приложения.

### Две стратегии

| Стратегия | Пример URL                       | Описание                                                                                                                 |
| --------- | -------------------------------- | ------------------------------------------------------------------------------------------------------------------------ |
| **Hash**  | `https://site.com/#/catalog/123` | По умолчанию. Путь идёт после `#`. Не требует настройки сервера.                                                         |
| **Path**  | `https://site.com/catalog/123`   | По умолчанию. Путь идёт после `#`. Не требует настройки сервера.                                                         |
| **Path**  | `https://site.com/catalog/123`   | «Чистые» пути без `#`. Лучше для SEO и удобнее для пользователя. Требует, чтобы сервер отдавал `index.html` на все пути. |

### Включение PathUrlStrategy (path-стратегия)

1. В **`pubspec.yaml`** должна быть зависимость (обычно уже есть):

   ```yaml
   dependencies:
     flutter:
       sdk: flutter
     flutter_web_plugins:
       sdk: flutter
   ```

2. В **`main.dart`** вызвать `usePathUrlStrategy()` **до** `runApp()`:

   ```dart
   import 'package:flutter_web_plugins/url_strategy.dart';

   void main() {
     usePathUrlStrategy();
     runApp(MyApp());
   }
   ```

   Либо явно задать стратегию:

   ```dart
   import 'package:flutter_web_plugins/url_strategy.dart';

   void main() {
     setUrlStrategy(PathUrlStrategy());
     runApp(MyApp());
   }
   ```

### Настройка сервера при PathUrlStrategy

PathUrlStrategy опирается на History API: при переходе по путям вроде `/catalog/123` запрос идёт на сервер. Чтобы SPA работала, **все такие запросы должны возвращать один и тот же `index.html`** (далее маршрутизацией занимается Flutter).

Примеры:

- **Firebase Hosting:** включить опцию «Configure as a single-page app» (rewrites в `firebase.json`).
- **Nginx:** правило с `try_files $uri $uri/ /index.html;`.
- **Dev-сервер Flutter** (`flutter run -d web-server` / Chrome) уже отдаёт `index.html` на любые пути.

Документация: [Configuring the URL strategy on the web](https://docs.flutter.dev/ui/navigation/url-strategies).

---

## Деплой на GitHub Pages

Ниже — минимальная схема деплоя `examples/02.web_deploy_example` на GitHub Pages через GitHub Actions.

### 1. Workflow

В репозитории добавлен workflow:

- `.github/workflows/deploy-gh-pages-web-deploy-example.yml`

Он собирает `examples/02.web_deploy_example` и публикует папку `build/web` в GitHub Pages.

Важно: сборка делается с базовым путём GitHub Pages:

```bash
flutter build web --release --base-href "/<repo>/"
```

В workflow это вычисляется автоматически как `/${{ github.event.repository.name }}/`.

### 2. Включить GitHub Pages в настройках репозитория

В GitHub: **Settings → Pages**:

- **Build and deployment** → **Source**: `GitHub Actions`

После этого при пуше в `main` workflow задеплоит сайт.

### 3. URL сайта

Сайт будет доступен по адресу:

- `https://<username>.github.io/<repo>/`

### 4. Нюансы для SEO/превью

В `web/index.html` у нас стоят шаблонные значения:

- `og:url`: `https://your-domain.com/`
- `og:image`: `https://your-domain.com/icons/Icon-512.png`

Для GitHub Pages замените их на ваш реальный URL вида `https://<username>.github.io/<repo>/`.

---

## Getting Started

Этот проект — отправная точка для Flutter-приложения.

Полезные ссылки:

- [Learn Flutter](https://docs.flutter.dev/get-started/learn-flutter)
- [Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Flutter learning resources](https://docs.flutter.dev/reference/learning-resources)
- [Flutter web: building and deployment](https://docs.flutter.dev/platform-integration/web/building)
