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
--- 黑暗环境 Debuff
-- 处于无光源区域时施加。
-- - 视野降低
-- - 造成的所有伤害降低 30%
-- - 承受的所有伤害提高 30%
____exports.modifier_env_darkness = __TS__Class()
local modifier_env_darkness = ____exports.modifier_env_darkness
modifier_env_darkness.name = "modifier_env_darkness"
__TS__ClassExtends(modifier_env_darkness, BaseModifier_CS)
function modifier_env_darkness.GetLocalizationCN(self)
	return {
		name = "黑暗",
		description = "视野降低，造成的伤害降低30%%，受到的伤害提高30%%。怪物在黑暗中技能更加强大",
	}
end
function modifier_env_darkness.prototype.DeclareEvents(self)
	return { BusinessEvents.ON_DAMAGE_PRE_APPLY_ATTACKER, BusinessEvents.ON_DAMAGE_PRE_APPLY }
end
function modifier_env_darkness.prototype.OnDamagePreApplyAttacker_CS(self, event)
	if not IsServer() then
		return
	end
	if event.ctx.spec.attacker ~= self:GetParent() then
		return
	end
	local ____event_final_0, ____mul_1 = event.final, "mul"
	if ____event_final_0[____mul_1] == nil then
		____event_final_0[____mul_1] = {}
	end
	local ____event_final_mul_2 = event.final.mul
	____event_final_mul_2[#____event_final_mul_2 + 1] = {
		value = 1 - ____exports.modifier_env_darkness.OUTGOING_DAMAGE_REDUCTION_PCT / 100,
		source = "modifier_env_darkness:黑暗输出减伤",
	}
end
function modifier_env_darkness.prototype.OnDamagePreApply_CS(self, event)
	if not IsServer() then
		return
	end
	if event.ctx.spec.victim ~= self:GetParent() then
		return
	end
	local ____event_final_3, ____mul_4 = event.final, "mul"
	if ____event_final_3[____mul_4] == nil then
		____event_final_3[____mul_4] = {}
	end
	local ____event_final_mul_5 = event.final.mul
	____event_final_mul_5[#____event_final_mul_5 + 1] = {
		value = 1 + ____exports.modifier_env_darkness.INCOMING_DAMAGE_INCREASE_PCT / 100,
		source = "modifier_env_darkness:黑暗受伤增加",
	}
end
function modifier_env_darkness.prototype.GetAttributeBonus(self)
	return { view_distance = ____exports.modifier_env_darkness.VIEW_DISTANCE_REDUCTION }
end
function modifier_env_darkness.prototype.IsHidden(self)
	return false
end
function modifier_env_darkness.prototype.IsDebuff(self)
	return true
end
function modifier_env_darkness.prototype.IsPurgable(self)
	return true
end
function modifier_env_darkness.prototype.IsPurgeException(self)
	return true
end
function modifier_env_darkness.prototype.GetTexture(self)
	return "night_stalker_darkness"
end
modifier_env_darkness.VIEW_DISTANCE_REDUCTION = -1200
modifier_env_darkness.OUTGOING_DAMAGE_REDUCTION_PCT = 30
modifier_env_darkness.INCOMING_DAMAGE_INCREASE_PCT = 30
modifier_env_darkness = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_env_darkness)
____exports.modifier_env_darkness = modifier_env_darkness
return ____exports