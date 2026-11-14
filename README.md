# claude-config

Мои навыки (skills), агенты и команды для Claude Code — чтобы одинаково настроить любой компьютер.

## Установка на новом компьютере

```powershell
git clone https://github.com/MadVbeats/claude-config.git
cd claude-config
powershell -ExecutionPolicy Bypass -File .\install.ps1
```

Инструменты для навыков (Portable Git с bash и Chrome for Testing, без прав администратора; пути пишутся в `env` в `~/.claude/settings.json`):

```powershell
powershell -ExecutionPolicy Bypass -File .\setup-tools.ps1
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
| `cybersecurity-skills` | Навигатор по 818 процедурам кибербезопасности ([mukul975/anthropic-cybersecurity-skills](https://github.com/mukul975/anthropic-cybersecurity-skills), Apache-2.0, не от Anthropic). Сам каталог (31 МБ) `install.ps1` клонирует в `~/.claude/skill-data/`, навык читает нужные процедуры по запросу |
| `impeccable` | Дизайн интерфейсов: 24 команды (`/impeccable audit`, `critique`, `polish`, `typeset`, `colorize`, `layout`, `animate`, `document`, `live`…) + 4 агента `impeccable-*` ([pbakaus/impeccable](https://github.com/pbakaus/impeccable) v4.9.1, Apache-2.0). **Без хуков плагина.** Движок (Rust) скачивается при первом запуске с проверкой SHA-256; телеметрия отключается `IMPECCABLE_NO_TELEMETRY=1` |
| `headroom` | Как встроить `compress()` из `headroom-ai` в своё приложение, которое вызывает LLM, чтобы тратить меньше токенов API ([headroomlabs-ai/headroom](https://github.com/headroomlabs-ai/headroom), Apache-2.0). Только навык, без прокси для Claude Code |
| `claude-automation-recommender` | Официальный плагин Anthropic `claude-code-setup`: анализирует проект и советует 1–2 лучших хука, навыка, агента, MCP-сервера и команды под его стек. Только читает, ничего не меняет ([anthropics/claude-plugins-official](https://github.com/anthropics/claude-plugins-official), Apache-2.0) |
| `task-observer` | Мета-навык: копит наблюдения о поправках и повторяющейся работе, предлагает улучшения навыков и новые навыки, ведёт еженедельный разбор ([rebelytics/one-skill-to-rule-them-all](https://github.com/rebelytics/one-skill-to-rule-them-all) v3.10.0, CC BY 4.0). **Только по запросу:** описание изменено, автозапуска и хука нет. Заметки — в `~/.claude/skill-observations/` |
| `mcp-servers-catalog` | Навигатор по ~4600 MCP-серверам из [punkpeye/awesome-mcp-servers](https://github.com/punkpeye/awesome-mcp-servers) (MIT): находит подходящий сервер под задачу, проверяет его и подключает только с согласия. Каталог `install.ps1` клонирует в `~/.claude/skill-data/` |
| `design-taste-frontend` | tasteskill 2.5.1: сайты компаний уровня figma.com / x.ai без «ИИ-шаблонности» — секция на экран, настоящие фото и интерфейс продукта, эффекты только для tech/игр, проверка в настоящем браузере ([Leonxlnx/taste-skill](https://github.com/Leonxlnx/taste-skill), MIT; ~35 МБ ассетов с лицензиями в credits-файлах). Нужны Node 22+, bash и Chrome — ставятся `setup-tools.ps1`. Stop-хук оригинальный (финальная проверка страницы через Git Bash) |

### Плагины (`enabled-plugins.json`) и переменные (`settings-env.json`)

`install.ps1` дописывает плагины в `enabledPlugins`, а переменные из `settings-env.json` — в `env` в `~/.claude/settings.json`, не трогая остальные настройки (старая версия сохраняется в `backups`). В `settings-env.json` — только несекретные значения: репозиторий публичный.

| Плагин | Что делает |
|---|---|
| `context7@claude-plugins-official` | Официальный плагин: подключает облачный MCP-сервер Context7 (Upstash) с актуальной документацией библиотек по версиям (Next.js, React, Prisma, Tailwind…). Без Node.js; без ключа работает анонимно с общими лимитами, свой ключ — переменная `CONTEXT7_API_KEY` |
| `superpowers@claude-plugins-official` | [obra/superpowers](https://github.com/obra/superpowers) v7 (MIT): 14 навыков-процессов — brainstorming → план → TDD → систематическая отладка → проверка перед «готово» → ревью, плюс написание навыков. SessionStart-хук (через Git Bash) добавляет короткое вступление `using-superpowers`, из-за которого навыки включаются сами. Телеметрия выключена `SUPERPOWERS_DISABLE_TELEMETRY=1` |

### Из ECC ([affaan-m/ecc](https://github.com/affaan-m/ecc) v2.2.3, MIT — см. `LICENSE-ECC`)

Выборка под веб-стек Next.js / React / TypeScript / Tailwind / Prisma. Без хуков ECC.

- **Навыки:** `nextjs-turbopack`, `react-patterns`, `react-performance`, `typescript-patterns`, `frontend-patterns`, `design-system`, `make-interfaces-feel-better`, `frontend-a11y`, `seo`, `prisma-patterns`, `api-design`, `error-handling`, `coding-standards`, `verification-loop`, `search-first`
- **Агенты** (`agents/`, запускаются по запросу; в описаниях убраны «PROACTIVELY / MUST BE USED», к Bash добавлен PowerShell): `planner`, `code-reviewer`, `react-reviewer`, `typescript-reviewer`, `security-reviewer`, `seo-specialist`, `build-error-resolver`, `react-build-resolver`, `performance-optimizer`
- **Правила** (`rules/ecc/`): `common` (всегда), `typescript`, `react`, `web` (подгружаются только для подходящих файлов). Без `hooks.md` и `agents.md`.

## Правило

Репозиторий публичный: **никаких** токенов, ключей, паролей, памяти и личных данных. Список исключений — в `.gitignore`.
