---
name: build-your-own-x
description: Каталог ~360 пошаговых туториалов «напиши с нуля» (codecrafters-io/build-your-own-x) — 3D-рендерер, БД, Docker, Git, эмулятор, ОС, язык программирования, regex, шелл, текстовый редактор, браузер, веб-сервер, нейросеть, блокчейн, BitTorrent, игры и др. Используй, когда пользователь хочет понять, как устроена технология, собрать её аналог с нуля, учебный проект, или ищет проверенный гайд/референс по реализации на конкретном языке.
---

# Build your own X

Источник: https://github.com/codecrafters-io/build-your-own-x. Локальная копия README — `catalog.md` рядом с этим файлом.

## Как пользоваться

1. Определи категорию (технологию) и, если указан, язык.
2. Найди раздел в `catalog.md` через Grep по заголовку `#### Build your own \`<Категория>\`` — не читай файл целиком (~47 КБ).
   Категории: Distributed Systems, 3D Renderer, AI Model, Augmented Reality, BitTorrent Client, Blockchain / Cryptocurrency, Bot, Command-Line Tool, Database, Docker, Emulator / Virtual Machine, Front-end Framework / Library, Game, Git, Memory Allocator, Network Stack, Neural Network, Operating System, Physics Engine, Processor, Programming Language, Regex Engine, Search Engine, Shell, Template Engine, Text Editor, Visual Recognition System, Voxel Engine, Web Browser, Web Server, Uncategorized.
3. Формат строки: `* [**Язык**: _Название_](URL)` — фильтруй по `**Язык**`.
4. Предложи пользователю 2–4 лучших варианта (язык, название, ссылка, почему подходит). Если нужно — открой туториал (WebFetch / браузер) и веди пользователя по шагам, реализуя код в его проекте.
5. Отвечай по-русски.

## Обновление каталога

```powershell
Invoke-WebRequest "https://raw.githubusercontent.com/codecrafters-io/build-your-own-x/master/README.md" -OutFile "$env:USERPROFILE\.claude\skills\build-your-own-x\catalog.md"
```
