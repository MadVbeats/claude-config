---
name: claude-code-best-practice
description: Справочник лучших практик Claude Code (shanraisshan/claude-code-best-practice) — настройки и settings.json, CLAUDE.md и память, навыки, субагенты, команды, хуки, MCP, флаги запуска, agent teams, scheduled tasks, оркестрация и процессы разработки (RPI, cross-model), 84 совета от создателей Claude Code (Boris Cherny, Thariq), отчёты про лимиты и использование, туториал для Windows. Используй, когда пользователь спрашивает, как лучше настроить или использовать Claude Code, как устроены навыки/агенты/хуки/память, как экономить лимиты, или хочет улучшить свой рабочий процесс с Claude.
---

# Claude Code best practice — навигатор

База лежит локально: `~/.claude/skill-data/claude-code-best-practice` (на Windows `$env:USERPROFILE\.claude\skill-data\claude-code-best-practice`). Если папки нет — предложи склонировать:

```powershell
git clone --depth 1 https://github.com/shanraisshan/claude-code-best-practice.git "$env:USERPROFILE\.claude\skill-data\claude-code-best-practice"
```

## Где что лежит

| Папка | Содержание |
|---|---|
| `best-practice/` | claude-settings, claude-memory (CLAUDE.md), claude-skills, claude-subagents, claude-commands, claude-mcp, claude-cli-startup-flags, claude-power-ups |
| `tips/` | советы создателей Claude Code: `claude-boris-*`, `claude-thariq-*` (по датам) |
| `implementation/` | как реализовать: agent teams, commands, goal, scheduled tasks, skills, subagents |
| `development-workflows/`, `orchestration-workflow/` | процессы: RPI (research → plan → implement), cross-model, оркестрация агентов |
| `reports/` | глобальные vs проектные настройки, лимиты и использование, память агентов, навыки в больших репозиториях, Chrome-интеграции и др. |
| `tutorial/day0/windows.md`, `tutorial/day1/` | установка и первые шаги |
| `README.md` (~76 КБ) | обзор и ссылки на коллекции навыков/агентов — не читай целиком, ищи Grep'ом |

## Как пользоваться

1. Найди нужное Grep'ом по `*.md` (ключевые слова вопроса) и прочитай только подходящие файлы.
2. Сопоставь с тем, что уже настроено у пользователя (`~/.claude/settings.json`, навыки из claude-config, плагины) и с текущей версией Claude Code: репозиторий — заметки сообщества, часть советов может устареть. При сомнении сверяйся с официальной документацией (агент `claude-code-guide`).
3. Отвечай по-русски, коротко, с конкретным предложением, что поменять. Менять настройки — только с согласия пользователя.
4. Учебные навыки из репозитория (weather-*, time-*, presentation) не устанавливай без отдельной просьбы.

## Обновление

```powershell
git -C "$env:USERPROFILE\.claude\skill-data\claude-code-best-practice" pull --depth 1
```

Источник: https://github.com/shanraisshan/claude-code-best-practice (MIT).
