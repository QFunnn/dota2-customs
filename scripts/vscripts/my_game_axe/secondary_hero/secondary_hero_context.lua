--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build ec5ff63 
  ~ auto-generated — do not edit
]]


local ____lualib = require("lualib_bundle")
local __TS__ObjectAssign = ____lualib.__TS__ObjectAssign
local ____exports = {}
local SECONDARY_HERO_CONTEXT_KEY = "__ak_secondary_hero_context__"
local SECONDARY_HERO_ITEM_CONTEXT_KEY = "__ak_secondary_hero_item_context__"
local function normalizeContext(self, context)
	return __TS__ObjectAssign({}, context, { rewardPolicy = context.rewardPolicy or "none" })
end
function ____exports.SetSecondaryHeroContext(self, unit, context)
	if not unit or not IsValid(nil, unit) then
		return
	end
	local carrier = unit
	carrier.__runtime_unit_type__ = UnitType.SECONDARY_HERO
	carrier[SECONDARY_HERO_CONTEXT_KEY] = normalizeContext(nil, context)
end
function ____exports.ClearSecondaryHeroContext(self, unit)
	if not unit or not IsValid(nil, unit) then
		return
	end
	local carrier = unit
	carrier[SECONDARY_HERO_CONTEXT_KEY] = nil
end
function ____exports.GetSecondaryHeroContext(self, unit)
	if not unit or not IsValid(nil, unit) then
		return nil
	end
	local carrier = unit
	return carrier[SECONDARY_HERO_CONTEXT_KEY]
end
function ____exports.MarkSecondaryHeroItem(self, item, context)
	if not item or not IsValid(nil, item) then
		return
	end
	local carrier = item
	carrier[SECONDARY_HERO_ITEM_CONTEXT_KEY] = normalizeContext(nil, context)
end
function ____exports.GetSecondaryHeroItemContext(self, item)
	if not item or not IsValid(nil, item) then
		return nil
	end
	local carrier = item
	return carrier[SECONDARY_HERO_ITEM_CONTEXT_KEY]
end
function ____exports.IsSecondaryHeroItem(self, item)
	return not not ____exports.GetSecondaryHeroItemContext(nil, item)
end
function ____exports.IsSecondaryHeroItemOwner(self, unit, item)
	local itemContext = ____exports.GetSecondaryHeroItemContext(nil, item)
	local unitContext = ____exports.GetSecondaryHeroContext(nil, unit)
	return not not itemContext and not not unitContext and itemContext.vid == unitContext.vid
end
function ____exports.IsSecondaryHero(self, unit)
	if not unit or not IsValid(nil, unit) then
		return false
	end
	if ____exports.GetSecondaryHeroContext(nil, unit) then
		return true
	end
	local ____this_1
	____this_1 = unit
	local ____opt_0 = ____this_1.GetUnitType
	return (____opt_0 and ____opt_0(____this_1)) == UnitType.SECONDARY_HERO
end
function ____exports.IsPlayerCombatHero(self, unit)
	if not unit or not IsValid(nil, unit) or not unit:IsHero() then
		return false
	end
	local ____this_3
	____this_3 = unit
	local ____opt_2 = ____this_3.GetUnitType
	local unitType = ____opt_2 and ____opt_2(____this_3)
	return unitType == UnitType.HERO or unitType == UnitType.SECONDARY_HERO
end
function ____exports.IsPlayerCombatTarget(self, unit)
	if not unit or not IsValidAlive(nil, unit) or not unit:IsHero() then
		return false
	end
	return ____exports.IsPlayerCombatHero(nil, unit)
end
function ____exports.ShouldSuppressSecondaryHeroRewards(self, unit)
	local context = ____exports.GetSecondaryHeroContext(nil, unit)
	if not context then
		local ____temp_6 = not not unit and IsValid(nil, unit)
		if ____temp_6 then
			local ____this_5
			____this_5 = unit
			local ____opt_4 = ____this_5.GetUnitType
			____temp_6 = (____opt_4 and ____opt_4(____this_5)) == UnitType.SECONDARY_HERO
		end
		return ____temp_6
	end
	return context.rewardPolicy ~= "normal"
end
return ____exports