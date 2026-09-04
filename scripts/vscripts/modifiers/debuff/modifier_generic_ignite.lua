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
--- 点燃结算间隔（秒）。
local IGNITE_TICK_INTERVAL = 0.5
--- 每层每秒造成的（智力+力量）百分比，施加方未显式传入时的默认值。
local IGNITE_DEFAULT_PCT_PER_STACK = 20
--- 叠层上限默认值。
local IGNITE_DEFAULT_MAX_STACKS = 10
--- 持续时间默认值（秒）。
local IGNITE_DEFAULT_DURATION = 4
--- 通用负面状态【点燃】：可叠层的纯粹伤害 DOT。
--
-- 每 {@link IGNITE_TICK_INTERVAL} 秒结算一次。默认以施加者总智力与总力量为伤害基数；
-- 来源传入 use_all_stats=1 时改用全属性。伤害实时取自施加者（{@link GetCaster}），施加者失效时点燃停止。
--
-- 与灼烧 / 流血同级，但不接入 DebuffStatusType 体系：由各来源（如火焰纹章 item_0534）直接通过
-- AddNewModifier 首次施加；已有点燃时调用 AddExternalStacks 叠层，避免重启伤害 tick 与持续时间。
____exports.modifier_generic_ignite = __TS__Class()
local modifier_generic_ignite = ____exports.modifier_generic_ignite
modifier_generic_ignite.name = "modifier_generic_ignite"
__TS__ClassExtends(modifier_generic_ignite, BaseModifier_CS)
function modifier_generic_ignite.prototype.____constructor(self, ...)
	BaseModifier_CS.prototype.____constructor(self, ...)
	self.pctPerStack = IGNITE_DEFAULT_PCT_PER_STACK
	self.maxStacks = IGNITE_DEFAULT_MAX_STACKS
	self.useAllStats = false
	self.expireTime = 0
end
function modifier_generic_ignite.GetLocalizationCN(self)
	return {
		name = "点燃",
		description = "周期性受到纯粹伤害。每层伤害根据来源装备读取施加者的对应属性，可叠加层数，叠层不会刷新剩余持续时间。",
	}
end
function modifier_generic_ignite.prototype.OnCreated(self, params)
	if not IsServer() then
		return
	end
	self:ApplyConfig(params)
	local initialStack = math.max(1, math.floor(params.stack or 1))
	self:SetStackCount(math.min(self.maxStacks, initialStack))
	local duration = params.duration or IGNITE_DEFAULT_DURATION
	self.expireTime = GameRules:GetGameTime() + duration
	self:SetDuration(duration, true)
	self:StartIntervalThink(IGNITE_TICK_INTERVAL)
end
function modifier_generic_ignite.prototype.OnRefresh(self, params)
	if not IsServer() then
		return
	end
	self:AddExternalStacks(params)
	self:SetDuration(math.max(self.expireTime - GameRules:GetGameTime(), 0), true)
end
function modifier_generic_ignite.prototype.AddExternalStacks(self, params)
	if not IsServer() then
		return
	end
	self:ApplyConfig(params)
	local addStack = math.max(1, math.floor(params.stack or 1))
	self:SetStackCount(math.min(self.maxStacks, self:GetStackCount() + addStack))
end
function modifier_generic_ignite.prototype.ApplyConfig(self, params)
	if params.pct_per_stack ~= nil and params.pct_per_stack > 0 then
		self.pctPerStack = params.pct_per_stack
	end
	if params.max_stacks ~= nil and params.max_stacks > 0 then
		self.maxStacks = math.floor(params.max_stacks)
	end
	if params.use_all_stats ~= nil then
		self.useAllStats = params.use_all_stats == 1
	end
end
function modifier_generic_ignite.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	local victim = self:GetParent()
	local attacker = self:GetCaster()
	if not IsValidAlive(nil, victim) or not IsValidAlive(nil, attacker) then
		self:Destroy()
		return
	end
	local intelligence = MyGameAttribute:GetAttribute(attacker, "total_intelligence") or 0
	local strength = MyGameAttribute:GetAttribute(attacker, "total_strength") or 0
	local ____table_useAllStats_0
	if self.useAllStats then
		____table_useAllStats_0 = MyGameAttribute:GetAttribute(attacker, "total_agility") or 0
	else
		____table_useAllStats_0 = 0
	end
	local agility = ____table_useAllStats_0
	local stacks = self:GetStackCount()
	local damage = (intelligence + strength + agility) * (self.pctPerStack / 100) * stacks * IGNITE_TICK_INTERVAL
	if damage <= 0 then
		return
	end
	Damage:ApplyDamage({
		attacker = attacker,
		victim = victim,
		damage = damage,
		damage_type = 4,
		damage_flag = ApplyDamageFlag.HP_LOSS,
		ability = self:GetAbility(),
		extra_data = {
			damage_tags = DamageTag.DOT,
			source_name = self:GetName(),
		},
	})
end
function modifier_generic_ignite.prototype.IsHidden(self)
	return false
end
function modifier_generic_ignite.prototype.IsDebuff(self)
	return true
end
function modifier_generic_ignite.prototype.IsPurgable(self)
	return true
end
function modifier_generic_ignite.prototype.GetTexture(self)
	return "phoenix_fire_spirits"
end
function modifier_generic_ignite.prototype.GetEffectName(self)
	return ""
end
function modifier_generic_ignite.prototype.GetEffectAttachType(self)
	return PATTACH_ABSORIGIN_FOLLOW
end
modifier_generic_ignite = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_generic_ignite)
____exports.modifier_generic_ignite = modifier_generic_ignite
return ____exports