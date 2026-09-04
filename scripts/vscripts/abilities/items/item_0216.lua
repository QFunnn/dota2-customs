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
local RADIANCE_OWNER_PARTICLE = "particles/items2_fx/radiance_owner.vpcf"
local RADIANCE_ENEMY_PARTICLE = "particles/items2_fx/radiance.vpcf"
____exports.item_0216 = __TS__Class()
local item_0216 = ____exports.item_0216
item_0216.name = "item_0216"
__TS__ClassExtends(item_0216, BaseItem_CS)
function item_0216.prototype.GetItemConfig(self)
	return { behavior = DOTA_ABILITY_BEHAVIOR_TOGGLE + DOTA_ABILITY_BEHAVIOR_NO_TARGET }
end
function item_0216.prototype.GetAOERadius(self)
	return self:GetSpecialValueFor("ability_radius")
end
function item_0216.prototype.GetAbilityTextureName(self)
	if not self:IsNull() and not self:GetToggleState() then
		return "item_radiance_inactive"
	end
	return "item_radiance"
end
function item_0216.prototype.GetIntrinsicModifierName(self)
	return ____exports.modifier_item_0216.name
end
function item_0216.prototype.OnToggle(self)
	if not IsServer() then
		return
	end
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	local modifier = caster:FindModifierByName(____exports.modifier_item_0216.name)
	if modifier ~= nil then
		modifier:OnToggleStateChanged()
	end
end
item_0216 = __TS__DecorateLegacy({ registerAbility(nil) }, item_0216)
____exports.item_0216 = item_0216
--- 辉耀（传说·Lv7）。
-- 主动开启：自身持续受到通用灼烧，并对 ability_radius 范围内敌人造成
--  ability_value_shield_damage_pct% 最大护盾值的纯粹伤害，附加灼烧（ability_burn_duration 秒）。
--  护盾越厚伤害越高，与炽焰壁垒(回护盾)/火焰纹章(灼烧→点燃)形成护盾·灼烧联动闭环。
____exports.modifier_item_0216 = __TS__Class()
local modifier_item_0216 = ____exports.modifier_item_0216
modifier_item_0216.name = "modifier_item_0216"
__TS__ClassExtends(modifier_item_0216, BaseModifier_CS)
function modifier_item_0216.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	self:StartIntervalThink(self:GetInterval())
end
function modifier_item_0216.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	local ability = self:GetAbility()
	if ability then
		self:RemoveSelfBurn(parent, ability)
	end
	self:StopEffects1()
	self:StartIntervalThink(-1)
end
function modifier_item_0216.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	local ability = self:GetAbility()
	if not ability or not IsValidAlive(nil, parent) then
		return
	end
	if not ability:GetToggleState() then
		self:RemoveSelfBurn(parent, ability)
		self:StopEffects1()
		return
	end
	self:PlayEffects1(parent)
	self:EnsureSelfBurn(parent, ability)
	self:DamageEnemies(parent, ability)
end
function modifier_item_0216.prototype.OnToggleStateChanged(self)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	local ability = self:GetAbility()
	if not ability or not IsValidAlive(nil, parent) or not ability:GetToggleState() then
		if ability then
			self:RemoveSelfBurn(parent, ability)
		end
		self:StopEffects1()
		return
	end
	self:EnsureSelfBurn(parent, ability)
	self:PlayEffects1(parent)
end
function modifier_item_0216.prototype.EnsureSelfBurn(self, parent, ability)
	if parent:HasModifier("modifier_generic_burning") then
		return
	end
	local ability_burn_duration = ability:GetSpecialValueFor("ability_burn_duration")
	if ability_burn_duration <= 0 then
		return
	end
	AddDeBuffStatus(nil, parent, parent, ability, DebuffStatusType.BURN, { duration = ability_burn_duration })
end
function modifier_item_0216.prototype.RemoveSelfBurn(self, parent, ability)
	local selfBurn = parent:FindModifierByNameAndCaster("modifier_generic_burning", parent)
	if (selfBurn and selfBurn:GetAbility()) == ability then
		selfBurn:Destroy()
	end
end
function modifier_item_0216.prototype.DamageEnemies(self, parent, ability)
	local ____math_max_6 = math.max
	local ____this_5
	____this_5 = parent
	local ____opt_4 = ____this_5.GetTotalEnergyShield
	local ability_max_shield = ____math_max_6(
		0,
		____opt_4 and ____opt_4(____this_5) or MyGameAttribute:GetAttribute(parent, "total_energy_shield") or 0
	)
	if ability_max_shield <= 0 then
		return
	end
	local ability_value_shield_damage_pct = math.max(0, ability:GetSpecialValueFor("ability_value_shield_damage_pct"))
	if ability_value_shield_damage_pct <= 0 then
		return
	end
	local ability_damage = ability_max_shield * (ability_value_shield_damage_pct / 100)
	if ability_damage <= 0 then
		return
	end
	local ability_radius = math.max(0, ability:GetSpecialValueFor("ability_radius"))
	if ability_radius <= 0 then
		return
	end
	local ability_burn_duration = math.max(0, ability:GetSpecialValueFor("ability_burn_duration"))
	local enemies = FindUnitsInRadius(
		parent:GetTeamNumber(),
		parent:GetAbsOrigin(),
		nil,
		ability_radius,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		bit.bor(DOTA_UNIT_TARGET_HERO, DOTA_UNIT_TARGET_BASIC),
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_ANY_ORDER,
		false
	)
	for ____, enemy in ipairs(enemies) do
		do
			if not IsValidAlive(nil, enemy) or enemy:IsBuilding() then
				goto __continue33
			end
			Damage:ApplyDamage({
				victim = enemy,
				attacker = parent,
				damage = ability_damage * 0.8,
				damage_type = 4,
				ability = ability,
				extra_data = {
					damage_tags = DamageTag.NO_PROC,
					source_name = self:GetName(),
				},
			})
			if ability_burn_duration > 0 then
				AddDeBuffStatus(
					nil,
					enemy,
					parent,
					ability,
					DebuffStatusType.BURN,
					{ duration = ability_burn_duration }
				)
			end
			self:PlayEffects2(enemy, ability)
		end
		::__continue33::
	end
end
function modifier_item_0216.prototype.PlayEffects1(self, parent)
	if self.ownerParticle ~= nil then
		return
	end
	self.ownerParticle =
		MyGameHeroParticleManager:CreateParticle(RADIANCE_OWNER_PARTICLE, PATTACH_ABSORIGIN_FOLLOW, parent, parent)
end
function modifier_item_0216.prototype.StopEffects1(self)
	if self.ownerParticle == nil then
		return
	end
	MyGameHeroParticleManager:DestroyParticle(self.ownerParticle, false)
	MyGameHeroParticleManager:ReleaseParticleIndex(self.ownerParticle)
	self.ownerParticle = nil
end
function modifier_item_0216.prototype.PlayEffects2(self, enemy, ability)
	enemy:AddNewModifier(
		self:GetParent(),
		ability,
		____exports.modifier_item_0216_radiance_effect.name,
		{ duration = self:GetInterval() + 0.1 }
	)
end
function modifier_item_0216.prototype.GetInterval(self)
	local ability = self:GetAbility()
	local ____ability_7
	if ability then
		____ability_7 = ability:GetSpecialValueFor("ability_damage_interval")
	else
		____ability_7 = 1
	end
	local interval = ____ability_7
	return math.max(0.1, interval)
end
function modifier_item_0216.prototype.IsHidden(self)
	return true
end
function modifier_item_0216.prototype.IsPurgable(self)
	return false
end
modifier_item_0216 = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0216)
____exports.modifier_item_0216 = modifier_item_0216
____exports.modifier_item_0216_radiance_effect = __TS__Class()
local modifier_item_0216_radiance_effect = ____exports.modifier_item_0216_radiance_effect
modifier_item_0216_radiance_effect.name = "modifier_item_0216_radiance_effect"
__TS__ClassExtends(modifier_item_0216_radiance_effect, BaseModifier_CS)
function modifier_item_0216_radiance_effect.prototype.IsHidden(self)
	return true
end
function modifier_item_0216_radiance_effect.prototype.IsDebuff(self)
	return true
end
function modifier_item_0216_radiance_effect.prototype.IsPurgable(self)
	return false
end
function modifier_item_0216_radiance_effect.prototype.GetEffectName(self)
	return RADIANCE_ENEMY_PARTICLE
end
function modifier_item_0216_radiance_effect.prototype.GetEffectAttachType(self)
	return PATTACH_ABSORIGIN_FOLLOW
end
modifier_item_0216_radiance_effect = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0216_radiance_effect)
____exports.modifier_item_0216_radiance_effect = modifier_item_0216_radiance_effect
return ____exports