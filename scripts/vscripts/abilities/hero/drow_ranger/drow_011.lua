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
local __TS__StringSplit = ____lualib.__TS__StringSplit
local ____exports = {}
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local registerModifier = ____dota_ts_adapter.registerModifier
local _____base_hero_ability = require("abilities.hero._base_hero_ability")
local BaseHeroAbility = _____base_hero_ability.BaseHeroAbility
local BaseHeroModifier = _____base_hero_ability.BaseHeroModifier
--- 触发所需的目标冰冻层数（满层，与冻魄阈值同口径）
local DROW_011_REQUIRED_FREEZE_STACKS = 10
--- 返还比例：触发时来源技能剩余冷却乘以该系数
local DROW_011_COOLDOWN_REFUND_RATE = 0.5
--- 碎冰演出（项目现役：寒星射击/永夜之矢爆炸同款冰新星）
local DROW_011_SHATTER_PARTICLE = "particles/hero/dr/maiden_crystal_nova_cowlofice.vpcf"
local DROW_011_SHATTER_SOUND = "Ability.FrostNova"
--- 卓尔游侠技能 011 - 碎霜
-- 被动（E 槽）：主动技能的伤害命中带有满层冰冻的目标时，
-- 清空目标全部冰冻层数，并返还该技能一半剩余冷却时间。内置冷却见表。
____exports.drow_011 = __TS__Class()
local drow_011 = ____exports.drow_011
drow_011.name = "drow_011"
__TS__ClassExtends(drow_011, BaseHeroAbility)
function drow_011.prototype.Precache(self, context)
	PrecacheResource("particle", DROW_011_SHATTER_PARTICLE, context)
end
function drow_011.prototype.GetAbilityConfig(self)
	return { behavior = DOTA_ABILITY_BEHAVIOR_PASSIVE }
end
function drow_011.prototype.GetIntrinsicModifierName(self)
	return ____exports.modifier_drow_011_shatter.name
end
drow_011 = __TS__DecorateLegacy({ registerAbility(nil) }, drow_011)
____exports.drow_011 = drow_011
--- 碎霜监听：ON_DEAL_DAMAGE 派发在受害者实体桶，攻击者侧靠冒泡到 global 接收后过滤
____exports.modifier_drow_011_shatter = __TS__Class()
local modifier_drow_011_shatter = ____exports.modifier_drow_011_shatter
modifier_drow_011_shatter.name = "modifier_drow_011_shatter"
__TS__ClassExtends(modifier_drow_011_shatter, BaseHeroModifier)
function modifier_drow_011_shatter.prototype.____constructor(self, ...)
	BaseHeroModifier.prototype.____constructor(self, ...)
	self._activeTagCache = {}
end
function modifier_drow_011_shatter.prototype.GetModifierConfig(self)
	return { isHidden = true, isDebuff = false, isPurgable = false, isPurgeException = false }
end
function modifier_drow_011_shatter.prototype.IsPermanent(self)
	return true
end
function modifier_drow_011_shatter.prototype.DeclareEvents(self)
	return { { event = BusinessEvents.ON_DEAL_DAMAGE, target = { scope = "global" } } }
end
function modifier_drow_011_shatter.prototype.IsActiveTaggedAbility(self, sourceAbility)
	local abilityName = sourceAbility:GetAbilityName()
	local cached = self._activeTagCache[abilityName]
	if cached ~= nil then
		return cached
	end
	local ____opt_0 = GetAbilityKeyValuesByName(abilityName)
	local tagsRaw = ____opt_0 and ____opt_0.AbilityTags
	local isActive = false
	if tagsRaw then
		for ____, tag in ipairs(__TS__StringSplit(tagsRaw, "|")) do
			if tag == "active" then
				isActive = true
				break
			end
		end
	end
	self._activeTagCache[abilityName] = isActive
	return isActive
end
function modifier_drow_011_shatter.prototype.OnDealDamage_CS(self, event)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	if not IsValidAlive(nil, parent) then
		return
	end
	if event.attacker ~= parent then
		return
	end
	if event.is_base_attack then
		return
	end
	local sourceAbility = event.ability
	if not sourceAbility or not IsValid(nil, sourceAbility) then
		return
	end
	if not self:IsActiveTaggedAbility(sourceAbility) then
		return
	end
	if MyGameAbilityChargeManager and MyGameAbilityChargeManager:IsCustomChargeAbility(sourceAbility) then
		return
	end
	local victim = event.victim
	if not victim or not IsValidAlive(nil, victim) then
		return
	end
	if victim:GetTeamNumber() == parent:GetTeamNumber() then
		return
	end
	local ability = self:GetAbility()
	if not ability or not IsValid(nil, ability) then
		return
	end
	if not ability:IsCooldownReady() then
		return
	end
	local freezeModifiers = victim:FindAllModifiersByName("modifier_generic_slow") or {}
	local totalStacks = 0
	for ____, freezeModifier in ipairs(freezeModifiers) do
		do
			if not IsValid(nil, freezeModifier) then
				goto __continue26
			end
			totalStacks = totalStacks + math.max(freezeModifier:GetStackCount(), 0)
		end
		::__continue26::
	end
	if totalStacks < DROW_011_REQUIRED_FREEZE_STACKS then
		return
	end
	for ____, freezeModifier in ipairs(freezeModifiers) do
		do
			if not IsValid(nil, freezeModifier) then
				goto __continue30
			end
			freezeModifier:Destroy()
		end
		::__continue30::
	end
	local remaining = sourceAbility:GetCooldownTimeRemaining()
	if remaining > 0 then
		local refundTo = remaining * DROW_011_COOLDOWN_REFUND_RATE
		sourceAbility:EndCooldown()
		sourceAbility:StartCooldown(refundTo)
		local debugAbilityName = sourceAbility:GetAbilityName()
		print(
			(
				(
					(((("[碎霜调试] " .. debugAbilityName) .. " 返还 ") .. tostring(remaining)) .. " -> ")
					.. tostring(refundTo)
				) .. " @t="
			) .. tostring(GameRules:GetGameTime())
		)
		for ____, delay in ipairs({ 0.1, 0.5, 1, 2 }) do
			local checkDelay = delay
			Timers:CreateTimer(checkDelay, function()
				if not IsValid(nil, sourceAbility) then
					return nil
				end
				print(
					(((("[碎霜调试] " .. debugAbilityName) .. " +") .. tostring(checkDelay)) .. "s 剩余=")
						.. tostring(sourceAbility:GetCooldownTimeRemaining())
				)
				return nil
			end)
		end
	end
	local shatterFx = ParticleManager:CreateParticle(DROW_011_SHATTER_PARTICLE, PATTACH_ABSORIGIN_FOLLOW, victim)
	ParticleManager:ReleaseParticleIndex(shatterFx)
	victim:EmitSound(DROW_011_SHATTER_SOUND)
	ability:StartCooldown(math.max(0, ability:GetCooldown(math.max(0, ability:GetLevel() - 1))))
end
modifier_drow_011_shatter = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_drow_011_shatter)
____exports.modifier_drow_011_shatter = modifier_drow_011_shatter
return ____exports