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
local registerModifier = ____dota_ts_adapter.registerModifier
local ____modifier_base = require("modifiers.class.modifier_base")
local BaseModifier_CS = ____modifier_base.BaseModifier_CS
____exports.modifier_debug_god_mode = __TS__Class()
local modifier_debug_god_mode = ____exports.modifier_debug_god_mode
modifier_debug_god_mode.name = "modifier_debug_god_mode"
__TS__ClassExtends(modifier_debug_god_mode, BaseModifier_CS)
function modifier_debug_god_mode.prototype.IsHidden(self)
	return false
end
function modifier_debug_god_mode.prototype.IsDebuff(self)
	return false
end
function modifier_debug_god_mode.prototype.IsPurgable(self)
	return false
end
function modifier_debug_god_mode.prototype.IsPurgeException(self)
	return false
end
function modifier_debug_god_mode.prototype.RemoveOnDeath(self)
	return false
end
function modifier_debug_god_mode.prototype.GetTexture(self)
	return "omniknight_guardian_angel"
end
function modifier_debug_god_mode.prototype.CheckState(self)
	return { [MODIFIER_STATE_INVULNERABLE] = true }
end
function modifier_debug_god_mode.prototype.DeclareEvents(self)
	return { BusinessEvents.ON_ATTACK_LANDED }
end
function modifier_debug_god_mode.prototype.OnAttackLanded_CS(self, event)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	local target = event.target
	if event.attacker ~= parent then
		return
	end
	if not target or not IsValidAlive(nil, target) then
		return
	end
	if target == parent or target:GetTeamNumber() == parent:GetTeamNumber() then
		return
	end
	local ____opt_0 = target.IsBuilding
	if (____opt_0 and ____opt_0(target)) == true then
		return
	end
	if event.is_kill or not IsValidAlive(nil, target) then
		return
	end
	Damage:ApplyDamage({
		attacker = parent,
		victim = target,
		damage = math.max(1, target:GetHealth()),
		damage_type = 4,
		is_base_attack = true,
		is_force_kill = true,
		extra_data = { custom_tag = "debug_god_mode_one_shot", source_name = "调试无敌秒杀" },
	})
end
modifier_debug_god_mode = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_debug_god_mode)
____exports.modifier_debug_god_mode = modifier_debug_god_mode
return ____exports