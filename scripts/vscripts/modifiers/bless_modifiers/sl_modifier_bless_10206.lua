--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__Decorate = ____lualib.__TS__Decorate
local ____exports = {}
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerModifier = ____dota_ts_adapter.registerModifier
local ____sl_modifier_base = require("modifiers.sl_modifier_base")
local SLModifierBase = ____sl_modifier_base.SLModifierBase
____exports.sl_modifier_bless_10206 = __TS__Class()
local sl_modifier_bless_10206 = ____exports.sl_modifier_bless_10206
sl_modifier_bless_10206.name = "sl_modifier_bless_10206"
__TS__ClassExtends(sl_modifier_bless_10206, SLModifierBase)
function sl_modifier_bless_10206.prototype.IsHidden(self)
	return true
end
function sl_modifier_bless_10206.prototype.OnCreated(self, params)
	self:_ApplyParams(params)
end
function sl_modifier_bless_10206.prototype.OnRefresh(self, params)
	self:_ApplyParams(params)
end
function sl_modifier_bless_10206.prototype.SetBless(self, bless)
	self._bless = bless
end
function sl_modifier_bless_10206.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_ABSORB_SPELL, MODIFIER_EVENT_ON_ATTACK_FAIL }
end
function sl_modifier_bless_10206.prototype.GetAbsorbSpell(self, event)
	if not IsServer() then
		return 0
	end
	local parent = self:GetParent()
	local ____table__params_spell_dodge_chance_0 = self._params
	if ____table__params_spell_dodge_chance_0 ~= nil then
		____table__params_spell_dodge_chance_0 = ____table__params_spell_dodge_chance_0.spell_dodge_chance
	end
	local ____table__params_spell_dodge_chance_0_2 = ____table__params_spell_dodge_chance_0
	if ____table__params_spell_dodge_chance_0_2 == nil then
		____table__params_spell_dodge_chance_0_2 = 0
	end
	local chance = ____table__params_spell_dodge_chance_0_2
	if not RollPseudoRandomPercentage(chance, 1009, parent) then
		return 0
	end
	self:_PlaySpellDodgeFx()
	local ability = event.ability
	local ____event_unit_5 = event.unit
	if ____event_unit_5 == nil then
		local ____ability_GetCaster_result_3 = ability
		if ____ability_GetCaster_result_3 ~= nil then
			____ability_GetCaster_result_3 = ____ability_GetCaster_result_3:GetCaster()
		end
		____event_unit_5 = ____ability_GetCaster_result_3
	end
	local attacker = ____event_unit_5
	if IsValid(attacker) and attacker:IsHero() and attacker:IsRealHero() then
		self:_TryCounter(attacker)
	end
	return 1
end
function sl_modifier_bless_10206.prototype.OnAttackFail(self, event)
	if not IsServer() then
		return
	end
	if event.target ~= self:GetParent() then
		return
	end
	local attacker = event.attacker
	if not IsValid(attacker) or not attacker:IsHero() or not attacker:IsRealHero() then
		return
	end
	self:_TryCounter(attacker)
end
function sl_modifier_bless_10206.prototype._ApplyParams(self, params)
	if not IsServer() then
		return
	end
	if not params then
		return
	end
	self._params = params
end
function sl_modifier_bless_10206.prototype._PlaySpellDodgeFx(self)
	local bless = self._bless
	local parent = self:GetParent()
	if not bless or not bless:IsValid() or not IsValid(parent) then
		return
	end
	local pid = SParticleManager:CreateBlessParticle(
		bless,
		BLESS_PARTICLES.bless_10206_spell_dodge,
		PATTACH_ABSORIGIN_FOLLOW,
		parent
	)
	SParticleManager:SetParticleControlEnt(pid, 0, parent, PATTACH_ABSORIGIN_FOLLOW, "attach_hitloc")
	self:ReleaseParticleIndex(pid)
end
function sl_modifier_bless_10206.prototype._TryCounter(self, source)
	local bless = self._bless
	if not bless or not bless:IsValid() then
		return
	end
	local parent = self:GetParent()
	local ____table__params_trigger_chance_6 = self._params
	if ____table__params_trigger_chance_6 ~= nil then
		____table__params_trigger_chance_6 = ____table__params_trigger_chance_6.trigger_chance
	end
	local ____table__params_trigger_chance_6_8 = ____table__params_trigger_chance_6
	if ____table__params_trigger_chance_6_8 == nil then
		____table__params_trigger_chance_6_8 = 0
	end
	local trigger_chance = ____table__params_trigger_chance_6_8
	if not RollPseudoRandomPercentage(trigger_chance, 1010, parent) then
		return
	end
	if not IsValidAlive(parent) or not IsValidAlive(source) then
		return
	end
	local ____table__params_damage_9 = self._params
	if ____table__params_damage_9 ~= nil then
		____table__params_damage_9 = ____table__params_damage_9.damage
	end
	local ____table__params_damage_9_11 = ____table__params_damage_9
	if ____table__params_damage_9_11 == nil then
		____table__params_damage_9_11 = 0
	end
	local dmg_per_level = ____table__params_damage_9_11
	local damage = dmg_per_level * parent:GetLevel()
	if damage <= 0 then
		return
	end
	self:_PlayLightningFx(source)
	bless:ApplyDamage({ attacker = parent, victim = source, damage = damage, damage_type = DAMAGE_TYPE_MAGICAL })
end
function sl_modifier_bless_10206.prototype._PlayLightningFx(self, target)
	local bless = self._bless
	if not bless or not bless:IsValid() or not IsValid(target) then
		return
	end
	local pos = target:GetAbsOrigin()
	local pid =
		SParticleManager:CreateBlessParticle(bless, BLESS_PARTICLES.bless_10206_lightning, PATTACH_ABSORIGIN, target)
	SParticleManager:SetParticleControl(pid, 0, pos:__add(Vector(0, 0, 1000)))
	SParticleManager:SetParticleControl(pid, 1, pos)
	SParticleManager:SetParticleControlEnt(pid, 1, target, PATTACH_POINT_FOLLOW, "attach_hitloc")
	self:ReleaseParticleIndex(pid)
	EmitSoundOn("bless_10206_lightning", target)
end
sl_modifier_bless_10206 = __TS__Decorate(
	{ registerModifier(nil, "modifiers/bless_modifiers/sl_modifier_bless_10206") },
	sl_modifier_bless_10206
)
____exports.sl_modifier_bless_10206 = sl_modifier_bless_10206
return ____exports