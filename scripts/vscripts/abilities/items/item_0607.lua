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
--- AOE 同帧保护窗口：一次施法的多目标伤害事件只认第一个（秒）。
local SAME_CAST_WINDOW = 0.1
____exports.item_0607 = __TS__Class()
local item_0607 = ____exports.item_0607
item_0607.name = "item_0607"
__TS__ClassExtends(item_0607, BaseItem_CS)
function item_0607.prototype.GetIntrinsicModifierName(self)
	return ____exports.modifier_item_0607.name
end
item_0607 = __TS__DecorateLegacy({ registerAbility(nil) }, item_0607)
____exports.item_0607 = item_0607
--- 固有被动：技能直伤 → 对目标叠咒缚（换目标清旧印）。
____exports.modifier_item_0607 = __TS__Class()
local modifier_item_0607 = ____exports.modifier_item_0607
modifier_item_0607.name = "modifier_item_0607"
__TS__ClassExtends(modifier_item_0607, BaseModifier_CS)
function modifier_item_0607.prototype.____constructor(self, ...)
	BaseModifier_CS.prototype.____constructor(self, ...)
	self.lastStackTime = -100
end
function modifier_item_0607.prototype.DeclareEvents(self)
	return { BusinessEvents.ON_TAKE_DAMAGE }
end
function modifier_item_0607.prototype.IsHidden(self)
	return true
end
function modifier_item_0607.prototype.IsPurgable(self)
	return false
end
function modifier_item_0607.prototype.OnTakeDamage_CS(self, event)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	local ability = self:GetAbility()
	if not ability or event.attacker ~= parent then
		return
	end
	if not IsValidAlive(nil, parent) then
		return
	end
	if event.is_base_attack ~= false then
		return
	end
	if (event.final_damage or 0) <= 0 then
		return
	end
	if CheckTag(nil, event.damage_flag, ApplyDamageFlag.HP_LOSS) then
		return
	end
	local ____CheckTag_2 = CheckTag
	local ____opt_0 = event.source
	if ____CheckTag_2(nil, ____opt_0 and ____opt_0.damage_tags, DamageTag.NO_PROC) then
		return
	end
	local target = event.victim
	if not IsValidAlive(nil, target) or target:IsBuilding() then
		return
	end
	if target:GetTeamNumber() == parent:GetTeamNumber() then
		return
	end
	local now = GameRules:GetGameTime()
	if now - self.lastStackTime < SAME_CAST_WINDOW then
		return
	end
	local targetIndex = target:GetEntityIndex()
	if self.lastTargetIndex ~= nil and self.lastTargetIndex ~= targetIndex then
		local oldTarget = EntIndexToHScript(self.lastTargetIndex)
		if oldTarget and IsValid(nil, oldTarget) then
			local oldMark = oldTarget:FindModifierByName(____exports.modifier_item_0607_mark.name)
			if oldMark and oldMark:GetCaster() == parent then
				oldMark:Destroy()
			end
		end
	end
	self.lastTargetIndex = targetIndex
	self.lastStackTime = now
	target:AddNewModifier(parent, ability, ____exports.modifier_item_0607_mark.name, {})
end
modifier_item_0607 = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0607)
____exports.modifier_item_0607 = modifier_item_0607
--- 【咒缚】（挂敌人）：每层使宿主受到印记施加者的技能伤害提高；换目标或到期即消失。
____exports.modifier_item_0607_mark = __TS__Class()
local modifier_item_0607_mark = ____exports.modifier_item_0607_mark
modifier_item_0607_mark.name = "modifier_item_0607_mark"
__TS__ClassExtends(modifier_item_0607_mark, BaseModifier_CS)
function modifier_item_0607_mark.prototype.____constructor(self, ...)
	BaseModifier_CS.prototype.____constructor(self, ...)
	self.ampPctPerStack = 0
	self.maxStacks = 8
end
function modifier_item_0607_mark.GetLocalizationCN(self)
	return { name = "咒缚", description = "受到印记施加者的技能伤害提高，随层数增强。" }
end
function modifier_item_0607_mark.prototype.DeclareEvents(self)
	return { BusinessEvents.ON_DAMAGE_PRE_APPLY }
end
function modifier_item_0607_mark.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	self:RefreshConfig()
	self:SetStackCount(1)
end
function modifier_item_0607_mark.prototype.OnRefresh(self)
	if not IsServer() then
		return
	end
	self:RefreshConfig()
	self:SetStackCount(math.min(self.maxStacks, self:GetStackCount() + 1))
end
function modifier_item_0607_mark.prototype.RefreshConfig(self)
	local ability = self:GetAbility()
	local ____ability_3
	if ability then
		____ability_3 = math.max(0, ability:GetSpecialValueFor("ability_amp_per_stack"))
	else
		____ability_3 = 0
	end
	self.ampPctPerStack = ____ability_3
	local ____ability_4
	if ability then
		____ability_4 = ability:GetSpecialValueFor("ability_value_max_stacks")
	else
		____ability_4 = 0
	end
	local rolledMax = ____ability_4
	local ____temp_5
	if rolledMax > 0 then
		____temp_5 = math.max(1, math.floor(rolledMax))
	else
		____temp_5 = 8
	end
	self.maxStacks = ____temp_5
	local ____ability_6
	if ability then
		____ability_6 = math.max(0, ability:GetSpecialValueFor("ability_mark_duration"))
	else
		____ability_6 = 5
	end
	local duration = ____ability_6
	self:SetDuration(duration, true)
end
function modifier_item_0607_mark.prototype.OnDamagePreApply_CS(self, event)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	if event.ctx.spec.victim ~= parent then
		return
	end
	if event.ctx.spec.attacker ~= self:GetCaster() then
		return
	end
	if event.ctx.spec.is_base_attack then
		return
	end
	if CheckTag(nil, event.ctx.spec.damage_flag, ApplyDamageFlag.HP_LOSS) then
		return
	end
	local ampPct = self.ampPctPerStack * self:GetStackCount()
	if ampPct <= 0 then
		return
	end
	local ____event_final_7, ____mul_8 = event.final, "mul"
	if ____event_final_7[____mul_8] == nil then
		____event_final_7[____mul_8] = {}
	end
	local ____event_final_mul_9 = event.final.mul
	____event_final_mul_9[#____event_final_mul_9 + 1] = { value = 1 + ampPct / 100, source = "item_0607:咒缚印记" }
end
function modifier_item_0607_mark.prototype.IsHidden(self)
	return false
end
function modifier_item_0607_mark.prototype.IsDebuff(self)
	return true
end
function modifier_item_0607_mark.prototype.IsPurgable(self)
	return false
end
function modifier_item_0607_mark.prototype.GetTexture(self)
	return "item_book_of_shadows"
end
modifier_item_0607_mark = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0607_mark)
____exports.modifier_item_0607_mark = modifier_item_0607_mark
return ____exports