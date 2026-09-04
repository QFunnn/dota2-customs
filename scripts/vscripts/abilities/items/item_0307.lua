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
local ITEM_0307_DEBUFF_DURATION = 3
local ITEM_0307_TENTACLE_PARTICLE = "particles/boss_tidehunter/tidehunter_spell_ravage.vpcf"
____exports.item_0307 = __TS__Class()
local item_0307 = ____exports.item_0307
item_0307.name = "item_0307"
__TS__ClassExtends(item_0307, BaseItem_CS)
function item_0307.prototype.GetIntrinsicModifierName(self)
	return ____exports.modifier_item_0307.name
end
item_0307 = __TS__DecorateLegacy({ registerAbility(nil) }, item_0307)
____exports.item_0307 = item_0307
____exports.modifier_item_0307 = __TS__Class()
local modifier_item_0307 = ____exports.modifier_item_0307
modifier_item_0307.name = "modifier_item_0307"
__TS__ClassExtends(modifier_item_0307, BaseModifier_CS)
function modifier_item_0307.prototype.DeclareEvents(self)
	return { BusinessEvents.ON_ATTACK_LANDED }
end
function modifier_item_0307.prototype.OnAttackLanded_CS(self, event)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	local ability = self:GetAbility()
	if not ability or event.attacker ~= parent or event.is_sub_attack then
		return
	end
	local target = event.target
	if not IsValidAlive(nil, parent) or not IsValidAlive(nil, target) or target:IsBuilding() then
		return
	end
	if target:GetTeamNumber() == parent:GetTeamNumber() then
		return
	end
	if not RollPercentage(math.max(0, ability:GetSpecialValueFor("ability_value_trigger_chance_pct"))) then
		return
	end
	local agility = MyGameAttribute:GetAttribute(parent, "total_agility") or 0
	local intelligence = MyGameAttribute:GetAttribute(parent, "total_intelligence") or 0
	local damagePct = math.max(0, ability:GetSpecialValueFor("ability_value_damage_pct"))
	local slowPct = math.max(0, ability:GetSpecialValueFor("ability_slow_pct"))
	local dotPct = math.max(0, ability:GetSpecialValueFor("ability_dot_pct"))
	local damage = (agility + intelligence) * (damagePct / 100)
	if damage <= 0 then
		return
	end
	self:PlayTentacleEffect(target)
	Damage:ApplyDamage({
		attacker = parent,
		victim = target,
		ability = ability,
		damage = damage,
		damage_type = 2,
	})
	target:AddNewModifier(
		parent,
		ability,
		____exports.modifier_item_0307_vortex.name,
		{ duration = ITEM_0307_DEBUFF_DURATION, slow_pct = slowPct, dot_damage = damage * (dotPct / 100) }
	)
end
function modifier_item_0307.prototype.IsHidden(self)
	return true
end
function modifier_item_0307.prototype.PlayTentacleEffect(self, target)
	local pfx = MyGameHeroParticleManager:CreateParticle(
		ITEM_0307_TENTACLE_PARTICLE,
		PATTACH_CUSTOMORIGIN,
		target,
		self:GetParent()
	)
	MyGameHeroParticleManager:SetParticleControl(pfx, 0, target:GetAbsOrigin())
	MyGameHeroParticleManager:ReleaseParticleIndex(pfx)
	target:EmitSound("Hero_Tidehunter.Projection")
end
modifier_item_0307 = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0307)
____exports.modifier_item_0307 = modifier_item_0307
____exports.modifier_item_0307_vortex = __TS__Class()
local modifier_item_0307_vortex = ____exports.modifier_item_0307_vortex
modifier_item_0307_vortex.name = "modifier_item_0307_vortex"
__TS__ClassExtends(modifier_item_0307_vortex, BaseModifier_CS)
function modifier_item_0307_vortex.prototype.____constructor(self, ...)
	BaseModifier_CS.prototype.____constructor(self, ...)
	self.slowPct = 0
	self.dotDamagePerSecond = 0
end
function modifier_item_0307_vortex.GetLocalizationCN(self)
	return { name = "涡流缠击", description = "移动速度降低，并持续受到魔法伤害。" }
end
function modifier_item_0307_vortex.prototype.OnCreated(self, params)
	if not IsServer() then
		return
	end
	self:UpdateParams(params)
	self:StartIntervalThink(0.5)
end
function modifier_item_0307_vortex.prototype.OnRefresh(self, params)
	if not IsServer() then
		return
	end
	self:UpdateParams(params)
end
function modifier_item_0307_vortex.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	local caster = self:GetCaster()
	local ability = self:GetAbility()
	if not ability or not IsValidAlive(nil, parent) or not IsValidAlive(nil, caster) then
		return
	end
	if self.dotDamagePerSecond <= 0 then
		return
	end
	Damage:ApplyDamage({
		attacker = caster,
		victim = parent,
		ability = ability,
		damage = self.dotDamagePerSecond * 0.5,
		damage_type = 2,
	})
end
function modifier_item_0307_vortex.prototype.GetAttributeBonus(self)
	return { bonus_movespeed_pct = -self.slowPct }
end
function modifier_item_0307_vortex.prototype.IsHidden(self)
	return false
end
function modifier_item_0307_vortex.prototype.IsDebuff(self)
	return true
end
function modifier_item_0307_vortex.prototype.IsPurgable(self)
	return true
end
function modifier_item_0307_vortex.prototype.UpdateParams(self, params)
	self.slowPct = math.max(0, tonumber(params.slow_pct or self.slowPct))
	self.dotDamagePerSecond = math.max(0, tonumber(params.dot_damage or self.dotDamagePerSecond))
	self:RefreshAttributes()
end
modifier_item_0307_vortex = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0307_vortex)
____exports.modifier_item_0307_vortex = modifier_item_0307_vortex
return ____exports