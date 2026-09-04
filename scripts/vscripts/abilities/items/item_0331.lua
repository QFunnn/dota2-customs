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
local __TS__ArrayForEach = ____lualib.__TS__ArrayForEach
local ____exports = {}
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local registerModifier = ____dota_ts_adapter.registerModifier
local ____modifier_base = require("modifiers.class.modifier_base")
local BaseModifier_CS = ____modifier_base.BaseModifier_CS
local _____base_item = require("abilities.items._base_item")
local BaseItem_CS = _____base_item.BaseItem_CS
____exports.item_0331 = __TS__Class()
local item_0331 = ____exports.item_0331
item_0331.name = "item_0331"
__TS__ClassExtends(item_0331, BaseItem_CS)
function item_0331.prototype.GetIntrinsicModifierName(self)
	return ____exports.modifier_item_0331_shield_strike.name
end
item_0331 = __TS__DecorateLegacy({ registerAbility(nil) }, item_0331)
____exports.item_0331 = item_0331
____exports.modifier_item_0331_shield_strike = __TS__Class()
local modifier_item_0331_shield_strike = ____exports.modifier_item_0331_shield_strike
modifier_item_0331_shield_strike.name = "modifier_item_0331_shield_strike"
__TS__ClassExtends(modifier_item_0331_shield_strike, BaseModifier_CS)
function modifier_item_0331_shield_strike.prototype.DeclareEvents(self)
	return { BusinessEvents.ON_ATTACK_LANDED }
end
function modifier_item_0331_shield_strike.prototype.IsHidden(self)
	return true
end
function modifier_item_0331_shield_strike.prototype.IsPurgable(self)
	return false
end
function modifier_item_0331_shield_strike.prototype.PlayEffects(self, target)
	if not IsServer() then
		return
	end
	local ability = self:GetAbility()
	if not ability then
		return
	end
	local effect = MyGameHeroParticleManager:CreateParticle(
		"particles/elder_dust_hit.vpcf",
		PATTACH_ABSORIGIN_FOLLOW,
		target,
		self:GetParent()
	)
	MyGameHeroParticleManager:SetParticleControl(effect, 0, target:GetAbsOrigin())
	ScreenShake(target:GetAbsOrigin(), 5, 5, 0.1, 3000, 0, true)
	MyGameHeroParticleManager:ReleaseParticleIndex(effect)
	EmitSoundOn("Hero_Lion.ImpaleHitTarget", target)
end
function modifier_item_0331_shield_strike.prototype.OnAttackLanded_CS(self, event)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	if event.attacker ~= parent then
		return
	end
	local target = event.target
	if not target or not IsValid(nil, target) or target:IsBuilding() then
		return
	end
	if target:GetTeamNumber() == parent:GetTeamNumber() then
		return
	end
	local ability = self:GetAbility()
	if not ability then
		return
	end
	if not ability:IsCooldownReady() then
		return
	end
	local ability_current_shield_damage_pct = ability:GetSpecialValueFor("ability_current_shield_damage_pct")
	if ability_current_shield_damage_pct <= 0 then
		return
	end
	local ____opt_0 = parent.GetTotalEnergyShield
	local currentShield = ____opt_0 and ____opt_0(parent) or 0
	if currentShield <= 0 then
		return
	end
	local damage = currentShield * (ability_current_shield_damage_pct / 100)
	if damage <= 0 then
		return
	end
	local units = FindUnitsInRadius(
		event.attacker:GetTeamNumber(),
		target:GetAbsOrigin(),
		nil,
		240,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HEROES_AND_CREEPS,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_CLOSEST,
		false
	)
	self:PlayEffects(target)
	if #units == 0 then
		return
	end
	__TS__ArrayForEach(units, function(____, unit)
		if not unit or not IsValid(nil, unit) or unit:IsBuilding() then
			return
		end
		unit:EmitSound("Item.Lotus.Heal")
		Damage:ApplyDamage({
			victim = unit,
			attacker = parent,
			damage = damage,
			damage_type = 1,
			ability = ability,
		})
	end)
	local lv = math.max(0, ability:GetLevel() - 1)
	local cd = ability:GetCooldown(lv)
	local ____ability_StartCooldown_3 = ability.StartCooldown
	local ____temp_2
	if cd > 0 then
		____temp_2 = cd
	else
		____temp_2 = 0.01
	end
	____ability_StartCooldown_3(ability, ____temp_2)
end
modifier_item_0331_shield_strike = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0331_shield_strike)
____exports.modifier_item_0331_shield_strike = modifier_item_0331_shield_strike
return ____exports