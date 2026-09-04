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
local ____modifier_generic_bleed = require("modifiers.debuff.modifier_generic_bleed")
local modifier_generic_bleed = ____modifier_generic_bleed.modifier_generic_bleed
local ____item_0409_shared = require("abilities.items.item_0409_shared")
local IsOwnedByParentPlayer = ____item_0409_shared.IsOwnedByParentPlayer
local IsValidEnemyUnit = ____item_0409_shared.IsValidEnemyUnit
local StartAbilityCooldown = ____item_0409_shared.StartAbilityCooldown
local BLOOD_MIST_HEAL_PARTICLE = "particles/item/item_heal.vpcf"
local BLOOD_MIST_HIT_PARTICLE = "particles/axe/ability/life_stealer_infest_emerge_bloody.vpcf"
local BLOOD_HASTE_PARTICLE = "particles/generic_gameplay/rune_haste_owner.vpcf"
local BLOOD_MIST_HEAL_SOUND = "Hero_LifeStealer.OpenWounds"
local BLOOD_HASTE_SOUND = "Hero_Bloodseeker.Thirst.Cast"
____exports.item_0412 = __TS__Class()
local item_0412 = ____exports.item_0412
item_0412.name = "item_0412"
__TS__ClassExtends(item_0412, BaseItem_CS)
function item_0412.prototype.Precache(self, context)
	PrecacheResource("particle", BLOOD_MIST_HEAL_PARTICLE, context)
	PrecacheResource("particle", BLOOD_MIST_HIT_PARTICLE, context)
	PrecacheResource("particle", BLOOD_HASTE_PARTICLE, context)
end
function item_0412.prototype.GetIntrinsicModifierName(self)
	return ____exports.modifier_item_0412_blood_mist_mask.name
end
item_0412 = __TS__DecorateLegacy({ registerAbility(nil) }, item_0412)
____exports.item_0412 = item_0412
____exports.modifier_item_0412_blood_mist_mask = __TS__Class()
local modifier_item_0412_blood_mist_mask = ____exports.modifier_item_0412_blood_mist_mask
modifier_item_0412_blood_mist_mask.name = "modifier_item_0412_blood_mist_mask"
__TS__ClassExtends(modifier_item_0412_blood_mist_mask, BaseModifier_CS)
function modifier_item_0412_blood_mist_mask.prototype.DeclareEvents(self)
	return { BusinessEvents.ON_ATTACK_LANDED, BusinessEvents.ON_UNIT_DEATH_BEFORE }
end
function modifier_item_0412_blood_mist_mask.prototype.IsHidden(self)
	return true
end
function modifier_item_0412_blood_mist_mask.prototype.OnAttackLanded_CS(self, event)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	local ability = self:GetAbility()
	if not ability or event.attacker ~= parent or event.is_sub_attack then
		return
	end
	if not IsValidAlive(nil, parent) or not IsValidEnemyUnit(nil, parent, event.target) then
		return
	end
	if (event.final_damage or 0) <= 0 or not event.target:HasModifier(modifier_generic_bleed.name) then
		return
	end
	if not ability:IsCooldownReady() then
		return
	end
	local ability_restore_max_health_pct = math.max(0, ability:GetSpecialValueFor("ability_restore_max_health_pct"))
	local healAmount = parent:GetMaxHealth() * (ability_restore_max_health_pct / 100)
	if healAmount > 0 then
		MyGameHeal:ApplyHeal({
			healer = parent,
			target = parent,
			amount = healAmount,
			ability = ability,
			source = "attack_lifesteal",
		})
		self:PlayEffects1(parent, event.target)
	end
	StartAbilityCooldown(nil, ability, 1)
end
function modifier_item_0412_blood_mist_mask.prototype.OnUnitDeathBefore_CS(self, event)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	local ability = self:GetAbility()
	if not ability or not IsValidAlive(nil, parent) then
		return
	end
	if not IsOwnedByParentPlayer(nil, event.attacker, parent) then
		return
	end
	if not IsValidEnemyUnit(nil, parent, event.victim) or not event.victim:HasModifier(modifier_generic_bleed.name) then
		return
	end
	local ability_haste_duration = math.max(0, ability:GetSpecialValueFor("ability_haste_duration"))
	if ability_haste_duration <= 0 then
		return
	end
	parent:AddNewModifier(
		parent,
		ability,
		____exports.modifier_item_0412_blood_haste.name,
		{ duration = ability_haste_duration }
	)
end
function modifier_item_0412_blood_mist_mask.prototype.PlayEffects1(self, parent, target)
	local bloodParticle =
		MyGameHeroParticleManager:CreateParticle(BLOOD_MIST_HIT_PARTICLE, PATTACH_ABSORIGIN_FOLLOW, target, parent)
	MyGameHeroParticleManager:SetParticleControl(bloodParticle, 0, target:GetAbsOrigin())
	MyGameHeroParticleManager:ReleaseParticleIndex(bloodParticle)
	EmitSoundOn(BLOOD_MIST_HEAL_SOUND, target)
end
modifier_item_0412_blood_mist_mask = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0412_blood_mist_mask)
____exports.modifier_item_0412_blood_mist_mask = modifier_item_0412_blood_mist_mask
____exports.modifier_item_0412_blood_haste = __TS__Class()
local modifier_item_0412_blood_haste = ____exports.modifier_item_0412_blood_haste
modifier_item_0412_blood_haste.name = "modifier_item_0412_blood_haste"
__TS__ClassExtends(modifier_item_0412_blood_haste, BaseModifier_CS)
function modifier_item_0412_blood_haste.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	self:CreateOrRefreshHasteParticle(self:GetParent())
	self:PlayEffects1(self:GetParent())
	local healParticle =
		ParticleManager:CreateParticle(BLOOD_MIST_HEAL_PARTICLE, PATTACH_ABSORIGIN_FOLLOW, self:GetCaster())
	ParticleManager:SetParticleControl(healParticle, 0, self:GetCaster():GetAbsOrigin())
	self:AddParticle(healParticle, false, false, -1, false, false)
end
function modifier_item_0412_blood_haste.GetLocalizationCN(self)
	return { name = "血雾面具", description = "回复自身最大生命值百分比。" }
end
function modifier_item_0412_blood_haste.prototype.OnRefresh(self)
	if not IsServer() then
		return
	end
	self:CreateOrRefreshHasteParticle(self:GetParent())
	self:PlayEffects1(self:GetParent())
end
function modifier_item_0412_blood_haste.prototype.GetAttributeBonus(self)
	local ability = self:GetAbility()
	return { attack_speed = ability and ability:GetSpecialValueFor("ability_bonus_attack_speed") or 0 }
end
function modifier_item_0412_blood_haste.prototype.IsPurgable(self)
	return true
end
function modifier_item_0412_blood_haste.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	self:DestroyHasteParticle()
end
function modifier_item_0412_blood_haste.prototype.PlayEffects1(self, parent)
	EmitSoundOn(BLOOD_HASTE_SOUND, parent)
end
function modifier_item_0412_blood_haste.prototype.CreateOrRefreshHasteParticle(self, parent)
	if self.hasteParticle ~= nil then
		return
	end
	local particle = MyGameHeroParticleManager:CreateParticle(
		BLOOD_HASTE_PARTICLE,
		PATTACH_ABSORIGIN_FOLLOW,
		parent,
		self:GetCaster()
	)
	MyGameHeroParticleManager:SetParticleControlEnt(
		particle,
		0,
		parent,
		PATTACH_ABSORIGIN_FOLLOW,
		nil,
		parent:GetAbsOrigin(),
		true
	)
	self.hasteParticle = particle
end
function modifier_item_0412_blood_haste.prototype.DestroyHasteParticle(self)
	if self.hasteParticle == nil then
		return
	end
	MyGameHeroParticleManager:DestroyParticle(self.hasteParticle, true)
	MyGameHeroParticleManager:ReleaseParticleIndex(self.hasteParticle)
	self.hasteParticle = nil
end
modifier_item_0412_blood_haste = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0412_blood_haste)
____exports.modifier_item_0412_blood_haste = modifier_item_0412_blood_haste
return ____exports