--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


local a = "override/CDOTA_BaseNPC"
local b = require("lualib_bundle")
local c = b.__TS__ArraySetLength
local d = b.__TS__ArraySplice
local e = b.__TS__ArrayIsArray
local f = b.__TS__ArrayFilter
local g = b.__TS__ArrayForEach
local h = b.__TS__ArrayMap
local i = b.__TS__ArraySome
local j = b.__TS__Delete
local k = b.__TS__ArraySlice
local l = b.__TS__ArrayIndexOf
local m = b.__TS__ArrayConcat
local n = b.__TS__StringIncludes
lightningPresentation = {}
lightningPresentationLastTime = -1
function ShouldPlayLightningPresentation(o, p, q)
	if q < lightningPresentationLastTime then
		c(lightningPresentation, 0)
	end
	lightningPresentationLastTime = q
	local r = 0
	local s = false
	do
		local t = #lightningPresentation - 1
		while t >= 0 do
			do
				local u = lightningPresentation[t + 1]
				if q - u.time >= 0.1 then
					d(lightningPresentation, t, 1)
					goto v
				end
				r = r + u.cost
				local w = p.x - u.x
				local x = p.y - u.y
				if u.kind == o and w * w + x * x <= 300 * 300 then
					s = true
				end
			end
			::v::
			t = t - 1
		end
	end
	local y = o == "arc" and 3 or 2
	if s or r + y > 12 then
		return false
	end
	lightningPresentation[#lightningPresentation + 1] = { time = q, x = p.x, y = p.y, kind = o, cost = y }
	return true
end
KnockBackFlag = KnockBackFlag or {}
KnockBackFlag.IS_HIDDEN = 1
KnockBackFlag[KnockBackFlag.IS_HIDDEN] = "IS_HIDDEN"
KnockBackFlag.IS_BUFF = 2
KnockBackFlag[KnockBackFlag.IS_BUFF] = "IS_BUFF"
KnockBackFlag.IS_PURGABLE = 4
KnockBackFlag[KnockBackFlag.IS_PURGABLE] = "IS_PURGABLE"
KnockBackFlag.IS_NOT_PURGE_EXCEPTION = 8
KnockBackFlag[KnockBackFlag.IS_NOT_PURGE_EXCEPTION] = "IS_NOT_PURGE_EXCEPTION"
KnockBackFlag.NO_STUN = 16
KnockBackFlag[KnockBackFlag.NO_STUN] = "NO_STUN"
KnockBackFlag.IS_BLOCKABLE = 32
KnockBackFlag[KnockBackFlag.IS_BLOCKABLE] = "IS_BLOCKABLE"
KnockBackFlag.RETAIN_ON_DEATH = 64
KnockBackFlag[KnockBackFlag.RETAIN_ON_DEATH] = "RETAIN_ON_DEATH"
KnockBackFlag.DESTROY_TREES = 128
KnockBackFlag[KnockBackFlag.DESTROY_TREES] = "DESTROY_TREES"
KnockBackFlag.NO_STUN_PARTICLE = 256
KnockBackFlag[KnockBackFlag.NO_STUN_PARTICLE] = "NO_STUN_PARTICLE"
KnockBackFlag.IS_HORIZONTAL_FLAIL = 512
KnockBackFlag[KnockBackFlag.IS_HORIZONTAL_FLAIL] = "IS_HORIZONTAL_FLAIL"
BaseNPC = IsServer() and CDOTA_BaseNPC or C_DOTA_BaseNPC
MAX_LIGHTNING_STRIKE_SOUNDS_PER_WINDOW = 1
MAX_LIGHTNING_STRIKE_TARGET_HITS_PER_FRAME = 40
LIGHTNING_STRIKE_EFFECT_LIMIT_INTERVAL_SECONDS = 0.1
ARC_LIGHTNING_SOUND_COOLDOWN_SECONDS = 0.1
MAX_CALL_SWORD_GROUP_SIZE = 8
BaseNPC.IsFriendly = function(self, z)
	if IsValid(self) and IsValid(z) then
		return self:GetTeamNumber() == z:GetTeamNumber()
	end
	return false
end
BaseNPC.GetProperty = function(self, A)
	local B = PROPERTY_MAP_REVERSE[A]
	if B == nil then
		return 0
	end
	return PropertySystem:GetPropertyValueEx(B, self:GetPlayerOwnerID(), self:entindex())
end
BaseNPC.CanTriggerProc = function(self, C, D, q)
	if q == nil then
		q = GameRules:GetGameTime()
	end
	if self.__procLimitTimes == nil then
		self.__procLimitTimes = {}
	end
	local E = self.__procLimitTimes[C]
	if E ~= nil and q - E < D then
		return false
	end
	self.__procLimitTimes[C] = q
	return true
end
if BaseNPC.GetAttackDamage_Engine == nil then
	BaseNPC.GetAttackDamage_Engine = BaseNPC.GetAttackDamage
end
BaseNPC.GetAttackDamage = function(self)
	return (self:GetProperty(PropertyFunction.BASE_ATTACK) + self:GetProperty(PropertyFunction.ATTACK))
		* (1 + self:GetProperty(PropertyFunction.ATTACK_AMPLIFY) / 100)
end
if IsServer() then
	if CDOTA_BaseNPC.GetHealth_Engine == nil then
		CDOTA_BaseNPC.GetHealth_Engine = CDOTA_BaseNPC.GetHealth
	end
	if CDOTA_BaseNPC.SetHealth_Engine == nil then
		CDOTA_BaseNPC.SetHealth_Engine = CDOTA_BaseNPC.SetHealth
	end
	if CDOTA_BaseNPC.ModifyHealth_Engine == nil then
		CDOTA_BaseNPC.ModifyHealth_Engine = CDOTA_BaseNPC.ModifyHealth
	end
	if CDOTA_BaseNPC.SetMaxHealth_Engine == nil then
		CDOTA_BaseNPC.SetMaxHealth_Engine = CDOTA_BaseNPC.SetMaxHealth
	end
	if CDOTA_BaseNPC.SetBaseMaxHealth_Engine == nil then
		CDOTA_BaseNPC.SetBaseMaxHealth_Engine = CDOTA_BaseNPC.SetBaseMaxHealth
	end
	CDOTA_BaseNPC.GetHealth = function(self)
		return LargeNumberHealth:GetHealth(self) or self:GetHealth_Engine()
	end
	CDOTA_BaseNPC.SetHealth = function(self, F)
		if not LargeNumberHealth:SetHealth(self, F) then
			self:SetHealth_Engine(F)
		end
	end
	CDOTA_BaseNPC.ModifyHealth = function(self, F, G, H, I)
		if not LargeNumberHealth:ModifyHealth(self, F) then
			self:ModifyHealth_Engine(F, G, H, I)
		end
	end
end
if BaseNPC.Heal_Engine == nil then
	BaseNPC.Heal_Engine = BaseNPC.Heal
end
BaseNPC.Heal = function(self, J, G)
	local K = self:GetHealth()
	self:ModifyHealth(math.min(K + J, self:GetMaxHealth()), G, false, 0)
end
BaseNPC.HealthCost = function(self, J)
	local K = self:GetHealth()
	self:ModifyHealth(math.min(K + J, self:GetMaxHealth()), nil, false, 0)
end
if BaseNPC.GiveMana_Engine == nil then
	BaseNPC.GiveMana_Engine = BaseNPC.GiveMana
end
BaseNPC.GiveMana = function(self, L)
	self:GiveMana_Engine(L)
	Event:Fire("give_mana", { unit = self, manaAmount = L })
end
function CalculateEquivalentDefenseIntensity(M)
	local N = M:GetProperty(PropertyFunction.DEFENSE_INTENSITY)
		* (1 + M:GetProperty(PropertyFunction.DEFENSE_INTENSITY_BOOST) * 0.01)
	return (1000 + N)
			* (1 + M:GetProperty(PropertyFunction.HERO_DEFENSE_BOOST) * 0.01)
			* (1 + M:GetProperty(PropertyFunction.FINAL_DEFENSE) * 0.01)
		- 1000
end
if BaseNPC.GetMaxHealth_Engine == nil then
	BaseNPC.GetMaxHealth_Engine = BaseNPC.GetMaxHealth
end
BaseNPC.GetMaxHealth = function(self)
	local O = CalculateEquivalentDefenseIntensity(self)
	return math.floor(
		(self:GetProperty(PropertyFunction.BASE_HEALTH) + self:GetProperty(PropertyFunction.HEALTH))
			* (1 + self:GetProperty(PropertyFunction.HEALTH_AMPLIFY) * 0.01)
			* (1 + O * INTENSITY_FACTOR * 0.01)
	)
end
if BaseNPC.GetHealthPercent_Engine == nil then
	BaseNPC.GetHealthPercent_Engine = BaseNPC.GetHealthPercent
end
BaseNPC.GetHealthPercent = function(self)
	return self:GetHealth() / self:GetMaxHealth() * 100
end
if BaseNPC.GetMaxMana_Engine == nil then
	BaseNPC.GetMaxMana_Engine = BaseNPC.GetMaxMana
end
BaseNPC.GetMaxMana = function(self)
	return math.floor(
		(self:GetProperty(PropertyFunction.BASE_MANA) + self:GetProperty(PropertyFunction.MANA))
			* (1 + self:GetProperty(PropertyFunction.MANA_AMPLIFY) * 0.01)
	)
end
BaseNPC.HasAbilityUpgrade = function(self, P)
	return AbilityUpgrade:HasAbilityUpgrade(self, P)
end
BaseNPC.GetShield = function(self, Q)
	if IsServer() then
		local R = self:FindModifierByName("modifier_shield")
		if IsValid(R) then
			if Q ~= nil then
				return R:GetShieldAmount(Q)
			else
				return R:GetTotalShieldAmount(Q)
			end
		end
	else
		return self:GetModifierStackCount("modifier_shield", self)
	end
	return 0
end
BaseNPC.GetShieldModifier = function(self)
	return self.__shield_modofier
end
BaseNPC.GetVulnerabilityModifierValue = function(self, S)
	local R = self.__VulnerabilityModifier
	if not IsValid(R) then
		return 0
	end
	local T = R:GetVulnerabilityValue(S)
	if T == nil then
		T = 0
	end
	return T
end
BaseNPC.HasState = function(self, U)
	if IsServer() then
		return StateSystem:GetStateValue(self:entindex(), U)
	else
		return StateSystem:GetStateValueFromNetTable(self:entindex(), U)
	end
end
BaseNPC.IsBreakable = function(self)
	return self:HasState(StateEnum.BREAKABLE)
end
if IsServer() then
	if CDOTA_BaseNPC.EmitSound_Engine == nil then
		CDOTA_BaseNPC.EmitSound_Engine = CDOTA_BaseNPC.EmitSound
	end
	CDOTA_BaseNPC.EmitSound = function(self, V, p)
		if p then
			EmitSoundOnLocationWithCaster(p, V, self)
		else
			self:EmitSound_Engine(V)
		end
	end
	if CDOTA_BaseNPC.AddAbility_Engine == nil then
		CDOTA_BaseNPC.AddAbility_Engine = CDOTA_BaseNPC.AddAbility
	end
	CDOTA_BaseNPC.AddAbility = function(self, W, X)
		local Y = self:AddAbility_Engine(W)
		if X ~= nil and IsValid(Y) then
			Y:SetLevel(X)
		end
		Y:__OnCreated()
		return Y
	end
	if CDOTA_BaseNPC.RemoveAbility_Engine == nil then
		CDOTA_BaseNPC.RemoveAbility_Engine = CDOTA_BaseNPC.RemoveAbility
	end
	CDOTA_BaseNPC.RemoveAbility = function(self, W)
		local Y = self:FindAbilityByName(W)
		if IsValid(Y) then
			self:RemoveAbilityByHandle(Y)
		end
	end
	if CDOTA_BaseNPC.RemoveAbilityByHandle_Engine == nil then
		CDOTA_BaseNPC.RemoveAbilityByHandle_Engine = CDOTA_BaseNPC.RemoveAbilityByHandle
	end
	CDOTA_BaseNPC.RemoveAbilityByHandle = function(self, Y)
		if IsValid(Y) then
			if Y.__OnDestroy ~= nil then
				Y:__OnDestroy()
			end
			self:RemoveAbilityByHandle_Engine(Y)
		end
	end
	CDOTA_BaseNPC.GetAttachmentPosition = function(self, Z)
		if not IsValid(self) then
			return vec3_zero
		end
		return self:GetAttachmentOrigin(self:ScriptLookupAttachment(Z))
	end
	if CDOTA_BaseNPC.RespawnUnit_Engine == nil then
		CDOTA_BaseNPC.RespawnUnit_Engine = CDOTA_BaseNPC.RespawnUnit
	end
	CDOTA_BaseNPC.RespawnUnit = function(self)
		if not self:UnitCanRespawn() then
			return
		end
		local _ = self:FirstMoveChild()
		while _ ~= nil do
			local a0 = _:NextMovePeer()
			if _ ~= nil and _:GetClassname() ~= "" and _:GetClassname() == "dota_item_wearable" then
				UTIL_Remove(_)
			end
			_ = a0
		end
		self:RespawnUnit_Engine()
	end
	if CDOTA_BaseNPC.SetUnitCanRespawn_Engine == nil then
		CDOTA_BaseNPC.SetUnitCanRespawn_Engine = CDOTA_BaseNPC.SetUnitCanRespawn
	end
	CDOTA_BaseNPC.SetUnitCanRespawn = function(self, a1)
		self.__unitCanRespawn_ = a1
		if a1 == true then
			self:StopTimer("RecyclingUnit")
		elseif not self:IsAlive() and not self:IsRealHero() then
			self:GameTimer("RecyclingUnit", 8, function()
				if self:IsAlive() then
					return
				end
				if self:IsRealHero() then
					return
				end
				if self:UnitCanRespawn() then
					return
				end
				self:SafeRemoveUnit()
			end)
		end
	end
	if CDOTA_BaseNPC.UnitCanRespawn_Engine == nil then
		CDOTA_BaseNPC.UnitCanRespawn_Engine = CDOTA_BaseNPC.UnitCanRespawn
	end
	CDOTA_BaseNPC.UnitCanRespawn = function(self)
		local a2 = self.__unitCanRespawn_
		if a2 == nil then
			a2 = false
		end
		return a2
	end
	if CDOTA_BaseNPC.AddNewModifier_Engine == nil then
		CDOTA_BaseNPC.AddNewModifier_Engine = CDOTA_BaseNPC.AddNewModifier
	end
	CDOTA_BaseNPC.AddNewModifier = function(self, a3, Y, a4, a5, a6)
		local R = nil
		if a6 ~= nil then
			if IsValid(self) and bit.band(a6, AddModifierFlag.IGNORE_DEATH) == AddModifierFlag.IGNORE_DEATH then
				if self.__isRemoving then
					return
				end
				local a7 = not self:IsAlive()
				if a7 then
					self:SetHealth(1)
				end
				R = self:AddNewModifier_Engine(a3, Y, a4, a5)
				if a7 then
					self:SetHealth(0)
				end
			end
		else
			R = self:AddNewModifier_Engine(a3, Y, a4, a5)
		end
		if IsValid(R) and IsValid(a3) then
			local a8 = R:GetDuration()
			if a8 > 0 then
				if R:IsDebuff() then
					R:SetDuration(a8 * (1 + GetDebuffDuration(a3, nil) * 0.01), false)
				else
					R:SetDuration(a8 * (1 + GetBuffDuration(a3, nil) * 0.01), false)
				end
			end
		end
		return R
	end
	CDOTA_BaseNPC.ExecuteOrder = function(self, a9, ...)
		local aa = { ... }
		local ab
		local z
		local ac
		local ad = { DOTA_UNIT_ORDER_MOVE_TO_POSITION, DOTA_UNIT_ORDER_ATTACK_MOVE }
		local ae = { DOTA_UNIT_ORDER_MOVE_TO_TARGET, DOTA_UNIT_ORDER_ATTACK_TARGET }
		local af = {
			DOTA_UNIT_ORDER_CAST_POSITION,
			DOTA_UNIT_ORDER_CAST_TARGET,
			DOTA_UNIT_ORDER_CAST_TARGET_TREE,
			DOTA_UNIT_ORDER_CAST_NO_TARGET,
			DOTA_UNIT_ORDER_CAST_TOGGLE,
		}
		if TableFindKey(ad, a9) ~= nil then
			ac = aa[1]
		elseif TableFindKey(ae, a9) ~= nil then
			z = aa[1]
		elseif TableFindKey(af, a9) ~= nil then
			if a9 == DOTA_UNIT_ORDER_CAST_POSITION then
				ab = aa[1]
				ac = aa[2]
			elseif a9 == DOTA_UNIT_ORDER_CAST_NO_TARGET or a9 == DOTA_UNIT_ORDER_CAST_TOGGLE then
				ab = aa[1]
			else
				ab = aa[1]
				z = aa[2]
			end
		end
		ExecuteOrderFromTable({
			UnitIndex = self:entindex(),
			OrderType = a9,
			TargetIndex = IsValid(z) and z:entindex() or nil,
			AbilityIndex = IsValid(ab) and ab:entindex() or nil,
			Position = ac,
			Queue = false,
		})
	end
	CDOTA_BaseNPC.Dash = function(self, ag, ah, ai, a8, aj)
		if not self:IsAlive() then
			return
		end
		local ak = GetDashDistance(self, nil)
		local al = { direction = ag, dash_duration = a8, dash_distance = ah + ak, dash_height = ai }
		self:RemoveModifierByName("modifier_dash")
		local am = self:AddNewModifier(self, nil, "modifier_dash", al)
		if IsValid(am) and aj ~= nil then
			am.callback = aj
		end
	end
	CDOTA_BaseNPC.KnockBack = function(self, ag, ah, ai, a8, aj)
		if not self:IsAlive() then
			return
		end
		if self:HasState(StateEnum.KNOCKBACK_IMMUNE) then
			return
		end
		local al = { direction = ag, dash_duration = a8, dash_distance = ah, dash_height = ai }
		self:RemoveModifierByName("modifier_knockback_custom")
		local am = self:AddNewModifier(self, nil, "modifier_knockback_custom", al)
		if IsValid(am) and aj ~= nil then
			am.callback = aj
		end
	end
	CDOTA_BaseNPC.Stagger = function(self, a8, an, ao)
		if not self:IsAlive() then
			return
		end
		local al = { duration = a8, animation = an or ACT_DOTA_DISABLED, animation_rate = ao or 1 }
		self:RemoveModifierByName("modifier_stagger")
		self:AddNewModifier(self, nil, "modifier_stagger", al)
	end
	CDOTA_BaseNPC.Stun = function(self, a3, Y, a8)
		if not IsValid(self) then
			return
		end
		if a8 <= 0 then
			return
		end
		if self:HasState(StateEnum.STUN_IMMUNE) then
			return
		end
		self:AddNewModifier(a3, Y, "modifier_stunned", { duration = a8 })
	end
	CDOTA_BaseNPC.SummonUnit = function(self, ap, p, a8, aq)
		local ar = self:GetForwardVector()
		local as = {
			MapUnitName = ap,
			angles = (((tostring(ar.x) .. " ") .. tostring(ar.y)) .. " ") .. tostring(ar.z),
			teamnumber = self:GetTeamNumber(),
			NeverMoveToClearSpace = false,
			IsSummoned = "1",
		}
		if aq ~= nil then
			as = TableOverride(as, aq)
		end
		local M = CreateUnitFromTable(as, p)
		if not IsValid(M) then
			return nil
		end
		M.__Summoner = self
		if a8 ~= nil and a8 > 0 then
			M:AddNewModifier(self, nil, "modifier_kill", { duration = a8 })
		end
		return M
	end
	CDOTA_BaseNPC.SafeRemoveUnit = function(self)
		if not IsValid(self) then
			return
		end
		if self.__isRemoving then
			return
		end
		self.__isRemoving = true
		self:RemoveAllModifiers(0, false, true, false)
		self:ForceKill(false)
		self:MakeIllusion()
		self:AddNoDraw()
		self:CallAbilityDestroy()
		if PropertySystem ~= nil then
			PropertySystem:CleanupUnitProperties(self)
		end
		Timer:GameTimer(0, function()
			if self:IsNull() then
				return
			end
			self:Remove()
		end)
	end
	CDOTA_BaseNPC.PassiveCast = function(self, Y, at, aq, au)
		if not IsValid(Y) then
			return
		end
		if aq == nil then
			aq = {}
		end
		local av = aq.castPoint or Y:GetCastPoint()
		local aw = aq.castAnimation or Y:GetCastAnimation()
		local ax = aq.sActivityModifier
		if aq.sActivityModifier and type(aq.sActivityModifier) == "table" then
			ax = json.encode(aq.sActivityModifier)
		end
		local ay = av
		local az = av
		local aA = aw
		local aB = at
		local aC = aq.animationRate
		local aD = aq.position and VectorToString(aq.position) or nil
		local aE = IsValid(aq.target) and aq.target:entindex() or nil
		local aF = aq.bFadeAnimation
		local aG = aq.fadeAnimationTime
		local aH = ax
		local aI = aq.bIgnoreBackswing
		if aI == nil then
			aI = true
		end
		local aJ = {
			duration = ay,
			castPoint = az,
			castAnimation = aA,
			orderType = aB,
			animationRate = aC,
			position = aD,
			targetIndex = aE,
			bFadeAnimation = aF,
			fadeAnimationTime = aG,
			activityModifier = aH,
			bIgnoreBackswing = aI,
			bUseCooldown = (aq.bUseCooldown == nil or aq.bUseCooldown == true) and 1 or 0,
			bUseMana = (aq.bUseMana == nil or aq.bUseMana == true) and 1 or 0,
		}
		Y.CustomAbilityPhaseStart = aq.OnAbilityPhaseStart
		Y.CustomAbilityPhaseInterrupted = aq.OnAbilityPhaseInterrupted
		local R = self:AddNewModifier(self, Y, "modifier_passive_cast", aJ)
		if IsValid(R) then
			R.callback = au
		end
	end
	if CDOTA_BaseNPC.AddActivityModifier_Engine == nil then
		CDOTA_BaseNPC.AddActivityModifier_Engine = CDOTA_BaseNPC.AddActivityModifier
	end
	CDOTA_BaseNPC.UpdateActivityModifier = function(self)
		if self.__activityModifiers == nil then
			self.__activityModifiers = {}
		end
		self:ClearActivityModifiers()
		for t = 0, #self.__activityModifiers - 1, 1 do
			self:AddActivityModifier_Engine(self.__activityModifiers[t + 1])
		end
	end
	CDOTA_BaseNPC.AddActivityModifier = function(self, aK)
		if self.__activityModifiers == nil then
			self.__activityModifiers = {}
		end
		local aL = self.__activityModifiers
		aL[#aL + 1] = aK
		self:UpdateActivityModifier()
	end
	CDOTA_BaseNPC.RemoveActivityModifier = function(self, aK)
		if self.__activityModifiers == nil then
			self.__activityModifiers = {}
		end
		ArrayRemove(self.__activityModifiers, aK)
		self:UpdateActivityModifier()
	end
	CDOTA_BaseNPC.DealDamage = function(self, aM, Y, aN, aO, aP)
		if not IsValid(self) or Y ~= nil and not IsValid(Y) then
			return
		end
		local aQ = DOTA_DAMAGE_CATEGORY_BARRIER
		if Y ~= nil then
			if aO == nil then
				aO = Y:GetDamageType()
			end
			local aR = Y:GetAbilityTag()
			if
				aR == AbilityTag.Skill
				or aR == AbilityTag.Dodge
				or aR == AbilityTag.Defense
				or aR == AbilityTag.Ultimate
			then
				aQ = DOTA_DAMAGE_CATEGORY_SPELL
			end
		end
		if e(aM) then
			for t, aS in ipairs(aM) do
				do
					if not IsValid(aS) then
						goto aT
					end
					local aU = DamageSystem:AcquireDamageInfo()
					aU.attacker = self
					aU.target = aS
					aU.ability = Y
					aU.damage = aN
					aU.damage_type = aO or EOM_DAMAGE_TYPES.DAMAGE_TYPE_NONE
					aU.damage_flags = aP
					aU.damage_category = aQ
					DamageSystem:DealDamage(aU, true)
				end
				::aT::
			end
		else
			if not IsValid(aM) then
				return
			end
			local aU = DamageSystem:AcquireDamageInfo()
			aU.attacker = self
			aU.target = aM
			aU.ability = Y
			aU.damage = aN
			aU.damage_type = aO or EOM_DAMAGE_TYPES.DAMAGE_TYPE_NONE
			aU.damage_flags = aP
			aU.damage_category = aQ
			DamageSystem:DealDamage(aU, true)
		end
	end
	CDOTA_BaseNPC.Attack = function(self, aM, aU)
		local aV = aU and aU.baseDamage or self:GetAttackDamage()
		local aW = aU and aU.damageAmplify or 0
		local aX = aU and aU.bonusDamage or 0
		local aY = aU and aU.damageType or EOM_DAMAGE_TYPES.DAMAGE_TYPE_PHYSICAL
		local aZ = DamageSystem:AcquireDamageInfo()
		aZ.attacker = self
		aZ.target = aM
		aZ.ability = self:GetAbilityByTag(AbilityTag.Attack)
		aZ.damage = (aV + aX) * (1 + aW)
		aZ.damage_category = DOTA_DAMAGE_CATEGORY_ATTACK
		aZ.damage_type = aY
		aZ.damage_flags = aU and aU.flags or EOM_DAMAGE_FLAGS.NONE
		DamageSystem:DealDamage(aZ, true)
	end
	CDOTA_BaseNPC.GetAbilityByTag = function(self, a_)
		if self:IsHero() then
			if a_ == AbilityTag.Skill then
				return self:GetAbilityByIndex(0)
			end
			if a_ == AbilityTag.Dodge then
				return self:GetAbilityByIndex(1)
			end
			if a_ == AbilityTag.Defense then
				return self:GetAbilityByIndex(2)
			end
			if a_ == AbilityTag.Ultimate then
				return self:GetAbilityByIndex(5)
			end
			if a_ == AbilityTag.Attack then
				return self:GetAbilityByIndex(3)
			end
			if a_ == AbilityTag.Interact then
				return self:GetAbilityByIndex(4)
			end
		else
			do
				local b0 = 0
				while b0 < self:GetAbilityCount() do
					local Y = self:GetAbilityByIndex(b0)
					if IsValid(Y) and Y:GetAbilityTag() == a_ then
						return Y
					end
					b0 = b0 + 1
				end
			end
		end
	end
	CDOTA_BaseNPC.EachAbility = function(self, au)
		local b1 = { AbilityTag.Attack, AbilityTag.Skill, AbilityTag.Dodge, AbilityTag.Defense, AbilityTag.Ultimate }
		for t = 0, #b1 - 1, 1 do
			local aR = b1[t + 1]
			local Y = self:GetAbilityByTag(aR)
			if IsValid(Y) then
				au(Y, aR)
			end
		end
	end
	if CDOTA_BaseNPC.AddItem_Engine == nil then
		CDOTA_BaseNPC.AddItem_Engine = CDOTA_BaseNPC.AddItem
	end
	if CDOTA_BaseNPC.AddItemByName_Engine == nil then
		CDOTA_BaseNPC.AddItemByName_Engine = CDOTA_BaseNPC.AddItemByName
	end
	if CDOTA_BaseNPC.RemoveItem_Engine == nil then
		CDOTA_BaseNPC.RemoveItem_Engine = CDOTA_BaseNPC.RemoveItem
	end
	CDOTA_BaseNPC.AddItem = function(self, b2, b3)
		if b3 == nil then
			b3 = true
		end
		if self.__items == nil then
			self.__items = {}
		end
		self:AddItem_Engine(b2)
		b2:__OnCreated()
		local b4 = self.__items
		b4[#b4 + 1] = {
			entIndex = b2:entindex(),
			itemName = b2:GetAbilityName(),
			level = b2:GetLevel(),
			stackCount = b2.__StackCount or 0,
			charge = b2.__Charge or 0,
			maxCharge = b2:GetMaxCharges(),
			chargeRestoreTime = b2.__ChargeRestoreTime or 0,
			isChargeCooldownFrozen = b2:IsChargeCooldownFrozen(),
			chargeFrozenCooldownRemaining = b2:GetChargeCooldownRemaining(),
		}
		self:TakeItem(b2)
		Event:Fire("item_added", { unit = self, item = b2 })
		if b3 then
			self:UpdateAbilityNetData()
		end
		return b2
	end
	CDOTA_BaseNPC.AddItemByName = function(self, b5, X, b3)
		if X == nil then
			X = 1
		end
		if b3 == nil then
			b3 = true
		end
		if self.__items == nil then
			self.__items = {}
		end
		local b2 = self:AddItemByName_Engine(b5)
		b2:__OnCreated()
		if X > 1 then
			b2:SetLevel(X, false)
		end
		local b6 = self.__items
		b6[#b6 + 1] = {
			entIndex = b2:entindex(),
			itemName = b2:GetAbilityName(),
			level = b2:GetLevel(),
			stackCount = b2.__StackCount or 0,
			charge = b2.__Charge or 0,
			maxCharge = b2:GetMaxCharges(),
			chargeRestoreTime = b2.__ChargeRestoreTime or 0,
			isChargeCooldownFrozen = b2:IsChargeCooldownFrozen(),
			chargeFrozenCooldownRemaining = b2:GetChargeCooldownRemaining(),
		}
		self:TakeItem(b2)
		Event:Fire("item_added", { unit = self, item = b2 })
		if b3 then
			self:UpdateAbilityNetData()
		end
		return b2
	end
	CDOTA_BaseNPC.RemoveItem = function(self, b2)
		if self.__items == nil then
			self.__items = {}
		end
		if not IsValid(b2) then
			return
		end
		Event:Fire("item_consumed", { unit = self, item = b2 })
		b2:__OnDestroy()
		self.__items = f(self.__items, function(b7, aJ)
			return aJ.entIndex ~= b2:entindex()
		end)
		self:RemoveItem_Engine(b2)
		Event:Fire("item_removed", { unit = self, item = b2 })
		self:UpdateAbilityNetData()
	end
	CDOTA_BaseNPC.RemoveAllItem = function(self)
		if self.__items == nil then
			self.__items = {}
		end
		local b8 = self:GetAllItems()
		g(b8, function(b7, b2)
			if IsValid(b2) then
				b2:__OnDestroy()
				self.__items = f(self.__items or {}, function(b7, aJ)
					return aJ.entIndex ~= b2:entindex()
				end)
				self:RemoveItem_Engine(b2)
				Event:Fire("item_removed", { unit = self, item = b2 })
			end
		end)
		self.__items = {}
		CustomNetTables:SetNetData("unit", tostring(self:entindex()), nil)
	end
	CDOTA_BaseNPC.GetAllItems = function(self)
		local b9 = {}
		if self.__items == nil then
			self.__items = {}
		end
		g(self.__items, function(b7, aJ)
			local b2 = EntIndexToHScript(aJ.entIndex)
			if IsValid(b2) then
				b9[#b9 + 1] = b2
			end
		end)
		return b9
	end
	CDOTA_BaseNPC.GetItemByName = function(self, b5)
		if self.__items == nil then
			self.__items = {}
		end
		local b2
		h(self.__items, function(b7, aJ)
			if aJ.itemName == b5 then
				b2 = EntIndexToHScript(aJ.entIndex)
			end
		end)
		return b2
	end
	CDOTA_BaseNPC.GetItemByNameAndLevel = function(self, b5, X)
		if self.__items == nil then
			self.__items = {}
		end
		local b2
		h(self.__items, function(b7, aJ)
			if aJ.itemName == b5 and aJ.level == X then
				b2 = EntIndexToHScript(aJ.entIndex)
			end
		end)
		return b2
	end
	CDOTA_BaseNPC.HasItem = function(self, b5)
		if self.__items == nil then
			self.__items = {}
		end
		return i(self.__items, function(b7, aJ)
			return aJ.itemName == b5
		end)
	end
	CDOTA_BaseNPC.GetItemCount = function(self, b5)
		if self.__items == nil then
			self.__items = {}
		end
		return #f(self.__items, function(b7, aJ)
			return aJ.itemName == b5
		end)
	end
	CDOTA_BaseNPC.UpdateAbilityNetData = function(self)
		if self.__items == nil then
			self.__items = {}
		end
		g(self.__items, function(b7, aJ)
			local b2 = EntIndexToHScript(aJ.entIndex)
			aJ.stackCount = b2.__StackCount or 0
			aJ.charge = b2.__Charge or 0
			aJ.maxCharge = b2:GetMaxCharges()
			aJ.chargeRestoreTime = b2.__ChargeRestoreTime or 0
			aJ.isChargeCooldownFrozen = b2:IsChargeCooldownFrozen()
			aJ.chargeFrozenCooldownRemaining = b2:GetChargeCooldownRemaining()
		end)
		local ba = {}
		local bb = self:GetAbilityByTag(AbilityTag.Attack)
		if bb then
			ba[#ba + 1] = bb
		end
		local bc = self:GetAbilityByTag(AbilityTag.Skill)
		if bc then
			ba[#ba + 1] = bc
		end
		local bd = self:GetAbilityByTag(AbilityTag.Dodge)
		if bd then
			ba[#ba + 1] = bd
		end
		local be = self:GetAbilityByTag(AbilityTag.Defense)
		if be then
			ba[#ba + 1] = be
		end
		local bf = self:GetAbilityByTag(AbilityTag.Ultimate)
		if bf then
			ba[#ba + 1] = bf
		end
		if not self:IsRealHero() then
			return
		end
		CustomNetTables:SetNetData(
			"unit",
			tostring(self:entindex()),
			{
				items = self.__items,
				abilities = h(ba, function(b7, Y)
					return {
						entIndex = Y:entindex() or -1,
						stackCount = Y.__StackCount or 0,
						abilityName = Y:GetAbilityName(),
						charge = Y.__Charge or 0,
						maxCharge = Y:GetMaxCharges(),
						chargeRestoreTime = Y.__ChargeRestoreTime or 0,
						isChargeCooldownFrozen = Y:IsChargeCooldownFrozen(),
						chargeFrozenCooldownRemaining = Y:GetChargeCooldownRemaining(),
					}
				end),
			}
		)
	end
	CDOTA_BaseNPC.CallAbilityCreated = function(self)
		do
			local t = 0
			while t < self:GetAbilityCount() do
				local Y = self:GetAbilityByIndex(t)
				if IsValid(Y) then
					Y:__OnCreated()
				end
				t = t + 1
			end
		end
	end
	CDOTA_BaseNPC.CallAbilityRefresh = function(self)
		do
			local t = 0
			while t < self:GetAbilityCount() do
				local Y = self:GetAbilityByIndex(t)
				if IsValid(Y) then
					Y:__OnRefresh()
				end
				t = t + 1
			end
		end
	end
	CDOTA_BaseNPC.CallAbilityDestroy = function(self)
		do
			local t = 0
			while t < self:GetAbilityCount() do
				local Y = self:GetAbilityByIndex(t)
				if IsValid(Y) then
					Y:__OnDestroy()
				end
				t = t + 1
			end
		end
		self:RemoveAllItem()
	end
	CDOTA_BaseNPC.ChangeWeapon = function(self, bg)
		if self.__weapon ~= nil then
			self.__weapon:RemoveSelf()
			self.__weapon = nil
		end
		local al = KeyValues.weapon[bg]
		if al == nil then
			return
		end
		self.__weapon = SpawnEntityFromTableSynchronous(
			"dota_prop_customtexture",
			{
				targetname = bg,
				model = al.model,
				StartingAnim = "ACT_DOTA_IDLE",
				StartingAnimationLoopMode = "ANIM_LOOP_MODE_LOOPING",
			}
		)
		local bh = KeyValues.weapon_asset_modifier[bg]
		self.__weapon.__asset_modifier = {}
		if bh ~= nil then
			if bh.particle_color ~= nil then
				self.__weapon.__asset_modifier.particle_color = RGBStringToVector(bh.particle_color)
			end
		end
		self.__weapon:FollowEntity(self, true)
		self:CheckNoDraw(self.__weapon)
	end
	CDOTA_BaseNPC.SetWeaponVisible = function(self, bi)
		self.__weapon_hidden = not bi
		if IsValid(self.__weapon) then
			self:CheckNoDraw(self.__weapon)
		end
	end
	CDOTA_BaseNPC.EquipCosmetic = function(self, bj)
		bj = tostring(bj)
		local al = KeyValues.info_item_cosmetic[bj]
		if al == nil then
			return
		end
		local bk = tostring(al.type)
		if self.__cosmetics == nil then
			self.__cosmetics = {}
		end
		if bk == "MISC" then
			local u = { id = bj }
			local bl = self.__cosmetics[bk]
			if bl ~= nil then
				bl[#bl + 1] = u
			else
				self.__cosmetics[bk] = { u }
			end
			self:AddActivityModifier(bj)
			Cosmetic:RegisterParticleReplacements(self, bk, bj)
			if al.model == nil then
				return
			end
			local bm = SpawnEntityFromTableSynchronous(
				"dota_prop_customtexture",
				{
					targetname = bj,
					model = al.model,
					StartingAnim = "ACT_DOTA_IDLE",
					StartingAnimationLoopMode = "ANIM_LOOP_MODE_LOOPING",
				}
			)
			bm:FollowEntity(self, true)
			u.entity = bm
			return
		end
		self:UnequipCosmeticByType(bk, nil, true)
		self.__cosmetics[bk] = { id = bj }
		self:AddActivityModifier(bj)
		Cosmetic:RegisterParticleReplacements(self, bk, bj)
		print(bk, "kv.particle", al.particle)
		if al.particle ~= nil then
			local bn = ParticleManager:CreateParticle(tostring(al.particle), PATTACH_ABSORIGIN_FOLLOW, self)
			self.__cosmetics[bk].particleId = bn
			return
		end
		if al.model == nil then
			return
		end
		local bm = SpawnEntityFromTableSynchronous(
			"dota_prop_customtexture",
			{
				targetname = bj,
				model = al.model,
				StartingAnim = "ACT_DOTA_IDLE",
				StartingAnimationLoopMode = "ANIM_LOOP_MODE_LOOPING",
			}
		)
		bm:FollowEntity(self, true)
		self.__cosmetics[bk].entity = bm
	end
	CDOTA_BaseNPC.UnequipCosmeticByType = function(self, bk, bj, bo)
		if self.__cosmetics == nil then
			self.__cosmetics = {}
		end
		if bk == "MISC" then
			local bp = self.__cosmetics[bk]
			if bp == nil then
				return
			end
			if bj ~= nil then
				do
					local t = #bp - 1
					while t >= 0 do
						if bp[t + 1].id == bj then
							self:RemoveActivityModifier(bp[t + 1].id)
							Cosmetic:UnregisterParticleReplacements(self, bk)
							if bp[t + 1].entity ~= nil and IsValid(bp[t + 1].entity) then
								bp[t + 1].entity:RemoveSelf()
							end
							table.remove(bp, t)
							break
						end
						t = t - 1
					end
				end
				if #bp == 0 then
					j(self.__cosmetics, bk)
				end
			else
				do
					local t = #bp - 1
					while t >= 0 do
						self:RemoveActivityModifier(bp[t + 1].id)
						Cosmetic:UnregisterParticleReplacements(self, bk)
						if bp[t + 1].entity ~= nil and IsValid(bp[t + 1].entity) then
							bp[t + 1].entity:RemoveSelf()
						end
						t = t - 1
					end
				end
				j(self.__cosmetics, bk)
			end
			return
		end
		local bq = self.__cosmetics[bk]
		if bq == nil then
			return
		end
		self:RemoveActivityModifier(bq.id)
		Cosmetic:UnregisterParticleReplacements(self, bk)
		if bq.particleId ~= nil then
			ParticleManager:DestroyParticle(bq.particleId, true)
		end
		if bq.entity ~= nil and IsValid(bq.entity) then
			bq.entity:RemoveSelf()
		end
		j(self.__cosmetics, bk)
		if not bo then
			local br = self:GetPlayerOwnerID()
			local bs = tostring(PlayerResource:GetSelectedHeroID(br))
			for bt, bu in pairs(KeyValues.info_item_cosmetic) do
				do
					local u = bu
					if tostring(u.type) ~= bk then
						goto bv
					end
					if tostring(u.default) ~= "1" then
						goto bv
					end
					local bw = u.hero_id ~= nil and tostring(u.hero_id) or nil
					if bw == nil or bw == bs then
						self:EquipCosmetic(bt)
						break
					end
				end
				::bv::
			end
		end
	end
	CDOTA_BaseNPC.CheckNoDraw = function(self, bm)
		local bi = not self.__NODAW
		if self.__weapon_hidden then
			bi = false
		end
		if IsValid(bm) then
			if bi then
				bm:RemoveEffects(EF_NODRAW)
			else
				bm:AddEffects(EF_NODRAW)
			end
		end
	end
	if CDOTA_BaseNPC.AddNoDraw_Engine == nil then
		CDOTA_BaseNPC.AddNoDraw_Engine = CDOTA_BaseNPC.AddNoDraw
	end
	if CDOTA_BaseNPC.RemoveNoDraw_Engine == nil then
		CDOTA_BaseNPC.RemoveNoDraw_Engine = CDOTA_BaseNPC.RemoveNoDraw
	end
	CDOTA_BaseNPC.AddNoDraw = function(self)
		self.__NODAW = true
		self:CheckNoDraw(self.__weapon)
		self:AddNoDraw_Engine()
	end
	CDOTA_BaseNPC.RemoveNoDraw = function(self)
		self.__NODAW = false
		self:CheckNoDraw(self.__weapon)
		self:RemoveNoDraw_Engine()
	end
	CDOTA_BaseNPC.AddShield = function(self, bx, Q, by, bz)
		if bx <= 0 then
			return
		end
		local O = CalculateEquivalentDefenseIntensity(self)
		bx = bx * (1 + GetShieldAmplify(self) * 0.01) * (1 + O * INTENSITY_FACTOR * 0.01)
		local bA = Q or DoUniqueString("shield")
		local bB = by or "override"
		local bC = bz or "normal"
		self:AddNewModifier(self, nil, "modifier_shield", { shield = bx, id = bA, method = bB, type = bC })
	end
	CDOTA_BaseNPC.RemoveShield = function(self, Q)
		if Q == nil then
			self:RemoveModifierByName("modifier_shield")
		else
			local R = self:FindModifierByName("modifier_shield")
			if IsValid(R) then
				R:RemoveShield(Q)
			end
		end
	end
	CDOTA_BaseNPC.ReduceShield = function(self, J, Q, bD)
		if J <= 0 then
			return
		end
		local R = self:FindModifierByName("modifier_shield")
		if not IsValid(R) then
			return
		end
		R:ReduceShield(J, Q, bD)
	end
	CDOTA_BaseNPC.AddProperty = function(self, A, bE)
		if PROPERTY_MAP_REVERSE[A] ~= nil then
			PropertySystem:AddStaticProperty(
				self:entindex(),
				PROPERTY_MAP_REVERSE[A],
				DoUniqueString("static_property"),
				bE
			)
		end
	end
	CDOTA_BaseNPC.EnergyStrike = function(self, bF, bG, Y, bH, aN, aj, aq)
		aq = aq or {}
		local bI = aq.source or self
		local bJ = aq.jumpDelay or 0
		local bK = aq.jumpCount or 0
		local bL = aq.jumpRadius or 600
		local Z = aq.attachName or "attach_attack1"
		local bM = aq.soundName or "Hero_Zuus.ArcLightning.Cast"
		local function bN(bI, aM, bO)
			self:DealDamage(aM, Y, aN)
			if type(aj) == "function" then
				aj(bI, aM, bO)
			else
				local bn = ParticleManager:CreateParticle(aj, PATTACH_CUSTOMORIGIN, nil)
				ParticleManager:SetParticleControlEnt(
					bn,
					0,
					bI,
					PATTACH_POINT_FOLLOW,
					bO and Z or "attach_hitloc",
					bI:GetAbsOrigin(),
					false
				)
				ParticleManager:SetParticleControlEnt(
					bn,
					1,
					aM,
					PATTACH_POINT_FOLLOW,
					"attach_hitloc",
					aM:GetAbsOrigin(),
					false
				)
				ParticleManager:ReleaseParticleIndex(bn)
			end
			EmitSoundOnLocationWithCaster(bI:GetAbsOrigin(), bM, self)
		end
		local bP = { bF }
		if bH > 0 then
			local bQ = FindUnitsInRadiusWithAbility(self, bF:GetAbsOrigin(), bG, Y)
			ArrayRemove(bQ, bF)
			for bR, M in ipairs(bQ) do
				table.insert(bP, M)
				bH = bH - 1
				if bH <= 0 then
					break
				end
			end
		end
		local bS = {}
		local bT = bK - 1
		for bR, M in ipairs(bP) do
			local bU = M
			bN(bI, bU, true)
			table.insert(bS, M)
			if bT > 0 then
				bT = bT - 1
				self:GameTimer(bJ, function()
					local bV = FindUnitsInRadiusWithAbility(self, bU:GetAbsOrigin(), bL, Y, FIND_CLOSEST)
					for bR, bW in ipairs(bS) do
						ArrayRemove(bV, bW)
					end
					local bX = bV[1]
					if IsValid(bX) then
						bN(bU, bX, false)
						table.insert(bS, bX)
						if bT > 0 then
							bU = bX
							return bJ
						end
					end
				end)
			end
		end
	end
	CDOTA_BaseNPC.AddExpose = function(self, aM, bY)
		if bY == nil then
			bY = 1
		end
		local R = aM:AddNewModifier(self, nil, "modifier_expose", { stack = bY, duration = 3 })
		local bZ = IsValid(R) and R:GetStackCount() or 0
		Event:Fire("expose_event", { target = aM, caster = self, addStack = bY, stack = bZ })
	end
	CDOTA_BaseNPC.IsExpose = function(self)
		local R = self:FindModifierByName("modifier_expose")
		return IsValid(R)
	end
	CDOTA_BaseNPC.AddIceMark = function(self, aM, bY)
		if bY == nil then
			bY = 1
		end
		local R = aM:AddNewModifier(self, nil, "modifier_ice_mark", { stack = bY, duration = 3 })
		local b_ = IsValid(R) and R:GetStackCount() or 0
		Event:Fire("ice_mark_event", { target = aM, caster = self, addStack = bY, stack = b_ })
	end
	CDOTA_BaseNPC.IsIceMark = function(self)
		local R = self:FindModifierByName("modifier_ice_mark")
		return IsValid(R)
	end
	CDOTA_BaseNPC.ArcLightning = function(self, aM, aN, c0)
		if c0 == nil then
			c0 = false
		end
		local c1 = BlessPerformance.Enabled
		local c2 = GameRules:GetGameTime()
		if c1 then
			BlessPerformance:Increment("arc_calls")
		end
		local bP = FindUnitsInRadius(
			self:GetTeamNumber(),
			aM:GetAbsOrigin(),
			nil,
			900,
			DOTA_UNIT_TARGET_TEAM_ENEMY,
			DOTA_UNIT_TARGET_HEROES_AND_CREEPS,
			DOTA_UNIT_TARGET_FLAG_NONE,
			FIND_CLOSEST,
			false
		)
		ArrayRemove(bP, aM)
		table.insert(bP, 1, aM)
		local c3 = self
		local c4 = 3
		local c5 = ShouldPlayLightningPresentation("arc", aM:GetAbsOrigin(), c2)
		if
			self.__arcLightningSoundTime == nil
			or c2 - self.__arcLightningSoundTime >= ARC_LIGHTNING_SOUND_COOLDOWN_SECONDS
		then
			self.__arcLightningSoundTime = c2
			self:EmitSound("Bless.ArcLightning")
		end
		for t, aS in ipairs(bP) do
			if c1 then
				BlessPerformance:Increment("arc_hits")
			end
			if c5 then
				if c1 then
					BlessPerformance:Increment("arc_particles")
				end
				local bn = ParticleManager:CreateParticle(
					"particles/units/benediction/zuus_arc_lightning.vpcf",
					PATTACH_CUSTOMORIGIN,
					self
				)
				if t == 0 then
					ParticleManager:SetParticleControlEnt(
						bn,
						0,
						c3,
						PATTACH_POINT_FOLLOW,
						"attach_attack1",
						c3:GetAbsOrigin(),
						false
					)
				else
					ParticleManager:SetParticleControlEnt(
						bn,
						0,
						c3,
						PATTACH_POINT_FOLLOW,
						"attach_hitloc",
						c3:GetAbsOrigin(),
						false
					)
				end
				ParticleManager:SetParticleControlEnt(
					bn,
					1,
					aS,
					PATTACH_POINT_FOLLOW,
					"attach_hitloc",
					aS:GetAbsOrigin(),
					false
				)
				ParticleManager:ReleaseParticleIndex(bn)
			end
			self:DealDamage(aS, nil, aN, EOM_DAMAGE_TYPES.DAMAGE_TYPE_NONE, EOM_DAMAGE_FLAGS.LIGHTNING_DAMAGE)
			if PRD(nil, self, GetLightningExposeChance(self), "ArcLightning") then
				self:AddExpose(aS)
			end
			c4 = c4 - 1
			if c4 <= 0 then
				break
			end
			c3 = aS
		end
		if not c0 then
			local c6 = GetLightningCount(self)
			if c6 > 0 then
				local c7 = FindUnitsInRadius(
					self:GetTeamNumber(),
					aM:GetAbsOrigin(),
					nil,
					900,
					DOTA_UNIT_TARGET_TEAM_ENEMY,
					DOTA_UNIT_TARGET_HEROES_AND_CREEPS,
					DOTA_UNIT_TARGET_FLAG_NONE,
					FIND_ANY_ORDER,
					false
				)
				ArrayRemove(c7, aM)
				local c8 = 0
				for bR, M in ipairs(c7) do
					self:ArcLightning(M, aN, true)
					c8 = c8 + 1
					if c8 >= c6 then
						break
					end
				end
			end
		end
	end
	CDOTA_BaseNPC.LightningStrike = function(self, aM, aN, I)
		if I == nil then
			I = EOM_DAMAGE_FLAGS.NONE
		end
		local c1 = BlessPerformance.Enabled
		if c1 then
			BlessPerformance:Increment("lightning_requests")
		end
		local c2 = GameRules:GetGameTime()
		I = bit.bor(I, EOM_DAMAGE_FLAGS.LIGHTNING_DAMAGE)
		local c9 = GetLightningRadius(self)
		local ca = aM:GetAbsOrigin()
		local bP = {}
		if c9 > 0 then
			bP = FindEnemiesInRadius(self, ca, c9)
		else
			bP = { aM }
		end
		if c9 > 0 then
			local cb = ArrayRemove(bP, aM)
			if cb ~= nil then
				table.insert(bP, 1, cb)
			end
		end
		local cc = self.__lightningStrikeHitTime == c2 and (self.__lightningStrikeTargetHitCount or 0) or 0
		local cd = math.max(0, MAX_LIGHTNING_STRIKE_TARGET_HITS_PER_FRAME - cc)
		if #bP > cd then
			local ce = #bP - cd
			if c1 then
				BlessPerformance:Increment("lightning_dropped", ce)
			end
			bP = k(bP, 0, cd)
		end
		if #bP == 0 then
			return
		end
		self.__lightningStrikeHitTime = c2
		self.__lightningStrikeTargetHitCount = cc + #bP
		if c1 then
			BlessPerformance:Increment("lightning_aoe_hits", #bP)
		end
		for t, M in ipairs(bP) do
			if M == aM then
				self:DealDamage(M, nil, aN, EOM_DAMAGE_TYPES.DAMAGE_TYPE_NONE, I)
			else
				self:DealDamage(M, nil, aN, EOM_DAMAGE_TYPES.DAMAGE_TYPE_NONE, bit.bor(I, EOM_DAMAGE_FLAGS.NO_EXPOSE))
			end
		end
		if
			self.__lightningStrikeEffectWindowStart == nil
			or c2 - self.__lightningStrikeEffectWindowStart >= LIGHTNING_STRIKE_EFFECT_LIMIT_INTERVAL_SECONDS
		then
			self.__lightningStrikeEffectWindowStart = c2
			self.__lightningStrikeSoundCount = 0
		end
		if (self.__lightningStrikeSoundCount or 0) < MAX_LIGHTNING_STRIKE_SOUNDS_PER_WINDOW then
			self.__lightningStrikeSoundCount = (self.__lightningStrikeSoundCount or 0) + 1
			self:EmitSound("Bless.LightningStrike", ca)
		end
		if ShouldPlayLightningPresentation("strike", ca, c2) then
			if c1 then
				BlessPerformance:Increment("lightning_particles", 2)
			end
			local bn = ParticleManager:CreateParticle(
				"particles/units/benediction/zuus_lightning_bolt.vpcf",
				PATTACH_WORLDORIGIN,
				nil
			)
			ParticleManager:SetParticleControl(bn, 0, ca + Vector(0, 0, 900))
			ParticleManager:SetParticleControl(bn, 1, ca)
			ParticleManager:ReleaseParticleIndex(bn)
			bn = ParticleManager:CreateParticle(
				"particles/units/benediction/zuus_lightning_bolt_aoe.vpcf",
				PATTACH_WORLDORIGIN,
				nil
			)
			ParticleManager:SetParticleControl(bn, 0, ca)
			ParticleManager:SetParticleControl(bn, 1, Vector(c9, 0, 0))
			ParticleManager:ReleaseParticleIndex(bn)
		end
		local cf = GetLightningMultipleChance(self)
		if PRD(nil, self, cf, "LightningStrike") then
			self:StartThink(0.25, "LightningStrike", function()
				if IsValid(aM) then
					self:LightningStrike(aM, aN, I)
				end
				return -1
			end)
		end
		Event:Fire("lightning_strike", { caster = self, target = aM, damage = aN })
	end
	CDOTA_BaseNPC.LightningStorm = function(self, aM, aN)
		local p = aM:GetAbsOrigin()
		local bn = ParticleManager:CreateParticle(
			"particles/units/benediction/leshrac_lightning_bolt.vpcf",
			PATTACH_ABSORIGIN,
			self
		)
		ParticleManager:SetParticleControl(bn, 0, p + Vector(0, 0, 1000))
		ParticleManager:SetParticleControlEnt(bn, 1, aM, PATTACH_POINT_FOLLOW, "attach_hitloc", aM:GetAbsOrigin(), true)
		ParticleManager:ReleaseParticleIndex(bn)
		self:EmitSound("Hero_Leshrac.Lightning_Storm")
		self:DealDamage(
			aM,
			nil,
			aN,
			EOM_DAMAGE_TYPES.DAMAGE_TYPE_NONE,
			EOM_DAMAGE_FLAGS.LIGHTNING_DAMAGE + EOM_DAMAGE_FLAGS.NO_EXPOSE
		)
		Event:Fire("lightning_storm", { caster = self, target = aM, damage = aN })
	end
	CDOTA_BaseNPC.LightningCloud = function(self, a8)
		local cg = a8 * (1 + GetLightningCloudDuration(self) * 0.01)
		self:AddNewModifier(self, nil, "modifier_lightning_cloud", { duration = cg })
	end
	CDOTA_BaseNPC.CallSword = function(self, c4, ch, ci, cj)
		if ch == nil then
			ch = 0
		end
		if ci == nil then
			ci = 0
		end
		if cj == nil then
			cj = false
		end
		if self.__swordGroup == nil then
			self.__swordGroup = {}
		end
		do
			local t = #self.__swordGroup - 1
			while t >= 0 do
				local ck = self.__swordGroup[t + 1]
				if Bullet:GetBulletData(ck) == nil then
					d(self.__swordGroup, t, 1)
				end
				t = t - 1
			end
		end
		c4 = math.min(c4, MAX_CALL_SWORD_GROUP_SIZE - #self.__swordGroup)
		if c4 <= 0 then
			return
		end
		local a3 = self
		local aN = SWORD_DAMAGE * (1 + ch * 0.01)
		local cl = Bullet:CreateGroupSurroundBullet(c4, {
			caster = a3,
			group = "CallSword" .. tostring(a3:entindex()),
			circleRadius = 120,
			angularVelocity = 180,
			offset = 128,
			lifeTime = 5,
			interval = 1,
			ParticleCreator = function(cm)
				local bn =
					ParticleManager:CreateParticle("particles/abilities/custom_sword.vpcf", PATTACH_CUSTOMORIGIN, nil)
				ParticleManager:SetParticleControlEnt(
					bn,
					0,
					cm.__thinker,
					PATTACH_ABSORIGIN_FOLLOW,
					nil,
					cm.__thinker:GetAbsOrigin(),
					true
				)
				ParticleManager:SetParticleControlEnt(bn, 1, a3, PATTACH_ABSORIGIN_FOLLOW, nil, a3:GetAbsOrigin(), true)
				return bn
			end,
			OnIntervalThink = function(cm)
				if not IsValid(a3) then
					return
				end
				local aM = FindEnemiesInRadius(a3, a3:GetAbsOrigin(), 1200)[1]
				if IsValid(aM) then
					local cn = cm.__position
					cn.z = a3:GetAbsOrigin().z + 128
					local co = l(a3.__swordGroup, cm.__projIndex)
					Bullet:DestroyBulletByID(cm.__projIndex)
					local cp = Bullet:CreateGuidedBullet({
						caster = a3,
						target = aM,
						direction = CalcDirection2D(cn, a3),
						effectName = "particles/generic_gameplay/talent_sword_projectile.vpcf",
						spawnOrigin = cn,
						angularVelocity = 360,
						ignoreBlock = true,
						radius = 64,
						moveSpeed = 1500,
						teamFilter = DOTA_UNIT_TARGET_TEAM_ENEMY,
						typeFilter = DOTA_UNIT_TARGET_HEROES_AND_CREEPS,
						OnBulletThink = function(p, cm)
							cm.angularVelocity = cm.angularVelocity + 20
							if IsValid(cm.target) and not cm.target:IsAlive() then
								cm.target = nil
							end
						end,
						OnBulletHit = function(M, p, cm)
							a3:DealDamage(
								M,
								nil,
								aN,
								EOM_DAMAGE_TYPES.DAMAGE_TYPE_NONE,
								EOM_DAMAGE_FLAGS.NO_CRIT + EOM_DAMAGE_FLAGS.SWORD
							)
							if ci > 0 then
								local cq = cm.__thinker:GetAbsOrigin()
								DoCleaveAction(
									a3,
									M,
									100,
									200,
									ci,
									function(cr)
										if cr == M then
											return
										end
										a3:DealDamage(
											cr,
											nil,
											aN,
											EOM_DAMAGE_TYPES.DAMAGE_TYPE_NONE,
											EOM_DAMAGE_FLAGS.NO_CRIT + EOM_DAMAGE_FLAGS.SWORD
										)
									end,
									DOTA_UNIT_TARGET_TEAM_ENEMY,
									DOTA_UNIT_TARGET_CREEP + DOTA_UNIT_TARGET_HERO,
									nil,
									cq
								)
								local cs = ParticleManager:CreateParticle(
									"particles/econ/items/sven/sven_ti7_sword/sven_ti7_sword_spell_great_cleave.vpcf",
									PATTACH_WORLDORIGIN,
									cm.__thinker
								)
								ParticleManager:SetParticleControl(cs, 0, cq)
								ParticleManager:SetParticleControlForward(cs, 0, M:GetAbsOrigin() - cq)
								ParticleManager:ReleaseParticleIndex(cs)
							end
							Bullet:DestroyBullet(cm)
						end,
					})
					if co >= 0 then
						if cp ~= nil then
							a3.__swordGroup[co + 1] = cp
						else
							d(a3.__swordGroup, co, 1)
						end
					end
					self:EmitSound("Hero_Pangolier.PreAttack")
				end
				return 0.1
			end,
		})
		self.__swordGroup = m(self.__swordGroup, cl)
		Event:Fire("call_sword", { caster = self, extra = cj })
	end
	CDOTA_BaseNPC.SwordWave = function(self, ct, ag, aN, cu)
		if cu == nil then
			cu = 0
		end
		local a3 = self
		local cv = 1 + GetBladeSpeedAmplify(a3) * 0.01
		local cw = cv > 1 and 5 or 0
		local cx = 1 + cu * SWORD_INTENT_PCT_PER_STACK * 0.01
		local ah = 800 * cx * cv + GetBulletRange(self)
		local cy = a3:HasItem("item_crit_blade")
		Bullet:CreateLinearBullet({
			caster = a3,
			spawnOrigin = ct,
			direction = ag,
			moveSpeed = 3000,
			distance = ah,
			destroyOnBounce = true,
			bounce = cw,
			effectName = "particles/units/benediction/invoker_deafening_blast.vpcf",
			radius = 200,
			teamFilter = DOTA_UNIT_TARGET_TEAM_ENEMY,
			typeFilter = UNIT_AND_BUILDING,
			OnBulletBounceEnd = function(cm)
				ParticleManager:DestroyParticle(cm.__particleID, false)
				local bn = ParticleManager:CreateParticle(cm.effectName, PATTACH_CUSTOMORIGIN, cm.caster)
				ParticleManager:SetParticleControlTransformForward(bn, 0, cm.__position, cm.__velocity:Normalized())
				ParticleManager:SetParticleControl(bn, 1, cm.__velocity)
				cm.__particleID = bn
			end,
			OnBulletThink = function(p, cm)
				if cy then
					local cz = Bullet:GetBulletInLine(cm.__previous or cm.__position, cm.__position, 200)
					a3:ShootDown(cz)
				end
			end,
			OnBulletHit = function(aM)
				local cA = aN * cx * cv
				local aZ = {
					attacker = a3,
					target = aM,
					damage = cA,
					damage_type = EOM_DAMAGE_TYPES.DAMAGE_TYPE_NONE,
					damage_flags = EOM_DAMAGE_FLAGS.BLADE,
					damage_category = DOTA_DAMAGE_CATEGORY_BARRIER,
				}
				a3:DealDamage(
					aM,
					nil,
					cA * (1 + GetBladeDamageAmplify(a3, aZ) * 0.01),
					EOM_DAMAGE_TYPES.DAMAGE_TYPE_NONE,
					EOM_DAMAGE_FLAGS.BLADE
				)
			end,
		})
		a3:EmitSound("Hero_Kez.FalconRush.Sai.Target")
	end
	CDOTA_BaseNPC.SwordCircle = function(self, aN, cx)
		if cx == nil then
			cx = 1
		end
		local a3 = self
		local cB = 300 * (1 + GetAoeAmplify(self) * 0.01)
		local cy = a3:HasItem("item_crit_blade")
		local cv = 1 + GetBladeSpeedAmplify(a3) * 0.01
		local cC = cB * cx * cv
		local cA = aN * cx * cv
		local bP = FindEnemiesInRadius(a3, a3:GetAbsOrigin(), cC)
		for b7, aM in ipairs(bP) do
			local aZ = {
				attacker = a3,
				target = aM,
				damage = cA,
				damage_type = EOM_DAMAGE_TYPES.DAMAGE_TYPE_NONE,
				damage_flags = EOM_DAMAGE_FLAGS.BLADE,
				damage_category = DOTA_DAMAGE_CATEGORY_BARRIER,
			}
			a3:DealDamage(
				aM,
				nil,
				cA * (1 + GetBladeDamageAmplify(a3, aZ) * 0.01),
				EOM_DAMAGE_TYPES.DAMAGE_TYPE_NONE,
				EOM_DAMAGE_FLAGS.BLADE
			)
		end
		if cy then
			local cz = Bullet:GetBulletInRadius(a3:GetAbsOrigin(), cC)
			a3:ShootDown(cz)
		end
		local bn = ParticleManager:CreateParticle(
			"particles/units/heroes/hero_kez/kez_hungering_blades.vpcf",
			PATTACH_ABSORIGIN,
			a3
		)
		ParticleManager:SetParticleControl(bn, 2, Vector(cC, 0, 0))
		ParticleManager:ReleaseParticleIndex(bn)
		a3:EmitSound("Hero_Kez.RaptorDance.Katana.Slash")
	end
	CDOTA_BaseNPC.Frozen = function(self, aM, cD)
		if cD == nil then
			cD = 1
		end
		if cD == 0 then
			return
		end
		local R = aM:AddNewModifier(self, nil, "modifier_frozen_debuff", { stack = cD, entIndex = self:entindex() })
		local bY = IsValid(R) and R:GetStackCount() or 0
		Event:Fire("frozen_event", { target = aM, caster = self, addStack = cD, stack = bY })
	end
	CDOTA_BaseNPC.IsFrozen = function(self)
		return self:HasModifier("modifier_frozen_debuff")
	end
	CDOTA_BaseNPC.Freeze = function(self, aM, a8)
		if aM:IsBoss() then
			return
		end
		aM:AddNewModifier(self, nil, "modifier_freeze_debuff", { duration = a8 })
	end
	CDOTA_BaseNPC.IsFreeze = function(self)
		return self:HasModifier("modifier_freeze_debuff")
	end
	CDOTA_BaseNPC.TriggerDecayOnce = function(self)
		local R = self:FindModifierByName("modifier_frozen_debuff")
		if IsValid(R) then
			return R:TriggerDecayOnce()
		end
	end
	CDOTA_BaseNPC.GetFrozenStack = function(self, a3)
		local R = self:FindModifierByName("modifier_frozen_debuff")
		if IsValid(R) then
			return R:GetIceStack(a3:entindex())
		end
		return 0
	end
	CDOTA_BaseNPC.FrozenBurst = function(self, aN, cE, p, cj)
		if cj == nil then
			cj = false
		end
		local bP = FindUnitsInRadius(
			self:GetTeamNumber(),
			p,
			nil,
			200,
			DOTA_UNIT_TARGET_TEAM_ENEMY,
			UNIT_AND_BUILDING,
			DOTA_UNIT_TARGET_FLAG_NONE,
			FIND_ANY_ORDER,
			false
		)
		local cF = GetFrozenBurstStack(self)
		local cG = cE + cF
		for t, M in ipairs(bP) do
			self:Frozen(M, cE + cF)
			self:DealDamage(M, nil, aN, EOM_DAMAGE_TYPES.DAMAGE_TYPE_NONE, EOM_DAMAGE_FLAGS.FREEZE_DAMAGE)
		end
		local bn = ParticleManager:CreateParticle(
			"particles/units/benediction/lich_frost_nova.vpcf",
			PATTACH_CUSTOMORIGIN,
			nil
		)
		ParticleManager:SetParticleControl(bn, 0, p)
		ParticleManager:SetParticleControl(bn, 1, Vector(200, 200, 200))
		ParticleManager:ReleaseParticleIndex(bn)
		Event:Fire(
			"frozen_burst",
			{ caster = self, position = p, base_frozen_stack = cE, added_frozen = cG, targets = bP, extra = cj }
		)
	end
	CDOTA_BaseNPC.CreateIceVortex = function(self, p, aN, cE, a8)
		local cH, cI = self, "__iceVortexThinkers"
		if cH[cI] == nil then
			cH[cI] = {}
		end
		local cJ = self.__iceVortexThinkers
		local cK = {}
		do
			local b0 = #cJ - 1
			while b0 >= 0 do
				do
					local cL = cJ[b0 + 1]
					if not IsValid(cL) then
						d(cJ, b0, 1)
						goto cM
					end
					local cN = cL:FindModifierByName("modifier_ice_vortex_custom")
					if not IsValid(cN) then
						d(cJ, b0, 1)
						goto cM
					end
					if cN:CanMerge(p) then
						cK[#cK + 1] = cN
					end
				end
				::cM::
				b0 = b0 - 1
			end
		end
		if #cK > 0 then
			local cO = cK[1]
			cO:Merge(p, aN, cE, a8)
			do
				local b0 = 1
				while b0 < #cK do
					do
						local cN = cK[b0 + 1]
						if not IsValid(cN) then
							goto cP
						end
						local cQ = cN
						cO:Merge(cQ:GetParent():GetAbsOrigin(), cQ.damage, cQ.frozen, cQ:GetRemainingTime(), cQ.radius)
						cQ:Destroy()
					end
					::cP::
					b0 = b0 + 1
				end
			end
			return
		end
		CreateModifierThinker(
			self,
			nil,
			"modifier_ice_vortex_custom",
			{ entIndex = self:entindex(), damage = aN, frozen = cE, duration = a8, radius = 275 },
			p,
			self:GetTeamNumber(),
			false
		)
	end
	CDOTA_BaseNPC.ThrowBloodSpear = function(self, aM, Y, aN, cj)
		if cj == nil then
			cj = false
		end
		if not IsValid(aM) or not aM:IsAlive() then
			return
		end
		Bullet:CreateTrackingBullet({
			caster = self,
			target = aM,
			ability = Y,
			effectName = "particles/units/benediction/huskar_burning_spear.vpcf",
			moveSpeed = 900,
			spawnOrigin = self:GetAttachmentPosition("attach_hitloc"),
			OnBulletHit = function(cR)
				local cA = toFiniteNumber(aN)
				self:Bleed(cR, cA)
				if cA > 0 then
					self:DealDamage(cR, Y, cA, EOM_DAMAGE_TYPES.DAMAGE_TYPE_NONE)
				end
				Event:Fire("blood_spear", { caster = self, target = cR })
				self:EmitSound("Hero_BrewMaster.CinderBrew.Ignite", cR:GetAbsOrigin())
			end,
		})
	end
	CDOTA_BaseNPC.ThrowSnowball = function(self, aM, Y, cE, aN, cj)
		if cj == nil then
			cj = false
		end
		if not IsValid(aM) or not aM:IsAlive() then
			return
		end
		local cS = GetSnowballBounceCount(self)
		Bullet:CreateTrackingBullet({
			caster = self,
			target = aM,
			ability = nil,
			effectName = "particles/units/benediction/snowball_projectile.vpcf",
			moveSpeed = 900,
			spawnOrigin = self:GetAttachmentPosition("attach_hitloc"),
			OnBulletHit = function(aM, p, cm)
				self:Frozen(aM, cE)
				local aV = toFiniteNumber(aN)
				aN = aV + GetSnowballDamage(self, { target = aM, damage = aV })
				if aN > 0 then
					self:DealDamage(aM, Y, aN, EOM_DAMAGE_TYPES.DAMAGE_TYPE_NONE, EOM_DAMAGE_FLAGS.FREEZE_DAMAGE)
				end
				self:EmitSound("FrostivusConsumable.Snowball.Target", aM:GetAbsOrigin())
				if cS > 0 then
					local bP = FindEnemiesInRadius(self, p, 500, FIND_CLOSEST)
					ArrayRemove(bP, aM)
					if #bP > 0 then
						cm.target = bP[1]
						if cm.__particleID ~= nil then
							ParticleManager:SetParticleControlTransformForward(
								cm.__particleID,
								0,
								p,
								cm.__velocity:Normalized()
							)
							ParticleManager:SetParticleControlEnt(
								cm.__particleID,
								1,
								cm.target,
								PATTACH_POINT_FOLLOW,
								"attach_hitloc",
								cm.target:GetAbsOrigin(),
								false
							)
						end
						cS = cS - 1
						return false
					end
				end
			end,
		})
		Event:Fire("throw_snowball", { caster = self, target = aM, extra = cj })
	end
	CDOTA_BaseNPC.IceStrike = function(self, aM, Y, aN, cj)
		if aN == nil then
			aN = 0
		end
		if cj == nil then
			cj = false
		end
		if not IsValid(aM) or not aM:IsAlive() then
			return
		end
		local cT = IsValid(Y)
		if cT then
			local cU = KeyValues.items[Y:GetAbilityName()]
			if cU ~= nil then
				cU = cU.Access
			end
			cT = cU == "Bless"
		end
		if cT and not self:CanTriggerProc("bless_ice_strike", 0.1) then
			return
		end
		local bn = ParticleManager:CreateParticleWithCaster(
			"particles/generic_gameplay/sect_ice_freezing_attack.vpcf",
			PATTACH_CUSTOMORIGIN,
			nil,
			self,
			ParticleEffectLevel.Low
		)
		if bn ~= -1 then
			ParticleManager:SetParticleControlEnt(bn, 0, aM, PATTACH_ABSORIGIN_FOLLOW, nil, aM:GetAbsOrigin(), false)
			ParticleManager:SetParticleControl(
				bn,
				1,
				aM:GetAbsOrigin() + RandomVector(RandomInt(0, 150)) + Vector(0, 0, 1200)
			)
			ParticleManager:ReleaseParticleIndex(bn)
		end
		self:StartThink(0.2, DoUniqueString("ice_delay"), function()
			if IsValid(aM) and IsValid(self) then
				local br = self:GetPlayerOwnerID()
				if Privilege:HasPrivilege("privilege_myth_005", br) then
					local bG = Privilege:GetPlayerDynamicValue("privilege_myth_005", br, "value")
					local cV = FindEnemiesInRadius(self, aM:GetAbsOrigin(), bG, FIND_CLOSEST)
					self:DealDamage(cV, Y, aN, EOM_DAMAGE_TYPES.DAMAGE_TYPE_NONE, EOM_DAMAGE_FLAGS.FREEZE_DAMAGE)
				else
					self:DealDamage(aM, Y, aN, EOM_DAMAGE_TYPES.DAMAGE_TYPE_NONE, EOM_DAMAGE_FLAGS.FREEZE_DAMAGE)
				end
				self:EmitSound("Frostivus.Item.Snowball.Target", aM:GetAbsOrigin())
			end
			return -1
		end)
		Event:Fire("ice_strike", { caster = self, target = aM, extra = cj })
	end
	CDOTA_BaseNPC.Bleed = function(self, aM, bY)
		aM:AddNewModifier(self, nil, "modifier_bleed", { stack = bY, entIndex = self:entindex() })
	end
	CDOTA_BaseNPC.IsBleed = function(self)
		local R = self:FindModifierByName("modifier_bleed")
		return IsValid(R)
	end
	CDOTA_BaseNPC.GetBleedStack = function(self, a3)
		local R = self:FindModifierByName("modifier_bleed")
		if IsValid(R) then
			return R:GetBleedStack(a3:entindex())
		end
		return 0
	end
	CDOTA_BaseNPC.TriggerBleed = function(self, a3, cx)
		if cx == nil then
			cx = 1
		end
		local R = self:FindModifierByName("modifier_bleed")
		if IsValid(R) then
			return R:TriggerBleed(a3, cx)
		end
	end
	CDOTA_BaseNPC.Burning = function(self, aM, Y, bY)
		aM:AddNewModifier(
			self,
			Y,
			"modifier_burning",
			{ stack = math.floor(bY), entIndex = self:entindex(), duration = 5 }
		)
	end
	CDOTA_BaseNPC.IsBurning = function(self)
		local R = self:FindModifierByName("modifier_burning")
		return IsValid(R)
	end
	CDOTA_BaseNPC.GetBurningStack = function(self, a3)
		local R = self:FindModifierByName("modifier_burning")
		if IsValid(R) then
			return R:GetBurningStack(a3:entindex())
		end
		return 0
	end
	CDOTA_BaseNPC.TriggerBurning = function(self, a3)
		local R = self:FindModifierByName("modifier_burning")
		if IsValid(R) then
			return R:TriggerBurning(a3)
		end
	end
	CDOTA_BaseNPC.AddInvulnerable = function(self, a8)
		self:AddNewModifier(self, nil, "modifier_invulnerable_buff", { duration = a8 })
	end
	CDOTA_BaseNPC.CreateWisp = function(self, ap, aU)
		local R = self:AddNewModifier(self, nil, "modifier_wisps", { unit_name = ap })
		if IsValid(R) then
			return R:CreateWisp(ap, aU)
		end
	end
	CDOTA_BaseNPC.RemoveWisp = function(self, cW)
		local R = self:FindModifierByName("modifier_wisps")
		if IsValid(R) then
			R:RemoveWisp(cW)
		end
	end
	CDOTA_BaseNPC.ShootDown = function(self, cX, cY)
		if cY == nil then
			cY = self:HasItem("item_holy_reflect")
		end
		local aN = GetReflectDamage(self)
		for t, cm in ipairs(cX) do
			if IsValid(cm.caster) and Bullet:IsReflectable(cm) and not cm.caster:IsFriendly(self) then
				if Bullet:IsLinearBullet(cm) then
					if cY then
						Bullet:CreateLinearBullet({
							caster = self,
							direction = -cm.direction:Normalized(),
							spawnOrigin = cm.__position,
							effectName = cm.effectName,
							moveSpeed = cm.moveSpeed * 3,
							radius = cm.radius,
							distance = cm.distance,
							teamFilter = DOTA_UNIT_TARGET_TEAM_ENEMY,
							typeFilter = DOTA_UNIT_TARGET_HEROES_AND_CREEPS,
							OnBulletHit = function(aM, p, cm)
								self:DealDamage(
									aM,
									nil,
									aN,
									EOM_DAMAGE_TYPES.DAMAGE_TYPE_NONE,
									EOM_DAMAGE_FLAGS.REFLECT_DAMAGE
								)
							end,
							ParticleCreator = cm.ParticleCreator,
						})
					end
					Bullet:DestroyBulletByID(cm.__projIndex)
				elseif Bullet:IsGuidedBullet(cm) then
					if cY then
						Bullet:CreateGuidedBullet({
							caster = self,
							direction = -cm.__velocity:Normalized(),
							effectName = cm.effectName,
							spawnOrigin = cm.__position,
							moveSpeed = cm.moveSpeed * 3,
							radius = cm.radius,
							lifeTime = cm.lifeTime,
							teamFilter = DOTA_UNIT_TARGET_TEAM_ENEMY,
							typeFilter = DOTA_UNIT_TARGET_HEROES_AND_CREEPS,
							OnBulletHit = function(aM, p, cm)
								self:DealDamage(aM, nil, aN)
								return true
							end,
							ParticleCreator = cm.ParticleCreator,
						})
					end
					Bullet:DestroyBulletByID(cm.__projIndex)
				end
			end
		end
		if #cX > 0 then
			Event:Fire("avoid_damage", { unit = self })
		end
	end
	CDOTA_BaseNPC.Weaken = function(self, aM, bY)
		if bY == nil then
			bY = 1
		end
		aM:AddNewModifier(self, nil, "modifier_weak_debuff", { stack = bY, duration = WEAK_DURATION })
	end
	CDOTA_BaseNPC.IsWeaken = function(self)
		local R = self:FindModifierByName("modifier_weak_debuff")
		return IsValid(R)
	end
	CDOTA_BaseNPC.GetWeakenStack = function(self, a3)
		local R = self:FindModifierByName("modifier_weak_debuff")
		if IsValid(R) then
			return R:GetWeakenStack(a3:entindex())
		end
		return 0
	end
	CDOTA_BaseNPC.AddExecuteThreshold = function(self, aM, bY)
		aM:AddNewModifier(self, nil, "modifier_execute_threshold", { stack = math.floor(bY), duration = 5 })
	end
	CDOTA_BaseNPC.IsBoss = function(self)
		return n(self:GetUnitLabel(), "boss")
	end
	CDOTA_BaseNPC.IsElite = function(self)
		return self:HasModifier("modifier_elite")
	end
	CDOTA_BaseNPC.IsCreep = function(self)
		return n(self:GetUnitLabel(), "creep")
	end
end
if IsServer() then
	CDOTA_BaseNPC.SimulateCast = function(self, cZ)
		self:RemoveModifierByName("modifier_simulate_cast")
		local av = cZ.castPoint or 0
		local a8 = math.max(cZ.duration or 0, av or 0)
		local aJ = {
			duration = a8,
			castPoint = av,
			castAnimation = cZ.castAnimation,
			orderType = cZ.orderType,
			animationRate = cZ.animationRate or 1,
			animationFadeIn = cZ.animationFadeIn,
			animationFadeOut = cZ.animationFadeOut,
			position = cZ.position and VectorToString(cZ.position) or nil,
			targetIndex = IsValid(cZ.target) and cZ.target:entindex() or nil,
			activityModifier = cZ.activityModifier,
		}
		local R = self:AddNewModifier(self, nil, "modifier_simulate_cast", aJ)
		if IsValid(R) then
			R.OnSpellStart = cZ.OnSpellStart
			R.OnFinish = cZ.OnFinish
		end
	end
end
if IsServer() then
	CDOTA_BaseNPC.PushOff = function(self, p)
		if self:HasState(StateEnum.KNOCKBACK_IMMUNE) then
			return
		end
		self:SetAbsOrigin(p)
		local c_ = self:GetHullRadius() + 50
		local d0 = FindEnemiesInRadius(self, p, c_)
		for b7, aM in ipairs(d0) do
			aM:KnockBack(CalcDirection2D(aM, p), c_ - CalcDistance(aM, p), 0, 0.06)
		end
		FindClearSpaceForUnit(self, p, true)
	end
end
if IsServer() then
	CDOTA_BaseNPC.IsCasting = function(self)
		return self:IsChanneling()
			or self:HasModifier("modifier_simulate_cast")
			or self:HasModifier("modifier_passive_cast")
			or self:GetCurrentActiveAbility() ~= nil
	end
end
BaseNPC.IsHealthy = function(self)
	return self:GetHealthPercent() >= HEALTHY_PCT
end
BaseNPC.IsLowHealth = function(self)
	return self:GetHealthPercent() <= LOW_HEALTH_PCT
end
BaseNPC.IsCloseRange = function(self, aM)
	return CalcDistance(self, aM) <= CLOSE_RANGE
end
BaseNPC.IsFarRange = function(self, aM)
	return CalcDistance(self, aM) >= FAR_RANGE
end
if IsServer() then
	CDOTA_BaseNPC.Poison = function(self, aM, bY)
		if bY <= 0 then
			return
		end
		aM:AddNewModifier(self, nil, "modifier_poison_custom", { stack = bY, entIndex = self:entindex() })
		Event:Fire("poison_event", { target = aM, caster = self, addStack = bY, stack = aM:GetPoisonStack(self) })
	end
	CDOTA_BaseNPC.IsPoisoned = function(self)
		local R = self:FindModifierByName("modifier_poison_custom")
		return IsValid(R)
	end
	CDOTA_BaseNPC.GetPoisonStack = function(self, a3)
		local R = self:FindModifierByName("modifier_poison_custom")
		if IsValid(R) then
			return R:GetPoisonStack(a3:entindex())
		end
		return 0
	end
	CDOTA_BaseNPC.TriggerPoison = function(self, a3)
		local R = self:FindModifierByName("modifier_poison_custom")
		return R and R:TriggerPoison(a3)
	end
	CDOTA_BaseNPC.PoisionBottle = function(self, a8, d1, bG, d2)
		if bG == nil then
			bG = 100
		end
		if d2 == nil then
			d2 = 180
		end
		if self.__poisonGroup == nil then
			self.__poisonGroup = {}
		end
		local br = self:GetPlayerOwnerID()
		if Privilege:HasPrivilege("privilege_myth_024", br) then
			local bE = Privilege:GetPrivilegeSpecialValue("privilege_myth_024", 1, "value", self)
			a8 = a8 * (1 + bE * 0.01)
			d1 = d1 * (1 + bE * 0.01)
		end
		do
			local t = #self.__poisonGroup - 1
			while t >= 0 do
				local d3 = self.__poisonGroup[t + 1]
				if Bullet:GetBulletData(d3) == nil then
					d(self.__poisonGroup, t, 1)
				end
				t = t - 1
			end
		end
		while POISON_BOTTLE_MAX_COUNT > 0 and #self.__poisonGroup >= POISON_BOTTLE_MAX_COUNT do
			local d4 = 0
			local d5 = math.huge
			do
				local t = 0
				while t < #self.__poisonGroup do
					local cm = Bullet:GetBulletData(self.__poisonGroup[t + 1])
					local d6 = cm and cm.__lifeTimeRemaining
					if d6 == nil then
						d6 = 0
					end
					local d7 = d6
					if d7 < d5 then
						d5 = d7
						d4 = t
					end
					t = t + 1
				end
			end
			local d3 = self.__poisonGroup[d4 + 1]
			d(self.__poisonGroup, d4, 1)
			Bullet:DestroyBulletByID(d3)
		end
		local cl = Bullet:CreateGroupSurroundBullet(1, {
			caster = self,
			group = "PoisionBottle" .. tostring(self:entindex()),
			circleRadius = bG,
			angularVelocity = d2,
			offset = 128,
			lifeTime = a8,
			effectName = "particles/abilities/dupingzi.vpcf",
			interval = 1,
			teamFilter = DOTA_UNIT_TARGET_TEAM_ENEMY,
			typeFilter = DOTA_UNIT_TARGET_HEROES_AND_CREEPS,
			radius = 100,
			OnBulletCreated = function(cm)
				cm.poisionStack = d1
			end,
			OnBulletThink = function(p, cm)
				if cm.circleRadius < bG then
					cm.circleRadius = cm.circleRadius + 1
				end
			end,
			OnBulletHit = function(aM, d8, cm)
				local d9 = toFiniteNumber(cm.poisionStack)
				self:Poison(aM, d9)
				if Privilege:HasPrivilege("privilege_suit_026", self:GetPlayerOwnerID()) then
					cm.poisionStack = d9
						+ Privilege:GetPrivilegeSpecialValue("privilege_suit_026", 1, "extra_count", self)
				end
			end,
			OnBulletDestroy = function(cm)
				cm.poisionStack = nil
			end,
		})
		self.__poisonGroup = m(self.__poisonGroup, cl)
		return cl
	end
	CDOTA_BaseNPC.ThrowPoisonBottle = function(self, p, Y, da, a8)
		local ct = self:GetAbsOrigin()
		local ah = CalcDistance(p, ct)
		local db = a8 or ah / 900
		local dc = db > 0 and ah / db or 900
		Bullet:CreateLinearBullet({
			spawnOrigin = self:GetAbsOrigin(),
			moveSpeed = dc,
			direction = CalcDirection2D(p, self),
			distance = ah,
			ParticleCreator = function()
				local bn = ParticleManager:CreateParticle(
					"particles/units/benediction/bottle_poison.vpcf",
					PATTACH_CUSTOMORIGIN,
					nil
				)
				ParticleManager:SetParticleControl(bn, 0, self:GetAbsOrigin())
				ParticleManager:SetParticleControl(bn, 1, p)
				ParticleManager:SetParticleControl(bn, 2, Vector(dc, 0, 0))
				return bn
			end,
			OnBulletDestroy = function(cm)
				self:PoisonPool(cm.__position, toFiniteNumber(da))
			end,
		})
	end
	CDOTA_BaseNPC.PoisonPool = function(self, p, bY, bG)
		if bG == nil then
			bG = 200
		end
		CreateModifierThinker(
			self,
			nil,
			"modifier_poison_pool",
			{ entIndex = self:entindex(), duration = 3, radius = bG, stack = bY },
			p,
			self:GetTeamNumber(),
			false
		)
		Event:Fire("poison_pool_event", { caster = self, position = p })
	end
end
if IsServer() then
	CDOTA_BaseNPC.Laser = function(self, ag, aN, I)
		if I == nil then
			I = EOM_DAMAGE_FLAGS.NONE
		end
		I = bit.bor(I, EOM_DAMAGE_FLAGS.SHIELD_DAMAGE)
		local ah = LASER_LENGTH + GetBulletRange(self)
		local a3 = self
		local cw = GetLaserBounceCount(a3) + GetBounceCount(a3)
		print(GetLaserBounceCount(a3), GetBounceCount(a3))
		local a8 = 0.1
		local dd = a3:HasItem("item_holy_auto")
		local de
		de = function(df, dg, dh)
			Bullet:CreateLinearBullet({
				caster = a3,
				spawnOrigin = df,
				direction = dg,
				radius = LASER_WIDTH,
				teamFilter = DOTA_UNIT_TARGET_TEAM_ENEMY,
				typeFilter = UNIT_AND_BUILDING,
				flagFilter = DOTA_UNIT_TARGET_FLAG_NONE,
				moveSpeed = ah / a8,
				distance = ah,
				thinker = true,
				bounce = dh,
				OnBulletHit = function(M)
					a3:DealDamage(M, nil, aN, EOM_DAMAGE_TYPES.DAMAGE_TYPE_NONE, I)
				end,
				OnBulletBounceEnd = function(cm)
					cm.__lifeTimeRemaining = a8
					local bn = ParticleManager:CreateParticle(
						"particles/units/benediction/holy_laser.vpcf",
						PATTACH_CUSTOMORIGIN,
						nil
					)
					ParticleManager:SetParticleControl(bn, 9, Bullet:GetData(cm.__projIndex, "bounce_position", df))
					ParticleManager:SetParticleControl(bn, 1, cm.__position)
					Bullet:SaveData(cm.__projIndex, "bounce_position", cm.__position)
					print("OnBulletBounceEnd", dh)
				end,
				OnBulletDestroy = function(cm)
					local bn = ParticleManager:CreateParticle(
						"particles/units/benediction/holy_laser.vpcf",
						PATTACH_CUSTOMORIGIN,
						nil
					)
					ParticleManager:SetParticleControl(bn, 9, Bullet:GetData(cm.__projIndex, "bounce_position", df))
					ParticleManager:SetParticleControl(bn, 1, cm.__position)
					local di = cm.bounce or 0
					if di <= 0 then
						return
					end
					local dj = cm.__position
					local dk = dj + RandomVector(ah)
					if dd then
						local bP = FindEnemiesInRadius(a3, dj, ah, FIND_ANY_ORDER)
						local aM = GetRandomElement(bP)
						if IsValid(aM) then
							dk = aM:GetAbsOrigin() + RandomVector(aM:GetHullRadius())
						end
					end
					de(dj, CalcDirection2D(dk, dj), di - 1)
				end,
			})
		end
		a3:EmitSound("Hero_Tinker.LaserImpact")
		de(a3:GetAbsOrigin() + Vector(0, 0, 75), ag, cw)
	end
end