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
--- 闪避触发加速，触发后为自身提供短时移速增益并进入物品冷却。
____exports.item_0257 = __TS__Class()
local item_0257 = ____exports.item_0257
item_0257.name = "item_0257"
__TS__ClassExtends(item_0257, BaseItem_CS)
function item_0257.prototype.GetIntrinsicModifierName(self)
	return ____exports.modifier_item_0257.name
end
item_0257 = __TS__DecorateLegacy({ registerAbility(nil) }, item_0257)
____exports.item_0257 = item_0257
____exports.modifier_item_0257 = __TS__Class()
local modifier_item_0257 = ____exports.modifier_item_0257
modifier_item_0257.name = "modifier_item_0257"
__TS__ClassExtends(modifier_item_0257, BaseModifier_CS)
function modifier_item_0257.prototype.DeclareEvents(self)
	return { BusinessEvents.ON_TAKE_ATTACK_MISS }
end
function modifier_item_0257.prototype.OnTakeAttackMiss_CS(self, event)
	if not IsServer() then
		return
	end
	if event.target ~= self:GetParent() then
		return
	end
	local ability = self:GetAbility()
	if not ability or not ability:IsCooldownReady() then
		return
	end
	self:GetParent():AddNewModifier(
		self:GetParent(),
		ability,
		____exports.modifier_item_0257_buff.name,
		{ duration = ability:GetSpecialValueFor("ability_duration") }
	)
	self:GetParent():EmitSound("Greevil.MagicMissile")
	local lv = math.max(0, ability:GetLevel() - 1)
	ability:StartCooldown(ability:GetCooldown(lv))
end
function modifier_item_0257.prototype.IsHidden(self)
	return true
end
modifier_item_0257 = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0257)
____exports.modifier_item_0257 = modifier_item_0257
____exports.modifier_item_0257_buff = __TS__Class()
local modifier_item_0257_buff = ____exports.modifier_item_0257_buff
modifier_item_0257_buff.name = "modifier_item_0257_buff"
__TS__ClassExtends(modifier_item_0257_buff, BaseModifier_CS)
function modifier_item_0257_buff.GetLocalizationCN(self)
	return { name = "幻动", description = "移动速度提高。" }
end
function modifier_item_0257_buff.prototype.GetAttributeBonus(self)
	local ability = self:GetAbility()
	local ____ability_0
	if ability then
		____ability_0 = ability:GetSpecialValueFor("ability_bonus_movespeed_pct")
	else
		____ability_0 = 0
	end
	local bonusMovespeedPct = ____ability_0
	return { bonus_movespeed_pct = bonusMovespeedPct }
end
function modifier_item_0257_buff.prototype.GetEffectName(self)
	return "particles/neutral_fx/kobold_speed_buff.vpcf"
end
function modifier_item_0257_buff.prototype.GetEffectAttachType(self)
	return PATTACH_ABSORIGIN_FOLLOW
end
function modifier_item_0257_buff.prototype.IsDebuff(self)
	return false
end
function modifier_item_0257_buff.prototype.IsPurgable(self)
	return true
end
modifier_item_0257_buff = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0257_buff)
____exports.modifier_item_0257_buff = modifier_item_0257_buff
return ____exports