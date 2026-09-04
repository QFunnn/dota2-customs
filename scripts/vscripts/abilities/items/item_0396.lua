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
local ITEM_0396_VULNERABLE_DURATION = 3
____exports.item_0396 = __TS__Class()
local item_0396 = ____exports.item_0396
item_0396.name = "item_0396"
__TS__ClassExtends(item_0396, BaseItem_CS)
function item_0396.prototype.GetIntrinsicModifierName(self)
	return ____exports.modifier_item_0396_contempt.name
end
item_0396 = __TS__DecorateLegacy({ registerAbility(nil) }, item_0396)
____exports.item_0396 = item_0396
____exports.modifier_item_0396_contempt = __TS__Class()
local modifier_item_0396_contempt = ____exports.modifier_item_0396_contempt
modifier_item_0396_contempt.name = "modifier_item_0396_contempt"
__TS__ClassExtends(modifier_item_0396_contempt, BaseModifier_CS)
function modifier_item_0396_contempt.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	self:StartDamageInterval()
end
function modifier_item_0396_contempt.prototype.OnRefresh(self)
	if not IsServer() then
		return
	end
	self:StartDamageInterval()
end
function modifier_item_0396_contempt.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	local ability = self:GetAbility()
	if not ability or not IsValidAlive(nil, parent) then
		return
	end
	self:DamageEnemies(parent, ability)
end
function modifier_item_0396_contempt.prototype.IsHidden(self)
	return true
end
function modifier_item_0396_contempt.prototype.IsDebuff(self)
	return false
end
function modifier_item_0396_contempt.prototype.IsPurgable(self)
	return false
end
function modifier_item_0396_contempt.prototype.StartDamageInterval(self)
	local ability = self:GetAbility()
	if not ability then
		return
	end
	local ability_interval = math.max(0.1, ability:GetSpecialValueFor("ability_interval"))
	self:StartIntervalThink(ability_interval)
end
function modifier_item_0396_contempt.prototype.DamageEnemies(self, parent, ability)
	local ____math_max_2 = math.max
	local ____this_1
	____this_1 = parent
	local ____opt_0 = ____this_1.GetTotalEnergyShield
	local totalShield = ____math_max_2(
		0,
		____opt_0 and ____opt_0(____this_1) or MyGameAttribute:GetAttribute(parent, "total_energy_shield") or 0
	)
	if totalShield <= 0 then
		return
	end
	local ability_value_max_shield_damage_pct =
		math.max(0, ability:GetSpecialValueFor("ability_value_max_shield_damage_pct"))
	if ability_value_max_shield_damage_pct <= 0 then
		return
	end
	local ability_radius = math.max(0, ability:GetSpecialValueFor("ability_radius"))
	if ability_radius <= 0 then
		return
	end
	local damage = totalShield * (ability_value_max_shield_damage_pct / 100)
	if damage <= 0 then
		return
	end
	local enemies = FindUnitsInRadius(
		parent:GetTeamNumber(),
		parent:GetAbsOrigin(),
		nil,
		ability_radius,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HEROES_AND_CREEPS,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_ANY_ORDER,
		false
	)
	if #enemies <= 0 then
		return
	end
	self:PlayEffects1(parent, ability_radius)
	for ____, enemy in ipairs(enemies) do
		do
			if not IsValidAlive(nil, enemy) or enemy:IsBuilding() then
				goto __continue21
			end
			Damage:ApplyDamage({
				victim = enemy,
				attacker = parent,
				damage = damage,
				damage_type = 4,
				ability = ability,
			})
			AddDeBuffStatus(
				nil,
				enemy,
				parent,
				ability,
				DebuffStatusType.VULNERABLE,
				{ stack = 1, duration = ITEM_0396_VULNERABLE_DURATION }
			)
		end
		::__continue21::
	end
end
function modifier_item_0396_contempt.prototype.PlayEffects1(self, parent, radius)
	local particle = MyGameHeroParticleManager:CreateParticle(
		"particles/neutral_fx/miniboss_dire_shield_hit.vpcf",
		PATTACH_ABSORIGIN_FOLLOW,
		parent,
		parent
	)
	MyGameHeroParticleManager:SetParticleControl(particle, 0, parent:GetAbsOrigin())
	MyGameHeroParticleManager:SetParticleControl(particle, 1, Vector(radius, radius, radius))
	MyGameHeroParticleManager:ReleaseParticleIndex(particle)
end
modifier_item_0396_contempt = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0396_contempt)
____exports.modifier_item_0396_contempt = modifier_item_0396_contempt
return ____exports