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
local registerModifier = ____dota_ts_adapter.registerModifier
local ____modifier_base = require("modifiers.class.modifier_base")
local BaseModifier_CS = ____modifier_base.BaseModifier_CS
local _____base_item = require("abilities.items._base_item")
local BaseItem_CS = _____base_item.BaseItem_CS
local ITEM_0266_PARTICLE = "particles/items_fx/seeds_of_serenity.vpcf"
--- 与 KV 中「每秒回复百分比」对应：每 0.5 秒结算一次，单次系数为间隔秒数
local ITEM_0266_HEAL_INTERVAL = 0.5
____exports.item_0266 = __TS__Class()
local item_0266 = ____exports.item_0266
item_0266.name = "item_0266"
__TS__ClassExtends(item_0266, BaseItem_CS)
function item_0266.prototype.Precache(self, context)
	PrecacheResource("particle", ITEM_0266_PARTICLE, context)
end
function item_0266.prototype.GetItemConfig(self)
	return { behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET + DOTA_ABILITY_BEHAVIOR_AOE }
end
function item_0266.prototype.GetAOERadius(self)
	return self:GetSpecialValueFor("ability_radius")
end
function item_0266.prototype.OnSpellStart(self)
	if not IsServer() then
		return
	end
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	local ability_duration = self:GetSpecialValueFor("ability_duration")
	caster:AddNewModifier(caster, self, ____exports.modifier_item_0266_serenity.name, { duration = ability_duration })
	self:PlayEffects1(caster)
end
function item_0266.prototype.PlayEffects1(self, caster)
	caster:EmitSound("DOTA_Item.ClarityPotion.Activate")
end
item_0266 = __TS__DecorateLegacy({ registerAbility(nil) }, item_0266)
____exports.item_0266 = item_0266
____exports.modifier_item_0266_serenity = __TS__Class()
local modifier_item_0266_serenity = ____exports.modifier_item_0266_serenity
modifier_item_0266_serenity.name = "modifier_item_0266_serenity"
__TS__ClassExtends(modifier_item_0266_serenity, BaseModifier_CS)
function modifier_item_0266_serenity.GetLocalizationCN(self)
	return { name = "落种", description = "在落点位置持续治疗范围内友军。" }
end
function modifier_item_0266_serenity.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	local ability = self:GetAbility()
	if not ability or not IsValidAlive(nil, self._parent) then
		return
	end
	self.fieldOrigin = self._parent:GetAbsOrigin()
	local ability_radius = ability:GetSpecialValueFor("ability_radius")
	local pfx = ParticleManager:CreateParticle(ITEM_0266_PARTICLE, PATTACH_WORLDORIGIN, self._parent)
	ParticleManager:SetParticleControl(pfx, 0, self.fieldOrigin)
	ParticleManager:SetParticleControl(pfx, 1, Vector(ability_radius, 0, 0))
	self:AddParticle(pfx, false, false, -1, false, false)
	self:StartIntervalThink(ITEM_0266_HEAL_INTERVAL)
end
function modifier_item_0266_serenity.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	if not IsValidAlive(nil, self._parent) or not self._ability then
		self:Destroy()
		return
	end
	local ability_radius = self._ability:GetSpecialValueFor("ability_radius")
	local ability_heal_max_hp_pct = self._ability:GetSpecialValueFor("ability_heal_max_hp_pct")
	local allies = FindUnitsInRadius(
		self._parent:GetTeamNumber(),
		self.fieldOrigin,
		nil,
		ability_radius,
		DOTA_UNIT_TARGET_TEAM_FRIENDLY,
		DOTA_UNIT_TARGET_HEROES_AND_CREEPS,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_ANY_ORDER,
		false
	)
	local healFactor = ability_heal_max_hp_pct / 100 * ITEM_0266_HEAL_INTERVAL
	for ____, ally in ipairs(allies) do
		do
			if not IsValidAlive(nil, ally) or ally:IsBuilding() then
				goto __continue16
			end
			local healAmount = ally:GetMaxHealth() * healFactor
			if healAmount > 0 then
				MyGameHeal:ApplyHeal({
					healer = self:GetParent(),
					target = ally,
					amount = healAmount,
					ability = self._ability,
					source = "item",
				})
			end
		end
		::__continue16::
	end
end
function modifier_item_0266_serenity.prototype.IsHidden(self)
	return false
end
function modifier_item_0266_serenity.prototype.IsPurgable(self)
	return false
end
modifier_item_0266_serenity = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0266_serenity)
____exports.modifier_item_0266_serenity = modifier_item_0266_serenity
return ____exports