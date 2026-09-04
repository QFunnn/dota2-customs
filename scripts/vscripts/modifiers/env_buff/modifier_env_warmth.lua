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
--- 解冻 Buff（取暖）
-- 靠近篝火时施加。
-- - 每秒减少 1 层寒冷 debuff
-- - 每秒恢复 2% 最大生命
____exports.modifier_env_warmth = __TS__Class()
local modifier_env_warmth = ____exports.modifier_env_warmth
modifier_env_warmth.name = "modifier_env_warmth"
__TS__ClassExtends(modifier_env_warmth, BaseModifier_CS)
function modifier_env_warmth.prototype.OnCreated(self, _params)
	if not IsServer() then
		return
	end
end
function modifier_env_warmth.prototype.GetAttributeBonus(self)
	return { health_regen_pct = ____exports.modifier_env_warmth.HEALTH_REGEN_PCT }
end
function modifier_env_warmth.prototype.IsHidden(self)
	return false
end
function modifier_env_warmth.prototype.IsDebuff(self)
	return false
end
function modifier_env_warmth.prototype.IsPurgable(self)
	return true
end
function modifier_env_warmth.prototype.GetEffectName(self)
	return "particles/units/heroes/hero_jakiro/jakiro_liquid_fire_debuff_c.vpcf"
end
function modifier_env_warmth.prototype.GetTexture(self)
	return "brewmaster_fire_permanent_immolation"
end
modifier_env_warmth.HEALTH_REGEN_PCT = 2
modifier_env_warmth = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_env_warmth)
____exports.modifier_env_warmth = modifier_env_warmth
--- 篝火效果
____exports.modifier_env_warmth_effect = __TS__Class()
local modifier_env_warmth_effect = ____exports.modifier_env_warmth_effect
modifier_env_warmth_effect.name = "modifier_env_warmth_effect"
__TS__ClassExtends(modifier_env_warmth_effect, BaseModifier_CS)
function modifier_env_warmth_effect.prototype.OnCreated(self, _params)
	if not IsServer() then
		return
	end
	self:StartIntervalThink(0.1)
end
function modifier_env_warmth_effect.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	if not IsValidAlive(nil, self:GetParent()) then
		self:Destroy()
		return
	end
	local parent = self:GetParent()
	local coldMod = parent:FindModifierByName("modifier_env_cold")
	if coldMod and coldMod:GetStackCount() > 0 then
		coldMod:SetStackCount(
			math.max(0, coldMod:GetStackCount() - ____exports.modifier_env_warmth_effect.STACKS_PER_THINK)
		)
		if coldMod:GetStackCount() <= 0 then
			coldMod:Destroy()
		end
		return
	end
	local warmthMod = parent:FindModifierByName("modifier_env_warmth")
		or parent:FindModifierByName("item_P010_modifier")
	if warmthMod then
		local remainingTime = warmthMod:GetRemainingTime()
		if remainingTime > 20 then
			return
		end
	end
	parent:AddNewModifier(parent, nil, "modifier_env_warmth", { duration = 20 })
end
function modifier_env_warmth_effect.prototype.GetEffectName(self)
	return "particles/units/heroes/hero_lone_druid/lone_druid_battle_cry_buff.vpcf"
end
function modifier_env_warmth_effect.prototype.IsHidden(self)
	return true
end
modifier_env_warmth_effect.STACKS_PER_THINK = 1
modifier_env_warmth_effect = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_env_warmth_effect)
____exports.modifier_env_warmth_effect = modifier_env_warmth_effect
return ____exports