--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


-- ============================================================================
-- zxc_server_secrets.lua — ЛОКАЛЬНЫЕ СЕКРЕТЫ. НЕ КОММИТИТЬ В РЕПО.
-- Файл подпадает под .gitignore (*_secrets.lua). Заполняется на сервере вручную.
--
-- Скопируй этот файл рядом и впиши реальные значения. Без него вебхук-зависимые
-- фичи (багрепорты) будут просто отключены — см. zxc_server_settings.lua.
-- ============================================================================

ZXC_SECRETS = ZXC_SECRETS or {}

-- Discord Webhook URL для отправки багрепортов.
-- ВПИШИ РЕАЛЬНОЕ ЗНАЧЕНИЕ ЗДЕСЬ (на сервере), в репо оставляем пустым/placeholder.
ZXC_SECRETS.DISCORD_BUG_REPORT_WEBHOOK = "https://discord.com/api/webhooks/1465176556006805713/nrNs9uz9-CiihaTLt3xt32Bb2uHR_H2uNqmgZEVeqDvYgvBIJs_zcwDawu9ZAGz6NOKk"

-- Discord-вебхук для РЕПОРТОВ НА ИГРОКОВ (кнопка репорта, фича MF-9).
-- Вставить URL между кавычек (файл в .gitignore, в git не попадает).
ZXC_SECRETS.DISCORD_PLAYER_REPORT_WEBHOOK = "https://discord.com/api/webhooks/1525492445377331222/agNfJjiVi1H-GS_GfDPUQ-fdkapWasAkGwSUlJwew4Zs0eXKnDp7y3w5Hx_qstnsdNkf"