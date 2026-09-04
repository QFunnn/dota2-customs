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
local ____item_0409_shared = require("abilities.items.item_0409_shared")
local IsValidEnemyUnit = ____item_0409_shared.IsValidEnemyUnit
--- 欠账：为 hero 增加 n 层【债】（受 DEBT_CAP 钳制）。
--
-- @returns 实际欠到的层数（满仓借贷冻结时返回 0，且不刷新偿还计时）。
function ____exports.AddDebt(self, hero, ability, n)
	if not IsServer() or not IsValidAlive(nil, hero) or n <= 0 then
		return 0
	end
	local debt = hero:FindModifierByName(____exports.modifier_item_0614_debt.name)
	if not debt or not IsValid(nil, debt) then
		debt = hero:AddNewModifier(hero, ability, ____exports.modifier_item_0614_debt.name, {})
		if not debt then
			return 0
		end
		debt:SetStackCount(0)
	end
	local cur = debt:GetStackCount()
	local next = math.min(____exports.DEBT_CAP, cur + math.floor(n))
	local added = next - cur
	if added > 0 then
		debt:SetStackCount(next)
		debt:MarkBorrow()
	end
	return added
end
--- 查账：hero 当前的【债】层数。
function ____exports.GetDebt(self, hero)
	if not IsValid(nil, hero) then
		return 0
	end
	local debt = hero:FindModifierByName(____exports.modifier_item_0614_debt.name)
	local ____temp_0
	if debt and IsValid(nil, debt) then
		____temp_0 = debt:GetStackCount()
	else
		____temp_0 = 0
	end
	return ____temp_0
end
--- 债上限：满仓即借贷冻结。
____exports.DEBT_CAP = 40
--- 连续未欠新账多少秒后开始自动偿还。
local REPAY_DELAY = 5
--- 自动偿还速度（层/秒）。
local REPAY_PER_SEC = 2
____exports.item_0614 = __TS__Class()
local item_0614 = ____exports.item_0614
item_0614.name = "item_0614"
__TS__ClassExtends(item_0614, BaseItem_CS)
function item_0614.prototype.GetIntrinsicModifierName(self)
	return ____exports.modifier_item_0614.name
end
item_0614 = __TS__DecorateLegacy({ registerAbility(nil) }, item_0614)
____exports.item_0614 = item_0614
--- 固有被动「赊锋」：普攻命中记债；每秒按债务层数抽取当前生命作利息。
____exports.modifier_item_0614 = __TS__Class()
local modifier_item_0614 = ____exports.modifier_item_0614
modifier_item_0614.name = "modifier_item_0614"
__TS__ClassExtends(modifier_item_0614, BaseModifier_CS)
function modifier_item_0614.prototype.DeclareEvents(self)
	return { BusinessEvents.ON_ATTACK_LANDED }
end
function modifier_item_0614.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	self:RefreshAttributes()
	self:StartIntervalThink(1)
end
function modifier_item_0614.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	self:StartIntervalThink(-1)
end
function modifier_item_0614.prototype.GetAttributeBonus(self)
	local ability = self:GetAbility()
	if not ability or not IsValid(nil, ability) then
		return {}
	end
	local pct = math.max(0, ability:GetSpecialValueFor("ability_value_physical_damage_add_pct"))
	if pct <= 0 then
		return {}
	end
	return { physical_damage_add_pct = pct }
end
function modifier_item_0614.prototype.OnAttackLanded_CS(self, event)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	local ability = self:GetAbility()
	if not ability or event.attacker ~= parent then
		return
	end
	if event.is_sub_attack or event.is_base_attack == false then
		return
	end
	if not IsValidAlive(nil, parent) or not IsValidEnemyUnit(nil, parent, event.target) then
		return
	end
	local perHit = math.max(1, math.floor(ability:GetSpecialValueFor("ability_debt_per_hit")))
	____exports.AddDebt(nil, parent, ability, perHit)
end
function modifier_item_0614.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	local ability = self:GetAbility()
	if not ability or not IsValid(nil, ability) or not IsValidAlive(nil, parent) then
		return
	end
	local debt = ____exports.GetDebt(nil, parent)
	if debt <= 0 then
		return
	end
	local interestPct = math.max(0, ability:GetSpecialValueFor("ability_interest_pct"))
	local interest = parent:GetHealth() * debt * interestPct / 100
	local capPct = math.max(0, ability:GetSpecialValueFor("ability_value_c_interest_cap_pct"))
	if capPct > 0 then
		interest = math.min(interest, parent:GetHealth() * capPct / 100)
	end
	if interest <= 0 then
		return
	end
	parent:CostHeal(interest, { ability = ability, source = { source_name = "item_0614:赊锋利息" } })
end
function modifier_item_0614.prototype.IsHidden(self)
	return true
end
function modifier_item_0614.prototype.IsPurgable(self)
	return false
end
modifier_item_0614 = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0614)
____exports.modifier_item_0614 = modifier_item_0614
--- 【债】状态（挂英雄·层数=当前负债）：唯一真相源，负债线四件共读共写。
____exports.modifier_item_0614_debt = __TS__Class()
local modifier_item_0614_debt = ____exports.modifier_item_0614_debt
modifier_item_0614_debt.name = "modifier_item_0614_debt"
__TS__ClassExtends(modifier_item_0614_debt, BaseModifier_CS)
function modifier_item_0614_debt.prototype.____constructor(self, ...)
	BaseModifier_CS.prototype.____constructor(self, ...)
	self.lastBorrowTime = 0
end
function modifier_item_0614_debt.GetLocalizationCN(self)
	return {
		name = "债",
		description = "身负的债务层数（上限40层）。连续5秒未欠下新债时，每秒自动偿还2层。",
	}
end
function modifier_item_0614_debt.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	self.lastBorrowTime = GameRules:GetGameTime()
	self:StartIntervalThink(1)
end
function modifier_item_0614_debt.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	self:StartIntervalThink(-1)
end
function modifier_item_0614_debt.prototype.MarkBorrow(self)
	self.lastBorrowTime = GameRules:GetGameTime()
end
function modifier_item_0614_debt.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	local stacks = self:GetStackCount()
	if stacks <= 0 then
		self:Destroy()
		return
	end
	if GameRules:GetGameTime() - self.lastBorrowTime < REPAY_DELAY then
		return
	end
	local next = math.max(0, stacks - REPAY_PER_SEC)
	if next <= 0 then
		self:Destroy()
	else
		self:SetStackCount(next)
	end
end
function modifier_item_0614_debt.prototype.IsHidden(self)
	return false
end
function modifier_item_0614_debt.prototype.IsDebuff(self)
	return false
end
function modifier_item_0614_debt.prototype.IsPurgable(self)
	return false
end
function modifier_item_0614_debt.prototype.GetTexture(self)
	return "item_hand_of_midas"
end
modifier_item_0614_debt = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0614_debt)
____exports.modifier_item_0614_debt = modifier_item_0614_debt
--- 宣告破产：清空 hero 的全部【债】。
--
-- @returns 清掉的层数（清算之约按此结算爆发）。
function ____exports.ClearDebt(self, hero)
	if not IsServer() or not IsValid(nil, hero) then
		return 0
	end
	local debt = hero:FindModifierByName(____exports.modifier_item_0614_debt.name)
	if not debt or not IsValid(nil, debt) then
		return 0
	end
	local stacks = debt:GetStackCount()
	debt:Destroy()
	return math.max(0, stacks)
end
return ____exports