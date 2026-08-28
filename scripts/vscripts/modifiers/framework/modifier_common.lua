--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "modifiers/framework/modifier_common"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__ArrayPushArray
local f = b.__TS__ArrayIncludes
local g = b.__TS__DecorateLegacy
local h = {}
local i = require("modifiers.eom_modifier.eom_modifier")
local j = i.EOMModifier
local k = i.registerEOMModifier
local l = c()
l.name = "modifier_common"
d(l, j)
function l.prototype.____constructor(self, ...)
	j.prototype.____constructor(self, ...)
	self.BaseAttackspeed = 0
	self.AttackDamage = 0
	self.CritChance = 0
	self.CritDamage = 0
	self.StatusHealth = 0
	self.StatusMana = 0
	self.ValidPositionCheckCount = 0
	self.IsCheckingValidPosition = false
end
function l.prototype.OnCreated(self, m)
	local n = self:GetParent():GetUnitName()
	local o = KeyValues.heroes[n]
	if o == nil then
		o = KeyValues.units[n]
	end
	local p = o
	if p ~= nil then
		if p.BaseAttackSpeed ~= nil then
			self.BaseAttackspeed = p.BaseAttackSpeed
		end
		if p.AttackDamageMin ~= nil and p.AttackDamageMax then
			self.AttackDamage = RandomFloatWrapper(p.AttackDamageMin, p.AttackDamageMax)
		end
		if p.CritChance ~= nil then
			self.CritChance = toFiniteNumber(p.CritChance, 0)
		end
		if p.CritDamage ~= nil then
			self.CritDamage = toFiniteNumber(p.CritDamage, 0)
		end
		if p.StatusHealth ~= nil then
			self.StatusHealth = toFiniteNumber(p.StatusHealth, 0)
		end
		if p.StatusMana ~= nil then
			self.StatusMana = toFiniteNumber(p.StatusMana, 0)
		end
	end
	if IsServer() then
		self:StartIntervalThink(1)
	end
end
function l.prototype.StaticState(self)
	return { [StateEnum.HEALTH_BAR] = true }
end
function l.prototype.OnIntervalThink(self)
	local q = self:GetParent()
	local r = q:GetAbsOrigin()
	if q:HasModifier("modifier_wisp") then
		self:StartIntervalThink(-1)
		return
	end
	if self.IsCheckingValidPosition == true then
		return
	end
	if not GridNav:IsValidPosition(r) then
		self:StartContinuousValidPositionCheck()
	end
end
function l.prototype.StartContinuousValidPositionCheck(self)
	self.ValidPositionCheckCount = 0
	self.IsCheckingValidPosition = true
	self:StartThink(0.1, "ContinuousValidPositionCheck", function()
		local q = self:GetParent()
		local r = q:GetAbsOrigin()
		if q:IsAlive() then
			if GridNav:IsValidPosition(r) then
				self.ValidPositionCheckCount = 0
				self.IsCheckingValidPosition = false
				return -1
			end
			self.ValidPositionCheckCount = self.ValidPositionCheckCount + 1
			if self.ValidPositionCheckCount >= 10 then
				self.IsCheckingValidPosition = false
				local s = DungeonManager:GetCurrentRoom()
				if s ~= nil then
					local t = s:GetNearestValidGridPosition(r)
					if t ~= nil then
						FindClearSpaceForUnit(q, t, true)
					end
				end
				return -1
			end
		end
		return 0.2
	end)
end
function l.prototype.CheckState(self)
	return { [MODIFIER_STATE_NO_HEALTH_BAR] = true }
end
function l.prototype.DeclareFunctions(self)
	local u = {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_CONSTANT,
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
		MODIFIER_PROPERTY_ATTACKSPEED_BASE_OVERRIDE,
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
		MODIFIER_PROPERTY_ATTACKSPEED_PERCENTAGE,
		MODIFIER_PROPERTY_EVASION_CONSTANT,
		MODIFIER_PROPERTY_ATTACK_RANGE_BONUS,
		MODIFIER_PROPERTY_COOLDOWN_PERCENTAGE,
		MODIFIER_PROPERTY_DISABLE_AUTOATTACK,
	}
	if self:GetParent():IsRealHero() then
		e(
			u,
			{
				MODIFIER_PROPERTY_HEAL_AMPLIFY_PERCENTAGE_TARGET,
				MODIFIER_EVENT_ON_ABILITY_FULLY_CAST,
				MODIFIER_EVENT_ON_ABILITY_START,
				MODIFIER_PROPERTY_MOVESPEED_MAX_OVERRIDE,
				MODIFIER_PROPERTY_HEALTH_BONUS,
				MODIFIER_PROPERTY_MANA_BONUS,
				MODIFIER_EVENT_ON_SPENT_MANA,
				MODIFIER_EVENT_ON_ABILITY_END_CHANNEL,
			}
		)
	end
	return u
end
function l.prototype.GetDisableAutoAttack(self)
	return 1
end
function l.prototype.GetModifierHealthBonus(self)
	return self:GetParent():GetMaxHealth() - GetBaseHealth(self:GetParent())
end
function l.prototype.GetModifierManaBonus(self)
	return self:GetParent():GetMaxMana() - GetBaseMana(self:GetParent())
end
function l.prototype.GetModifierPercentageCooldown(self, v)
	return GetCooldownReduction(self:GetParent())
end
function l.prototype.GetModifierMoveSpeed_MaxOverride(self)
	return 8000
end
function l.prototype.GetModifierMoveSpeedBonus_Percentage(self)
	return GetMovespeedAmplify(self:GetParent())
end
function l.prototype.GetModifierAttackSpeedPercentage(self)
	return -GetAttackspeedReduction(self:GetParent())
end
function l.prototype.StaticProperty(self)
	return {
		[PropertyFunction.BASE_HEALTH] = self.StatusHealth,
		[PropertyFunction.BASE_MANA] = self.StatusMana,
		[PropertyFunction.BASE_ATTACK] = self.AttackDamage,
		[PropertyFunction.CRIT_CHANCE] = self.CritChance,
		[PropertyFunction.CRIT_DAMAGE] = self.CritDamage,
	}
end
function l.prototype.GetModifierMoveSpeedBonus_Constant(self)
	return GetMovespeed(self:GetParent()) + GetMovespeedNotCalculated(self:GetParent())
end
function l.prototype.GetModifierEvasion_Constant(self)
	return GetEvasion(self:GetParent())
end
function l.prototype.GetModifierAttackSpeedBonus_Constant(self)
	return GetAttackspeed(self:GetParent())
end
function l.prototype.GetModifierAttackRangeBonus(self)
	if self:GetParent():IsRangedAttacker() then
		return GetAttackRange(self:GetParent()) + GetAttackRangeRanger(self:GetParent())
	else
		return GetAttackRange(self:GetParent()) + GetAttackRangeMelee(self:GetParent())
	end
end
function l.prototype.GetModifierHealAmplify_PercentageTarget(self)
	return GetHealAmplify(self:GetParent())
end
function l.prototype.OnAbilityEndChannel(self, v)
	if v.unit ~= self:GetParent() then
		return
	end
	Event:Fire(
		"ability_end_channel",
		{ ability = v.ability, caster = v.unit, position = v.ability:GetCursorPosition(), abilityTag = v.ability:GetAbilityTag() }
	)
end
function l.prototype.OnAbilityFullyCast(self, v)
	if v.unit ~= self:GetParent() then
		return
	end
	Event:Fire(
		"ability_cast_complete",
		{ ability = v.ability, caster = v.unit, position = v.ability:GetCursorPosition(), abilityTag = v.ability:GetAbilityTag() }
	)
	if v.ability:UseCharges() then
		v.ability:EndCooldown()
		if v.ability:GetCharges() == 0 then
			v.ability:StartCooldown(v.ability.__ChargeRestoreTime - GameRules:GetGameTime())
		end
	end
	if v.ability:GetCastCooldown() > 0 then
		v.ability:SetActivated(false)
		self:StartThink(v.ability:GetCastCooldown(), DoUniqueString("CastCooldown"), function()
			v.ability:SetActivated(true)
			return -1
		end)
	end
end
function l.prototype.OnAbilityStart(self, v)
	if v.unit ~= self:GetParent() then
		return
	end
	Event:Fire(
		"ability_cast_start",
		{ ability = v.ability, caster = v.unit, position = v.ability:GetCursorPosition(), abilityTag = v.ability:GetAbilityTag() }
	)
end
function l.prototype.OnSpentMana(self, v)
	local w = v.cost
	if w > 0 then
		Event:Fire("spent_mana", { unit = v.unit, ability = v.ability, cost = w })
	end
end
function l.prototype.EventListener(self)
	return {
		property_changed = function(x, y)
			local q = self:GetParent()
			if y.key ~= q:entindex() then
				return
			end
			if f({ "health", "health_amplify", "defense_intensity" }, y.propertyId) then
				if q:IsHero() then
					q:CalculateStatBonus(true)
				else
					local z = q:GetMaxHealth()
					local A = q:GetHealthPercent_Engine()
					if not LargeNumberHealth:Refresh(q) then
						q:SetMaxHealth(z)
						q:SetBaseMaxHealth(z)
						q:SetHealth(math.max(1, z * A * 0.01))
					end
					q:CalculateGenericBonuses()
				end
			elseif f({ "mana", "mana_amplify" }, y.propertyId) then
				if q:IsHero() then
					q:CalculateStatBonus(true)
				else
					q:CalculateGenericBonuses()
				end
			end
		end,
		dungeon_start = function(x, y)
			local q = self:GetParent()
			if q:IsHero() then
				q:SetHealth(q:GetMaxHealth())
				q:SetMana(q:GetMaxMana())
			end
		end,
	}
end
l = g(
	{
		k(
			a,
			{
				IsHidden = true,
				IsDebuff = false,
				IsPurgable = false,
				IsPurgeException = false,
				AllowIllusionDuplicate = false,
				RemoveOnDeath = false,
			}
		),
	},
	l
)
return h