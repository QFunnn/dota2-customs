--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "override/CDOTABaseAbility"
local b = require("lualib_bundle")
local c = b.__TS__StringStartsWith
local d = b.__TS__StringSubstring
local e = b.__TS__ArrayForEach
DOTABaseAbility = IsServer() and CDOTABaseAbility or C_DOTABaseAbility
DOTABaseAbility.IsAbility = function(self)
	return true
end
DOTABaseAbility.SaveData = function(self, f, g)
	if not IsValid(self) then
		return
	end
	local h = self:GetCaster()
	if not IsValid(h) then
		return
	end
	h:SaveData(self:GetAbilityName() .. f, g)
end
DOTABaseAbility.LoadData = function(self, f, i)
	local h = self:GetCaster()
	local j = h._saveData_
	local k = j and j[self:GetAbilityName() .. f]
	if k == nil then
		k = i
	end
	return k
end
DOTABaseAbility.PRD = function(self, l, m)
	return PRD(nil, self:GetCaster(), l, m or self:GetName())
end
if DOTABaseAbility.GetLevelSpecialValueFor_Engine == nil then
	DOTABaseAbility.GetLevelSpecialValueFor_Engine = DOTABaseAbility.GetLevelSpecialValueFor
end
if DOTABaseAbility.GetSpecialValueFor_Engine == nil then
	DOTABaseAbility.GetSpecialValueFor_Engine = DOTABaseAbility.GetSpecialValueFor
end
DOTABaseAbility.GetLevelSpecialValueFor = function(self, f, n, h)
	if not IsValid(self) then
		return 0
	end
	h = h or self:GetCaster()
	local o = self:GetAbilityName()
	local p
	if self:IsItem() then
		p = KeyValues.items[o]
	else
		p = KeyValues.abilities[o]
	end
	local q = p
	if q == nil then
		return 0
	end
	local r = q.AbilityValues
	if r == nil then
		r = {}
	end
	local s = r
	local t = q[f]
	if t == nil then
		t = s[f]
	end
	local u = t
	local v = GetAbilityValues(u, n, h)
	if f == "abilitycharges" then
		v = v + GetAbilityChargeByType(nil, self)
	end
	return AbilityUpgrade:GetUpgradedValue(h, o, n, f, v)
end
DOTABaseAbility.GetSpecialValueFor = function(self, f, h)
	return self:GetLevelSpecialValueFor(f, self:GetLevel(), h)
end
DOTABaseAbility.GetSpecialValue = function(self)
	local w = self.__AbilityValueEntries
	if w == nil then
		return
	end
	do
		local x = 0
		while x < #w do
			local y = w[x + 1]
			self[y.propertyKey] = self:GetSpecialValueFor(y.specialValueKey)
			x = x + 1
		end
	end
end
DOTABaseAbility.IncrementStackCount = function(self, z, A)
	if A == nil then
		A = false
	end
	if self.__StackCount == nil then
		self.__StackCount = 0
	end
	self.__StackCount = self.__StackCount + (z or 1)
	self:RefreshStaticProperty()
	if A and self:IsItem() then
		self:GetCaster():UpdateAbilityNetData()
	end
end
DOTABaseAbility.DecrementStackCount = function(self, z, A)
	if A == nil then
		A = false
	end
	if self.__StackCount == nil then
		self.__StackCount = 0
	end
	self.__StackCount = self.__StackCount - (z or 1)
	self:RefreshStaticProperty()
	if A and self:IsItem() then
		self:GetCaster():UpdateAbilityNetData()
	end
end
DOTABaseAbility.SetStackCount = function(self, z, A)
	if A == nil then
		A = false
	end
	self.__StackCount = z
	self:RefreshStaticProperty()
	if A and self:IsItem() then
		self:GetCaster():UpdateAbilityNetData()
	end
end
DOTABaseAbility.GetStackCount = function(self)
	return self.__StackCount or 0
end
DOTABaseAbility.RefreshStaticProperty = function(self)
	local h = self:GetCaster()
	if self.StaticProperty ~= nil then
		for B, g in pairs(self:StaticProperty()) do
			if PROPERTY_MAP_REVERSE[B] then
				PropertySystem:AddStaticProperty(
					h:entindex(),
					PROPERTY_MAP_REVERSE[B],
					self:GetName() .. tostring(self:entindex()),
					g
				)
			end
		end
	end
end
DOTABaseAbility.GetAbilityTag = function(self)
	local C = KeyValues.abilities[self:GetAbilityName()]
	if C ~= nil then
		C = C.AbilityTag
	end
	local D = C
	if D == nil then
		D = "None"
	end
	local E = D
	return AbilityTag[E]
end
DOTABaseAbility.GetMaxCharges = function(self)
	local F = self:GetSpecialValueFor("abilitycharges")
	if F > 0 then
		return 1 + F
	end
	return 0
end
DOTABaseAbility.GetCharges = function(self)
	return self.__Charge
end
DOTABaseAbility.GetChargeRestoreTime = function(self)
	local G = self:GetEffectiveCooldown(self:GetLevel() - 1)
	local E = self:GetAbilityTag()
	local h = self:GetCaster()
	repeat
		local H = E
		local I = H == AbilityTag.Defense
		if I then
			return G * (1 - GetAbilityChargeDefenseTime(h) * 0.01)
		end
		do
			return G
		end
	until true
end
DOTABaseAbility.IsChargeCooldownFrozen = function(self)
	return self.__IsChargeCooldownFrozen == true
end
DOTABaseAbility.GetChargeCooldownRemaining = function(self)
	if self:IsChargeCooldownFrozen() then
		return self.__ChargeFrozenCooldownRemaining or 0
	end
	return math.max(0, (self.__ChargeRestoreTime or GameRules:GetGameTime()) - GameRules:GetGameTime())
end
DOTABaseAbility.AddParticle = function(self, J)
	if self.__ParticleIDs == nil then
		self.__ParticleIDs = {}
	end
	local K = self.__ParticleIDs
	K[#K + 1] = J
end
DOTABaseAbility.DestroyParticles = function(self)
	if self.__ParticleIDs ~= nil then
		for x, J in ipairs(self.__ParticleIDs) do
			ParticleManager:DestroyParticle(J, false)
			ParticleManager:ReleaseParticleIndex(J)
		end
	end
	self.__ParticleIDs = {}
end
DOTABaseAbility.AddWarningParticle = function(self, J)
	if self.__WarningParticleIDs == nil then
		self.__WarningParticleIDs = {}
	end
	local L = self.__WarningParticleIDs
	L[#L + 1] = J
end
DOTABaseAbility.DestroyWarningParticles = function(self, M)
	if M == nil then
		M = false
	end
	if self.__WarningParticleIDs == nil then
		return
	end
	for N, O in ipairs(self.__WarningParticleIDs) do
		ParticleManager:DestroyParticle(O, M)
		ParticleManager:ReleaseParticleIndex(O)
	end
	self.__WarningParticleIDs = {}
end
DOTABaseAbility.LineWarning = function(self, P, Q, R, S, T)
	local J = ParticleManager:CreateParticleForce(
		"particles/generic_gameplay/creep_linear_warning_fx.vpcf",
		PATTACH_CUSTOMORIGIN,
		nil
	)
	local U = P
	local V = P
	local W = Q
	local X = Q
	if U.GetAbsOrigin ~= nil then
		ParticleManager:SetParticleControlEnt(J, 0, U, PATTACH_ABSORIGIN_FOLLOW, nil, U:GetAbsOrigin(), true)
	else
		ParticleManager:SetParticleControl(J, 0, V)
	end
	if W.GetAbsOrigin ~= nil then
		ParticleManager:SetParticleControlEnt(J, 1, W, PATTACH_ABSORIGIN_FOLLOW, nil, W:GetAbsOrigin(), true)
	else
		ParticleManager:SetParticleControl(J, 1, X)
	end
	if T == nil then
		T = S
		S = R
	end
	ParticleManager:SetParticleControl(J, 2, Vector(T, R, S))
	ParticleManager:SetParticleControl(J, 15, Vector(1, 0, 0))
	self:AddWarningParticle(J)
	return J
end
DOTABaseAbility.CircleWarning = function(self, P, Y, T)
	local Z = P
	local _ = P
	local J = ParticleManager:CreateParticleForce("particles/warning/circular.vpcf", PATTACH_CUSTOMORIGIN, nil)
	if Z.GetAbsOrigin ~= nil then
		ParticleManager:SetParticleControlEnt(J, 0, Z, PATTACH_ABSORIGIN_FOLLOW, nil, Z:GetAbsOrigin(), true)
		ParticleManager:SetParticleControlEnt(J, 1, Z, PATTACH_ABSORIGIN_FOLLOW, nil, Z:GetAbsOrigin(), true)
	else
		ParticleManager:SetParticleControl(J, 0, _)
		ParticleManager:SetParticleControl(J, 1, _)
	end
	ParticleManager:SetParticleControl(J, 2, Vector(Y, T, 0))
	self:AddWarningParticle(J)
	return J
end
DOTABaseAbility.SectorWarning = function(self, P, a0, Y, a1, T)
	local J = ParticleManager:CreateParticleForce("particles/warning/sector.vpcf", PATTACH_CUSTOMORIGIN, nil)
	ParticleManager:SetParticleControlTransformForward(J, 0, P, a0)
	ParticleManager:SetParticleControl(J, 1, Vector(Y, a1, T))
	self:AddWarningParticle(J)
	return J
end
DOTABaseAbility.TruncatedSectorWarning = function(self, P, a0, a2, a3, a1, T)
	local J =
		ParticleManager:CreateParticleForce("particles/warning/creep_sector_waring_fx.vpcf", PATTACH_CUSTOMORIGIN, nil)
	ParticleManager:SetParticleControlTransformForward(J, 0, P, a0)
	ParticleManager:SetParticleControl(J, 1, Vector(a2, a3, a1))
	ParticleManager:SetParticleControl(J, 2, Vector(a3, T, 0))
	self:AddWarningParticle(J)
	return J
end
DOTALuaAbility = IsServer() and CDOTA_Ability_Lua or C_DOTA_Ability_Lua
if DOTALuaAbility.GetCooldown_Engine == nil then
	DOTALuaAbility.GetCooldown_Engine = DOTALuaAbility.GetCooldown
end
DOTALuaAbility.GetCooldown = function(self, n)
	local a4 = GetCooldownReductionByTag(nil, self)
	return self:GetCooldown_Engine(n)
		* (1 - a4 * COOLDOWN_REDUCTION_RATE / (1 + a4 * COOLDOWN_REDUCTION_RATE) * COOLDOWN_REDUCTION_CAP)
end
if IsServer() then
	if CDOTABaseAbility.SetFrozenCooldown_Engine == nil then
		CDOTABaseAbility.SetFrozenCooldown_Engine = CDOTABaseAbility.SetFrozenCooldown
	end
	CDOTABaseAbility.SetFrozenCooldown = function(self, a5)
		self:SetFrozenCooldown_Engine(a5)
		local h = self:GetCaster()
		local a6 = GameRules:GetGameTime()
		local a7 = self:GetMaxCharges() > 0 and self:GetCharges() < self:GetMaxCharges()
		if a5 then
			if not self:IsChargeCooldownFrozen() then
				self.__IsChargeCooldownFrozen = true
				self.__ChargeFrozenCooldownRemaining = a7 and math.max(0, self.__ChargeRestoreTime - a6) or 0
			end
		elseif self:IsChargeCooldownFrozen() then
			if a7 then
				self.__ChargeRestoreTime = a6 + (self.__ChargeFrozenCooldownRemaining or 0)
			else
				self.__ChargeRestoreTime = a6
			end
			self.__IsChargeCooldownFrozen = false
			self.__ChargeFrozenCooldownRemaining = 0
		end
		if IsValid(h) then
			h:UpdateAbilityNetData()
		end
	end
	CDOTABaseAbility.__OnCreated = function(self)
		self.__Charge = 0
		self.__ChargeRestoreTime = GameRules:GetGameTime()
		self.__IsChargeCooldownFrozen = false
		self.__ChargeFrozenCooldownRemaining = 0
		local h = self:GetCaster()
		local a8 = h:GetPlayerOwnerID()
		if self.StaticProperty ~= nil then
			for B, g in pairs(self:StaticProperty()) do
				if PROPERTY_MAP_REVERSE[B] then
					PropertySystem:AddStaticProperty(
						h:entindex(),
						PROPERTY_MAP_REVERSE[B],
						self:GetName() .. tostring(self:entindex()),
						g
					)
				end
			end
		end
		if self.DynamicProperty ~= nil then
			for B, a9 in pairs(self:DynamicProperty()) do
				if PROPERTY_MAP_REVERSE[B] then
					PropertySystem:RegisterDynamicProperty(
						h:entindex(),
						PROPERTY_MAP_REVERSE[B],
						self:GetName() .. tostring(self:entindex()),
						a9
					)
				end
			end
		end
		if self.EventListener ~= nil then
			if self.__EventIDList == nil then
				self.__EventIDList = {}
			end
			for aa, ab in pairs(self:EventListener()) do
				local ac = self.__EventIDList
				ac[#ac + 1] = Event:RegisterForOwner(aa, ab, h)
			end
		end
		local o = self:GetAbilityName()
		local ad = KeyValues.abilities[o]
		if ad == nil then
			ad = KeyValues.items[o]
		end
		local ae = ad
		if ae ~= nil and ae.AbilityValues ~= nil and ae.AbilityValues ~= "" then
			for af, ag in pairs(ae.AbilityValues) do
				if c(af, "item_") then
					local g = GetAbilityValues(ag, self:GetLevel(), h)
					local B = d(af, 5)
					if PROPERTY_MAP[B] ~= nil then
						PropertySystem:AddStaticProperty(
							h:entindex(),
							B,
							("item_" .. self:GetName()) .. tostring(self:entindex()),
							g
						)
					end
				end
			end
		end
		local E = self:GetAbilityTag()
		if
			E == AbilityTag.Attack
			or E == AbilityTag.Skill
			or E == AbilityTag.Dodge
			or E == AbilityTag.Defense
			or E == AbilityTag.Ultimate
		then
			self:StartThink(0, "ChargeRestore", function()
				if self:GetMaxCharges() <= 0 then
					return 0
				end
				if self:GetChargeRestoreTime() <= 0 then
					return 0
				end
				if self:IsChargeCooldownFrozen() then
					return 0
				end
				if self:GetCharges() < self:GetMaxCharges() and GameRules:GetGameTime() >= self.__ChargeRestoreTime then
					self:RestoreCharges()
				end
			end)
		end
		if
			IsServer()
			and ae ~= nil
			and Service:GetPlayerSetting(a8, "setting_switch_" .. tostring(ae.AbilityTag), false)
		then
			self:ToggleAutoCast()
		end
		self:OnCreated()
	end
	CDOTABaseAbility.OnCreated = function(self) end
	CDOTABaseAbility.__OnRefresh = function(self)
		self.__Charge = 0
		self.__ChargeRestoreTime = GameRules:GetGameTime()
		self.__IsChargeCooldownFrozen = false
		self.__ChargeFrozenCooldownRemaining = 0
		local h = self:GetCaster()
		if self.StaticProperty ~= nil then
			for B, g in pairs(self:StaticProperty()) do
				if PROPERTY_MAP_REVERSE[B] then
					PropertySystem:AddStaticProperty(
						h:entindex(),
						PROPERTY_MAP_REVERSE[B],
						self:GetName() .. tostring(self:entindex()),
						g
					)
				end
			end
		end
		local o = self:GetAbilityName()
		local ah = KeyValues.abilities[o]
		if ah == nil then
			ah = KeyValues.items[o]
		end
		local ae = ah
		if ae ~= nil and ae.AbilityValues ~= nil and ae.AbilityValues ~= "" then
			for af, ag in pairs(ae.AbilityValues) do
				if c(af, "item_") then
					local g = GetAbilityValues(ag, self:GetLevel(), h)
					local B = d(af, 5)
					if PROPERTY_MAP[B] ~= nil then
						PropertySystem:AddStaticProperty(
							h:entindex(),
							B,
							("item_" .. self:GetName()) .. tostring(self:entindex()),
							g
						)
					end
				end
			end
		end
		self:OnRefresh()
	end
	CDOTABaseAbility.OnRefresh = function(self) end
	CDOTABaseAbility.__OnDestroy = function(self)
		local h = self:GetCaster()
		PropertySystem:RemoveStaticProperty(h:entindex(), self:GetName() .. tostring(self:entindex()))
		PropertySystem:RemoveStaticProperty(h:entindex(), ("item_" .. self:GetName()) .. tostring(self:entindex()))
		PropertySystem:UnregisterDynamicProperty(h:entindex(), self:GetName() .. tostring(self:entindex()))
		PropertySystem:ClearAbilityStaticProperties(self)
		if self.__EventIDList ~= nil then
			e(self.__EventIDList, function(N, ai)
				Event:Unregister(ai)
			end)
		end
		self:DestroyParticles()
		self:OnDestroy()
	end
	CDOTABaseAbility.OnDestroy = function(self) end
	CDOTABaseAbility.IsAbilityReady = function(self)
		local aj = self:GetCaster()
		local ak = self:GetBehaviorInt()
		if not IsValid(aj) then
			return false
		end
		if
			not (aj:IsAlive() or bit.band(ak, DOTA_ABILITY_BEHAVIOR_UNRESTRICTED) == DOTA_ABILITY_BEHAVIOR_UNRESTRICTED)
		then
			return false
		end
		local al = aj:GetCurrentActiveAbility()
		if IsValid(al) and al:IsInAbilityPhase() then
			return false
		end
		if self:GetLevel() <= 0 then
			return false
		end
		if self:IsHidden() then
			return false
		end
		if not self:IsActivated() then
			return false
		end
		if not self:IsCooldownReady() then
			return false
		end
		if not self:IsOwnersManaEnough() then
			return false
		end
		if not self:IsOwnersGoldEnough(aj:GetPlayerOwnerID()) then
			return false
		end
		if aj:IsHexed() or aj:IsCommandRestricted() then
			return false
		end
		if
			bit.band(ak, DOTA_ABILITY_BEHAVIOR_IGNORE_PSEUDO_QUEUE) ~= DOTA_ABILITY_BEHAVIOR_IGNORE_PSEUDO_QUEUE
			and aj:IsStunned()
		then
			return false
		end
		if not self:IsItem() and not self:IsPassive() and aj:IsSilenced() then
			return false
		end
		if not self:IsItem() and self:IsPassive() and aj:PassivesDisabled() then
			return false
		end
		if self:IsItem() and not self:IsPassive() and aj:IsMuted() then
			return false
		end
		if
			bit.band(ak, DOTA_ABILITY_BEHAVIOR_IGNORE_CHANNEL + DOTA_ABILITY_BEHAVIOR_IMMEDIATE)
				~= DOTA_ABILITY_BEHAVIOR_IGNORE_CHANNEL + DOTA_ABILITY_BEHAVIOR_IMMEDIATE
			and aj:IsChanneling()
		then
			return false
		end
		if not self:IsFullyCastable() then
			return false
		end
		return true
	end
	CDOTABaseAbility.CanProcsCast = function(self)
		if not IsValid(self) then
			return false
		end
		if not self:IsAbility() then
			return false
		end
		if self:IsItem() then
			return false
		end
		if self:IsPassive() then
			return false
		end
		if self:IsToggle() then
			return false
		end
		if not self:ProcsMagicStick() then
			return false
		end
		return true
	end
	CDOTABaseAbility.ReduceCooldown = function(self, am)
		local an = self:GetCooldownTimeRemaining()
		self:EndCooldown()
		if an > am then
			self:StartCooldown(an - am)
		end
		self:RefreshCharges()
	end
	CDOTABaseAbility.OnController = function(self, _, a0) end
	CDOTABaseAbility.GetDamageType = function(self)
		local ao = KeyValues.abilities[self:GetAbilityName()]
		if ao ~= nil then
			ao = ao.AbilityDamageType
		end
		local ap = ao
		if ap == nil then
			ap = "DAMAGE_TYPE_NONE"
		end
		local aq = ap
		return EOM_DAMAGE_TYPES[aq]
	end
	CDOTABaseAbility.UseCooldown = function(self)
		self:UseResources(false, false, false, true)
	end
	CDOTABaseAbility.UseCharges = function(self)
		if self.__Charge > 0 then
			local ar = self:IsChargeCooldownFrozen()
			local as = self.__ChargeFrozenCooldownRemaining or 0
			self.__Charge = self.__Charge - 1
			if self.__ChargeRestoreTime < GameRules:GetGameTime() then
				self.__ChargeRestoreTime = GameRules:GetGameTime() + self:GetChargeRestoreTime()
			end
			if ar then
				self.__ChargeFrozenCooldownRemaining = as > 0 and as
					or math.max(0, self.__ChargeRestoreTime - GameRules:GetGameTime())
			end
			self:GetCaster():UpdateAbilityNetData()
			return true
		end
		return false
	end
	CDOTABaseAbility.RestoreCharges = function(self, at)
		if at == nil then
			at = 1
		end
		self.__Charge = math.min(self.__Charge + at, self:GetMaxCharges())
		if self.__Charge < self:GetMaxCharges() then
			self.__ChargeRestoreTime = GameRules:GetGameTime() + self:GetChargeRestoreTime()
		else
			self.__ChargeRestoreTime = GameRules:GetGameTime()
			self.__IsChargeCooldownFrozen = false
			self.__ChargeFrozenCooldownRemaining = 0
		end
		self:GetCaster():UpdateAbilityNetData()
	end
	CDOTABaseAbility.GetCastCooldown = function(self)
		return 0
	end
	CDOTABaseAbility.GetSupportCastPoint = function(self)
		local h = self:GetCaster()
		local a8 = h:GetPlayerOwnerID()
		local au = Service:GetPlayerSetting(a8, "aim_mode", 2)
		local _ = self:GetCursorPosition()
		if au == 3 then
			return _
		elseif au == 2 then
			local av = Service:GetPlayerSetting(a8, "Setting_aim_distance", 300)
			local aw = FindUnitsInRadius(
				h:GetTeamNumber(),
				_,
				nil,
				av,
				DOTA_UNIT_TARGET_TEAM_ENEMY,
				DOTA_UNIT_TARGET_HEROES_AND_CREEPS,
				DOTA_UNIT_TARGET_FLAG_NONE,
				FIND_CLOSEST,
				false
			)
			if aw[1] then
				return aw[1]:GetAbsOrigin()
			end
		end
		return _
	end
end
if IsServer() then
	CDOTABaseAbility.LockFacingTarget = function(self, ax, ay, T)
		if ay == nil then
			ay = 1
		end
		local h = self:GetCaster()
		if not IsValid(h) or not IsValid(ax) then
			return
		end
		local az = T or self:GetCastPoint()
		local aA = az >= 0 and GameRules:GetGameTime() + az or -1
		local aB = h:GetLocalAngles().y
		self:StartThink(0, "LockFacingTarget", function()
			if not IsValid(self) or not IsValid(h) or not IsValid(ax) or not h:IsAlive() or not ax:IsAlive() then
				return -1
			end
			local aC = CalcDirection2D(ax:GetAbsOrigin(), h)
			local aD = VectorToAngles(aC).y
			local aE = AngleDiff(aD, aB)
			local aF = ay * FrameTime()
			local aG = math.max(-aF, math.min(aF, aE))
			local aH = aB + aG
			if math.abs(aE) <= aF then
				aH = aD
			end
			h:SetLocalAngles(0, aH, 0)
			h:SetForwardVector(AnglesToVector(h:GetLocalAngles()))
			h:FaceTowards(h:GetAbsOrigin() + h:GetForwardVector())
			aB = aH
			if aA >= 0 and GameRules:GetGameTime() >= aA then
				return -1
			end
			return 0
		end)
	end
	CDOTABaseAbility.FacingSupport = function(self, P, ax, ay, aI, T, aJ)
		if ay == nil then
			ay = 1
		end
		local h = self:GetCaster()
		local aK = CreateModifierThinker(
			h,
			self,
			"modifier_tracing_support",
			{
				duration = T or self:GetCastPoint(),
				entindex = ax:entindex(),
				flowAngle = aJ or 0,
				turnRate = ay,
				distance = aI or self:GetCastRange(vec3_zero, nil),
			},
			P,
			h:GetTeamNumber(),
			false
		)
		return aK
	end
end