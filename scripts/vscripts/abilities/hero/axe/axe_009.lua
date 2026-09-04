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
local __TS__ArrayFilter = ____lualib.__TS__ArrayFilter
local ____exports = {}
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local registerModifier = ____dota_ts_adapter.registerModifier
local _____base_hero_ability = require("abilities.hero._base_hero_ability")
local BaseHeroAbility = _____base_hero_ability.BaseHeroAbility
local BaseHeroModifier = _____base_hero_ability.BaseHeroModifier
--- 与
--
-- @registerModifier 类名一致，供 GetIntrinsicModifierName 使用
local AXE_009_INTRINSIC_MODIFIER = "modifier_axe_009_red_mist_supply"
____exports.axe_009 = __TS__Class()
local axe_009 = ____exports.axe_009
axe_009.name = "axe_009"
__TS__ClassExtends(axe_009, BaseHeroAbility)
function axe_009.prototype.GetAbilityConfig(self)
	return { behavior = DOTA_ABILITY_BEHAVIOR_PASSIVE }
end
function axe_009.prototype.GetIntrinsicModifierName(self)
	return AXE_009_INTRINSIC_MODIFIER
end
axe_009 = __TS__DecorateLegacy({ registerAbility(nil) }, axe_009)
____exports.axe_009 = axe_009
____exports.modifier_axe_009_red_mist_supply = __TS__Class()
local modifier_axe_009_red_mist_supply = ____exports.modifier_axe_009_red_mist_supply
modifier_axe_009_red_mist_supply.name = "modifier_axe_009_red_mist_supply"
__TS__ClassExtends(modifier_axe_009_red_mist_supply, BaseHeroModifier)
function modifier_axe_009_red_mist_supply.prototype.____constructor(self, ...)
	BaseHeroModifier.prototype.____constructor(self, ...)
	self.expireTimes = {}
end
function modifier_axe_009_red_mist_supply.prototype.DestroyOnExpire(self)
	return false
end
function modifier_axe_009_red_mist_supply.prototype.DeclareEvents(self)
	return { { event = BusinessEvents.ON_UNIT_DEATH, target = { scope = "global" } } }
end
function modifier_axe_009_red_mist_supply.GetLocalizationCN(self)
	return {
		name = "红雾补给",
		description = "每层使生命回复增加最大生命值的若干百分比，多层可叠加且每层独立计时。",
	}
end
function modifier_axe_009_red_mist_supply.prototype.GetModifierConfig(self)
	return {
		isHidden = self:GetStackCount() <= 0,
		isDebuff = false,
		isPurgable = false,
		isPurgeException = false,
	}
end
function modifier_axe_009_red_mist_supply.prototype.IsPermanent(self)
	return true
end
function modifier_axe_009_red_mist_supply.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	self:SetStackCount(0)
	local interval = math.max(0.05, self:GetSpecialValue("axe_009", "prune_interval"))
	self:StartIntervalThink(interval)
end
function modifier_axe_009_red_mist_supply.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	self:pruneExpired()
end
function modifier_axe_009_red_mist_supply.prototype.OnUnitDeath_CS(self, event)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	if not IsValidAlive(nil, parent) then
		return
	end
	local ____event_entindex_attacker_0
	if event.entindex_attacker then
		____event_entindex_attacker_0 = EntIndexToHScript(event.entindex_attacker)
	else
		____event_entindex_attacker_0 = nil
	end
	local attacker = ____event_entindex_attacker_0
	if not attacker or not IsValid(nil, attacker) or attacker:IsNull() or attacker ~= parent then
		return
	end
	local ____event_entindex_killed_1
	if event.entindex_killed then
		____event_entindex_killed_1 = EntIndexToHScript(event.entindex_killed)
	else
		____event_entindex_killed_1 = nil
	end
	local killed = ____event_entindex_killed_1
	if not killed or not IsValid(nil, killed) or killed:IsNull() then
		return
	end
	if killed == parent then
		return
	end
	if killed:IsBuilding() then
		return
	end
	local duration = self:readStackDuration()
	local now = GameRules:GetGameTime()
	local ____self_expireTimes_2 = self.expireTimes
	____self_expireTimes_2[#____self_expireTimes_2 + 1] = now + duration
	self:syncStacksFromExpires()
	self:RefreshAttributes()
end
function modifier_axe_009_red_mist_supply.prototype.GetAttributeBonus(self)
	local stacks = #self.expireTimes
	if stacks <= 0 then
		return {}
	end
	local pctPer = self:readRegenPctPerStack()
	return { health_regen_pct = stacks * pctPer }
end
function modifier_axe_009_red_mist_supply.prototype.readRegenPctPerStack(self)
	return self:GetSpecialValue("axe_009", "health_regen_pct_per_stack")
end
function modifier_axe_009_red_mist_supply.prototype.readStackDuration(self)
	return math.max(0.01, self:GetSpecialValue("axe_009", "stack_duration"))
end
function modifier_axe_009_red_mist_supply.prototype.pruneExpired(self)
	local now = GameRules:GetGameTime()
	local next = __TS__ArrayFilter(self.expireTimes, function(____, t)
		return t > now
	end)
	if #next == #self.expireTimes then
		return
	end
	self.expireTimes = next
	self:syncStacksFromExpires()
	self:RefreshAttributes()
end
function modifier_axe_009_red_mist_supply.prototype.syncStacksFromExpires(self)
	self:SetStackCount(#self.expireTimes)
end
modifier_axe_009_red_mist_supply = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_axe_009_red_mist_supply)
____exports.modifier_axe_009_red_mist_supply = modifier_axe_009_red_mist_supply
return ____exports