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
local ____item_0409_shared = require("abilities.items.item_0409_shared")
local IsValidEnemyUnit = ____item_0409_shared.IsValidEnemyUnit
local ____dark_domain_lightning_flash = require("my_game_axe.room.dark_domain_lightning_flash")
local TriggerDarkDomainLightningFlash = ____dark_domain_lightning_flash.TriggerDarkDomainLightningFlash
____exports.item_0469 = __TS__Class()
local item_0469 = ____exports.item_0469
item_0469.name = "item_0469"
__TS__ClassExtends(item_0469, BaseItem_CS)
function item_0469.prototype.Precache(self, context)
	PrecacheResource("particle", "particles/generic_gameplay/rune_haste_owner.vpcf", context)
end
function item_0469.prototype.GetIntrinsicModifierName(self)
	return ____exports.modifier_item_0469_thunder_energy.name
end
item_0469 = __TS__DecorateLegacy({ registerAbility(nil) }, item_0469)
____exports.item_0469 = item_0469
____exports.modifier_item_0469_thunder_energy = __TS__Class()
local modifier_item_0469_thunder_energy = ____exports.modifier_item_0469_thunder_energy
modifier_item_0469_thunder_energy.name = "modifier_item_0469_thunder_energy"
__TS__ClassExtends(modifier_item_0469_thunder_energy, BaseModifier_CS)
function modifier_item_0469_thunder_energy.prototype.____constructor(self, ...)
	BaseModifier_CS.prototype.____constructor(self, ...)
	self.lastAttackTime = 0
	self.cooldownUntil = 0
end
function modifier_item_0469_thunder_energy.prototype.DeclareEvents(self)
	return { BusinessEvents.ON_ATTACK_LANDED }
end
function modifier_item_0469_thunder_energy.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	self:SetStackCount(0)
	self:StartDecayThink()
end
function modifier_item_0469_thunder_energy.prototype.OnRefresh(self)
	if not IsServer() then
		return
	end
	self:StartDecayThink()
end
function modifier_item_0469_thunder_energy.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	self:StartIntervalThink(-1)
end
function modifier_item_0469_thunder_energy.prototype.OnAttackLanded_CS(self, event)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	local ability = self:GetAbility()
	if not ability or event.attacker ~= parent or event.is_sub_attack or event.is_base_attack == false then
		return
	end
	if not IsValidAlive(nil, parent) or not IsValidEnemyUnit(nil, parent, event.target) then
		return
	end
	if parent:HasModifier(____exports.modifier_item_0469_swift_thunder.name) then
		return
	end
	if GameRules:GetGameTime() < self.cooldownUntil then
		return
	end
	self.lastAttackTime = GameRules:GetGameTime()
	self:AddThunderEnergy(parent, ability)
end
function modifier_item_0469_thunder_energy.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	local ability = self:GetAbility()
	if not ability then
		return
	end
	local currentStacks = self:GetStackCount()
	if currentStacks <= 0 then
		return
	end
	local ability_decay_delay = math.max(0, ability:GetSpecialValueFor("ability_decay_delay"))
	if GameRules:GetGameTime() - self.lastAttackTime < ability_decay_delay then
		return
	end
	local ability_decay_stacks = math.max(1, math.floor(ability:GetSpecialValueFor("ability_decay_stacks")))
	local nextStacks = math.max(0, currentStacks - ability_decay_stacks)
	self:SetStackCount(nextStacks)
end
function modifier_item_0469_thunder_energy.prototype.IsHidden(self)
	return self:GetStackCount() <= 0
end
function modifier_item_0469_thunder_energy.prototype.IsPurgable(self)
	return false
end
function modifier_item_0469_thunder_energy.prototype.AddThunderEnergy(self, parent, ability)
	local ability_required_stacks =
		math.max(1, math.floor(ability:GetSpecialValueFor("ability_value_c_required_stacks")))
	local nextStacks = self:GetStackCount() + 1
	if nextStacks < ability_required_stacks then
		self:SetStackCount(nextStacks)
		return
	end
	self:SetStackCount(0)
	local ability_duration = math.max(0, ability:GetSpecialValueFor("ability_duration"))
	if ability_duration <= 0 then
		return
	end
	parent:AddNewModifier(
		parent,
		ability,
		____exports.modifier_item_0469_swift_thunder.name,
		{ duration = ability_duration }
	)
	TriggerDarkDomainLightningFlash(nil, parent)
	self.cooldownUntil = GameRules:GetGameTime() + math.max(0, ability:GetSpecialValueFor("ability_internal_cd"))
end
function modifier_item_0469_thunder_energy.prototype.StartDecayThink(self)
	local ability = self:GetAbility()
	if not ability then
		return
	end
	local ability_decay_interval = math.max(0.1, ability:GetSpecialValueFor("ability_decay_interval"))
	self:StartIntervalThink(ability_decay_interval)
end
modifier_item_0469_thunder_energy = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0469_thunder_energy)
____exports.modifier_item_0469_thunder_energy = modifier_item_0469_thunder_energy
____exports.modifier_item_0469_swift_thunder = __TS__Class()
local modifier_item_0469_swift_thunder = ____exports.modifier_item_0469_swift_thunder
modifier_item_0469_swift_thunder.name = "modifier_item_0469_swift_thunder"
__TS__ClassExtends(modifier_item_0469_swift_thunder, BaseModifier_CS)
function modifier_item_0469_swift_thunder.GetLocalizationCN(self)
	return { name = "迅雷", description = "攻击速度大幅提高。" }
end
function modifier_item_0469_swift_thunder.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	self:PlayEffects1(self:GetParent())
end
function modifier_item_0469_swift_thunder.prototype.OnRefresh(self)
	if not IsServer() then
		return
	end
	self:PlayEffects1(self:GetParent())
end
function modifier_item_0469_swift_thunder.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	self:DestroyHasteParticle()
end
function modifier_item_0469_swift_thunder.prototype.GetAttributeBonus(self)
	local ability = self:GetAbility()
	local ____ability_0
	if ability then
		____ability_0 = math.max(0, ability:GetSpecialValueFor("ability_value_attack_speed"))
	else
		____ability_0 = 0
	end
	return { attack_speed = ____ability_0 }
end
function modifier_item_0469_swift_thunder.prototype.IsHidden(self)
	return false
end
function modifier_item_0469_swift_thunder.prototype.IsPurgable(self)
	return true
end
function modifier_item_0469_swift_thunder.prototype.PlayEffects1(self, parent)
	if self.hasteParticle == nil then
		local particle = MyGameHeroParticleManager:CreateParticle(
			"particles/generic_gameplay/rune_haste_owner.vpcf",
			PATTACH_ABSORIGIN_FOLLOW,
			parent,
			parent
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
	EmitSoundOn("Hero_Bloodseeker.Thirst.Cast", parent)
end
function modifier_item_0469_swift_thunder.prototype.DestroyHasteParticle(self)
	if self.hasteParticle == nil then
		return
	end
	MyGameHeroParticleManager:DestroyParticle(self.hasteParticle, true)
	MyGameHeroParticleManager:ReleaseParticleIndex(self.hasteParticle)
	self.hasteParticle = nil
end
modifier_item_0469_swift_thunder = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0469_swift_thunder)
____exports.modifier_item_0469_swift_thunder = modifier_item_0469_swift_thunder
return ____exports