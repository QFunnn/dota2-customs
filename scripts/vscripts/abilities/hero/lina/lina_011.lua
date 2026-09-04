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
local __TS__Number = ____lualib.__TS__Number
local __TS__NumberIsFinite = ____lualib.__TS__NumberIsFinite
local ____exports = {}
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local registerModifier = ____dota_ts_adapter.registerModifier
local _____base_hero_ability = require("abilities.hero._base_hero_ability")
local BaseHeroAbility = _____base_hero_ability.BaseHeroAbility
local BaseHeroModifier = _____base_hero_ability.BaseHeroModifier
local MODIFIER_LINA_011_FIRE_CURSE = "modifier_lina_011_fire_curse"
local MODIFIER_LINA_011_PASSIVE = "modifier_lina_011_passive"
--- 宝石 hero_data：火咒触发时额外附加 1 层火咒的概率。
____exports.LINA_011_EXTRA_STACK_CHANCE_PCT_HERO_DATA_KEY = "lina_011_extra_stack_chance_pct"
--- 宝石 hero_data：额外附加判定成功时附加的层数（缺省 1；符印Ⅳ档=2）。
____exports.LINA_011_EXTRA_STACK_COUNT_HERO_DATA_KEY = "lina_011_extra_stack_count"
--- 丽娜技能 011 - 火咒之印（被动）
-- 技能造成伤害时，按概率给目标附加火咒；火咒会提高其承受的技能伤害，并按固定间隔自然流失层数。
____exports.lina_011 = __TS__Class()
local lina_011 = ____exports.lina_011
lina_011.name = "lina_011"
__TS__ClassExtends(lina_011, BaseHeroAbility)
function lina_011.prototype.GetAbilityConfig(self)
	return { behavior = DOTA_ABILITY_BEHAVIOR_PASSIVE }
end
function lina_011.prototype.GetIntrinsicModifierName(self)
	return MODIFIER_LINA_011_PASSIVE
end
lina_011 = __TS__DecorateLegacy({ registerAbility(nil) }, lina_011)
____exports.lina_011 = lina_011
--- 敌方身上的火咒层数：提高技能承伤，并每秒流失 1 层。
local modifier_lina_011_fire_curse = __TS__Class()
modifier_lina_011_fire_curse.name = "modifier_lina_011_fire_curse"
__TS__ClassExtends(modifier_lina_011_fire_curse, BaseHeroModifier)
function modifier_lina_011_fire_curse.GetLocalizationCN(self)
	return { name = "火咒之印", description = "每层使目标受到的技能伤害，并每秒流失 1 层。" }
end
function modifier_lina_011_fire_curse.prototype.GetModifierConfig(self)
	return { isHidden = false, isDebuff = true, isPurgable = true, isPurgeException = false }
end
function modifier_lina_011_fire_curse.prototype.OnCreated(self, params)
	if not IsServer() then
		return
	end
	local ability = self:GetAbility()
	if not ability or not IsValid(nil, ability) then
		return
	end
	local addStacks = math.max(1, math.floor(params.stack or 1))
	self:SetStackCount(addStacks)
	self:RefreshAttributes()
	local decayInterval = math.max(0.1, ability:GetSpecialValue("lina_011", "stack_decay_interval"))
	self:StartIntervalThink(decayInterval)
end
function modifier_lina_011_fire_curse.prototype.OnRefresh(self, params)
	if not IsServer() then
		return
	end
	local ability = self:GetAbility()
	if not ability or not IsValid(nil, ability) then
		return
	end
	local maxStacks = math.max(1, math.floor(ability:GetSpecialValue("lina_011", "max_stacks")))
	local addStacks = math.max(1, math.floor(params.stack or 1))
	self:SetStackCount(math.min(maxStacks, self:GetStackCount() + addStacks))
	self:RefreshAttributes()
end
function modifier_lina_011_fire_curse.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	local nextStacks = self:GetStackCount() - 1
	if nextStacks <= 0 then
		self:Destroy()
		return
	end
	self:SetStackCount(nextStacks)
	self:RefreshAttributes()
end
function modifier_lina_011_fire_curse.prototype.DeclareEvents(self)
	return { BusinessEvents.ON_DAMAGE_PRE_APPLY }
end
function modifier_lina_011_fire_curse.prototype.OnDamagePreApply_CS(self, event)
	if not IsServer() then
		return
	end
	if event.ctx.spec.victim ~= self:GetParent() then
		return
	end
	if event.ctx.spec.is_base_attack then
		return
	end
	if not event.ctx.spec.ability then
		return
	end
	if CheckTag(nil, event.ctx.spec.damage_flag, ApplyDamageFlag.HP_LOSS) then
		return
	end
	local ability = self:GetAbility()
	if not ability or not IsValid(nil, ability) then
		return
	end
	local stacks = self:GetStackCount()
	if stacks <= 0 then
		return
	end
	local perStackPct = math.max(0, ability:GetSpecialValue("lina_011", "incoming_skill_damage_pct_per_stack"))
	local totalPct = stacks * perStackPct
	if totalPct <= 0 then
		return
	end
	local ____event_final_0, ____mul_1 = event.final, "mul"
	if ____event_final_0[____mul_1] == nil then
		____event_final_0[____mul_1] = {}
	end
	local ____event_final_mul_2 = event.final.mul
	____event_final_mul_2[#____event_final_mul_2 + 1] = { value = 1 + totalPct / 100, source = "lina_011:炽魂易伤" }
end
function modifier_lina_011_fire_curse.prototype.GetTexture(self)
	return "lina_fiery_soul"
end
modifier_lina_011_fire_curse =
	__TS__DecorateLegacy({ registerModifier(nil, "modifier_lina_011_fire_curse") }, modifier_lina_011_fire_curse)
--- 英雄侧：监听技能伤害，并按概率为敌方叠加火咒。
local modifier_lina_011_passive = __TS__Class()
modifier_lina_011_passive.name = "modifier_lina_011_passive"
__TS__ClassExtends(modifier_lina_011_passive, BaseHeroModifier)
function modifier_lina_011_passive.prototype.DeclareEvents(self)
	return { BusinessEvents.ON_TAKE_DAMAGE }
end
function modifier_lina_011_passive.prototype.GetModifierConfig(self)
	return { isHidden = true, isDebuff = false, isPurgable = false, isPurgeException = false }
end
function modifier_lina_011_passive.prototype.IsPermanent(self)
	return true
end
function modifier_lina_011_passive.prototype.OnTakeDamage_CS(self, event)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	local ability = self:GetAbility()
	if not ability or not IsValid(nil, ability) then
		return
	end
	if event.attacker ~= parent then
		return
	end
	if event.is_base_attack then
		return
	end
	if not event.ability then
		return
	end
	if not IsValidAlive(nil, event.victim) then
		return
	end
	if event.victim:GetTeamNumber() == parent:GetTeamNumber() then
		return
	end
	if CheckTag(nil, event.damage_flag, ApplyDamageFlag.HP_LOSS) then
		return
	end
	if (event.final_damage or 0) <= 0 then
		return
	end
	local ____this_4
	____this_4 = event.victim
	local ____opt_3 = ____this_4.GetUnitType
	local unitType = ____opt_3 and ____opt_3(____this_4)
	if unitType == UnitType.BUILDING or unitType == UnitType.DESTRUCTIBLE then
		return
	end
	local procChancePct = math.max(0, math.min(100, ability:GetSpecialValue("lina_011", "proc_chance_pct")))
	if procChancePct <= 0 then
		return
	end
	if not RollPercentage(procChancePct) then
		return
	end
	local addStacks = 1
	local ____tonumber_7 = tonumber
	local ____opt_5 = parent.GetCustomValue
	local extraStackChancePctRaw =
		____tonumber_7(____opt_5 and ____opt_5(parent, ____exports.LINA_011_EXTRA_STACK_CHANCE_PCT_HERO_DATA_KEY) or 0)
	local ____isFinite_result_8
	if __TS__NumberIsFinite(__TS__Number(extraStackChancePctRaw)) then
		____isFinite_result_8 = math.max(0, math.min(100, extraStackChancePctRaw))
	else
		____isFinite_result_8 = 0
	end
	local extraStackChancePct = ____isFinite_result_8
	if extraStackChancePct > 0 and RollPercentage(extraStackChancePct) then
		local ____tonumber_11 = tonumber
		local ____opt_9 = parent.GetCustomValue
		local extraStackCountRaw = ____tonumber_11(
			____opt_9 and ____opt_9(parent, ____exports.LINA_011_EXTRA_STACK_COUNT_HERO_DATA_KEY) or 0
		) or 0
		addStacks = addStacks + math.max(1, math.floor(extraStackCountRaw))
	end
	modifier_lina_011_fire_curse:applys(event.victim, parent, ability, { stack = addStacks })
end
modifier_lina_011_passive =
	__TS__DecorateLegacy({ registerModifier(nil, "modifier_lina_011_passive") }, modifier_lina_011_passive)
return ____exports