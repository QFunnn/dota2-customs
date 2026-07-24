--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


-- Предупреждение за репорты (MF-2): чисто ИНФОРМАТИВНЫЙ модификатор, БЕЗ игрового эффекта.
-- Показывает игроку/врагам, что на него много жалоб (пробный период). MULTIPLE — если
-- вдруг несколько строк-предупреждений. Срок/остаток времени показываются отдельно (net table + UI).
-- Иконка — плейсхолдер (владелец даст свой ассет).
modifier_report_warning = class({})

function modifier_report_warning:GetTexture() return "punishment_warning" end
function modifier_report_warning:IsHidden() return false end
function modifier_report_warning:IsDebuff() return true end
function modifier_report_warning:IsPurgable() return false end
function modifier_report_warning:RemoveOnDeath() return false end
function modifier_report_warning:GetAttributes() return MODIFIER_ATTRIBUTE_MULTIPLE end

-- Без DeclareFunctions — никакого влияния на геймплей.