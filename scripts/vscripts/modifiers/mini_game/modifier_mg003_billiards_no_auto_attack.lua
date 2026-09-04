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
local MG003_MELEE_ATTACK_RANGE_BONUS = 200
____exports.modifier_mg003_billiards_no_auto_attack = __TS__Class()
local modifier_mg003_billiards_no_auto_attack = ____exports.modifier_mg003_billiards_no_auto_attack
modifier_mg003_billiards_no_auto_attack.name = "modifier_mg003_billiards_no_auto_attack"
__TS__ClassExtends(modifier_mg003_billiards_no_auto_attack, BaseModifier_CS)
function modifier_mg003_billiards_no_auto_attack.prototype.IsHidden(self)
	return true
end
function modifier_mg003_billiards_no_auto_attack.prototype.IsPurgable(self)
	return false
end
function modifier_mg003_billiards_no_auto_attack.prototype.RemoveOnDeath(self)
	return false
end
function modifier_mg003_billiards_no_auto_attack.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_DISABLE_AUTOATTACK }
end
function modifier_mg003_billiards_no_auto_attack.prototype.GetDisableAutoAttack(self)
	return 1
end
function modifier_mg003_billiards_no_auto_attack.prototype.GetAttributeBonus(self)
	local parent = self:GetParent()
	local ____temp_2 = not parent or parent:IsNull()
	if not ____temp_2 then
		local ____opt_0 = parent.IsRangedAttacker
		____temp_2 = (____opt_0 and ____opt_0(parent)) == true
	end
	if ____temp_2 then
		return {}
	end
	return { bonus_attack_range = MG003_MELEE_ATTACK_RANGE_BONUS }
end
modifier_mg003_billiards_no_auto_attack =
	__TS__DecorateLegacy({ registerModifier(nil) }, modifier_mg003_billiards_no_auto_attack)
____exports.modifier_mg003_billiards_no_auto_attack = modifier_mg003_billiards_no_auto_attack
return ____exports