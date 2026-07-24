--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


if item_demonicon_custom == nil then
	item_demonicon_custom = class({}) ---@class CDOTA_Item_Lua
end

-- если предмет активируемый без цели
function item_demonicon_custom:OnSpellStart()
    if not IsServer() then return end

    local caster = self:GetCaster()

	if caster:HasModifier("modifier_item_demonicon") then
		return
	end


    local units = FindUnitsInRadius(
        caster:GetTeamNumber(),
        caster:GetAbsOrigin(),
        nil,
        2000, ---радиус поиска предыдущих некрочей
        DOTA_UNIT_TARGET_TEAM_FRIENDLY,
        DOTA_UNIT_TARGET_ALL,
        DOTA_UNIT_TARGET_FLAG_INVULNERABLE + DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES + DOTA_UNIT_TARGET_FLAG_OUT_OF_WORLD + DOTA_UNIT_TARGET_FLAG_NOT_ILLUSIONS, 
        FIND_ANY_ORDER,
        false
    )

    local demons = {} ---@type CDOTA_BaseNPC[]
    for _, unit in ipairs(units) do
        if string.find(unit:GetUnitName(), "necronomicon") then
            table.insert(demons, unit)
        end
    end

    if #demons ~= 0 then
        for _, unit in ipairs(demons) do
            unit:ForceKill(false)
        end
    end

    -- временно добавляем оригинальную способность Dota
    local abil = caster:AddAbility("item_demonicon")
    if abil then
        abil:SetLevel(1)
        abil:OnSpellStart()
        abil:RemoveSelf()
	end
end