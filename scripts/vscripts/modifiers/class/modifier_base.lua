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
local ____exports = {}
local ____ability_tag_context = require("shared.ability_tag_context")
local BuildTagContextFromAbilityKv = ____ability_tag_context.BuildTagContextFromAbilityKv
local ____WithAttributes = require("modules.WithAttributes")
local WithAttributes = ____WithAttributes.WithAttributes
local ____WithEventHandler = require("modules.WithEventHandler")
local WithEventHandler = ____WithEventHandler.WithEventHandler
local ____WithTagRules = require("modules.WithTagRules")
local WithTagRules = ____WithTagRules.WithTagRules
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local BaseModifier = ____dota_ts_adapter.BaseModifier
local BaseModifierMotionHorizontal = ____dota_ts_adapter.BaseModifierMotionHorizontal
local BaseModifierMotionVertical = ____dota_ts_adapter.BaseModifierMotionVertical
local BaseModifierMotionBoth = ____dota_ts_adapter.BaseModifierMotionBoth
--- 普通（非位移）Modifier 的 CS 基类，内置属性系统 + 事件系统。
____exports.BaseModifier_CS = __TS__Class()
local BaseModifier_CS = ____exports.BaseModifier_CS
BaseModifier_CS.name = "BaseModifier_CS"
__TS__ClassExtends(BaseModifier_CS, WithTagRules(nil, WithAttributes(nil, WithEventHandler(nil, BaseModifier))))
function BaseModifier_CS.prototype.____constructor(self, ...)
	BaseModifier_CS.____super.prototype.____constructor(self, ...)
	self.__wearablesInvisibilityApplied = 0
end
function BaseModifier_CS.GetLocalizationCN(self)
	return nil
end
function BaseModifier_CS.prototype.Spawn(self)
	self._caster = self:GetCaster()
	self._parent = self:GetParent()
	self._ability = self:GetAbility()
end
function BaseModifier_CS.prototype.IsHidden(self)
	return false
end
function BaseModifier_CS.prototype.GetEntity(self)
	return self:GetParent()
end
function BaseModifier_CS.prototype.GetAttributeBonus(self)
	return nil
end
function BaseModifier_CS.prototype.IsRemoved(self)
	return BaseModifier_CS.____super.prototype.IsRemoved(self)
end
function BaseModifier_CS.prototype.GetPlayerId(self)
	return self:GetParent():GetPlayerId()
end
function BaseModifier_CS.prototype.AddStackCount(self, count)
	if count == nil then
		count = 1
	end
	self:SetStackCount(self:GetStackCount() + count)
end
function BaseModifier_CS.prototype.Timer(self, delay, callback)
	Timers:CreateTimer(delay, function()
		if not IsValid(nil, self) or not IsValidAlive(nil, self._caster) then
			return
		end
		return callback(nil)
	end)
end
function BaseModifier_CS.prototype.GetName(self)
	return self.constructor.name
end
function BaseModifier_CS.prototype.GetAddAttributesEntity(self)
	return { self:GetParent() }
end
function BaseModifier_CS.prototype.GetAddTagRulesEntity(self)
	return { self:GetParent() }
end
function BaseModifier_CS.prototype.GetSpecialValue(self, abilityName, key)
	local ability = self:GetAbility()
	if IsClient() then
		return ability:GetSpecialValueFor(key)
	end
	local ____opt_0 = self._caster
	local ____temp_4 = ____opt_0 and ____opt_0:IsHero() and self._ability ~= nil
	if ____temp_4 then
		local ____opt_2 = self._ability
		____temp_4 = not (____opt_2 and ____opt_2:IsItem())
	end
	if ____temp_4 then
		return ability:GetSpecialValue(abilityName, key)
	end
	return ability:GetSpecialValueFor(key)
end
function BaseModifier_CS.prototype.GetSpecialValueRaw(self, abilityName, key)
	local ability = self:GetAbility()
	return ability:GetSpecialValueRaw(abilityName, key)
end
function BaseModifier_CS.prototype.GetAllAttackDamage(self, caster)
	if caster == nil then
		caster = self:GetCaster()
	end
	return MyGameAttribute:GetAttribute(caster, "total_attack_damage")
end
function BaseModifier_CS.prototype.GetMaxHealth(self)
	return MyGameAttribute:GetAttribute(self:GetParent(), "total_health")
end
function BaseModifier_CS.prototype.GetAllAttributes(self)
	local str = MyGameAttribute:GetAttribute(self:GetParent(), "total_strength")
	local agi = MyGameAttribute:GetAttribute(self:GetParent(), "total_agility")
	local int = MyGameAttribute:GetAttribute(self:GetParent(), "total_intelligence")
	return str + agi + int
end
function BaseModifier_CS.prototype.MonsterDamage(self, target, damageRate, effectName)
	ApplyMonsterDamage(nil, self:GetCaster(), {
		victim = target,
		damage_rate = damageRate,
		ability = self:GetAbility(),
		damage_type = 2,
		effectName = effectName,
	})
end
function BaseModifier_CS.prototype.ResolveTagNumber(self, baseValue, statKey, extraContext)
	if not MyGameTagManager then
		return baseValue
	end
	local ability = self:GetAbility()
	local ____opt_5 = ability and ability.GetAbilityName
	local abilityName = ____opt_5 and ____opt_5(ability)
	local ____ability_IsItem_result_17
	local ____opt_9 = ability and ability.IsItem
	if ____opt_9 and ____opt_9(ability) then
		____ability_IsItem_result_17 = MyGameRulesetManager and MyGameRulesetManager:GetItemConfig(abilityName or "")
	else
		____ability_IsItem_result_17 = MyGameRulesetManager and MyGameRulesetManager:GetAbilityConfig(abilityName or "")
	end
	local abilityKv = ____ability_IsItem_result_17
	local mergedTagContext = BuildTagContextFromAbilityKv(nil, abilityKv, extraContext and extraContext.tagContext)
	local context = { abilityName = abilityName, abilityKv = abilityKv, tagContext = mergedTagContext }
	if extraContext and extraContext.rules then
		context.rules = extraContext.rules
	end
	return MyGameTagManager:ResolveNumberForUnit(self:GetParent(), baseValue, statKey, context)
end
function BaseModifier_CS.prototype.GetMutexKey(self)
	return nil
end
function BaseModifier_CS.prototype.GetMutexPriority(self)
	return 0
end
function BaseModifier_CS.prototype.IsMutexActive(self)
	if not IsServer() then
		return true
	end
	local player = self:getMutexPlayer()
	local ____opt_22 = player and player.playerModifierMutex
	local ____temp_26 = ____opt_22 and ____opt_22:IsModifierActive(self)
	if ____temp_26 == nil then
		____temp_26 = true
	end
	return ____temp_26
end
function BaseModifier_CS.prototype.OnCreated_AutoModifierMutex(self)
	if not IsServer() then
		return true
	end
	self.__mutexBornTime = self.__mutexBornTime or GameRules:GetGameTime()
	local player = self:getMutexPlayer()
	local ____opt_27 = player and player.playerModifierMutex
	local ____temp_31 = ____opt_27 and ____opt_27:RegisterPendingModifier(self)
	if ____temp_31 == nil then
		____temp_31 = true
	end
	return ____temp_31
end
function BaseModifier_CS.prototype.OnRefresh_AutoModifierMutex(self)
	if not IsServer() then
		return true
	end
	local player = self:getMutexPlayer()
	local ____opt_32 = player and player.playerModifierMutex
	local ____temp_36 = ____opt_32 and ____opt_32:OnModifierRefresh(self)
	if ____temp_36 == nil then
		____temp_36 = true
	end
	return ____temp_36
end
function BaseModifier_CS.prototype.OnDestroy_AutoModifierMutex(self)
	if not IsServer() then
		return
	end
	local player = self:getMutexPlayer()
	local ____opt_37 = player and player.playerModifierMutex
	if ____opt_37 ~= nil then
		____opt_37:OnModifierDestroy(self)
	end
end
function BaseModifier_CS.prototype.OnCreated_AutoWearablesInvisibilitySync(self)
	if not IsServer() then
		return
	end
	self:syncWearablesInvisibilityDelta()
end
function BaseModifier_CS.prototype.OnRefresh_AutoWearablesInvisibilitySync(self)
	if not IsServer() then
		return
	end
	self:syncWearablesInvisibilityDelta()
end
function BaseModifier_CS.prototype.OnDestroy_AutoWearablesInvisibilitySync(self)
	if not IsServer() then
		return
	end
	if self.__wearablesInvisibilityApplied <= 0 then
		return
	end
	local hero = self:GetParent()
	if not hero or not IsValid(nil, hero) or not hero:IsHero() then
		return
	end
	local player = MyGamePlayers:getPlayer(hero:GetPlayerId())
	if not player or not player.playerWearables then
		return
	end
	player.playerWearables:addHeroWearablesInvisibilityLevel(hero, -self.__wearablesInvisibilityApplied)
	self.__wearablesInvisibilityApplied = 0
end
function BaseModifier_CS.prototype.syncWearablesInvisibilityDelta(self)
	local hero = self:GetParent()
	if not hero or not IsValid(nil, hero) or not hero:IsHero() then
		return
	end
	local player = MyGamePlayers:getPlayer(hero:GetPlayerId())
	if not player or not player.playerWearables then
		return
	end
	local invisibilityGetter = self.GetModifierInvisibilityLevel
	local ____invisibilityGetter_41
	if invisibilityGetter then
		____invisibilityGetter_41 = tonumber(invisibilityGetter(self))
	else
		____invisibilityGetter_41 = 0
	end
	local desiredRaw = ____invisibilityGetter_41
	local desired = math.max(0, math.floor(desiredRaw or 0))
	local delta = desired - self.__wearablesInvisibilityApplied
	if delta == 0 then
		return
	end
	player.playerWearables:addHeroWearablesInvisibilityLevel(hero, delta)
	self.__wearablesInvisibilityApplied = desired
end
function BaseModifier_CS.prototype.getMutexPlayer(self)
	local parent = self:GetParent()
	if not parent or not IsValid(nil, parent) then
		return nil
	end
	if not parent.IsRealHero or not parent:IsRealHero() then
		return nil
	end
	local ____opt_42 = parent.GetPlayerOwnerID
	local playerId = ____opt_42 and ____opt_42(parent) or -1
	if playerId < 0 then
		return nil
	end
	return MyGamePlayers:getPlayer(playerId)
end
--- 水平位移 Modifier 的 CS 基类：带属性系统 + 事件系统。
____exports.BaseModifierMotionHorizontal_CS = __TS__Class()
local BaseModifierMotionHorizontal_CS = ____exports.BaseModifierMotionHorizontal_CS
BaseModifierMotionHorizontal_CS.name = "BaseModifierMotionHorizontal_CS"
__TS__ClassExtends(
	BaseModifierMotionHorizontal_CS,
	WithTagRules(nil, WithAttributes(nil, WithEventHandler(nil, BaseModifierMotionHorizontal)))
)
function BaseModifierMotionHorizontal_CS.GetLocalizationCN(self)
	return nil
end
function BaseModifierMotionHorizontal_CS.prototype.Spawn(self)
	self._caster = self:GetCaster()
	self._parent = self:GetParent()
	self._ability = self:GetAbility()
end
function BaseModifierMotionHorizontal_CS.prototype.GetEntity(self)
	return self:GetParent()
end
function BaseModifierMotionHorizontal_CS.prototype.GetAddAttributesEntity(self)
	return { self:GetParent() }
end
function BaseModifierMotionHorizontal_CS.prototype.GetAddTagRulesEntity(self)
	return { self:GetParent() }
end
function BaseModifierMotionHorizontal_CS.prototype.GetSpecialValue(self, abilityName, key)
	local ability = self:GetAbility()
	return ability:GetSpecialValue(abilityName, key)
end
function BaseModifierMotionHorizontal_CS.prototype.GetSpecialValueRaw(self, abilityName, key)
	local ability = self:GetAbility()
	return ability:GetSpecialValueRaw(abilityName, key)
end
function BaseModifierMotionHorizontal_CS.prototype.GetAllAttackDamage(self, caster)
	if caster == nil then
		caster = self:GetCaster()
	end
	return MyGameAttribute:GetAttribute(caster, "total_attack_damage")
end
--- 垂直位移 Modifier 的 CS 基类：带属性系统 + 事件系统。
____exports.BaseModifierMotionVertical_CS = __TS__Class()
local BaseModifierMotionVertical_CS = ____exports.BaseModifierMotionVertical_CS
BaseModifierMotionVertical_CS.name = "BaseModifierMotionVertical_CS"
__TS__ClassExtends(
	BaseModifierMotionVertical_CS,
	WithTagRules(nil, WithAttributes(nil, WithEventHandler(nil, BaseModifierMotionVertical)))
)
function BaseModifierMotionVertical_CS.GetLocalizationCN(self)
	return nil
end
function BaseModifierMotionVertical_CS.prototype.Spawn(self)
	self._caster = self:GetCaster()
	self._parent = self:GetParent()
	self._ability = self:GetAbility()
end
function BaseModifierMotionVertical_CS.prototype.GetEntity(self)
	return self:GetParent()
end
function BaseModifierMotionVertical_CS.prototype.GetAddAttributesEntity(self)
	return { self:GetParent() }
end
function BaseModifierMotionVertical_CS.prototype.GetAddTagRulesEntity(self)
	return { self:GetParent() }
end
function BaseModifierMotionVertical_CS.prototype.GetSpecialValue(self, abilityName, key)
	local ability = self:GetAbility()
	return ability:GetSpecialValue(abilityName, key)
end
function BaseModifierMotionVertical_CS.prototype.GetSpecialValueRaw(self, abilityName, key)
	local ability = self:GetAbility()
	return ability:GetSpecialValueRaw(abilityName, key)
end
function BaseModifierMotionVertical_CS.prototype.GetAllAttackDamage(self, caster)
	if caster == nil then
		caster = self:GetCaster()
	end
	return MyGameAttribute:GetAttribute(caster, "total_attack_damage")
end
--- 同时具备水平+垂直位移的 Modifier CS 基类：带属性系统 + 事件系统。
____exports.BaseModifierMotionBoth_CS = __TS__Class()
local BaseModifierMotionBoth_CS = ____exports.BaseModifierMotionBoth_CS
BaseModifierMotionBoth_CS.name = "BaseModifierMotionBoth_CS"
__TS__ClassExtends(
	BaseModifierMotionBoth_CS,
	WithTagRules(nil, WithAttributes(nil, WithEventHandler(nil, BaseModifierMotionBoth)))
)
function BaseModifierMotionBoth_CS.GetLocalizationCN(self)
	return nil
end
function BaseModifierMotionBoth_CS.prototype.Spawn(self)
	self._caster = self:GetCaster()
	self._parent = self:GetParent()
	self._ability = self:GetAbility()
end
function BaseModifierMotionBoth_CS.prototype.GetEntity(self)
	return self:GetParent()
end
function BaseModifierMotionBoth_CS.prototype.GetAddAttributesEntity(self)
	return { self:GetParent() }
end
function BaseModifierMotionBoth_CS.prototype.GetAddTagRulesEntity(self)
	return { self:GetParent() }
end
function BaseModifierMotionBoth_CS.prototype.GetSpecialValue(self, abilityName, key)
	local ability = self:GetAbility()
	return ability:GetSpecialValue(abilityName, key)
end
function BaseModifierMotionBoth_CS.prototype.GetSpecialValueRaw(self, abilityName, key)
	local ability = self:GetAbility()
	return ability:GetSpecialValueRaw(abilityName, key)
end
function BaseModifierMotionBoth_CS.prototype.GetAllAttackDamage(self, caster)
	if caster == nil then
		caster = self:GetCaster()
	end
	return MyGameAttribute:GetAttribute(caster, "total_attack_damage")
end
return ____exports