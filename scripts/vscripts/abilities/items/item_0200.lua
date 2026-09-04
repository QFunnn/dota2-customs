--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build ec5ff63 
  ~ auto-generated — do not edit
]]


local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__DecorateLegacy = ____lualib.__TS__DecorateLegacy
local ____exports = {}
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local _____base_item = require("abilities.items._base_item")
local BaseItem_CS = _____base_item.BaseItem_CS
local ____item_0409_shared = require("abilities.items.item_0409_shared")
local IsRealNonItemAbility = ____item_0409_shared.IsRealNonItemAbility
local ITEM_SLOT_MAX = 16
____exports.item_0200 = __TS__Class()
local item_0200 = ____exports.item_0200
item_0200.name = "item_0200"
__TS__ClassExtends(item_0200, BaseItem_CS)
function item_0200.prototype.Precache(self, context)
	PrecacheResource("particle", "particles/items2_fx/refresher.vpcf", context)
end
function item_0200.prototype.GetItemConfig(self)
	return { behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET }
end
function item_0200.prototype.OnSpellStart(self)
	if not IsServer() then
		return
	end
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	local abilityCount = caster:GetAbilityCount()
	do
		local i = 0
		while i < abilityCount do
			do
				local ability = caster:GetAbilityByIndex(i)
				if not IsRealNonItemAbility(nil, ability) then
					goto __continue7
				end
				if MyGameAbilityChargeManager and MyGameAbilityChargeManager:IsCustomChargeAbility(ability) then
					goto __continue7
				end
				ability:EndCooldown()
			end
			::__continue7::
			i = i + 1
		end
	end
	do
		local slot = 0
		while slot <= ITEM_SLOT_MAX do
			do
				local item = caster:GetItemInSlot(slot)
				if not item or not IsValid(nil, item) then
					goto __continue10
				end
				if item:entindex() == self:entindex() then
					goto __continue10
				end
				item:EndCooldown()
			end
			::__continue10::
			slot = slot + 1
		end
	end
	EmitSoundOn("DOTA_Item.Refresher.Activate", caster)
	local particle = MyGameHeroParticleManager:CreateParticle(
		"particles/items2_fx/refresher.vpcf",
		PATTACH_ABSORIGIN_FOLLOW,
		caster,
		caster
	)
	MyGameHeroParticleManager:ReleaseParticleIndex(particle)
end
item_0200 = __TS__DecorateLegacy({ registerAbility(nil) }, item_0200)
____exports.item_0200 = item_0200
return ____exports