--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


-- modifiers/bless_modifiers/sl_modifier_bless_10206.lua
local ____debugRuntime = require("utils.debug_runtime")
local debug = ____debugRuntime.safe_debug
local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__Decorate = ____lualib.__TS__Decorate
____debugRuntime.register(
	"modifiers/bless_modifiers/sl_modifier_bless_10206.lua",
	{
		["10"] = "2:1",
		["11"] = "2:10",
		["12"] = "3:1",
		["13"] = "3:10",
		["14"] = "5:1",
		["15"] = "6:14",
		["16"] = "5:1",
		["17"] = "6:38",
		["18"] = "10:5",
		["19"] = "11:9",
		["20"] = "10:5",
		["21"] = "14:5",
		["22"] = "15:9",
		["23"] = "14:5",
		["24"] = "18:5",
		["25"] = "19:9",
		["26"] = "18:5",
		["27"] = "22:5",
		["28"] = "23:9",
		["29"] = "22:5",
		["30"] = "26:5",
		["31"] = "27:9",
		["32"] = "26:5",
		["33"] = "30:5",
		["34"] = "31:14",
		["35"] = "31:26",
		["37"] = "32:15",
		["38"] = "33:15",
		["39"] = "34:26",
		["41"] = "34:40",
		["42"] = "34:40",
		["43"] = "34:40",
		["45"] = "34:26",
		["47"] = "34:15",
		["48"] = "36:14",
		["49"] = "36:58",
		["51"] = "37:24",
		["52"] = "37:24",
		["53"] = "37:24",
		["55"] = "37:24",
		["57"] = "37:24",
		["59"] = "37:15",
		["60"] = "38:14",
		["61"] = "38:96",
		["63"] = "39:9",
		["64"] = "40:9",
		["65"] = "41:9",
		["66"] = "30:5",
		["67"] = "44:5",
		["68"] = "45:14",
		["71"] = "46:15",
		["72"] = "47:13",
		["75"] = "48:15",
		["76"] = "49:14",
		["79"] = "50:9",
		["80"] = "44:5",
		["81"] = "53:5",
		["82"] = "54:14",
		["83"] = "54:51",
		["85"] = "55:9",
		["86"] = "53:5",
		["87"] = "58:5",
		["88"] = "59:14",
		["91"] = "60:14",
		["94"] = "61:9",
		["95"] = "58:5",
		["96"] = "64:5",
		["97"] = "65:15",
		["98"] = "66:15",
		["99"] = "67:14",
		["102"] = "68:15",
		["103"] = "69:9",
		["104"] = "69:48",
		["105"] = "69:53",
		["106"] = "69:56",
		["107"] = "69:9",
		["108"] = "69:101",
		["109"] = "69:9",
		["110"] = "70:9",
		["111"] = "64:5",
		["112"] = "73:5",
		["113"] = "74:15",
		["114"] = "75:14",
		["117"] = "76:15",
		["118"] = "77:32",
		["119"] = "77:32",
		["120"] = "77:32",
		["122"] = "77:32",
		["124"] = "77:32",
		["126"] = "77:15",
		["127"] = "78:14",
		["130"] = "79:14",
		["133"] = "80:31",
		["134"] = "80:31",
		["135"] = "80:31",
		["137"] = "80:31",
		["139"] = "80:31",
		["141"] = "80:15",
		["142"] = "81:15",
		["143"] = "82:13",
		["146"] = "83:9",
		["147"] = "84:9",
		["148"] = "73:5",
		["149"] = "92:5",
		["150"] = "93:15",
		["151"] = "94:14",
		["154"] = "95:15",
		["155"] = "96:15",
		["156"] = "97:9",
		["157"] = "97:45",
		["158"] = "97:50",
		["159"] = "97:53",
		["160"] = "97:9",
		["161"] = "98:9",
		["162"] = "99:9",
		["163"] = "99:48",
		["164"] = "99:53",
		["165"] = "99:56",
		["166"] = "99:9",
		["167"] = "99:97",
		["168"] = "99:9",
		["169"] = "100:9",
		["170"] = "101:9",
		["171"] = "92:5",
		["172"] = "6:14",
		["173"] = "5:2",
		["174"] = "5:2",
		["175"] = "5:19",
		["176"] = "5:2",
		["178"] = "5:2",
		["179"] = "6:14",
		["181"] = "6:14",
	}
)
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
	local ability = event.ability
	local ____event_unit_2 = event.unit
	if ____event_unit_2 == nil then
		local ____ability_GetCaster_result_0 = ability
		if ____ability_GetCaster_result_0 ~= nil then
			____ability_GetCaster_result_0 = ____ability_GetCaster_result_0:GetCaster()
		end
		____event_unit_2 = ____ability_GetCaster_result_0
	end
	local attacker = ____event_unit_2
	if not self:_IsValidEnemySource(parent, attacker) then
		return 0
	end
	local ____table__params_spell_dodge_chance_3 = self._params
	if ____table__params_spell_dodge_chance_3 ~= nil then
		____table__params_spell_dodge_chance_3 = ____table__params_spell_dodge_chance_3.spell_dodge_chance
	end
	local ____table__params_spell_dodge_chance_3_5 = ____table__params_spell_dodge_chance_3
	if ____table__params_spell_dodge_chance_3_5 == nil then
		____table__params_spell_dodge_chance_3_5 = 0
	end
	local chance = ____table__params_spell_dodge_chance_3_5
	if not RollPseudoRandomPercentage(chance, 1009, parent) then
		return 0
	end
	self:_PlaySpellDodgeFx()
	self:_TryCounter(attacker)
	return 1
end
function sl_modifier_bless_10206.prototype.OnAttackFail(self, event)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	if event.target ~= parent then
		return
	end
	local attacker = event.attacker
	if not self:_IsValidEnemySource(parent, attacker) then
		return
	end
	self:_TryCounter(attacker)
end
function sl_modifier_bless_10206.prototype._IsValidEnemySource(self, parent, source)
	if not IsValid(source) or not source:IsHero() then
		return false
	end
	return source:GetTeamNumber() ~= parent:GetTeamNumber()
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
	{ registerModifier(nil, "modifiers/bless_modifiers/sl_modifier_bless_10206", nil, getfenv()) },
	sl_modifier_bless_10206
)
____exports.sl_modifier_bless_10206 = sl_modifier_bless_10206
return ____exports