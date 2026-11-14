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
| `grill-me` + `grilling` | Жёсткое интервью по плану или идее: вопросы раундами с рекомендуемыми ответами, пока не останется непроговорённых решений. `/grill-me` вызывает `grilling` ([mattpocock/skills](https://github.com/mattpocock/skills), MIT) |

### Из ECC ([affaan-m/ecc](https://github.com/affaan-m/ecc) v2.2.3, MIT — см. `LICENSE-ECC`)

Выборка под веб-стек Next.js / React / TypeScript / Tailwind / Prisma. Без хуков ECC.

- **Навыки:** `nextjs-turbopack`, `react-patterns`, `react-performance`, `typescript-patterns`, `frontend-patterns`, `design-system`, `make-interfaces-feel-better`, `frontend-a11y`, `seo`, `prisma-patterns`, `api-design`, `error-handling`, `coding-standards`, `verification-loop`, `search-first`
- **Агенты** (`agents/`, запускаются по запросу; в описаниях убраны «PROACTIVELY / MUST BE USED», к Bash добавлен PowerShell): `planner`, `code-reviewer`, `react-reviewer`, `typescript-reviewer`, `security-reviewer`, `seo-specialist`, `build-error-resolver`, `react-build-resolver`, `performance-optimizer`
- **Правила** (`rules/ecc/`): `common` (всегда), `typescript`, `react`, `web` (подгружаются только для подходящих файлов). Без `hooks.md` и `agents.md`.

## Правило

Репозиторий публичный: **никаких** токенов, ключей, паролей, памяти и личных данных. Список исключений — в `.gitignore`.
