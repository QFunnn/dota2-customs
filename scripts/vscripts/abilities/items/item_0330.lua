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
--- 护盾恢复：每 tick 按 health_regen_pct% 最大护盾补充当前护盾（与「不灭」生命恢复同速）。
-- 直接补充当前护盾，不受基础护盾「脱战才回充」门限制（体现强大恢复）。
-- 抽成共享函数，item_0531 永恒勋章复用同一护盾恢复逻辑。
function ____exports.RegenShieldWithHealthRegenPct(self, parent, ability, interval)
	if not ability or not IsValidAlive(nil, parent) then
		return
	end
	if not parent.GetCurrentEnergyShield or not parent.AddCurrentEnergyShield then
		return
	end
	local maxShield = math.max(0, MyGameAttribute:GetAttribute(parent, "total_energy_shield") or 0)
	if maxShield <= 0 then
		return
	end
	local current = math.max(0, parent:GetCurrentEnergyShield())
	if current >= maxShield then
		return
	end
	local regenPct = math.max(0, ability:GetSpecialValueFor("ability_value_health_regen_pct"))
	local restore = maxShield * (regenPct / 100) * interval
	if restore > 0 then
		parent:AddCurrentEnergyShield(restore)
	end
end
local THINK_INTERVAL = 0.2
--- 「不灭」护盾恢复共享互斥键：item_0203 血精石 / item_0330 牺牲勋章 / item_0531 永恒勋章 同键。
-- 同时持有多件「不灭」时，框架帧末仲裁只保留最高优先级一件的护盾恢复 modifier，防强大护盾恢复叠加。
-- （生命恢复走 health_regen_pct 属性、不在门禁内，以便 item_0531「越战越勇」能放大它。）
____exports.BU_MIE_MUTEX_KEY = "bu_mie"
____exports.item_0330 = __TS__Class()
local item_0330 = ____exports.item_0330
item_0330.name = "item_0330"
__TS__ClassExtends(item_0330, BaseItem_CS)
function item_0330.prototype.GetIntrinsicModifierName(self)
	return ____exports.modifier_item_0330_sacrifice_medal.name
end
item_0330 = __TS__DecorateLegacy({ registerAbility(nil) }, item_0330)
____exports.item_0330 = item_0330
____exports.modifier_item_0330_sacrifice_medal = __TS__Class()
local modifier_item_0330_sacrifice_medal = ____exports.modifier_item_0330_sacrifice_medal
modifier_item_0330_sacrifice_medal.name = "modifier_item_0330_sacrifice_medal"
__TS__ClassExtends(modifier_item_0330_sacrifice_medal, BaseModifier_CS)
function modifier_item_0330_sacrifice_medal.prototype.IsHidden(self)
	return true
end
function modifier_item_0330_sacrifice_medal.prototype.IsPurgable(self)
	return false
end
function modifier_item_0330_sacrifice_medal.prototype.GetMutexKey(self)
	return ____exports.BU_MIE_MUTEX_KEY
end
function modifier_item_0330_sacrifice_medal.prototype.GetMutexPriority(self)
	return 200
end
function modifier_item_0330_sacrifice_medal.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	self:StartIntervalThink(THINK_INTERVAL)
end
function modifier_item_0330_sacrifice_medal.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	self:StartIntervalThink(-1)
end
function modifier_item_0330_sacrifice_medal.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	____exports.RegenShieldWithHealthRegenPct(nil, self:GetParent(), self:GetAbility(), THINK_INTERVAL)
end
function modifier_item_0330_sacrifice_medal.prototype.GetAttributeBonus(self)
	local ____opt_0 = self:GetAbility()
	return { health_regen_pct = ____opt_0 and ____opt_0:GetSpecialValueFor("ability_value_health_regen_pct") or 0 }
end
modifier_item_0330_sacrifice_medal = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0330_sacrifice_medal)
____exports.modifier_item_0330_sacrifice_medal = modifier_item_0330_sacrifice_medal
return ____exports