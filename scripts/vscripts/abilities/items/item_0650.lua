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
local ITEM_0650_BURST_EFFECT = "particles/items2_fx/veil_of_discord.vpcf"
local ITEM_0650_POLL_INTERVAL = 0.25
local ITEM_0650_FALLBACK_COOLDOWN = 10
____exports.item_0650 = __TS__Class()
local item_0650 = ____exports.item_0650
item_0650.name = "item_0650"
__TS__ClassExtends(item_0650, BaseItem_CS)
function item_0650.prototype.GetIntrinsicModifierName(self)
	return ____exports.modifier_item_0650_archmage.name
end
item_0650 = __TS__DecorateLegacy({ registerAbility(nil) }, item_0650)
____exports.item_0650 = item_0650
--- 固有被动「大魔导」：周期消耗当前魔法引导范围爆破（视为技能释放）。
____exports.modifier_item_0650_archmage = __TS__Class()
local modifier_item_0650_archmage = ____exports.modifier_item_0650_archmage
modifier_item_0650_archmage.name = "modifier_item_0650_archmage"
__TS__ClassExtends(modifier_item_0650_archmage, BaseModifier_CS)
function modifier_item_0650_archmage.GetLocalizationCN(self)
	return {
		name = "大魔导",
		description = "周期性消耗当前魔法值，引导一次范围爆破，视为一次技能释放。",
	}
end
function modifier_item_0650_archmage.prototype.IsHidden(self)
	return true
end
function modifier_item_0650_archmage.prototype.IsPurgable(self)
	return false
end
function modifier_item_0650_archmage.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	self:StartIntervalThink(ITEM_0650_POLL_INTERVAL)
end
function modifier_item_0650_archmage.prototype.OnIntervalThink(self)
	local parent = self:GetParent()
	local ability = self:GetAbility()
	if not ability or not IsValidAlive(nil, parent) then
		return
	end
	if not ability:IsCooldownReady() then
		return
	end
	local rolledCost = ability:GetSpecialValueFor("ability_value_mana_cost_pct")
	local ____math_max_1 = math.max
	local ____temp_0
	if rolledCost > 0 then
		____temp_0 = rolledCost
	else
		____temp_0 = ability:GetSpecialValueFor("ability_mana_cost_pct")
	end
	local costPct = ____math_max_1(0, ____temp_0)
	local cost = math.floor(parent:GetMana() * (costPct / 100))
	if cost <= 0 then
		return
	end
	local radius = math.max(0, ability:GetSpecialValueFor("ability_radius"))
	if radius <= 0 then
		return
	end
	parent:SpendMana(cost, ability)
	local rolledPct = ability:GetSpecialValueFor("ability_value_int_damage_pct")
	local ____math_max_3 = math.max
	local ____temp_2
	if rolledPct > 0 then
		____temp_2 = rolledPct
	else
		____temp_2 = ability:GetSpecialValueFor("ability_int_damage_pct")
	end
	local basePct = ____math_max_3(0, ____temp_2)
	local rolledPer = ability:GetSpecialValueFor("ability_value_c_mana_per_bonus_pct")
	local ____math_max_5 = math.max
	local ____temp_4
	if rolledPer > 0 then
		____temp_4 = rolledPer
	else
		____temp_4 = ability:GetSpecialValueFor("ability_mana_per_bonus_pct")
	end
	local manaPerBonus = ____math_max_5(1, ____temp_4)
	local bonusPct = math.floor(cost / manaPerBonus) * 2
	local maxMana = math.max(0, parent:GetMaxMana())
	local damage = maxMana * ((basePct + bonusPct) / 100)
	if damage > 0 then
		local enemies = FindUnitsInRadius(
			parent:GetTeamNumber(),
			parent:GetAbsOrigin(),
			nil,
			radius,
			DOTA_UNIT_TARGET_TEAM_ENEMY,
			DOTA_UNIT_TARGET_HEROES_AND_CREEPS,
			DOTA_UNIT_TARGET_FLAG_NONE,
			FIND_ANY_ORDER,
			false
		)
		for ____, enemy in ipairs(enemies) do
			do
				if not IsValidAlive(nil, enemy) or enemy:IsBuilding() then
					goto __continue14
				end
				Damage:ApplyDamage({
					attacker = parent,
					victim = enemy,
					damage = damage,
					damage_type = 2,
					ability = ability,
					extra_data = { source_name = "item_0650_archmage_burst" },
				})
			end
			::__continue14::
		end
	end
	self:PlayEffects(parent, radius)
	MyGameEvent:FireEvent(BusinessEvents.ON_AFTER_ABILITY_FULLY_CAST, {
		ability_index = ability:GetEntityIndex(),
		ability_name = ability:GetAbilityName(),
		caster = parent:GetEntityIndex(),
		target = parent:GetEntityIndex(),
		pos = parent:GetAbsOrigin(),
		is_trigger = true,
	}, { scope = "entity", entity = parent })
	local ability_level = math.max(0, ability:GetLevel() - 1)
	local cooldown = ability:GetCooldown(ability_level)
	local ____ability_StartCooldown_8 = ability.StartCooldown
	local ____math_max_7 = math.max
	local ____temp_6
	if cooldown > 0 then
		____temp_6 = cooldown
	else
		____temp_6 = ITEM_0650_FALLBACK_COOLDOWN
	end
	____ability_StartCooldown_8(ability, ____math_max_7(0.5, ____temp_6))
end
function modifier_item_0650_archmage.prototype.PlayEffects(self, parent, radius)
	local particle = MyGameHeroParticleManager:CreateParticle(ITEM_0650_BURST_EFFECT, PATTACH_WORLDORIGIN, nil, parent)
	MyGameHeroParticleManager:SetParticleControl(particle, 0, parent:GetAbsOrigin())
	MyGameHeroParticleManager:SetParticleControl(particle, 1, Vector(radius, radius, radius))
	MyGameHeroParticleManager:ReleaseParticleIndex(particle)
end
modifier_item_0650_archmage = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0650_archmage)
____exports.modifier_item_0650_archmage = modifier_item_0650_archmage
return ____exports