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
local item_0228 = __TS__Class()
item_0228.name = "item_0228"
__TS__ClassExtends(item_0228, BaseItem_CS)
function item_0228.prototype.Precache(self, context)
	PrecacheResource("particle", "particles/items_fx/arcane_boots.vpcf", context)
	PrecacheResource("particle", "particles/items_fx/arcane_boots_recipient.vpcf", context)
end
function item_0228.prototype.GetItemConfig(self)
	return { behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET }
end
function item_0228.prototype.OnSpellStart(self)
	if not IsServer() then
		return
	end
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	local ability_radius = self:GetSpecialValueFor("ability_radius")
	local ability_mana_restore = self:GetSpecialValueFor("ability_mana_restore")
	local ability_duration = self:GetSpecialValueFor("ability_duration")
	local ability_damage_reduction_pct = self:GetSpecialValueFor("ability_damage_reduction_pct")
	self:PlayEffects1(caster)
	local heroes = FindUnitsInRadius(
		caster:GetTeamNumber(),
		caster:GetAbsOrigin(),
		nil,
		ability_radius,
		DOTA_UNIT_TARGET_TEAM_FRIENDLY,
		DOTA_UNIT_TARGET_HERO,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_ANY_ORDER,
		false
	)
	for ____, hero in ipairs(heroes) do
		do
			if not IsValidAlive(nil, hero) then
				goto __continue7
			end
			hero:GiveMana(ability_mana_restore)
			hero:AddNewModifier(
				caster,
				self,
				"modifier_cs_damage_reduction",
				{ duration = ability_duration, damage_reduction_pct = ability_damage_reduction_pct }
			)
			self:PlayEffects2(caster, hero)
		end
		::__continue7::
	end
end
function item_0228.prototype.PlayEffects1(self, caster)
	local castParticle = MyGameHeroParticleManager:CreateParticle(
		"particles/items_fx/arcane_boots.vpcf",
		PATTACH_ABSORIGIN_FOLLOW,
		caster,
		caster
	)
	MyGameHeroParticleManager:SetParticleControl(castParticle, 0, caster:GetAbsOrigin())
	MyGameHeroParticleManager:ReleaseParticleIndex(castParticle)
	caster:EmitSound("DOTA_Item.ArcaneBoots.Activate")
end
function item_0228.prototype.PlayEffects2(self, sourceHero, target)
	local recipientParticle = MyGameHeroParticleManager:CreateParticle(
		"particles/items_fx/arcane_boots_recipient.vpcf",
		PATTACH_ABSORIGIN_FOLLOW,
		target,
		sourceHero
	)
	MyGameHeroParticleManager:SetParticleControl(recipientParticle, 0, target:GetAbsOrigin())
	MyGameHeroParticleManager:ReleaseParticleIndex(recipientParticle)
end
item_0228 = __TS__DecorateLegacy({ registerAbility(nil) }, item_0228)
return ____exports