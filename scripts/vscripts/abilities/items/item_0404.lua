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
____exports.item_0404 = __TS__Class()
local item_0404 = ____exports.item_0404
item_0404.name = "item_0404"
__TS__ClassExtends(item_0404, BaseItem_CS)
function item_0404.prototype.Precache(self, context)
	PrecacheResource("particle", "particles/items3_fx/glimmer_cape_initial.vpcf", context)
	PrecacheResource("particle", "particles/items3_fx/glimmer_cape_initial_flash.vpcf", context)
end
function item_0404.prototype.GetIntrinsicModifierName(self)
	return ____exports.modifier_item_0404.name
end
function item_0404.prototype.GetItemConfig(self)
	return { behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET }
end
function item_0404.prototype.OnSpellStart(self)
	if not IsServer() then
		return
	end
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	local ability_initial_fade_delay = self:GetSpecialValueFor("ability_initial_fade_delay")
	local ability_duration = self:GetSpecialValueFor("ability_duration")
	____exports.modifier_item_0404_glimmer:applys(
		caster,
		caster,
		self,
		{ duration = ability_initial_fade_delay + ability_duration, fade_duration = ability_initial_fade_delay }
	)
	self:PlayEffects1(caster)
end
function item_0404.prototype.PlayEffects1(self, caster)
	caster:EmitSound("Item.GlimmerCape.Activate")
end
item_0404 = __TS__DecorateLegacy({ registerAbility(nil) }, item_0404)
____exports.item_0404 = item_0404
____exports.modifier_item_0404 = __TS__Class()
local modifier_item_0404 = ____exports.modifier_item_0404
modifier_item_0404.name = "modifier_item_0404"
__TS__ClassExtends(modifier_item_0404, BaseModifier_CS)
function modifier_item_0404.prototype.____constructor(self, ...)
	BaseModifier_CS.prototype.____constructor(self, ...)
	self.cachedTotalAttackSpeed = -1
	self.cachedEvasionPct = 0
end
function modifier_item_0404.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	self:RecalculateEvasion(true)
	self:StartIntervalThink(0.5)
end
function modifier_item_0404.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	self:RecalculateEvasion(false)
end
function modifier_item_0404.prototype.GetAttributeBonus(self)
	return { evasion_pct = self.cachedEvasionPct }
end
function modifier_item_0404.prototype.IsHidden(self)
	return true
end
function modifier_item_0404.prototype.RecalculateEvasion(self, forceRefresh)
	local parent = self:GetParent()
	local ability = self:GetAbility()
	if not IsValid(nil, parent) or not ability then
		return
	end
	local ability_attack_speed_per_evasion =
		math.max(1, ability:GetSpecialValueFor("ability_value_c_attack_speed_per_evasion"))
	local ability_evasion_pct_per_step = math.max(0, ability:GetSpecialValueFor("ability_evasion_pct_per_step"))
	local ability_evasion_pct_max = math.max(0, ability:GetSpecialValueFor("ability_value_evasion_pct_max"))
	local totalAttackSpeed = math.max(0, MyGameAttribute:GetAttribute(parent, "total_attack_speed") or 0)
	local evasionPct = math.min(
		math.floor(totalAttackSpeed / ability_attack_speed_per_evasion) * ability_evasion_pct_per_step,
		ability_evasion_pct_max
	)
	local attackSpeedChanged = math.abs(totalAttackSpeed - self.cachedTotalAttackSpeed) > 0.01
	local evasionChanged = math.abs(evasionPct - self.cachedEvasionPct) > 0.01
	if not forceRefresh and not attackSpeedChanged and not evasionChanged then
		return
	end
	self.cachedTotalAttackSpeed = totalAttackSpeed
	self.cachedEvasionPct = evasionPct
	self:RefreshAttributes()
end
modifier_item_0404 = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0404)
____exports.modifier_item_0404 = modifier_item_0404
____exports.modifier_item_0404_glimmer = __TS__Class()
local modifier_item_0404_glimmer = ____exports.modifier_item_0404_glimmer
modifier_item_0404_glimmer.name = "modifier_item_0404_glimmer"
__TS__ClassExtends(modifier_item_0404_glimmer, BaseModifier_CS)
function modifier_item_0404_glimmer.prototype.____constructor(self, ...)
	BaseModifier_CS.prototype.____constructor(self, ...)
	self.fadeDuration = 0
	self.nextInvisTime = 0
end
function modifier_item_0404_glimmer.prototype.OnCreated(self, params)
	self.fadeDuration = params.fade_duration or 0
	self:RestartFade()
	self:PlayEffects1()
end
function modifier_item_0404_glimmer.prototype.DeclareEvents(self)
	return { BusinessEvents.ON_ATTACK_START, BusinessEvents.ON_ABILITY_START }
end
function modifier_item_0404_glimmer.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_INVISIBILITY_LEVEL }
end
function modifier_item_0404_glimmer.prototype.GetAttributeBonus(self)
	local ability = self:GetAbility()
	if not ability then
		return {}
	end
	local ability_bonus_movespeed_pct = ability:GetSpecialValueFor("ability_bonus_movespeed_pct")
	local ability_damage_reduction_pct = ability:GetSpecialValueFor("ability_damage_reduction_pct")
	return { bonus_movespeed_pct = ability_bonus_movespeed_pct, damage_reduction_pct = ability_damage_reduction_pct }
end
function modifier_item_0404_glimmer.prototype.CheckState(self)
	local ____MODIFIER_STATE_INVISIBLE_1 = MODIFIER_STATE_INVISIBLE
	local ____table_IsInvisibleActive_result_0
	if self:IsInvisibleActive() then
		____table_IsInvisibleActive_result_0 = true
	else
		____table_IsInvisibleActive_result_0 = nil
	end
	return { [____MODIFIER_STATE_INVISIBLE_1] = ____table_IsInvisibleActive_result_0 }
end
function modifier_item_0404_glimmer.prototype.IsHidden(self)
	return false
end
function modifier_item_0404_glimmer.prototype.IsDebuff(self)
	return false
end
function modifier_item_0404_glimmer.prototype.IsPurgable(self)
	return true
end
function modifier_item_0404_glimmer.prototype.GetTexture(self)
	return "item_glimmer_cape"
end
function modifier_item_0404_glimmer.prototype.OnAttackStart_CS(self, event)
	if not IsServer() then
		return
	end
	if event.attacker ~= self:GetParent() then
		return
	end
	self:RestartFade()
end
function modifier_item_0404_glimmer.prototype.OnAbilityStart_CS(self, event)
	if not IsServer() then
		return
	end
	if event.caster ~= self:GetParent():entindex() then
		return
	end
	self.nextInvisTime = math.huge
end
function modifier_item_0404_glimmer.prototype.GetModifierInvisibilityLevel(self)
	return self:IsInvisibleActive() and 1 or 0
end
function modifier_item_0404_glimmer.prototype.RestartFade(self)
	self.nextInvisTime = GameRules:GetGameTime() + self.fadeDuration
end
function modifier_item_0404_glimmer.prototype.IsInvisibleActive(self)
	return GameRules:GetGameTime() >= self.nextInvisTime
end
function modifier_item_0404_glimmer.prototype.PlayEffects1(self)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	local initialParticle = ParticleManager:CreateParticle(
		"particles/items3_fx/glimmer_cape_initial.vpcf",
		PATTACH_ABSORIGIN_FOLLOW,
		parent
	)
	ParticleManager:SetParticleControl(initialParticle, 0, parent:GetAbsOrigin())
	self:AddParticle(initialParticle, false, false, -1, false, false)
	local flashParticle = ParticleManager:CreateParticle(
		"particles/items3_fx/glimmer_cape_initial_flash.vpcf",
		PATTACH_ABSORIGIN_FOLLOW,
		parent
	)
	ParticleManager:SetParticleControl(flashParticle, 0, parent:GetAbsOrigin())
	self:AddParticle(flashParticle, false, false, -1, false, false)
end
modifier_item_0404_glimmer = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0404_glimmer)
____exports.modifier_item_0404_glimmer = modifier_item_0404_glimmer
return ____exports