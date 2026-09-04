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
local ____modifier_base = require("modifiers.class.modifier_base")
local BaseModifier_CS = ____modifier_base.BaseModifier_CS
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerModifier = ____dota_ts_adapter.registerModifier
____exports.modifier_energy_shield_recharge_cooldown = __TS__Class()
local modifier_energy_shield_recharge_cooldown = ____exports.modifier_energy_shield_recharge_cooldown
modifier_energy_shield_recharge_cooldown.name = "modifier_energy_shield_recharge_cooldown"
__TS__ClassExtends(modifier_energy_shield_recharge_cooldown, BaseModifier_CS)
function modifier_energy_shield_recharge_cooldown.GetLocalizationCN(self)
	return { name = "护盾充能冷却中", description = "护盾充能冷却中" }
end
function modifier_energy_shield_recharge_cooldown.prototype.GetTexture(self)
	return "miniboss_minion_deflecting_shield"
end
function modifier_energy_shield_recharge_cooldown.prototype.IsHidden(self)
	return false
end
function modifier_energy_shield_recharge_cooldown.prototype.IsDebuff(self)
	return true
end
function modifier_energy_shield_recharge_cooldown.prototype.IsPurgable(self)
	return false
end
function modifier_energy_shield_recharge_cooldown.prototype.IsPurgeException(self)
	return false
end
modifier_energy_shield_recharge_cooldown = __TS__DecorateLegacy(
	{ registerModifier(nil, "modifier_energy_shield_recharge_cooldown") },
	modifier_energy_shield_recharge_cooldown
)
____exports.modifier_energy_shield_recharge_cooldown = modifier_energy_shield_recharge_cooldown
____exports.modifier_base_energy_shield = __TS__Class()
local modifier_base_energy_shield = ____exports.modifier_base_energy_shield
modifier_base_energy_shield.name = "modifier_base_energy_shield"
__TS__ClassExtends(modifier_base_energy_shield, BaseModifier_CS)
function modifier_base_energy_shield.prototype.____constructor(self, ...)
	BaseModifier_CS.prototype.____constructor(self, ...)
	self._currentShield = 0
	self._totalShield = 0
end
function modifier_base_energy_shield.GetLocalizationCN(self)
	return {
		name = "护盾",
		description = "抵挡大部分伤害，但无法抵挡纯粹伤害。受到伤害后3秒内不会恢复；开始恢复后每秒恢复25%。",
	}
end
function modifier_base_energy_shield.prototype.GetTexture(self)
	return "miniboss_minion_deflecting_shield"
end
function modifier_base_energy_shield.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	self:SetHasCustomTransmitterData(true)
	self:RefreshShieldState()
	self:StartIntervalThink(FrameTime())
end
function modifier_base_energy_shield.prototype.OnRefresh(self)
	if not IsServer() then
		return
	end
	self:SetHasCustomTransmitterData(true)
	self:RefreshShieldState()
end
function modifier_base_energy_shield.prototype.DestroyOnExpire(self)
	return false
end
function modifier_base_energy_shield.prototype.DeclareEvents(self)
	return { BusinessEvents.ON_DEAL_DAMAGE }
end
function modifier_base_energy_shield.prototype.OnDealDamage_CS(self, event)
	self:HandleCombatEvent(event)
end
function modifier_base_energy_shield.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	if not IsValid(nil, self._parent) then
		self:Destroy()
		return
	end
	local totalEnergyShield = self:GetTotalEnergyShield()
	if totalEnergyShield <= 0 then
		self._parent.__current_energy_shield__ = 0
		self:Destroy()
		return
	end
	local currentEnergyShield = self._parent:GetCurrentEnergyShield()
	if currentEnergyShield >= totalEnergyShield then
		self:RefreshShieldState()
		return
	end
	local ____self__parent___last_energy_shield_combat_time___0 = self._parent.__last_energy_shield_combat_time__
	if ____self__parent___last_energy_shield_combat_time___0 == nil then
		____self__parent___last_energy_shield_combat_time___0 = 0
	end
	local lastCombatTime = ____self__parent___last_energy_shield_combat_time___0
	if GameRules:GetGameTime() - lastCombatTime < ____exports.modifier_base_energy_shield.RECHARGE_DELAY then
		self:RefreshShieldState()
		return
	end
	local rechargeAmount = totalEnergyShield
		* (____exports.modifier_base_energy_shield.RECHARGE_PCT_PER_SECOND / 100)
		* FrameTime()
	self._parent.__current_energy_shield__ = math.min(totalEnergyShield, currentEnergyShield + rechargeAmount)
	self:RefreshShieldState()
end
function modifier_base_energy_shield.prototype.RecordCombat(self)
	if not IsServer() or not IsValid(nil, self._parent) then
		return
	end
	self._parent.__last_energy_shield_combat_time__ = GameRules:GetGameTime()
	self._parent:AddNewModifier(
		self._parent,
		nil,
		____exports.modifier_energy_shield_recharge_cooldown.name,
		{ duration = ____exports.modifier_base_energy_shield.RECHARGE_DELAY }
	)
	self:RefreshShieldState()
end
function modifier_base_energy_shield.prototype.RefreshShieldState(self)
	if not IsValid(nil, self._parent) then
		return
	end
	self._currentShield = self._parent:GetCurrentEnergyShield()
	self._totalShield = self:GetTotalEnergyShield()
	self:SetStackCount(math.floor(self._currentShield))
	if IsServer() then
		self:SendBuffRefreshToClients()
	end
end
function modifier_base_energy_shield.prototype.AddCustomTransmitterData(self)
	return { current_shield = self._currentShield, total_shield = self._totalShield }
end
function modifier_base_energy_shield.prototype.HandleCustomTransmitterData(self, data)
	self._currentShield = data.current_shield or 0
	self._totalShield = data.total_shield or 0
end
function modifier_base_energy_shield.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_INCOMING_DAMAGE_CONSTANT }
end
function modifier_base_energy_shield.prototype.GetModifierIncomingDamageConstant(self, event)
	local currentShieldClientFallback = math.max(self._currentShield or 0, self:GetStackCount() or 0)
	local ____math_floor_2 = math.floor
	local ____IsServer_result_1
	if IsServer() then
		____IsServer_result_1 = self:GetTotalEnergyShield()
	else
		____IsServer_result_1 = self._totalShield
	end
	local totalEnergyShield = ____math_floor_2(____IsServer_result_1)
	local ____math_floor_4 = math.floor
	local ____IsServer_result_3
	if IsServer() then
		____IsServer_result_3 = self:GetParent():GetCurrentEnergyShield()
	else
		____IsServer_result_3 = currentShieldClientFallback
	end
	local currentEnergyShield = ____math_floor_4(____IsServer_result_3)
	if not IsServer() then
		if event.report_max then
			return math.max(totalEnergyShield, currentEnergyShield)
		end
		if currentEnergyShield <= 0 then
			return 0
		end
		return currentEnergyShield
	end
	return 0
end
function modifier_base_energy_shield.prototype.IsHidden(self)
	return true
end
function modifier_base_energy_shield.prototype.IsPurgable(self)
	return false
end
function modifier_base_energy_shield.prototype.IsPurgeException(self)
	return false
end
function modifier_base_energy_shield.prototype.IsPermanent(self)
	return true
end
function modifier_base_energy_shield.prototype.RemoveOnDeath(self)
	return false
end
function modifier_base_energy_shield.prototype.HandleCombatEvent(self, event)
	if not IsServer() then
		return
	end
	if (event.final_damage or 0) <= 0 and (event.shield_absorbed_value or 0) <= 0 then
		return
	end
	local ____opt_5 = event.source
	if (____opt_5 and ____opt_5.damage_tags) == DamageTag.DOT then
		return
	end
	self:RecordCombat()
end
function modifier_base_energy_shield.prototype.GetTotalEnergyShield(self)
	local ____MyGameAttribute_HasAttributes_result_7
	if MyGameAttribute:HasAttributes(self._parent) then
		____MyGameAttribute_HasAttributes_result_7 =
			math.max(0, MyGameAttribute:GetAttribute(self._parent, "total_energy_shield") or 0)
	else
		____MyGameAttribute_HasAttributes_result_7 = 0
	end
	return ____MyGameAttribute_HasAttributes_result_7
end
modifier_base_energy_shield.RECHARGE_DELAY = 3
modifier_base_energy_shield.RECHARGE_PCT_PER_SECOND = 25
modifier_base_energy_shield =
	__TS__DecorateLegacy({ registerModifier(nil, "modifier_base_energy_shield") }, modifier_base_energy_shield)
____exports.modifier_base_energy_shield = modifier_base_energy_shield
return ____exports