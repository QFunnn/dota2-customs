--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


extra_creature_add = class({})
function extra_creature_add:OnChargeCountChanged(iCharges) end

function extra_creature_add:IsRefreshable() return false end

item_extra_creature_roshling_big = extra_creature_add or class({})
item_extra_creature_big_thunder_lizard = extra_creature_add or class({})
item_extra_creature_centaur_khan = extra_creature_add or class({})
item_extra_creature_dark_troll_warlord = extra_creature_add or class({})
item_extra_creature_elf_wolf = extra_creature_add or class({})
item_extra_creature_explode_spider = extra_creature_add or class({})
item_extra_creature_ghost = extra_creature_add or class({})
item_extra_creature_gnoll_assassin = extra_creature_add or class({})
item_extra_creature_granite_golem = extra_creature_add or class({})
item_extra_creature_kobold = extra_creature_add or class({})
item_extra_creature_ogreseal = extra_creature_add or class({})
item_extra_creature_prowler_shaman = extra_creature_add or class({})
item_extra_creature_rock_golem = extra_creature_add or class({})
item_extra_creature_satyr_trickster = extra_creature_add or class({})
item_extra_creature_siltbreaker = extra_creature_add or class({})
item_extra_creature_spider_range = extra_creature_add or class({})
item_extra_creature_timber_spider = extra_creature_add or class({})
item_extra_creature_warpine = extra_creature_add or class({})

function extra_creature_add:CastFilterResult()
	if not IsServer() then return end

	if Rounds:GetCurrentRound() >= GetGameSetting("ROUND_WHEN_CAN_SUMMON_CREEPS") or #Players:GetAllActivePlayers(true) <= PLAYERS_WHEN_CAN_SUMMON_CREEPS then
		return UF_SUCCESS
	end

	return UF_FAIL_CUSTOM
end

function extra_creature_add:GetCustomCastError()
	return "#dota_hud_error_cant_summon"
end

function extra_creature_add:OnSpellStart()
	if not IsServer() then return end

	local UnitName = EXTRA_CREATURES_LIST[self:GetName()]
	
	if UnitName == nil then return end

	local caster = self:GetCaster()
	if not caster:IsRealHero() then return end
	if caster:IsTempestDouble() then return end
	if caster:HasModifier("modifier_arc_warden_tempest_double_lua") then return end
	if caster.GetPlayerOwnerID == nil then return end

	local PlayerID = caster:GetPlayerOwnerID()

	if Rounds:AddExtraCreep(PlayerID, UnitName) then
        self:SpendCharge(0)
    end
end