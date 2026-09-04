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
local __TS__ArraySlice = ____lualib.__TS__ArraySlice
local ____exports = {}
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local registerModifier = ____dota_ts_adapter.registerModifier
local ____modifier_base = require("modifiers.class.modifier_base")
local BaseModifier_CS = ____modifier_base.BaseModifier_CS
local _____base_item = require("abilities.items._base_item")
local BaseItem_CS = _____base_item.BaseItem_CS
____exports.item_0272 = __TS__Class()
local item_0272 = ____exports.item_0272
item_0272.name = "item_0272"
__TS__ClassExtends(item_0272, BaseItem_CS)
function item_0272.prototype.GetIntrinsicModifierName(self)
	return ____exports.modifier_item_0272_tracker.name
end
item_0272 = __TS__DecorateLegacy({ registerAbility(nil) }, item_0272)
____exports.item_0272 = item_0272
____exports.modifier_item_0272_tracker = __TS__Class()
local modifier_item_0272_tracker = ____exports.modifier_item_0272_tracker
modifier_item_0272_tracker.name = "modifier_item_0272_tracker"
__TS__ClassExtends(modifier_item_0272_tracker, BaseModifier_CS)
function modifier_item_0272_tracker.prototype.____constructor(self, ...)
	BaseModifier_CS.prototype.____constructor(self, ...)
	self.damageRecords = {}
	self.damageSumInWindow = 0
	self.damageRecordHead = 0
end
function modifier_item_0272_tracker.prototype.DeclareEvents(self)
	return { BusinessEvents.ON_DEAL_DAMAGE }
end
function modifier_item_0272_tracker.prototype.IsHidden(self)
	return true
end
function modifier_item_0272_tracker.prototype.OnDealDamage_CS(self, event)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	local ability = self:GetAbility()
	if not ability then
		return
	end
	if event.victim ~= parent then
		return
	end
	if (event.final_damage or 0) <= 0 then
		return
	end
	if CheckTag(nil, event.damage_flag, ApplyDamageFlag.HP_LOSS) then
		return
	end
	if not ability:IsCooldownReady() then
		return
	end
	local now = GameRules:GetGameTime()
	local windowStart = now - ____exports.modifier_item_0272_tracker.DAMAGE_MERGE_WINDOW
	while
		self.damageRecordHead < #self.damageRecords
		and self.damageRecords[self.damageRecordHead + 1].t < windowStart
	do
		self.damageSumInWindow = self.damageSumInWindow - self.damageRecords[self.damageRecordHead + 1].dmg
		self.damageRecordHead = self.damageRecordHead + 1
	end
	if self.damageRecordHead > 32 and self.damageRecordHead * 2 > #self.damageRecords then
		self.damageRecords = __TS__ArraySlice(self.damageRecords, self.damageRecordHead)
		self.damageRecordHead = 0
	end
	local sumBefore = self.damageSumInWindow
	local dmg = event.final_damage or 0
	local ____self_damageRecords_0 = self.damageRecords
	____self_damageRecords_0[#____self_damageRecords_0 + 1] = { t = now, dmg = dmg }
	self.damageSumInWindow = self.damageSumInWindow + dmg
	local sumAfter = self.damageSumInWindow
	local ability_threshold_pct = ability:GetSpecialValue("item_0272", "ability_threshold_pct")
	local threshold = parent:GetMaxHealth() * (ability_threshold_pct / 100)
	if sumBefore <= threshold and sumAfter > threshold then
		local ability_duration = ability:GetSpecialValue("item_0272", "ability_duration")
		parent:AddNewModifier(
			parent,
			ability,
			____exports.modifier_item_0272_unyielding_shield.name,
			{ duration = ability_duration }
		)
		local cd = ability:GetCooldown(ability:GetLevel())
		local ____ability_StartCooldown_2 = ability.StartCooldown
		local ____temp_1
		if cd > 0 then
			____temp_1 = cd
		else
			____temp_1 = 1
		end
		____ability_StartCooldown_2(ability, ____temp_1)
	end
end
modifier_item_0272_tracker.DAMAGE_MERGE_WINDOW = 0.1
modifier_item_0272_tracker = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0272_tracker)
____exports.modifier_item_0272_tracker = modifier_item_0272_tracker
____exports.modifier_item_0272_unyielding_shield = __TS__Class()
local modifier_item_0272_unyielding_shield = ____exports.modifier_item_0272_unyielding_shield
modifier_item_0272_unyielding_shield.name = "modifier_item_0272_unyielding_shield"
__TS__ClassExtends(modifier_item_0272_unyielding_shield, BaseModifier_CS)
function modifier_item_0272_unyielding_shield.GetLocalizationCN(self)
	return { name = "不屈", description = "获得额外护盾上限与临时护盾。" }
end
function modifier_item_0272_unyielding_shield.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	self:PlayEffects1()
	self:ApplyShield()
end
function modifier_item_0272_unyielding_shield.prototype.OnRefresh(self)
	if not IsServer() then
		return
	end
	self:ApplyShield()
end
function modifier_item_0272_unyielding_shield.prototype.PlayEffects1(self)
	local parent = self:GetParent()
	if not IsValid(nil, parent) then
		return
	end
	parent:EmitSound("DOTA_Item.ComboBreaker")
	local particle =
		ParticleManager:CreateParticle("particles/items4_fx/combo_breaker_buff.vpcf", PATTACH_ABSORIGIN_FOLLOW, parent)
	ParticleManager:SetParticleControlEnt(
		particle,
		0,
		parent,
		PATTACH_ABSORIGIN_FOLLOW,
		nil,
		parent:GetAbsOrigin(),
		true
	)
	ParticleManager:SetParticleControlEnt(
		particle,
		1,
		parent,
		PATTACH_ABSORIGIN_FOLLOW,
		nil,
		parent:GetAbsOrigin(),
		true
	)
	self:AddParticle(particle, false, false, -1, false, false)
end
function modifier_item_0272_unyielding_shield.prototype.ApplyShield(self)
	local parent = self:GetParent()
	local ability = self:GetAbility()
	if not IsValidAlive(nil, parent) or not ability then
		return
	end
	local ability_shield_amount = ability:GetSpecialValue("item_0272", "ability_shield_amount")
	if ability_shield_amount <= 0 then
		return
	end
	parent:AddCurrentEnergyShield(ability_shield_amount, "next_frame_delta")
	self:RefreshAttributes()
end
function modifier_item_0272_unyielding_shield.prototype.GetAttributeBonus(self)
	local ability = self:GetAbility()
	if not ability then
		return {}
	end
	local ability_shield_amount = ability:GetSpecialValue("item_0272", "ability_shield_amount")
	return { base_energy_shield = ability_shield_amount }
end
function modifier_item_0272_unyielding_shield.prototype.IsHidden(self)
	return false
end
function modifier_item_0272_unyielding_shield.prototype.IsDebuff(self)
	return false
end
function modifier_item_0272_unyielding_shield.prototype.IsPurgable(self)
	return true
end
function modifier_item_0272_unyielding_shield.prototype.GetTexture(self)
	return "item_unrelenting_eye"
end
modifier_item_0272_unyielding_shield =
	__TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0272_unyielding_shield)
____exports.modifier_item_0272_unyielding_shield = modifier_item_0272_unyielding_shield
return ____exports