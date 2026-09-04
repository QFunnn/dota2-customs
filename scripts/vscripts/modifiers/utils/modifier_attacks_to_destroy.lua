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
local DEFAULT_ATTACKS = 5
--- 工具 Modifier：将单位转为「按攻击次数销毁」模式
--
-- - 每次被普攻击中时计数 -1，计数归零时 ForceKill 单位
-- - 阻挡普攻伤害（不扣血，纯按次数计算）
-- - 使用方式：modifier_attacks_to_destroy.applys(unit, caster, ability, { attacks_to_destroy: 5 })
____exports.modifier_attacks_to_destroy = __TS__Class()
local modifier_attacks_to_destroy = ____exports.modifier_attacks_to_destroy
modifier_attacks_to_destroy.name = "modifier_attacks_to_destroy"
__TS__ClassExtends(modifier_attacks_to_destroy, BaseModifier_CS)
function modifier_attacks_to_destroy.prototype.____constructor(self, ...)
	BaseModifier_CS.prototype.____constructor(self, ...)
	self._attacksRemaining = 0
	self._attacksTotal = 0
end
function modifier_attacks_to_destroy.prototype.OnCreated(self, params)
	if not IsServer() then
		return
	end
	self._attacksTotal = params.attacks_to_destroy or DEFAULT_ATTACKS
	self._attacksRemaining = self._attacksTotal
	self:SetStackCount(self._attacksRemaining)
end
function modifier_attacks_to_destroy.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_HEALTHBAR_PIPS }
end
function modifier_attacks_to_destroy.prototype.GetModifierHealthBarPips(self, event)
	return self:GetStackCount()
end
function modifier_attacks_to_destroy.prototype.DeclareEvents(self)
	return { BusinessEvents.ON_TAKE_ATTACK_LANDED, BusinessEvents.ON_DAMAGE_PRE_APPLY }
end
function modifier_attacks_to_destroy.prototype.OnTakeAttackLanded_CS(self, event)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	if event.target ~= parent then
		return
	end
	if not IsValidAlive(nil, parent) then
		return
	end
	self._attacksRemaining = self._attacksRemaining - 1
	if self._attacksRemaining <= 0 then
		parent:CustomKill(event.attacker, self:GetAbility())
		return
	end
	local maxHp = parent:GetMaxHealth()
	local newHealth = math.max(1, math.ceil(maxHp * (self._attacksRemaining / self._attacksTotal)))
	parent:SetHealth(newHealth)
end
function modifier_attacks_to_destroy.prototype.OnDamagePreApply_CS(self, event)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	local ____event_0 = event
	local ctx = ____event_0.ctx
	if ctx.spec.victim ~= parent then
		return
	end
	event.prevent_apply = true
end
function modifier_attacks_to_destroy.prototype.IsHidden(self)
	return true
end
function modifier_attacks_to_destroy.prototype.IsPurgable(self)
	return false
end
function modifier_attacks_to_destroy.prototype.IsDebuff(self)
	return false
end
function modifier_attacks_to_destroy.prototype.GetRemainingAttacks(self)
	return self._attacksRemaining
end
modifier_attacks_to_destroy =
	__TS__DecorateLegacy({ registerModifier(nil, "modifier_attacks_to_destroy") }, modifier_attacks_to_destroy)
____exports.modifier_attacks_to_destroy = modifier_attacks_to_destroy
return ____exports