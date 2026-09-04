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
local FindEnemies = ____item_0409_shared.FindEnemies
local GetIntelligence = ____item_0409_shared.GetIntelligence
local IsNonDotDamage = ____item_0409_shared.IsNonDotDamage
local IsValidEnemyUnit = ____item_0409_shared.IsValidEnemyUnit
local StartAbilityCooldown = ____item_0409_shared.StartAbilityCooldown
____exports.item_0409 = __TS__Class()
local item_0409 = ____exports.item_0409
item_0409.name = "item_0409"
__TS__ClassExtends(item_0409, BaseItem_CS)
function item_0409.prototype.Precache(self, context)
	PrecacheResource("particle", "particles/lina/huskar_inner_fire2.vpcf", context)
end
function item_0409.prototype.GetIntrinsicModifierName(self)
	return ____exports.modifier_item_0409_burn_mark.name
end
item_0409 = __TS__DecorateLegacy({ registerAbility(nil) }, item_0409)
____exports.item_0409 = item_0409
____exports.modifier_item_0409_burn_mark = __TS__Class()
local modifier_item_0409_burn_mark = ____exports.modifier_item_0409_burn_mark
modifier_item_0409_burn_mark.name = "modifier_item_0409_burn_mark"
__TS__ClassExtends(modifier_item_0409_burn_mark, BaseModifier_CS)
function modifier_item_0409_burn_mark.prototype.DeclareEvents(self)
	return { BusinessEvents.ON_TAKE_DAMAGE }
end
function modifier_item_0409_burn_mark.prototype.IsHidden(self)
	return true
end
function modifier_item_0409_burn_mark.prototype.IsPurgable(self)
	return false
end
function modifier_item_0409_burn_mark.prototype.OnTakeDamage_CS(self, event)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	local ability = self:GetAbility()
	if not ability or event.attacker ~= parent then
		return
	end
	if not IsValidAlive(nil, parent) or not IsNonDotDamage(nil, event, "item_0409_burn_mark") then
		return
	end
	if not ability:IsCooldownReady() then
		return
	end
	local target = event.victim
	if not IsValidEnemyUnit(nil, parent, target) or not target:HasModifier("modifier_generic_burning") then
		return
	end
	local ability_duration = math.max(0.1, ability:GetSpecialValueFor("ability_duration"))
	target:AddNewModifier(
		parent,
		ability,
		____exports.modifier_item_0409_ember_stack.name,
		{ duration = ability_duration }
	)
	StartAbilityCooldown(nil, ability, 2)
end
modifier_item_0409_burn_mark = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0409_burn_mark)
____exports.modifier_item_0409_burn_mark = modifier_item_0409_burn_mark
____exports.modifier_item_0409_ember_stack = __TS__Class()
local modifier_item_0409_ember_stack = ____exports.modifier_item_0409_ember_stack
modifier_item_0409_ember_stack.name = "modifier_item_0409_ember_stack"
__TS__ClassExtends(modifier_item_0409_ember_stack, BaseModifier_CS)
function modifier_item_0409_ember_stack.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	self:SetStackCount(1)
end
function modifier_item_0409_ember_stack.prototype.OnRefresh(self)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	local caster = self:GetCaster()
	local ability = self:GetAbility()
	if not ability or not IsValidAlive(nil, caster) or not IsValidAlive(nil, parent) then
		return
	end
	local ability_required_stacks = math.max(1, math.floor(ability:GetSpecialValueFor("ability_required_stacks")))
	local nextStacks = self:GetStackCount() + 1
	if nextStacks < ability_required_stacks then
		self:SetStackCount(nextStacks)
		return
	end
	self:Explode(parent, caster, ability)
	self:Destroy()
end
function modifier_item_0409_ember_stack.prototype.IsDebuff(self)
	return true
end
function modifier_item_0409_ember_stack.prototype.IsPurgable(self)
	return true
end
function modifier_item_0409_ember_stack.prototype.GetTexture(self)
	return "item_searing_signet"
end
function modifier_item_0409_ember_stack.prototype.Explode(self, target, caster, ability)
	local ability_radius = math.max(0, ability:GetSpecialValueFor("ability_radius"))
	local ability_int_damage_pct = math.max(0, ability:GetSpecialValueFor("ability_int_damage_pct"))
	if ability_radius <= 0 or ability_int_damage_pct <= 0 then
		return
	end
	local damage = GetIntelligence(nil, caster) * (ability_int_damage_pct / 100)
	if damage <= 0 then
		return
	end
	self:PlayEffects1(target, ability_radius)
	for ____, enemy in ipairs(FindEnemies(nil, caster, target:GetAbsOrigin(), ability_radius)) do
		do
			if not IsValidEnemyUnit(nil, caster, enemy) then
				goto __continue25
			end
			Damage:ApplyDamage({
				attacker = caster,
				victim = enemy,
				damage = damage,
				damage_type = 2,
				ability = ability,
				extra_data = {
					custom_tag = "item_0409_burn_mark",
					source_name = self:GetName(),
				},
			})
		end
		::__continue25::
	end
end
function modifier_item_0409_ember_stack.prototype.PlayEffects1(self, target, ability_radius)
	local particle = MyGameHeroParticleManager:CreateParticle(
		"particles/lina/huskar_inner_fire2.vpcf",
		PATTACH_ABSORIGIN_FOLLOW,
		target,
		self:GetCaster()
	)
	MyGameHeroParticleManager:SetParticleControlEnt(
		particle,
		0,
		target,
		PATTACH_ABSORIGIN_FOLLOW,
		nil,
		target:GetAbsOrigin(),
		true
	)
	MyGameHeroParticleManager:SetParticleControl(particle, 1, Vector(ability_radius, ability_radius, ability_radius))
	MyGameHeroParticleManager:ReleaseParticleIndex(particle)
	EmitSoundOn("Hero_Huskar.Burning_Spear.Cast", target)
end
modifier_item_0409_ember_stack = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0409_ember_stack)
____exports.modifier_item_0409_ember_stack = modifier_item_0409_ember_stack
return ____exports