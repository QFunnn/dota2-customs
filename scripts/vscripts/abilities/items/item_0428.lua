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
local IsRealNonItemAbility = ____item_0409_shared.IsRealNonItemAbility
local IsValidEnemyUnit = ____item_0409_shared.IsValidEnemyUnit
local ____dark_domain_lightning_flash = require("my_game_axe.room.dark_domain_lightning_flash")
local TriggerDarkDomainLightningFlash = ____dark_domain_lightning_flash.TriggerDarkDomainLightningFlash
____exports.item_0428 = __TS__Class()
local item_0428 = ____exports.item_0428
item_0428.name = "item_0428"
__TS__ClassExtends(item_0428, BaseItem_CS)
function item_0428.prototype.Precache(self, context)
	PrecacheResource("particle", "particles/items_fx/chain_lightning.vpcf", context)
end
function item_0428.prototype.GetIntrinsicModifierName(self)
	return ____exports.modifier_item_0428_thunder_hammer.name
end
item_0428 = __TS__DecorateLegacy({ registerAbility(nil) }, item_0428)
____exports.item_0428 = item_0428
____exports.modifier_item_0428_thunder_hammer = __TS__Class()
local modifier_item_0428_thunder_hammer = ____exports.modifier_item_0428_thunder_hammer
modifier_item_0428_thunder_hammer.name = "modifier_item_0428_thunder_hammer"
__TS__ClassExtends(modifier_item_0428_thunder_hammer, BaseModifier_CS)
function modifier_item_0428_thunder_hammer.prototype.DeclareEvents(self)
	return { BusinessEvents.ON_ATTACK_LANDED, BusinessEvents.ON_AFTER_ABILITY_FULLY_CAST }
end
function modifier_item_0428_thunder_hammer.prototype.IsHidden(self)
	return true
end
function modifier_item_0428_thunder_hammer.prototype.IsPurgable(self)
	return false
end
function modifier_item_0428_thunder_hammer.prototype.OnAttackLanded_CS(self, event)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	local ability = self:GetAbility()
	if not ability or event.attacker ~= parent or event.is_sub_attack then
		return
	end
	if not IsValidEnemyUnit(nil, parent, event.target) then
		return
	end
	self:TryTriggerLightning(parent, ability, event.target)
end
function modifier_item_0428_thunder_hammer.prototype.OnAfterAbilityFullyCast_CS(self, event)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	local ability = self:GetAbility()
	if not ability or event.caster ~= parent:GetEntityIndex() then
		return
	end
	local castAbility = EntIndexToHScript(event.ability_index)
	if not IsRealNonItemAbility(nil, castAbility) then
		return
	end
	local target = self:FindSpellTriggerTarget(parent, ability)
	self:TryTriggerLightning(parent, ability, target)
end
function modifier_item_0428_thunder_hammer.prototype.TryTriggerLightning(self, parent, ability, target)
	if not IsValidAlive(nil, parent) then
		return
	end
	if not ability:IsCooldownReady() then
		return
	end
	if not IsValidEnemyUnit(nil, parent, target) then
		return
	end
	local ability_trigger_chance_pct = ability:GetSpecialValueFor("ability_trigger_chance_pct")
	if not RollPercentage(ability_trigger_chance_pct) then
		return
	end
	Timers:CreateTimer(FrameTime(), function()
		if not IsValid(nil, self) or self:IsNull() then
			return
		end
		if not IsValidAlive(nil, parent) or not IsValid(nil, ability) or ability:IsNull() then
			return
		end
		if not ability:IsCooldownReady() then
			return
		end
		if not IsValidEnemyUnit(nil, parent, target) then
			return
		end
		local ability_damage = ability:GetSpecialValueFor("ability_value_damage")
		local damage = self:GetAllAttackDamage(parent) * (ability_damage / 100)
		if damage <= 0 then
			return
		end
		Damage:ApplyDamage({
			attacker = parent,
			victim = target,
			damage = damage,
			damage_type = 2,
			ability = ability,
			extra_data = {
				custom_tag = "item_0428_thunder_hammer",
				source_name = ability:GetAbilityName(),
			},
		})
		self:PlayEffects1(parent, target)
		TriggerDarkDomainLightningFlash(nil, parent, target)
		self:StartAbilityCooldown(ability)
	end)
end
function modifier_item_0428_thunder_hammer.prototype.FindSpellTriggerTarget(self, parent, ability)
	local ability_radius = ability:GetSpecialValueFor("ability_radius")
	if ability_radius <= 0 then
		return nil
	end
	local enemies = FindUnitsInRadius(
		parent:GetTeamNumber(),
		parent:GetAbsOrigin(),
		nil,
		ability_radius,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HEROES_AND_CREEPS,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_CLOSEST,
		false
	)
	for ____, enemy in ipairs(enemies) do
		if IsValidEnemyUnit(nil, parent, enemy) then
			return enemy
		end
	end
	return nil
end
function modifier_item_0428_thunder_hammer.prototype.StartAbilityCooldown(self, ability)
	local level = math.max(0, ability:GetLevel() - 1)
	local ability_cooldown = ability:GetCooldown(level)
	local ____ability_1 = ability
	local ____ability_StartCooldown_2 = ability.StartCooldown
	local ____temp_0
	if ability_cooldown > 0 then
		____temp_0 = ability_cooldown
	else
		____temp_0 = 1
	end
	____ability_StartCooldown_2(____ability_1, ____temp_0)
end
function modifier_item_0428_thunder_hammer.prototype.PlayEffects1(self, source, target)
	local particle = MyGameHeroParticleManager:CreateParticle(
		"particles/items_fx/chain_lightning.vpcf",
		PATTACH_ABSORIGIN_FOLLOW,
		source,
		source
	)
	MyGameHeroParticleManager:SetParticleControlEnt(
		particle,
		0,
		source,
		PATTACH_POINT_FOLLOW,
		"attach_hitloc",
		source:GetAbsOrigin(),
		true
	)
	MyGameHeroParticleManager:SetParticleControlEnt(
		particle,
		1,
		target,
		PATTACH_POINT_FOLLOW,
		"attach_hitloc",
		target:GetAbsOrigin(),
		true
	)
	MyGameHeroParticleManager:ReleaseParticleIndex(particle)
	EmitSoundOn("Item.Maelstrom.Chain_Lightning", target)
end
modifier_item_0428_thunder_hammer = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0428_thunder_hammer)
____exports.modifier_item_0428_thunder_hammer = modifier_item_0428_thunder_hammer
return ____exports