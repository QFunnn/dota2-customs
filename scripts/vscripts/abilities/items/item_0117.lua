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
local __TS__ArrayIncludes = ____lualib.__TS__ArrayIncludes
local ____exports = {}
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local registerModifier = ____dota_ts_adapter.registerModifier
local ____modifier_base = require("modifiers.class.modifier_base")
local BaseModifier_CS = ____modifier_base.BaseModifier_CS
local _____base_item = require("abilities.items._base_item")
local BaseItem_CS = _____base_item.BaseItem_CS
local ____dark_domain_lightning_flash = require("my_game_axe.room.dark_domain_lightning_flash")
local TriggerDarkDomainLightningFlash = ____dark_domain_lightning_flash.TriggerDarkDomainLightningFlash
local item_0117 = __TS__Class()
item_0117.name = "item_0117"
__TS__ClassExtends(item_0117, BaseItem_CS)
function item_0117.prototype.GetIntrinsicModifierName(self)
	return "item_0117_modifier"
end
item_0117 = __TS__DecorateLegacy({ registerAbility(nil) }, item_0117)
local item_0117_modifier = __TS__Class()
item_0117_modifier.name = "item_0117_modifier"
__TS__ClassExtends(item_0117_modifier, BaseModifier_CS)
function item_0117_modifier.prototype.IsHidden(self)
	return true
end
function item_0117_modifier.prototype.DeclareEvents(self)
	return { BusinessEvents.ON_ATTACK_LANDED }
end
function item_0117_modifier.prototype.OnAttackLanded_CS(self, event)
	if not IsServer() then
		return
	end
	local attacker = event.attacker
	if attacker ~= self:GetParent() then
		return
	end
	local ability = self:GetAbility()
	if not ability then
		return
	end
	if not IsValidAlive(nil, attacker) or not IsValidAlive(nil, event.target) or event.target:IsBuilding() then
		return
	end
	if event.target:GetTeamNumber() == attacker:GetTeamNumber() then
		return
	end
	local ability_trigger_chance_pct = ability:GetSpecialValueFor("ability_trigger_chance_pct")
	if RollPercentage(ability_trigger_chance_pct) then
		local ability_damage = ability:GetSpecialValueFor("ability_damage")
		local ability_jump_count = ability:GetSpecialValueFor("ability_jump_count")
		local ability_jump_range = 550
		local attackerTeam = attacker:GetTeamNumber()
		local damage = self:GetAllAttackDamage(attacker) * ability_damage * 0.01
		local current_target = event.target
		local hit_units = { current_target }
		self:PlayEffects1(current_target)
		self:ApplyLightningDamage(attacker, current_target, damage, ability)
		local jumps = 1
		local jump_timer
		jump_timer = function()
			if jumps >= ability_jump_count then
				return
			end
			if not IsValidAlive(nil, current_target) then
				return
			end
			local units = FindUnitsInRadius(
				attackerTeam,
				current_target:GetAbsOrigin(),
				nil,
				ability_jump_range,
				DOTA_UNIT_TARGET_TEAM_ENEMY,
				DOTA_UNIT_TARGET_HEROES_AND_CREEPS,
				DOTA_UNIT_TARGET_FLAG_NONE,
				FIND_CLOSEST,
				false
			)
			local next_target
			for ____, unit in ipairs(units) do
				if not __TS__ArrayIncludes(hit_units, unit) then
					next_target = unit
					break
				end
			end
			if next_target and IsValidAlive(nil, next_target) then
				self:PlayEffects2(attacker, current_target, next_target)
				current_target = next_target
				hit_units[#hit_units + 1] = current_target
				self:ApplyLightningDamage(attacker, current_target, damage * 0.7, ability)
				jumps = jumps + 1
				Timers:CreateTimer(0.15, jump_timer)
			end
		end
		Timers:CreateTimer(0.15, jump_timer)
	end
end
function item_0117_modifier.prototype.ApplyLightningDamage(self, attacker, target, damage, ability)
	Damage:ApplyDamage({
		victim = target,
		attacker = attacker,
		damage = damage,
		damage_type = 2,
		ability = ability,
	})
	TriggerDarkDomainLightningFlash(nil, attacker, target)
end
function item_0117_modifier.prototype.PlayEffects1(self, target)
	EmitSoundOn("Item.Maelstrom.Chain_Lightning", target)
end
function item_0117_modifier.prototype.PlayEffects2(self, attacker, source, target)
	local pfx = MyGameHeroParticleManager:CreateParticle(
		"particles/items_fx/chain_lightning.vpcf",
		PATTACH_ABSORIGIN_FOLLOW,
		source,
		attacker
	)
	MyGameHeroParticleManager:SetParticleControlEnt(
		pfx,
		0,
		source,
		PATTACH_POINT_FOLLOW,
		"attach_hitloc",
		source:GetAbsOrigin(),
		true
	)
	MyGameHeroParticleManager:SetParticleControlEnt(
		pfx,
		1,
		target,
		PATTACH_POINT_FOLLOW,
		"attach_hitloc",
		target:GetAbsOrigin(),
		true
	)
	MyGameHeroParticleManager:ReleaseParticleIndex(pfx)
	EmitSoundOn("Item.Maelstrom.Chain_Lightning.Jump", target)
end
item_0117_modifier = __TS__DecorateLegacy({ registerModifier(nil) }, item_0117_modifier)
return ____exports