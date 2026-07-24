--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


GenericUpgrades = GenericUpgrades or {}

DEFAULT_PATH = "game/upgrades/generic_upgrades/"

function GenericUpgrades:Init()
	GenericUpgrades.generic_upgrades_data = LoadKeyValues("scripts/upgrades/generic.txt")

	GenericUpgrades.upgrades_by_rarity = {
		[UPGRADE_RARITY_COMMON] = {},
		[UPGRADE_RARITY_RARE] = {},
		[UPGRADE_RARITY_EPIC] = {}
	}

	for upgrade_name, upgrade_data in pairs(GenericUpgrades.generic_upgrades_data) do
		-- print("[GenericUpgrades] processing upgrade", upgrade_name)

		upgrade_data.class = upgrade_data.class or "modifier"

		UpgradesUtilities:ParseUpgrade(upgrade_data, upgrade_name, UPGRADE_TYPE.GENERIC)

		if upgrade_data.class == "modifier" then
			local modifier_name = "modifier_" .. upgrade_name .. "_upgrade"
			-- print("[GenericUpgrades] linking upgrade modifier", modifier_name)
			LinkLuaModifier(
				modifier_name,
				(upgrade_data.path or DEFAULT_PATH) .. modifier_name,
				upgrade_data.modifier_type or LUA_MODIFIER_MOTION_NONE
			)
		end

		if not upgrade_data.disabled then
			table.insert(GenericUpgrades.upgrades_by_rarity[upgrade_data.rarity], upgrade_name)
		end
	end
end


GenericUpgrades:Init()