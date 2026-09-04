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
____exports.item_0595 = __TS__Class()
local item_0595 = ____exports.item_0595
item_0595.name = "item_0595"
__TS__ClassExtends(item_0595, BaseItem_CS)
function item_0595.prototype.GetIntrinsicModifierName(self)
	return ____exports.modifier_item_0595.name
end
item_0595 = __TS__DecorateLegacy({ registerAbility(nil) }, item_0595)
____exports.item_0595 = item_0595
--- 固有被动：对敌伤害进乘区前掷骰浮动，带低掷保底。
____exports.modifier_item_0595 = __TS__Class()
local modifier_item_0595 = ____exports.modifier_item_0595
modifier_item_0595.name = "modifier_item_0595"
__TS__ClassExtends(modifier_item_0595, BaseModifier_CS)
function modifier_item_0595.prototype.____constructor(self, ...)
	BaseModifier_CS.prototype.____constructor(self, ...)
	self.pityArmed = false
end
function modifier_item_0595.prototype.DeclareEvents(self)
	return { BusinessEvents.ON_DAMAGE_PRE_APPLY_ATTACKER }
end
function modifier_item_0595.prototype.IsHidden(self)
	return true
end
function modifier_item_0595.prototype.IsPurgable(self)
	return false
end
function modifier_item_0595.prototype.OnDamagePreApplyAttacker_CS(self, event)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	local ability = self:GetAbility()
	if not ability or event.ctx.spec.attacker ~= parent then
		return
	end
	if not IsValidAlive(nil, parent) then
		return
	end
	if CheckTag(nil, event.ctx.spec.damage_flag, ApplyDamageFlag.HP_LOSS) then
		return
	end
	local ____CheckTag_2 = CheckTag
	local ____opt_0 = event.ctx.spec.source
	if ____CheckTag_2(nil, ____opt_0 and ____opt_0.damage_tags, DamageTag.NO_PROC) then
		return
	end
	local victim = event.ctx.spec.victim
	if not victim or not IsValidAlive(nil, victim) or victim:IsBuilding() then
		return
	end
	if victim:GetTeamNumber() == parent:GetTeamNumber() then
		return
	end
	local rollMin = math.floor(ability:GetSpecialValueFor("ability_roll_min_pct"))
	local rollMax = math.floor(ability:GetSpecialValueFor("ability_roll_max_pct"))
	local pityBelow = ability:GetSpecialValueFor("ability_pity_below_pct")
	local pityFloor = math.floor(ability:GetSpecialValueFor("ability_pity_floor_pct"))
	if rollMax <= 0 or rollMax < rollMin then
		return
	end
	local ____table_pityArmed_3
	if self.pityArmed then
		____table_pityArmed_3 = math.min(math.max(rollMin, pityFloor), rollMax)
	else
		____table_pityArmed_3 = rollMin
	end
	local lo = ____table_pityArmed_3
	local roll = RandomInt(lo, rollMax)
	self.pityArmed = roll < pityBelow
	local ____event_final_4, ____mul_5 = event.final, "mul"
	if ____event_final_4[____mul_5] == nil then
		____event_final_4[____mul_5] = {}
	end
	local ____event_final_mul_6 = event.final.mul
	____event_final_mul_6[#____event_final_mul_6 + 1] = { value = roll / 100, source = "item_0595:命运骰盅" }
end
modifier_item_0595 = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0595)
____exports.modifier_item_0595 = modifier_item_0595
return ____exports