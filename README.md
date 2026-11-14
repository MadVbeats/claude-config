# claude-config

Мои навыки (skills), агенты и команды для Claude Code — чтобы одинаково настроить любой компьютер.

## Установка на новом компьютере

```powershell
git clone https://github.com/MadVbeats/claude-config.git
cd claude-config
powershell -ExecutionPolicy Bypass -File .\install.ps1
```

## Обновление

```powershell
cd claude-config
git pull
powershell -ExecutionPolicy Bypass -File .\install.ps1
```

## Что внутри

| Навык | Назначение |
|---|---|
| `build-your-own-x` | Каталог ~360 туториалов «напиши с нуля» из [codecrafters-io/build-your-own-x](https://github.com/codecrafters-io/build-your-own-x) |
| `find-skills` | Поиск и установка навыков из открытого каталога [skills.sh](https://skills.sh) через `npx skills` ([vercel-labs/skills](https://github.com/vercel-labs/skills), MIT). Нужен Node.js 22.20+ |

## Правило

Репозиторий публичный: **никаких** токенов, ключей, паролей, памяти и личных данных. Список исключений — в `.gitignore`.
