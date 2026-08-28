--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "override/CDOTA_BaseNPC"
local b = require("lualib_bundle")
local c = b.__TS__ArrayIsArray
local d = b.__TS__ArrayFilter
local e = b.__TS__ArrayForEach
local f = b.__TS__ArrayMap
local g = b.__TS__ArraySome
local h = b.__TS__Delete
local i = b.__TS__ArraySlice
local j = b.__TS__ArrayConcat
local k = b.__TS__ArraySplice
local l = b.__TS__StringIncludes
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
MAX_LIGHTNING_STRIKE_EFFECTS_PER_SECOND = 5
MAX_LIGHTNING_STRIKE_SOUNDS_PER_SECOND = 1
MAX_LIGHTNING_STRIKE_TARGET_HITS_PER_FRAME = 40
LIGHTNING_STRIKE_EFFECT_LIMIT_INTERVAL_SECONDS = 0.1
ARC_LIGHTNING_SOUND_COOLDOWN_SECONDS = 0.1
MAX_CALL_SWORD_GROUP_SIZE = 40
BaseNPC.IsFriendly = function(self, m)
	if IsValid(self) and IsValid(m) then
		return self:GetTeamNumber() == m:GetTeamNumber()
	end
	return false
end
BaseNPC.GetProperty = function(self, n)
	local o = PROPERTY_MAP_REVERSE[n]
	if o == nil then
		return 0
	end
	return PropertySystem:GetPropertyValueEx(o, self:GetPlayerOwnerID(), self:entindex())
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
	CDOTA_BaseNPC.SetHealth = function(self, p)
		if not LargeNumberHealth:SetHealth(self, p) then
			self:SetHealth_Engine(p)
		end
	end
	CDOTA_BaseNPC.ModifyHealth = function(self, p, q, r, s)
		if not LargeNumberHealth:ModifyHealth(self, p) then
			self:ModifyHealth_Engine(p, q, r, s)
		end
	end
end
if BaseNPC.Heal_Engine == nil then
	BaseNPC.Heal_Engine = BaseNPC.Heal
end
BaseNPC.Heal = function(self, t, q)
	local u = self:GetHealth()
	self:ModifyHealth(math.min(u + t, self:GetMaxHealth()), q, false, 0)
end
BaseNPC.HealthCost = function(self, t)
	local u = self:GetHealth()
	self:ModifyHealth(math.min(u + t, self:GetMaxHealth()), nil, false, 0)
end
if BaseNPC.GiveMana_Engine == nil then
	BaseNPC.GiveMana_Engine = BaseNPC.GiveMana
end
BaseNPC.GiveMana = function(self, v)
	self:GiveMana_Engine(v)
	Event:Fire("give_mana", { unit = self, manaAmount = v })
end
if BaseNPC.GetMaxHealth_Engine == nil then
	BaseNPC.GetMaxHealth_Engine = BaseNPC.GetMaxHealth
end
BaseNPC.GetMaxHealth = function(self)
	local w = self:GetProperty(PropertyFunction.DEFENSE_INTENSITY)
		* (1 + self:GetProperty(PropertyFunction.DEFENSE_INTENSITY_BOOST) * 0.01)
	return math.floor(
		(self:GetProperty(PropertyFunction.BASE_HEALTH) + self:GetProperty(PropertyFunction.HEALTH))
			* (1 + self:GetProperty(PropertyFunction.HEALTH_AMPLIFY) * 0.01)
			* (1 + w * INTENSITY_FACTOR * 0.01)
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
BaseNPC.HasAbilityUpgrade = function(self, x)
	return AbilityUpgrade:HasAbilityUpgrade(self, x)
end
BaseNPC.GetShield = function(self, y)
	if IsServer() then
		local z = self:FindModifierByName("modifier_shield")
		if IsValid(z) then
			if y ~= nil then
				return z:GetShieldAmount(y)
			else
				return z:GetTotalShieldAmount(y)
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
BaseNPC.GetVulnerabilityModifierValue = function(self, A)
	local z = self.__VulnerabilityModifier
	if not IsValid(z) then
		return 0
	end
	local B = z:GetVulnerabilityValue(A)
	if B == nil then
		B = 0
	end
	return B
end
BaseNPC.HasState = function(self, C)
	if IsServer() then
		return StateSystem:GetStateValue(self:entindex(), C)
	else
		return StateSystem:GetStateValueFromNetTable(self:entindex(), C)
	end
end
BaseNPC.IsBreakable = function(self)
	return self:HasState(StateEnum.BREAKABLE)
end
if IsServer() then
	if CDOTA_BaseNPC.EmitSound_Engine == nil then
		CDOTA_BaseNPC.EmitSound_Engine = CDOTA_BaseNPC.EmitSound
	end
	CDOTA_BaseNPC.EmitSound = function(self, D, E)
		if E then
			EmitSoundOnLocationWithCaster(E, D, self)
		else
			self:EmitSound_Engine(D)
		end
	end
	if CDOTA_BaseNPC.AddAbility_Engine == nil then
		CDOTA_BaseNPC.AddAbility_Engine = CDOTA_BaseNPC.AddAbility
	end
	CDOTA_BaseNPC.AddAbility = function(self, F, G)
		local H = self:AddAbility_Engine(F)
		if G ~= nil and IsValid(H) then
			H:SetLevel(G)
		end
		H:__OnCreated()
		return H
	end
	if CDOTA_BaseNPC.RemoveAbility_Engine == nil then
		CDOTA_BaseNPC.RemoveAbility_Engine = CDOTA_BaseNPC.RemoveAbility
	end
	CDOTA_BaseNPC.RemoveAbility = function(self, F)
		local H = self:FindAbilityByName(F)
		if IsValid(H) then
			self:RemoveAbilityByHandle(H)
		end
	end
	if CDOTA_BaseNPC.RemoveAbilityByHandle_Engine == nil then
		CDOTA_BaseNPC.RemoveAbilityByHandle_Engine = CDOTA_BaseNPC.RemoveAbilityByHandle
	end
	CDOTA_BaseNPC.RemoveAbilityByHandle = function(self, H)
		if IsValid(H) then
			if H.__OnDestroy ~= nil then
				H:__OnDestroy()
			end
			self:RemoveAbilityByHandle_Engine(H)
		end
	end
	CDOTA_BaseNPC.GetAttachmentPosition = function(self, I)
		if not IsValid(self) then
			return vec3_zero
		end
		return self:GetAttachmentOrigin(self:ScriptLookupAttachment(I))
	end
	if CDOTA_BaseNPC.RespawnUnit_Engine == nil then
		CDOTA_BaseNPC.RespawnUnit_Engine = CDOTA_BaseNPC.RespawnUnit
	end
	CDOTA_BaseNPC.RespawnUnit = function(self)
		if not self:UnitCanRespawn() then
			return
		end
		local J = self:FirstMoveChild()
		while J ~= nil do
			local K = J:NextMovePeer()
			if J ~= nil and J:GetClassname() ~= "" and J:GetClassname() == "dota_item_wearable" then
				UTIL_Remove(J)
			end
			J = K
		end
		self:RespawnUnit_Engine()
	end
	if CDOTA_BaseNPC.SetUnitCanRespawn_Engine == nil then
		CDOTA_BaseNPC.SetUnitCanRespawn_Engine = CDOTA_BaseNPC.SetUnitCanRespawn
	end
	CDOTA_BaseNPC.SetUnitCanRespawn = function(self, L)
		self.__unitCanRespawn_ = L
		if L == true then
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
		local M = self.__unitCanRespawn_
		if M == nil then
			M = false
		end
		return M
	end
	if CDOTA_BaseNPC.AddNewModifier_Engine == nil then
		CDOTA_BaseNPC.AddNewModifier_Engine = CDOTA_BaseNPC.AddNewModifier
	end
	CDOTA_BaseNPC.AddNewModifier = function(self, N, H, O, P, Q)
		local z = nil
		if Q ~= nil then
			if IsValid(self) and bit.band(Q, AddModifierFlag.IGNORE_DEATH) == AddModifierFlag.IGNORE_DEATH then
				if self.__isRemoving then
					return
				end
				local R = not self:IsAlive()
				if R then
					self:SetHealth(1)
				end
				z = self:AddNewModifier_Engine(N, H, O, P)
				if R then
					self:SetHealth(0)
				end
			end
		else
			z = self:AddNewModifier_Engine(N, H, O, P)
		end
		if IsValid(z) and IsValid(N) then
			local S = z:GetDuration()
			if S > 0 then
				if z:IsDebuff() then
					z:SetDuration(S * (1 + GetDebuffDuration(N, nil) * 0.01), false)
				else
					z:SetDuration(S * (1 + GetBuffDuration(N, nil) * 0.01), false)
				end
			end
		end
		return z
	end
	CDOTA_BaseNPC.ExecuteOrder = function(self, T, ...)
		local U = { ... }
		local V
		local m
		local W
		local X = { DOTA_UNIT_ORDER_MOVE_TO_POSITION, DOTA_UNIT_ORDER_ATTACK_MOVE }
		local Y = { DOTA_UNIT_ORDER_MOVE_TO_TARGET, DOTA_UNIT_ORDER_ATTACK_TARGET }
		local Z = {
			DOTA_UNIT_ORDER_CAST_POSITION,
			DOTA_UNIT_ORDER_CAST_TARGET,
			DOTA_UNIT_ORDER_CAST_TARGET_TREE,
			DOTA_UNIT_ORDER_CAST_NO_TARGET,
			DOTA_UNIT_ORDER_CAST_TOGGLE,
		}
		if TableFindKey(X, T) ~= nil then
			W = U[1]
		elseif TableFindKey(Y, T) ~= nil then
			m = U[1]
		elseif TableFindKey(Z, T) ~= nil then
			if T == DOTA_UNIT_ORDER_CAST_POSITION then
				V = U[1]
				W = U[2]
			elseif T == DOTA_UNIT_ORDER_CAST_NO_TARGET or T == DOTA_UNIT_ORDER_CAST_TOGGLE then
				V = U[1]
			else
				V = U[1]
				m = U[2]
			end
		end
		ExecuteOrderFromTable({
			UnitIndex = self:entindex(),
			OrderType = T,
			TargetIndex = IsValid(m) and m:entindex() or nil,
			AbilityIndex = IsValid(V) and V:entindex() or nil,
			Position = W,
			Queue = false,
		})
	end
	CDOTA_BaseNPC.Dash = function(self, _, a0, a1, S, a2)
		if not self:IsAlive() then
			return
		end
		local a3 = GetDashDistance(self, nil)
		local a4 = { direction = _, dash_duration = S, dash_distance = a0 + a3, dash_height = a1 }
		self:RemoveModifierByName("modifier_dash")
		local a5 = self:AddNewModifier(self, nil, "modifier_dash", a4)
		if IsValid(a5) and a2 ~= nil then
			a5.callback = a2
		end
	end
	CDOTA_BaseNPC.KnockBack = function(self, _, a0, a1, S, a2)
		if not self:IsAlive() then
			return
		end
		if self:HasState(StateEnum.KNOCKBACK_IMMUNE) then
			return
		end
		local a4 = { direction = _, dash_duration = S, dash_distance = a0, dash_height = a1 }
		self:RemoveModifierByName("modifier_knockback_custom")
		local a5 = self:AddNewModifier(self, nil, "modifier_knockback_custom", a4)
		if IsValid(a5) and a2 ~= nil then
			a5.callback = a2
		end
	end
	CDOTA_BaseNPC.Stagger = function(self, S, a6, a7)
		if not self:IsAlive() then
			return
		end
		local a4 = { duration = S, animation = a6 or ACT_DOTA_DISABLED, animation_rate = a7 or 1 }
		self:RemoveModifierByName("modifier_stagger")
		self:AddNewModifier(self, nil, "modifier_stagger", a4)
	end
	CDOTA_BaseNPC.Stun = function(self, N, H, S)
		if not IsValid(self) then
			return
		end
		if S <= 0 then
			return
		end
		if self:HasState(StateEnum.STUN_IMMUNE) then
			return
		end
		self:AddNewModifier(N, H, "modifier_stunned", { duration = S })
	end
	CDOTA_BaseNPC.SummonUnit = function(self, a8, E, S, a9)
		local aa = self:GetForwardVector()
		local ab = {
			MapUnitName = a8,
			angles = (((tostring(aa.x) .. " ") .. tostring(aa.y)) .. " ") .. tostring(aa.z),
			teamnumber = self:GetTeamNumber(),
			NeverMoveToClearSpace = false,
			IsSummoned = "1",
		}
		if a9 ~= nil then
			ab = TableOverride(ab, a9)
		end
		local ac = CreateUnitFromTable(ab, E)
		if not IsValid(ac) then
			return nil
		end
		ac.__Summoner = self
		if S ~= nil and S > 0 then
			ac:AddNewModifier(self, nil, "modifier_kill", { duration = S })
		end
		return ac
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
	CDOTA_BaseNPC.PassiveCast = function(self, H, ad, a9, ae)
		if not IsValid(H) then
			return
		end
		if a9 == nil then
			a9 = {}
		end
		local af = a9.castPoint or H:GetCastPoint()
		local ag = a9.castAnimation or H:GetCastAnimation()
		local ah = a9.sActivityModifier
		if a9.sActivityModifier and type(a9.sActivityModifier) == "table" then
			ah = json.encode(a9.sActivityModifier)
		end
		local ai = af
		local aj = af
		local ak = ag
		local al = ad
		local am = a9.animationRate
		local an = a9.position and VectorToString(a9.position) or nil
		local ao = IsValid(a9.target) and a9.target:entindex() or nil
		local ap = a9.bFadeAnimation
		local aq = a9.fadeAnimationTime
		local ar = ah
		local as = a9.bIgnoreBackswing
		if as == nil then
			as = true
		end
		local at = {
			duration = ai,
			castPoint = aj,
			castAnimation = ak,
			orderType = al,
			animationRate = am,
			position = an,
			targetIndex = ao,
			bFadeAnimation = ap,
			fadeAnimationTime = aq,
			activityModifier = ar,
			bIgnoreBackswing = as,
			bUseCooldown = (a9.bUseCooldown == nil or a9.bUseCooldown == true) and 1 or 0,
			bUseMana = (a9.bUseMana == nil or a9.bUseMana == true) and 1 or 0,
		}
		H.CustomAbilityPhaseStart = a9.OnAbilityPhaseStart
		H.CustomAbilityPhaseInterrupted = a9.OnAbilityPhaseInterrupted
		local z = self:AddNewModifier(self, H, "modifier_passive_cast", at)
		if IsValid(z) then
			z.callback = ae
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
		for au = 0, #self.__activityModifiers - 1, 1 do
			self:AddActivityModifier_Engine(self.__activityModifiers[au + 1])
		end
	end
	CDOTA_BaseNPC.AddActivityModifier = function(self, av)
		if self.__activityModifiers == nil then
			self.__activityModifiers = {}
		end
		local aw = self.__activityModifiers
		aw[#aw + 1] = av
		self:UpdateActivityModifier()
	end
	CDOTA_BaseNPC.RemoveActivityModifier = function(self, av)
		if self.__activityModifiers == nil then
			self.__activityModifiers = {}
		end
		ArrayRemove(self.__activityModifiers, av)
		self:UpdateActivityModifier()
	end
	CDOTA_BaseNPC.DealDamage = function(self, ax, H, ay, az, aA)
		if not IsValid(self) or H ~= nil and not IsValid(H) then
			return
		end
		local aB = DOTA_DAMAGE_CATEGORY_BARRIER
		if H ~= nil then
			if az == nil then
				az = H:GetDamageType()
			end
			local aC = H:GetAbilityTag()
			if
				aC == AbilityTag.Skill
				or aC == AbilityTag.Dodge
				or aC == AbilityTag.Defense
				or aC == AbilityTag.Ultimate
			then
				aB = DOTA_DAMAGE_CATEGORY_SPELL
			end
		end
		if c(ax) then
			for au, aD in ipairs(ax) do
				do
					if not IsValid(aD) then
						goto aE
					end
					local aF = DamageSystem:AcquireDamageInfo()
					aF.attacker = self
					aF.target = aD
					aF.ability = H
					aF.damage = ay
					aF.damage_type = az or EOM_DAMAGE_TYPES.DAMAGE_TYPE_NONE
					aF.damage_flags = aA
					aF.damage_category = aB
					DamageSystem:DealDamage(aF, true)
				end
				::aE::
			end
		else
			if not IsValid(ax) then
				return
			end
			local aF = DamageSystem:AcquireDamageInfo()
			aF.attacker = self
			aF.target = ax
			aF.ability = H
			aF.damage = ay
			aF.damage_type = az or EOM_DAMAGE_TYPES.DAMAGE_TYPE_NONE
			aF.damage_flags = aA
			aF.damage_category = aB
			DamageSystem:DealDamage(aF, true)
		end
	end
	CDOTA_BaseNPC.Attack = function(self, ax, aF)
		local aG = aF and aF.baseDamage or self:GetAttackDamage()
		local aH = aF and aF.damageAmplify or 0
		local aI = aF and aF.bonusDamage or 0
		local aJ = aF and aF.damageType or EOM_DAMAGE_TYPES.DAMAGE_TYPE_PHYSICAL
		local aK = DamageSystem:AcquireDamageInfo()
		aK.attacker = self
		aK.target = ax
		aK.ability = self:GetAbilityByTag(AbilityTag.Attack)
		aK.damage = (aG + aI) * (1 + aH)
		aK.damage_category = DOTA_DAMAGE_CATEGORY_ATTACK
		aK.damage_type = aJ
		aK.damage_flags = aF and aF.flags or EOM_DAMAGE_FLAGS.NONE
		DamageSystem:DealDamage(aK, true)
	end
	CDOTA_BaseNPC.GetAbilityByTag = function(self, aL)
		if self:IsHero() then
			if aL == AbilityTag.Skill then
				return self:GetAbilityByIndex(0)
			end
			if aL == AbilityTag.Dodge then
				return self:GetAbilityByIndex(1)
			end
			if aL == AbilityTag.Defense then
				return self:GetAbilityByIndex(2)
			end
			if aL == AbilityTag.Ultimate then
				return self:GetAbilityByIndex(5)
			end
			if aL == AbilityTag.Attack then
				return self:GetAbilityByIndex(3)
			end
			if aL == AbilityTag.Interact then
				return self:GetAbilityByIndex(4)
			end
		else
			do
				local aM = 0
				while aM < self:GetAbilityCount() do
					local H = self:GetAbilityByIndex(aM)
					if IsValid(H) and H:GetAbilityTag() == aL then
						return H
					end
					aM = aM + 1
				end
			end
		end
	end
	CDOTA_BaseNPC.EachAbility = function(self, ae)
		local aN = { AbilityTag.Attack, AbilityTag.Skill, AbilityTag.Dodge, AbilityTag.Defense, AbilityTag.Ultimate }
		for au = 0, #aN - 1, 1 do
			local aC = aN[au + 1]
			local H = self:GetAbilityByTag(aC)
			if IsValid(H) then
				ae(H, aC)
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
	CDOTA_BaseNPC.AddItem = function(self, aO, aP)
		if aP == nil then
			aP = true
		end
		if self.__items == nil then
			self.__items = {}
		end
		self:AddItem_Engine(aO)
		aO:__OnCreated()
		local aQ = self.__items
		aQ[#aQ + 1] = {
			entIndex = aO:entindex(),
			itemName = aO:GetAbilityName(),
			level = aO:GetLevel(),
			stackCount = aO.__StackCount or 0,
			charge = aO.__Charge or 0,
			maxCharge = aO:GetMaxCharges(),
			chargeRestoreTime = aO.__ChargeRestoreTime or 0,
			isChargeCooldownFrozen = aO:IsChargeCooldownFrozen(),
			chargeFrozenCooldownRemaining = aO:GetChargeCooldownRemaining(),
		}
		self:TakeItem(aO)
		Event:Fire("item_added", { unit = self, item = aO })
		if aP then
			self:UpdateAbilityNetData()
		end
		return aO
	end
	CDOTA_BaseNPC.AddItemByName = function(self, aR, G, aP)
		if G == nil then
			G = 1
		end
		if aP == nil then
			aP = true
		end
		if self.__items == nil then
			self.__items = {}
		end
		local aO = self:AddItemByName_Engine(aR)
		aO:__OnCreated()
		if G > 1 then
			aO:SetLevel(G, false)
		end
		local aS = self.__items
		aS[#aS + 1] = {
			entIndex = aO:entindex(),
			itemName = aO:GetAbilityName(),
			level = aO:GetLevel(),
			stackCount = aO.__StackCount or 0,
			charge = aO.__Charge or 0,
			maxCharge = aO:GetMaxCharges(),
			chargeRestoreTime = aO.__ChargeRestoreTime or 0,
			isChargeCooldownFrozen = aO:IsChargeCooldownFrozen(),
			chargeFrozenCooldownRemaining = aO:GetChargeCooldownRemaining(),
		}
		self:TakeItem(aO)
		Event:Fire("item_added", { unit = self, item = aO })
		if aP then
			self:UpdateAbilityNetData()
		end
		return aO
	end
	CDOTA_BaseNPC.RemoveItem = function(self, aO)
		if self.__items == nil then
			self.__items = {}
		end
		if not IsValid(aO) then
			return
		end
		Event:Fire("item_consumed", { unit = self, item = aO })
		aO:__OnDestroy()
		self.__items = d(self.__items, function(aT, at)
			return at.entIndex ~= aO:entindex()
		end)
		self:RemoveItem_Engine(aO)
		Event:Fire("item_removed", { unit = self, item = aO })
		self:UpdateAbilityNetData()
	end
	CDOTA_BaseNPC.RemoveAllItem = function(self)
		if self.__items == nil then
			self.__items = {}
		end
		local aU = self:GetAllItems()
		e(aU, function(aT, aO)
			if IsValid(aO) then
				aO:__OnDestroy()
				self.__items = d(self.__items or {}, function(aT, at)
					return at.entIndex ~= aO:entindex()
				end)
				self:RemoveItem_Engine(aO)
				Event:Fire("item_removed", { unit = self, item = aO })
			end
		end)
		self.__items = {}
		CustomNetTables:SetNetData("unit", tostring(self:entindex()), nil)
	end
	CDOTA_BaseNPC.GetAllItems = function(self)
		local aV = {}
		if self.__items == nil then
			self.__items = {}
		end
		e(self.__items, function(aT, at)
			local aO = EntIndexToHScript(at.entIndex)
			if IsValid(aO) then
				aV[#aV + 1] = aO
			end
		end)
		return aV
	end
	CDOTA_BaseNPC.GetItemByName = function(self, aR)
		if self.__items == nil then
			self.__items = {}
		end
		local aO
		f(self.__items, function(aT, at)
			if at.itemName == aR then
				aO = EntIndexToHScript(at.entIndex)
			end
		end)
		return aO
	end
	CDOTA_BaseNPC.GetItemByNameAndLevel = function(self, aR, G)
		if self.__items == nil then
			self.__items = {}
		end
		local aO
		f(self.__items, function(aT, at)
			if at.itemName == aR and at.level == G then
				aO = EntIndexToHScript(at.entIndex)
			end
		end)
		return aO
	end
	CDOTA_BaseNPC.HasItem = function(self, aR)
		if self.__items == nil then
			self.__items = {}
		end
		return g(self.__items, function(aT, at)
			return at.itemName == aR
		end)
	end
	CDOTA_BaseNPC.GetItemCount = function(self, aR)
		if self.__items == nil then
			self.__items = {}
		end
		return #d(self.__items, function(aT, at)
			return at.itemName == aR
		end)
	end
	CDOTA_BaseNPC.UpdateAbilityNetData = function(self)
		if self.__items == nil then
			self.__items = {}
		end
		e(self.__items, function(aT, at)
			local aO = EntIndexToHScript(at.entIndex)
			at.stackCount = aO.__StackCount or 0
			at.charge = aO.__Charge or 0
			at.maxCharge = aO:GetMaxCharges()
			at.chargeRestoreTime = aO.__ChargeRestoreTime or 0
			at.isChargeCooldownFrozen = aO:IsChargeCooldownFrozen()
			at.chargeFrozenCooldownRemaining = aO:GetChargeCooldownRemaining()
		end)
		local aW = {}
		local aX = self:GetAbilityByTag(AbilityTag.Attack)
		if aX then
			aW[#aW + 1] = aX
		end
		local aY = self:GetAbilityByTag(AbilityTag.Skill)
		if aY then
			aW[#aW + 1] = aY
		end
		local aZ = self:GetAbilityByTag(AbilityTag.Dodge)
		if aZ then
			aW[#aW + 1] = aZ
		end
		local a_ = self:GetAbilityByTag(AbilityTag.Defense)
		if a_ then
			aW[#aW + 1] = a_
		end
		local b0 = self:GetAbilityByTag(AbilityTag.Ultimate)
		if b0 then
			aW[#aW + 1] = b0
		end
		if not self:IsRealHero() then
			return
		end
		CustomNetTables:SetNetData(
			"unit",
			tostring(self:entindex()),
			{
				items = self.__items,
				abilities = f(aW, function(aT, H)
					return {
						entIndex = H:entindex() or -1,
						stackCount = H.__StackCount or 0,
						abilityName = H:GetAbilityName(),
						charge = H.__Charge or 0,
						maxCharge = H:GetMaxCharges(),
						chargeRestoreTime = H.__ChargeRestoreTime or 0,
						isChargeCooldownFrozen = H:IsChargeCooldownFrozen(),
						chargeFrozenCooldownRemaining = H:GetChargeCooldownRemaining(),
					}
				end),
			}
		)
	end
	CDOTA_BaseNPC.CallAbilityCreated = function(self)
		do
			local au = 0
			while au < self:GetAbilityCount() do
				local H = self:GetAbilityByIndex(au)
				if IsValid(H) then
					H:__OnCreated()
				end
				au = au + 1
			end
		end
	end
	CDOTA_BaseNPC.CallAbilityRefresh = function(self)
		do
			local au = 0
			while au < self:GetAbilityCount() do
				local H = self:GetAbilityByIndex(au)
				if IsValid(H) then
					H:__OnRefresh()
				end
				au = au + 1
			end
		end
	end
	CDOTA_BaseNPC.CallAbilityDestroy = function(self)
		do
			local au = 0
			while au < self:GetAbilityCount() do
				local H = self:GetAbilityByIndex(au)
				if IsValid(H) then
					H:__OnDestroy()
				end
				au = au + 1
			end
		end
		self:RemoveAllItem()
	end
	CDOTA_BaseNPC.ChangeWeapon = function(self, b1)
		if self.__weapon ~= nil then
			self.__weapon:RemoveSelf()
			self.__weapon = nil
		end
		local a4 = KeyValues.weapon[b1]
		if a4 == nil then
			return
		end
		self.__weapon = SpawnEntityFromTableSynchronous(
			"dota_prop_customtexture",
			{
				targetname = b1,
				model = a4.model,
				StartingAnim = "ACT_DOTA_IDLE",
				StartingAnimationLoopMode = "ANIM_LOOP_MODE_LOOPING",
			}
		)
		local b2 = KeyValues.weapon_asset_modifier[b1]
		self.__weapon.__asset_modifier = {}
		if b2 ~= nil then
			if b2.particle_color ~= nil then
				self.__weapon.__asset_modifier.particle_color = RGBStringToVector(b2.particle_color)
			end
		end
		self.__weapon:FollowEntity(self, true)
		self:CheckNoDraw(self.__weapon)
	end
	CDOTA_BaseNPC.SetWeaponVisible = function(self, b3)
		self.__weapon_hidden = not b3
		if IsValid(self.__weapon) then
			self:CheckNoDraw(self.__weapon)
		end
	end
	CDOTA_BaseNPC.EquipCosmetic = function(self, b4)
		b4 = tostring(b4)
		local a4 = KeyValues.info_item_cosmetic[b4]
		if a4 == nil then
			return
		end
		local b5 = tostring(a4.type)
		if self.__cosmetics == nil then
			self.__cosmetics = {}
		end
		if b5 == "MISC" then
			local b6 = { id = b4 }
			local b7 = self.__cosmetics[b5]
			if b7 ~= nil then
				b7[#b7 + 1] = b6
			else
				self.__cosmetics[b5] = { b6 }
			end
			self:AddActivityModifier(b4)
			Cosmetic:RegisterParticleReplacements(self, b5, b4)
			if a4.model == nil then
				return
			end
			local b8 = SpawnEntityFromTableSynchronous(
				"dota_prop_customtexture",
				{
					targetname = b4,
					model = a4.model,
					StartingAnim = "ACT_DOTA_IDLE",
					StartingAnimationLoopMode = "ANIM_LOOP_MODE_LOOPING",
				}
			)
			b8:FollowEntity(self, true)
			b6.entity = b8
			return
		end
		self:UnequipCosmeticByType(b5, nil, true)
		self.__cosmetics[b5] = { id = b4 }
		self:AddActivityModifier(b4)
		Cosmetic:RegisterParticleReplacements(self, b5, b4)
		print(b5, "kv.particle", a4.particle)
		if a4.particle ~= nil then
			local b9 = ParticleManager:CreateParticle(tostring(a4.particle), PATTACH_ABSORIGIN_FOLLOW, self)
			self.__cosmetics[b5].particleId = b9
			return
		end
		if a4.model == nil then
			return
		end
		local b8 = SpawnEntityFromTableSynchronous(
			"dota_prop_customtexture",
			{
				targetname = b4,
				model = a4.model,
				StartingAnim = "ACT_DOTA_IDLE",
				StartingAnimationLoopMode = "ANIM_LOOP_MODE_LOOPING",
			}
		)
		b8:FollowEntity(self, true)
		self.__cosmetics[b5].entity = b8
	end
	CDOTA_BaseNPC.UnequipCosmeticByType = function(self, b5, b4, ba)
		if self.__cosmetics == nil then
			self.__cosmetics = {}
		end
		if b5 == "MISC" then
			local bb = self.__cosmetics[b5]
			if bb == nil then
				return
			end
			if b4 ~= nil then
				do
					local au = #bb - 1
					while au >= 0 do
						if bb[au + 1].id == b4 then
							self:RemoveActivityModifier(bb[au + 1].id)
							Cosmetic:UnregisterParticleReplacements(self, b5)
							if bb[au + 1].entity ~= nil and IsValid(bb[au + 1].entity) then
								bb[au + 1].entity:RemoveSelf()
							end
							table.remove(bb, au)
							break
						end
						au = au - 1
					end
				end
				if #bb == 0 then
					h(self.__cosmetics, b5)
				end
			else
				do
					local au = #bb - 1
					while au >= 0 do
						self:RemoveActivityModifier(bb[au + 1].id)
						Cosmetic:UnregisterParticleReplacements(self, b5)
						if bb[au + 1].entity ~= nil and IsValid(bb[au + 1].entity) then
							bb[au + 1].entity:RemoveSelf()
						end
						au = au - 1
					end
				end
				h(self.__cosmetics, b5)
			end
			return
		end
		local bc = self.__cosmetics[b5]
		if bc == nil then
			return
		end
		self:RemoveActivityModifier(bc.id)
		Cosmetic:UnregisterParticleReplacements(self, b5)
		if bc.particleId ~= nil then
			ParticleManager:DestroyParticle(bc.particleId, true)
		end
		if bc.entity ~= nil and IsValid(bc.entity) then
			bc.entity:RemoveSelf()
		end
		h(self.__cosmetics, b5)
		if not ba then
			local bd = self:GetPlayerOwnerID()
			local be = tostring(PlayerResource:GetSelectedHeroID(bd))
			for bf, bg in pairs(KeyValues.info_item_cosmetic) do
				do
					local b6 = bg
					if tostring(b6.type) ~= b5 then
						goto bh
					end
					if tostring(b6.default) ~= "1" then
						goto bh
					end
					local bi = b6.hero_id ~= nil and tostring(b6.hero_id) or nil
					if bi == nil or bi == be then
						self:EquipCosmetic(bf)
						break
					end
				end
				::bh::
			end
		end
	end
	CDOTA_BaseNPC.CheckNoDraw = function(self, b8)
		local b3 = not self.__NODAW
		if self.__weapon_hidden then
			b3 = false
		end
		if IsValid(b8) then
			if b3 then
				b8:RemoveEffects(EF_NODRAW)
			else
				b8:AddEffects(EF_NODRAW)
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
	CDOTA_BaseNPC.AddShield = function(self, bj, y, bk, bl)
		if bj <= 0 then
			return
		end
		local w = self:GetProperty(PropertyFunction.DEFENSE_INTENSITY)
			* (1 + self:GetProperty(PropertyFunction.DEFENSE_INTENSITY_BOOST) * 0.01)
		bj = bj * (1 + GetShieldAmplify(self) * 0.01) * (1 + w * INTENSITY_FACTOR * 0.01)
		local bm = y or DoUniqueString("shield")
		local bn = bk or "override"
		local bo = bl or "normal"
		self:AddNewModifier(self, nil, "modifier_shield", { shield = bj, id = bm, method = bn, type = bo })
	end
	CDOTA_BaseNPC.RemoveShield = function(self, y)
		if y == nil then
			self:RemoveModifierByName("modifier_shield")
		else
			local z = self:FindModifierByName("modifier_shield")
			if IsValid(z) then
				z:RemoveShield(y)
			end
		end
	end
	CDOTA_BaseNPC.ReduceShield = function(self, t, y, bp)
		if t <= 0 then
			return
		end
		local z = self:FindModifierByName("modifier_shield")
		if not IsValid(z) then
			return
		end
		z:ReduceShield(t, y, bp)
	end
	CDOTA_BaseNPC.AddProperty = function(self, n, bq)
		if PROPERTY_MAP_REVERSE[n] ~= nil then
			PropertySystem:AddStaticProperty(
				self:entindex(),
				PROPERTY_MAP_REVERSE[n],
				DoUniqueString("static_property"),
				bq
			)
		end
	end
	CDOTA_BaseNPC.EnergyStrike = function(self, br, bs, H, bt, ay, a2, a9)
		a9 = a9 or {}
		local bu = a9.source or self
		local bv = a9.jumpDelay or 0
		local bw = a9.jumpCount or 0
		local bx = a9.jumpRadius or 600
		local I = a9.attachName or "attach_attack1"
		local by = a9.soundName or "Hero_Zuus.ArcLightning.Cast"
		local function bz(bu, ax, bA)
			self:DealDamage(ax, H, ay)
			if type(a2) == "function" then
				a2(bu, ax, bA)
			else
				local b9 = ParticleManager:CreateParticle(a2, PATTACH_CUSTOMORIGIN, nil)
				ParticleManager:SetParticleControlEnt(
					b9,
					0,
					bu,
					PATTACH_POINT_FOLLOW,
					bA and I or "attach_hitloc",
					bu:GetAbsOrigin(),
					false
				)
				ParticleManager:SetParticleControlEnt(
					b9,
					1,
					ax,
					PATTACH_POINT_FOLLOW,
					"attach_hitloc",
					ax:GetAbsOrigin(),
					false
				)
				ParticleManager:ReleaseParticleIndex(b9)
			end
			EmitSoundOnLocationWithCaster(bu:GetAbsOrigin(), by, self)
		end
		local bB = { br }
		if bt > 0 then
			local bC = FindUnitsInRadiusWithAbility(self, br:GetAbsOrigin(), bs, H)
			ArrayRemove(bC, br)
			for bD, ac in ipairs(bC) do
				table.insert(bB, ac)
				bt = bt - 1
				if bt <= 0 then
					break
				end
			end
		end
		local bE = {}
		local bF = bw - 1
		for bD, ac in ipairs(bB) do
			local bG = ac
			bz(bu, bG, true)
			table.insert(bE, ac)
			if bF > 0 then
				bF = bF - 1
				self:GameTimer(bv, function()
					local bH = FindUnitsInRadiusWithAbility(self, bG:GetAbsOrigin(), bx, H, FIND_CLOSEST)
					for bD, bI in ipairs(bE) do
						ArrayRemove(bH, bI)
					end
					local bJ = bH[1]
					if IsValid(bJ) then
						bz(bG, bJ, false)
						table.insert(bE, bJ)
						if bF > 0 then
							bG = bJ
							return bv
						end
					end
				end)
			end
		end
	end
	CDOTA_BaseNPC.AddExpose = function(self, ax, bK)
		if bK == nil then
			bK = 1
		end
		local z = ax:AddNewModifier(self, nil, "modifier_expose", { stack = bK, duration = 3 })
		local bL = IsValid(z) and z:GetStackCount() or 0
		Event:Fire("expose_event", { target = ax, caster = self, addStack = bK, stack = bL })
	end
	CDOTA_BaseNPC.IsExpose = function(self)
		local z = self:FindModifierByName("modifier_expose")
		return IsValid(z)
	end
	CDOTA_BaseNPC.AddIceMark = function(self, ax, bK)
		if bK == nil then
			bK = 1
		end
		local z = ax:AddNewModifier(self, nil, "modifier_ice_mark", { stack = bK, duration = 3 })
		local bM = IsValid(z) and z:GetStackCount() or 0
		Event:Fire("ice_mark_event", { target = ax, caster = self, addStack = bK, stack = bM })
	end
	CDOTA_BaseNPC.IsIceMark = function(self)
		local z = self:FindModifierByName("modifier_ice_mark")
		return IsValid(z)
	end
	CDOTA_BaseNPC.ArcLightning = function(self, ax, ay, bN)
		if bN == nil then
			bN = false
		end
		local bO = BlessPerformance.Enabled
		local bP = GameRules:GetGameTime()
		if bO then
			BlessPerformance:Increment("arc_calls")
		end
		local bB = FindUnitsInRadius(
			self:GetTeamNumber(),
			ax:GetAbsOrigin(),
			nil,
			900,
			DOTA_UNIT_TARGET_TEAM_ENEMY,
			DOTA_UNIT_TARGET_HEROES_AND_CREEPS,
			DOTA_UNIT_TARGET_FLAG_NONE,
			FIND_CLOSEST,
			false
		)
		ArrayRemove(bB, ax)
		table.insert(bB, 1, ax)
		local bQ = self
		local bR = 3
		if
			self.__arcLightningSoundTime == nil
			or bP - self.__arcLightningSoundTime >= ARC_LIGHTNING_SOUND_COOLDOWN_SECONDS
		then
			self.__arcLightningSoundTime = bP
			self:EmitSound("Bless.ArcLightning")
		end
		for au, aD in ipairs(bB) do
			if bO then
				BlessPerformance:Increment("arc_hits")
				BlessPerformance:Increment("arc_particles")
			end
			local b9 = ParticleManager:CreateParticle(
				"particles/units/benediction/zuus_arc_lightning.vpcf",
				PATTACH_CUSTOMORIGIN,
				self
			)
			if au == 0 then
				ParticleManager:SetParticleControlEnt(
					b9,
					0,
					bQ,
					PATTACH_POINT_FOLLOW,
					"attach_attack1",
					bQ:GetAbsOrigin(),
					false
				)
			else
				ParticleManager:SetParticleControlEnt(
					b9,
					0,
					bQ,
					PATTACH_POINT_FOLLOW,
					"attach_hitloc",
					bQ:GetAbsOrigin(),
					false
				)
			end
			ParticleManager:SetParticleControlEnt(
				b9,
				1,
				aD,
				PATTACH_POINT_FOLLOW,
				"attach_hitloc",
				aD:GetAbsOrigin(),
				false
			)
			ParticleManager:ReleaseParticleIndex(b9)
			self:DealDamage(aD, nil, ay, EOM_DAMAGE_TYPES.DAMAGE_TYPE_NONE, EOM_DAMAGE_FLAGS.LIGHTNING_DAMAGE)
			if PRD(nil, self, GetLightningExposeChance(self), "ArcLightning") then
				self:AddExpose(aD)
			end
			bR = bR - 1
			if bR <= 0 then
				break
			end
			bQ = aD
		end
		if not bN then
			local bS = GetLightningCount(self)
			if bS > 0 then
				local bT = FindUnitsInRadius(
					self:GetTeamNumber(),
					ax:GetAbsOrigin(),
					nil,
					900,
					DOTA_UNIT_TARGET_TEAM_ENEMY,
					DOTA_UNIT_TARGET_HEROES_AND_CREEPS,
					DOTA_UNIT_TARGET_FLAG_NONE,
					FIND_ANY_ORDER,
					false
				)
				ArrayRemove(bT, ax)
				local bU = 0
				for bD, ac in ipairs(bT) do
					self:ArcLightning(ac, ay, true)
					bU = bU + 1
					if bU >= bS then
						break
					end
				end
			end
		end
	end
	CDOTA_BaseNPC.LightningStrike = function(self, ax, ay, s)
		if s == nil then
			s = EOM_DAMAGE_FLAGS.NONE
		end
		local bO = BlessPerformance.Enabled
		if bO then
			BlessPerformance:Increment("lightning_requests")
		end
		local bP = GameRules:GetGameTime()
		s = bit.bor(s, EOM_DAMAGE_FLAGS.LIGHTNING_DAMAGE)
		local bV = GetLightningRadius(self)
		local bW = ax:GetAbsOrigin()
		local bB = {}
		if bV > 0 then
			bB = FindEnemiesInRadius(self, bW, bV)
		else
			bB = { ax }
		end
		if bV > 0 then
			local bX = ArrayRemove(bB, ax)
			if bX ~= nil then
				table.insert(bB, 1, bX)
			end
		end
		local bY = self.__lightningStrikeHitTime == bP and (self.__lightningStrikeTargetHitCount or 0) or 0
		local bZ = math.max(0, MAX_LIGHTNING_STRIKE_TARGET_HITS_PER_FRAME - bY)
		if #bB > bZ then
			local b_ = #bB - bZ
			if bO then
				BlessPerformance:Increment("lightning_dropped", b_)
			end
			bB = i(bB, 0, bZ)
		end
		if #bB == 0 then
			return
		end
		self.__lightningStrikeHitTime = bP
		self.__lightningStrikeTargetHitCount = bY + #bB
		if bO then
			BlessPerformance:Increment("lightning_aoe_hits", #bB)
		end
		for au, ac in ipairs(bB) do
			if ac == ax then
				self:DealDamage(ac, nil, ay, EOM_DAMAGE_TYPES.DAMAGE_TYPE_NONE, s)
			else
				self:DealDamage(ac, nil, ay, EOM_DAMAGE_TYPES.DAMAGE_TYPE_NONE, bit.bor(s, EOM_DAMAGE_FLAGS.NO_EXPOSE))
			end
		end
		if
			self.__lightningStrikeEffectWindowStart == nil
			or bP - self.__lightningStrikeEffectWindowStart >= LIGHTNING_STRIKE_EFFECT_LIMIT_INTERVAL_SECONDS
		then
			self.__lightningStrikeEffectWindowStart = bP
			self.__lightningStrikeEffectCount = 0
			self.__lightningStrikeSoundCount = 0
		end
		if (self.__lightningStrikeSoundCount or 0) < MAX_LIGHTNING_STRIKE_SOUNDS_PER_SECOND then
			self.__lightningStrikeSoundCount = (self.__lightningStrikeSoundCount or 0) + 1
			self:EmitSound("Bless.LightningStrike", bW)
		end
		if (self.__lightningStrikeEffectCount or 0) < MAX_LIGHTNING_STRIKE_EFFECTS_PER_SECOND then
			self.__lightningStrikeEffectCount = (self.__lightningStrikeEffectCount or 0) + 1
			if bO then
				BlessPerformance:Increment("lightning_particles", 2)
			end
			local b9 = ParticleManager:CreateParticle(
				"particles/units/benediction/zuus_lightning_bolt.vpcf",
				PATTACH_WORLDORIGIN,
				nil
			)
			ParticleManager:SetParticleControl(b9, 0, bW + Vector(0, 0, 900))
			ParticleManager:SetParticleControl(b9, 1, bW)
			ParticleManager:ReleaseParticleIndex(b9)
			b9 = ParticleManager:CreateParticle(
				"particles/units/benediction/zuus_lightning_bolt_aoe.vpcf",
				PATTACH_WORLDORIGIN,
				nil
			)
			ParticleManager:SetParticleControl(b9, 0, bW)
			ParticleManager:SetParticleControl(b9, 1, Vector(bV, 0, 0))
			ParticleManager:ReleaseParticleIndex(b9)
		end
		local c0 = GetLightningMultipleChance(self)
		if PRD(nil, self, c0, "LightningStrike") then
			self:StartThink(0.25, "LightningStrike", function()
				if IsValid(ax) then
					self:LightningStrike(ax, ay, s)
				end
				return -1
			end)
		end
		Event:Fire("lightning_strike", { caster = self, target = ax, damage = ay })
	end
	CDOTA_BaseNPC.LightningStorm = function(self, ax, ay)
		local E = ax:GetAbsOrigin()
		local b9 = ParticleManager:CreateParticle(
			"particles/units/benediction/leshrac_lightning_bolt.vpcf",
			PATTACH_ABSORIGIN,
			self
		)
		ParticleManager:SetParticleControl(b9, 0, E + Vector(0, 0, 1000))
		ParticleManager:SetParticleControlEnt(b9, 1, ax, PATTACH_POINT_FOLLOW, "attach_hitloc", ax:GetAbsOrigin(), true)
		ParticleManager:ReleaseParticleIndex(b9)
		self:EmitSound("Hero_Leshrac.Lightning_Storm")
		self:DealDamage(
			ax,
			nil,
			ay,
			EOM_DAMAGE_TYPES.DAMAGE_TYPE_NONE,
			EOM_DAMAGE_FLAGS.LIGHTNING_DAMAGE + EOM_DAMAGE_FLAGS.NO_EXPOSE
		)
		Event:Fire("lightning_storm", { caster = self, target = ax, damage = ay })
	end
	CDOTA_BaseNPC.LightningCloud = function(self, S)
		local c1 = S * (1 + GetLightningCloudDuration(self) * 0.01)
		self:AddNewModifier(self, nil, "modifier_lightning_cloud", { duration = c1 })
	end
	CDOTA_BaseNPC.CallSword = function(self, bR, c2, c3, c4)
		if c2 == nil then
			c2 = 0
		end
		if c3 == nil then
			c3 = 0
		end
		if c4 == nil then
			c4 = false
		end
		if self.__swordGroup == nil then
			self.__swordGroup = {}
		end
		do
			local au = #self.__swordGroup - 1
			while au >= 0 do
				local c5 = self.__swordGroup[au + 1]
				if Bullet:GetBulletData(c5) == nil then
					table.remove(self.__swordGroup, au)
				end
				au = au - 1
			end
		end
		bR = math.min(bR, MAX_CALL_SWORD_GROUP_SIZE - #self.__swordGroup)
		if bR <= 0 then
			return
		end
		local N = self
		local ay = SWORD_DAMAGE * (1 + c2 * 0.01)
		local c6 = Bullet:CreateGroupSurroundBullet(bR, {
			caster = N,
			group = "CallSword" .. tostring(N:entindex()),
			circleRadius = 120,
			angularVelocity = 180,
			offset = 128,
			lifeTime = 5,
			interval = 1,
			ParticleCreator = function(c7)
				local b9 =
					ParticleManager:CreateParticle("particles/abilities/custom_sword.vpcf", PATTACH_CUSTOMORIGIN, nil)
				ParticleManager:SetParticleControlEnt(
					b9,
					0,
					c7.__thinker,
					PATTACH_ABSORIGIN_FOLLOW,
					nil,
					c7.__thinker:GetAbsOrigin(),
					true
				)
				ParticleManager:SetParticleControlEnt(b9, 1, N, PATTACH_ABSORIGIN_FOLLOW, nil, N:GetAbsOrigin(), true)
				return b9
			end,
			OnIntervalThink = function(c7)
				local ax = FindEnemiesInRadius(N, N:GetAbsOrigin(), 1200)[1]
				if IsValid(ax) then
					local c8 = c7.__position
					c8.z = N:GetAbsOrigin().z + 128
					Bullet:CreateGuidedBullet({
						caster = N,
						target = ax,
						direction = CalcDirection2D(c8, N),
						effectName = "particles/generic_gameplay/talent_sword_projectile.vpcf",
						spawnOrigin = c8,
						angularVelocity = 360,
						ignoreBlock = true,
						radius = 64,
						moveSpeed = 1500,
						teamFilter = DOTA_UNIT_TARGET_TEAM_ENEMY,
						typeFilter = DOTA_UNIT_TARGET_HEROES_AND_CREEPS,
						OnBulletThink = function(E, c7)
							c7.angularVelocity = c7.angularVelocity + 20
							if IsValid(c7.target) and not c7.target:IsAlive() then
								c7.target = nil
							end
						end,
						OnBulletHit = function(ac, E, c7)
							N:DealDamage(
								ac,
								nil,
								ay,
								EOM_DAMAGE_TYPES.DAMAGE_TYPE_NONE,
								EOM_DAMAGE_FLAGS.NO_CRIT + EOM_DAMAGE_FLAGS.SWORD
							)
							if c3 > 0 then
								local c9 = c7.__thinker:GetAbsOrigin()
								DoCleaveAction(
									N,
									ac,
									100,
									200,
									c3,
									function(ca)
										if ca == ac then
											return
										end
										N:DealDamage(
											ca,
											nil,
											ay,
											EOM_DAMAGE_TYPES.DAMAGE_TYPE_NONE,
											EOM_DAMAGE_FLAGS.NO_CRIT + EOM_DAMAGE_FLAGS.SWORD
										)
									end,
									DOTA_UNIT_TARGET_TEAM_ENEMY,
									DOTA_UNIT_TARGET_CREEP + DOTA_UNIT_TARGET_HERO,
									nil,
									c9
								)
								local cb = ParticleManager:CreateParticle(
									"particles/econ/items/sven/sven_ti7_sword/sven_ti7_sword_spell_great_cleave.vpcf",
									PATTACH_WORLDORIGIN,
									c7.__thinker
								)
								ParticleManager:SetParticleControl(cb, 0, c9)
								ParticleManager:SetParticleControlForward(cb, 0, ac:GetAbsOrigin() - c9)
								ParticleManager:ReleaseParticleIndex(cb)
							end
							Bullet:DestroyBullet(c7)
						end,
					})
					self:EmitSound("Hero_Pangolier.PreAttack")
					Bullet:DestroyBulletByID(c7.__projIndex)
				end
				return 0.1
			end,
		})
		self.__swordGroup = j(self.__swordGroup, c6)
		Event:Fire("call_sword", { caster = self, extra = c4 })
	end
	CDOTA_BaseNPC.SwordWave = function(self, cc, _, ay, cd)
		if cd == nil then
			cd = 0
		end
		local N = self
		local ce = 1 + GetBladeSpeedAmplify(N) * 0.01
		local cf = ce > 1 and 5 or 0
		local cg = 1 + cd * SWORD_INTENT_PCT_PER_STACK * 0.01
		local a0 = 800 * cg * ce + GetBulletRange(self)
		local ch = N:HasItem("item_crit_blade")
		Bullet:CreateLinearBullet({
			caster = N,
			spawnOrigin = cc,
			direction = _,
			moveSpeed = 3000,
			distance = a0,
			destroyOnBounce = true,
			bounce = cf,
			effectName = "particles/units/benediction/invoker_deafening_blast.vpcf",
			radius = 200,
			teamFilter = DOTA_UNIT_TARGET_TEAM_ENEMY,
			typeFilter = UNIT_AND_BUILDING,
			OnBulletBounceEnd = function(c7)
				ParticleManager:DestroyParticle(c7.__particleID, false)
				local b9 = ParticleManager:CreateParticle(c7.effectName, PATTACH_CUSTOMORIGIN, c7.caster)
				ParticleManager:SetParticleControlTransformForward(b9, 0, c7.__position, c7.__velocity:Normalized())
				ParticleManager:SetParticleControl(b9, 1, c7.__velocity)
				c7.__particleID = b9
			end,
			OnBulletThink = function(E, c7)
				if ch then
					local ci = Bullet:GetBulletInLine(c7.__previous or c7.__position, c7.__position, 200)
					N:ShootDown(ci)
				end
			end,
			OnBulletHit = function(ax)
				local cj = ay * cg * ce
				local aK = {
					attacker = N,
					target = ax,
					damage = cj,
					damage_type = EOM_DAMAGE_TYPES.DAMAGE_TYPE_NONE,
					damage_flags = EOM_DAMAGE_FLAGS.BLADE,
					damage_category = DOTA_DAMAGE_CATEGORY_BARRIER,
				}
				N:DealDamage(
					ax,
					nil,
					cj * (1 + GetBladeDamageAmplify(N, aK) * 0.01),
					EOM_DAMAGE_TYPES.DAMAGE_TYPE_NONE,
					EOM_DAMAGE_FLAGS.BLADE
				)
			end,
		})
		N:EmitSound("Hero_Kez.FalconRush.Sai.Target")
	end
	CDOTA_BaseNPC.SwordCircle = function(self, ay, cg)
		if cg == nil then
			cg = 1
		end
		local N = self
		local ck = 300 * (1 + GetAoeAmplify(self) * 0.01)
		local ch = N:HasItem("item_crit_blade")
		local ce = 1 + GetBladeSpeedAmplify(N) * 0.01
		local cl = ck * cg * ce
		local cj = ay * cg * ce
		local bB = FindEnemiesInRadius(N, N:GetAbsOrigin(), cl)
		for aT, ax in ipairs(bB) do
			local aK = {
				attacker = N,
				target = ax,
				damage = cj,
				damage_type = EOM_DAMAGE_TYPES.DAMAGE_TYPE_NONE,
				damage_flags = EOM_DAMAGE_FLAGS.BLADE,
				damage_category = DOTA_DAMAGE_CATEGORY_BARRIER,
			}
			N:DealDamage(
				ax,
				nil,
				cj * (1 + GetBladeDamageAmplify(N, aK) * 0.01),
				EOM_DAMAGE_TYPES.DAMAGE_TYPE_NONE,
				EOM_DAMAGE_FLAGS.BLADE
			)
		end
		if ch then
			local ci = Bullet:GetBulletInRadius(N:GetAbsOrigin(), cl)
			N:ShootDown(ci)
		end
		local b9 = ParticleManager:CreateParticle(
			"particles/units/heroes/hero_kez/kez_hungering_blades.vpcf",
			PATTACH_ABSORIGIN,
			N
		)
		ParticleManager:SetParticleControl(b9, 2, Vector(cl, 0, 0))
		ParticleManager:ReleaseParticleIndex(b9)
		N:EmitSound("Hero_Kez.RaptorDance.Katana.Slash")
	end
	CDOTA_BaseNPC.Frozen = function(self, ax, cm)
		if cm == nil then
			cm = 1
		end
		if cm == 0 then
			return
		end
		local z = ax:AddNewModifier(self, nil, "modifier_frozen_debuff", { stack = cm, entIndex = self:entindex() })
		local bK = IsValid(z) and z:GetStackCount() or 0
		Event:Fire("frozen_event", { target = ax, caster = self, addStack = cm, stack = bK })
	end
	CDOTA_BaseNPC.IsFrozen = function(self)
		return self:HasModifier("modifier_frozen_debuff")
	end
	CDOTA_BaseNPC.Freeze = function(self, ax, S)
		if ax:IsBoss() then
			return
		end
		ax:AddNewModifier(self, nil, "modifier_freeze_debuff", { duration = S })
	end
	CDOTA_BaseNPC.IsFreeze = function(self)
		return self:HasModifier("modifier_freeze_debuff")
	end
	CDOTA_BaseNPC.TriggerDecayOnce = function(self)
		local z = self:FindModifierByName("modifier_frozen_debuff")
		if IsValid(z) then
			return z:TriggerDecayOnce()
		end
	end
	CDOTA_BaseNPC.GetFrozenStack = function(self, N)
		local z = self:FindModifierByName("modifier_frozen_debuff")
		if IsValid(z) then
			return z:GetIceStack(N:entindex())
		end
		return 0
	end
	CDOTA_BaseNPC.FrozenBurst = function(self, ay, cn, E, c4)
		if c4 == nil then
			c4 = false
		end
		local bB = FindUnitsInRadius(
			self:GetTeamNumber(),
			E,
			nil,
			200,
			DOTA_UNIT_TARGET_TEAM_ENEMY,
			UNIT_AND_BUILDING,
			DOTA_UNIT_TARGET_FLAG_NONE,
			FIND_ANY_ORDER,
			false
		)
		local co = GetFrozenBurstStack(self)
		local cp = cn + co
		for au, ac in ipairs(bB) do
			self:Frozen(ac, cn + co)
			self:DealDamage(ac, nil, ay, EOM_DAMAGE_TYPES.DAMAGE_TYPE_NONE, EOM_DAMAGE_FLAGS.FREEZE_DAMAGE)
		end
		local b9 = ParticleManager:CreateParticle(
			"particles/units/benediction/lich_frost_nova.vpcf",
			PATTACH_CUSTOMORIGIN,
			nil
		)
		ParticleManager:SetParticleControl(b9, 0, E)
		ParticleManager:SetParticleControl(b9, 1, Vector(200, 200, 200))
		ParticleManager:ReleaseParticleIndex(b9)
		Event:Fire(
			"frozen_burst",
			{ caster = self, position = E, base_frozen_stack = cn, added_frozen = cp, targets = bB, extra = c4 }
		)
	end
	CDOTA_BaseNPC.CreateIceVortex = function(self, E, ay, cn, S)
		local cq, cr = self, "__iceVortexThinkers"
		if cq[cr] == nil then
			cq[cr] = {}
		end
		local cs = self.__iceVortexThinkers
		local ct = {}
		do
			local aM = #cs - 1
			while aM >= 0 do
				do
					local cu = cs[aM + 1]
					if not IsValid(cu) then
						k(cs, aM, 1)
						goto cv
					end
					local cw = cu:FindModifierByName("modifier_ice_vortex_custom")
					if not IsValid(cw) then
						k(cs, aM, 1)
						goto cv
					end
					if cw:CanMerge(E) then
						ct[#ct + 1] = cw
					end
				end
				::cv::
				aM = aM - 1
			end
		end
		if #ct > 0 then
			local cx = ct[1]
			cx:Merge(E, ay, cn, S)
			do
				local aM = 1
				while aM < #ct do
					do
						local cw = ct[aM + 1]
						if not IsValid(cw) then
							goto cy
						end
						local cz = cw
						cx:Merge(cz:GetParent():GetAbsOrigin(), cz.damage, cz.frozen, cz:GetRemainingTime(), cz.radius)
						cz:Destroy()
					end
					::cy::
					aM = aM + 1
				end
			end
			return
		end
		CreateModifierThinker(
			self,
			nil,
			"modifier_ice_vortex_custom",
			{ entIndex = self:entindex(), damage = ay, frozen = cn, duration = S, radius = 275 },
			E,
			self:GetTeamNumber(),
			false
		)
	end
	CDOTA_BaseNPC.ThrowBloodSpear = function(self, ax, H, ay, c4)
		if c4 == nil then
			c4 = false
		end
		if not IsValid(ax) or not ax:IsAlive() then
			return
		end
		Bullet:CreateTrackingBullet({
			caster = self,
			target = ax,
			ability = H,
			effectName = "particles/units/benediction/huskar_burning_spear.vpcf",
			moveSpeed = 900,
			spawnOrigin = self:GetAttachmentPosition("attach_hitloc"),
			OnBulletHit = function(cA)
				local cj = toFiniteNumber(ay)
				self:Bleed(cA, cj)
				if cj > 0 then
					self:DealDamage(cA, H, cj, EOM_DAMAGE_TYPES.DAMAGE_TYPE_NONE)
				end
				Event:Fire("blood_spear", { caster = self, target = cA })
				self:EmitSound("Hero_BrewMaster.CinderBrew.Ignite", cA:GetAbsOrigin())
			end,
		})
	end
	CDOTA_BaseNPC.ThrowSnowball = function(self, ax, H, cn, ay, c4)
		if c4 == nil then
			c4 = false
		end
		if not IsValid(ax) or not ax:IsAlive() then
			return
		end
		local cB = GetSnowballBounceCount(self)
		Bullet:CreateTrackingBullet({
			caster = self,
			target = ax,
			ability = nil,
			effectName = "particles/units/benediction/snowball_projectile.vpcf",
			moveSpeed = 900,
			spawnOrigin = self:GetAttachmentPosition("attach_hitloc"),
			OnBulletHit = function(ax, E, c7)
				self:Frozen(ax, cn)
				local aG = toFiniteNumber(ay)
				ay = aG + GetSnowballDamage(self, { target = ax, damage = aG })
				if ay > 0 then
					self:DealDamage(ax, H, ay, EOM_DAMAGE_TYPES.DAMAGE_TYPE_NONE, EOM_DAMAGE_FLAGS.FREEZE_DAMAGE)
				end
				self:EmitSound("FrostivusConsumable.Snowball.Target", ax:GetAbsOrigin())
				if cB > 0 then
					local bB = FindEnemiesInRadius(self, E, 500, FIND_CLOSEST)
					ArrayRemove(bB, ax)
					if #bB > 0 then
						c7.target = bB[1]
						if c7.__particleID ~= nil then
							ParticleManager:SetParticleControlTransformForward(
								c7.__particleID,
								0,
								E,
								c7.__velocity:Normalized()
							)
							ParticleManager:SetParticleControlEnt(
								c7.__particleID,
								1,
								c7.target,
								PATTACH_POINT_FOLLOW,
								"attach_hitloc",
								c7.target:GetAbsOrigin(),
								false
							)
						end
						cB = cB - 1
						return false
					end
				end
			end,
		})
		Event:Fire("throw_snowball", { caster = self, target = ax, extra = c4 })
	end
	CDOTA_BaseNPC.IceStrike = function(self, ax, H, ay, c4)
		if ay == nil then
			ay = 0
		end
		if c4 == nil then
			c4 = false
		end
		local b9 = ParticleManager:CreateParticle(
			"particles/generic_gameplay/sect_ice_freezing_attack.vpcf",
			PATTACH_CUSTOMORIGIN,
			nil
		)
		ParticleManager:SetParticleControlEnt(b9, 0, ax, PATTACH_ABSORIGIN_FOLLOW, nil, ax:GetAbsOrigin(), false)
		ParticleManager:SetParticleControl(
			b9,
			1,
			ax:GetAbsOrigin() + RandomVector(RandomInt(0, 150)) + Vector(0, 0, 1200)
		)
		ParticleManager:ReleaseParticleIndex(b9)
		self:StartThink(0.2, DoUniqueString("ice_delay"), function()
			if IsValid(ax) and IsValid(self) then
				local bd = self:GetPlayerOwnerID()
				if Privilege:HasPrivilege("privilege_myth_005", bd) then
					local bs = Privilege:GetPlayerDynamicValue("privilege_myth_005", bd, "value")
					local cC = FindEnemiesInRadius(self, ax:GetAbsOrigin(), bs, FIND_CLOSEST)
					self:DealDamage(cC, H, ay, EOM_DAMAGE_TYPES.DAMAGE_TYPE_NONE, EOM_DAMAGE_FLAGS.FREEZE_DAMAGE)
				else
					self:DealDamage(ax, H, ay, EOM_DAMAGE_TYPES.DAMAGE_TYPE_NONE, EOM_DAMAGE_FLAGS.FREEZE_DAMAGE)
				end
				self:EmitSound("Frostivus.Item.Snowball.Target", ax:GetAbsOrigin())
			end
			return -1
		end)
		Event:Fire("ice_strike", { caster = self, target = ax, extra = c4 })
	end
	CDOTA_BaseNPC.Bleed = function(self, ax, bK)
		ax:AddNewModifier(self, nil, "modifier_bleed", { stack = bK, entIndex = self:entindex() })
	end
	CDOTA_BaseNPC.IsBleed = function(self)
		local z = self:FindModifierByName("modifier_bleed")
		return IsValid(z)
	end
	CDOTA_BaseNPC.GetBleedStack = function(self, N)
		local z = self:FindModifierByName("modifier_bleed")
		if IsValid(z) then
			return z:GetBleedStack(N:entindex())
		end
		return 0
	end
	CDOTA_BaseNPC.TriggerBleed = function(self, N, cg)
		if cg == nil then
			cg = 1
		end
		local z = self:FindModifierByName("modifier_bleed")
		if IsValid(z) then
			return z:TriggerBleed(N, cg)
		end
	end
	CDOTA_BaseNPC.Burning = function(self, ax, H, bK)
		ax:AddNewModifier(
			self,
			H,
			"modifier_burning",
			{ stack = math.floor(bK), entIndex = self:entindex(), duration = 5 }
		)
	end
	CDOTA_BaseNPC.IsBurning = function(self)
		local z = self:FindModifierByName("modifier_burning")
		return IsValid(z)
	end
	CDOTA_BaseNPC.GetBurningStack = function(self, N)
		local z = self:FindModifierByName("modifier_burning")
		if IsValid(z) then
			return z:GetBurningStack(N:entindex())
		end
		return 0
	end
	CDOTA_BaseNPC.TriggerBurning = function(self, N)
		local z = self:FindModifierByName("modifier_burning")
		if IsValid(z) then
			return z:TriggerBurning(N)
		end
	end
	CDOTA_BaseNPC.AddInvulnerable = function(self, S)
		self:AddNewModifier(self, nil, "modifier_invulnerable_buff", { duration = S })
	end
	CDOTA_BaseNPC.CreateWisp = function(self, a8, aF)
		local z = self:AddNewModifier(self, nil, "modifier_wisps", { unit_name = a8 })
		if IsValid(z) then
			return z:CreateWisp(a8, aF)
		end
	end
	CDOTA_BaseNPC.RemoveWisp = function(self, cD)
		local z = self:FindModifierByName("modifier_wisps")
		if IsValid(z) then
			z:RemoveWisp(cD)
		end
	end
	CDOTA_BaseNPC.ShootDown = function(self, cE, cF)
		if cF == nil then
			cF = self:HasItem("item_holy_reflect")
		end
		local ay = GetReflectDamage(self)
		for au, c7 in ipairs(cE) do
			if IsValid(c7.caster) and Bullet:IsReflectable(c7) and not c7.caster:IsFriendly(self) then
				if Bullet:IsLinearBullet(c7) then
					if cF then
						Bullet:CreateLinearBullet({
							caster = self,
							direction = -c7.direction:Normalized(),
							spawnOrigin = c7.__position,
							effectName = c7.effectName,
							moveSpeed = c7.moveSpeed * 3,
							radius = c7.radius,
							distance = c7.distance,
							teamFilter = DOTA_UNIT_TARGET_TEAM_ENEMY,
							typeFilter = DOTA_UNIT_TARGET_HEROES_AND_CREEPS,
							OnBulletHit = function(ax, E, c7)
								self:DealDamage(
									ax,
									nil,
									ay,
									EOM_DAMAGE_TYPES.DAMAGE_TYPE_NONE,
									EOM_DAMAGE_FLAGS.REFLECT_DAMAGE
								)
							end,
							ParticleCreator = c7.ParticleCreator,
						})
					end
					Bullet:DestroyBulletByID(c7.__projIndex)
				elseif Bullet:IsGuidedBullet(c7) then
					if cF then
						Bullet:CreateGuidedBullet({
							caster = self,
							direction = -c7.__velocity:Normalized(),
							effectName = c7.effectName,
							spawnOrigin = c7.__position,
							moveSpeed = c7.moveSpeed * 3,
							radius = c7.radius,
							lifeTime = c7.lifeTime,
							teamFilter = DOTA_UNIT_TARGET_TEAM_ENEMY,
							typeFilter = DOTA_UNIT_TARGET_HEROES_AND_CREEPS,
							OnBulletHit = function(ax, E, c7)
								self:DealDamage(ax, nil, ay)
								return true
							end,
							ParticleCreator = c7.ParticleCreator,
						})
					end
					Bullet:DestroyBulletByID(c7.__projIndex)
				end
			end
		end
		if #cE > 0 then
			Event:Fire("avoid_damage", { unit = self })
		end
	end
	CDOTA_BaseNPC.Weaken = function(self, ax, bK)
		if bK == nil then
			bK = 1
		end
		ax:AddNewModifier(self, nil, "modifier_weak_debuff", { stack = bK, duration = WEAK_DURATION })
	end
	CDOTA_BaseNPC.IsWeaken = function(self)
		local z = self:FindModifierByName("modifier_weak_debuff")
		return IsValid(z)
	end
	CDOTA_BaseNPC.GetWeakenStack = function(self, N)
		local z = self:FindModifierByName("modifier_weak_debuff")
		if IsValid(z) then
			return z:GetWeakenStack(N:entindex())
		end
		return 0
	end
	CDOTA_BaseNPC.AddExecuteThreshold = function(self, ax, bK)
		ax:AddNewModifier(self, nil, "modifier_execute_threshold", { stack = math.floor(bK), duration = 5 })
	end
	CDOTA_BaseNPC.IsBoss = function(self)
		return l(self:GetUnitLabel(), "boss")
	end
	CDOTA_BaseNPC.IsElite = function(self)
		return self:HasModifier("modifier_elite")
	end
	CDOTA_BaseNPC.IsCreep = function(self)
		return l(self:GetUnitLabel(), "creep")
	end
end
if IsServer() then
	CDOTA_BaseNPC.SimulateCast = function(self, cG)
		self:RemoveModifierByName("modifier_simulate_cast")
		local af = cG.castPoint or 0
		local S = math.max(cG.duration or 0, af or 0)
		local at = {
			duration = S,
			castPoint = af,
			castAnimation = cG.castAnimation,
			orderType = cG.orderType,
			animationRate = cG.animationRate or 1,
			animationFadeIn = cG.animationFadeIn,
			animationFadeOut = cG.animationFadeOut,
			position = cG.position and VectorToString(cG.position) or nil,
			targetIndex = IsValid(cG.target) and cG.target:entindex() or nil,
			activityModifier = cG.activityModifier,
		}
		local z = self:AddNewModifier(self, nil, "modifier_simulate_cast", at)
		if IsValid(z) then
			z.OnSpellStart = cG.OnSpellStart
			z.OnFinish = cG.OnFinish
		end
	end
end
if IsServer() then
	CDOTA_BaseNPC.PushOff = function(self, E)
		if self:HasState(StateEnum.KNOCKBACK_IMMUNE) then
			return
		end
		self:SetAbsOrigin(E)
		local cH = self:GetHullRadius() + 50
		local cI = FindEnemiesInRadius(self, E, cH)
		for aT, ax in ipairs(cI) do
			ax:KnockBack(CalcDirection2D(ax, E), cH - CalcDistance(ax, E), 0, 0.06)
		end
		FindClearSpaceForUnit(self, E, true)
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
BaseNPC.IsCloseRange = function(self, ax)
	return CalcDistance(self, ax) <= CLOSE_RANGE
end
BaseNPC.IsFarRange = function(self, ax)
	return CalcDistance(self, ax) >= FAR_RANGE
end
if IsServer() then
	CDOTA_BaseNPC.Poison = function(self, ax, bK)
		if bK <= 0 then
			return
		end
		ax:AddNewModifier(self, nil, "modifier_poison_custom", { stack = bK, entIndex = self:entindex() })
		Event:Fire("poison_event", { target = ax, caster = self, addStack = bK, stack = ax:GetPoisonStack(self) })
	end
	CDOTA_BaseNPC.IsPoisoned = function(self)
		local z = self:FindModifierByName("modifier_poison_custom")
		return IsValid(z)
	end
	CDOTA_BaseNPC.GetPoisonStack = function(self, N)
		local z = self:FindModifierByName("modifier_poison_custom")
		if IsValid(z) then
			return z:GetPoisonStack(N:entindex())
		end
		return 0
	end
	CDOTA_BaseNPC.TriggerPoison = function(self, N)
		local z = self:FindModifierByName("modifier_poison_custom")
		return z and z:TriggerPoison(N)
	end
	CDOTA_BaseNPC.PoisionBottle = function(self, S, cJ, bs, cK)
		if bs == nil then
			bs = 100
		end
		if cK == nil then
			cK = 180
		end
		if self.__poisonGroup == nil then
			self.__poisonGroup = {}
		end
		local bd = self:GetPlayerOwnerID()
		if Privilege:HasPrivilege("privilege_myth_024", bd) then
			local bq = Privilege:GetPrivilegeSpecialValue("privilege_myth_024", 1, "value", self)
			S = S * (1 + bq * 0.01)
			cJ = cJ * (1 + bq * 0.01)
		end
		do
			local au = #self.__poisonGroup - 1
			while au >= 0 do
				local cL = self.__poisonGroup[au + 1]
				if Bullet:GetBulletData(cL) == nil then
					k(self.__poisonGroup, au, 1)
				end
				au = au - 1
			end
		end
		while POISON_BOTTLE_MAX_COUNT > 0 and #self.__poisonGroup >= POISON_BOTTLE_MAX_COUNT do
			local cM = 0
			local cN = math.huge
			do
				local au = 0
				while au < #self.__poisonGroup do
					local c7 = Bullet:GetBulletData(self.__poisonGroup[au + 1])
					local cO = c7 and c7.__lifeTimeRemaining
					if cO == nil then
						cO = 0
					end
					local cP = cO
					if cP < cN then
						cN = cP
						cM = au
					end
					au = au + 1
				end
			end
			local cL = self.__poisonGroup[cM + 1]
			k(self.__poisonGroup, cM, 1)
			Bullet:DestroyBulletByID(cL)
		end
		local c6 = Bullet:CreateGroupSurroundBullet(1, {
			caster = self,
			group = "PoisionBottle" .. tostring(self:entindex()),
			circleRadius = bs,
			angularVelocity = cK,
			offset = 128,
			lifeTime = S,
			effectName = "particles/abilities/dupingzi.vpcf",
			interval = 1,
			teamFilter = DOTA_UNIT_TARGET_TEAM_ENEMY,
			typeFilter = DOTA_UNIT_TARGET_HEROES_AND_CREEPS,
			radius = 100,
			OnBulletCreated = function(c7)
				c7.poisionStack = cJ
			end,
			OnBulletThink = function(E, c7)
				if c7.circleRadius < bs then
					c7.circleRadius = c7.circleRadius + 1
				end
			end,
			OnBulletHit = function(ax, cQ, c7)
				local cR = toFiniteNumber(c7.poisionStack)
				self:Poison(ax, cR)
				if Privilege:HasPrivilege("privilege_suit_026", self:GetPlayerOwnerID()) then
					c7.poisionStack = cR
						+ Privilege:GetPrivilegeSpecialValue("privilege_suit_026", 1, "extra_count", self)
				end
			end,
			OnBulletDestroy = function(c7)
				c7.poisionStack = nil
			end,
		})
		self.__poisonGroup = j(self.__poisonGroup, c6)
		return c6
	end
	CDOTA_BaseNPC.ThrowPoisonBottle = function(self, E, H, cS, S)
		local cc = self:GetAbsOrigin()
		local a0 = CalcDistance(E, cc)
		local cT = S or a0 / 900
		local cU = cT > 0 and a0 / cT or 900
		Bullet:CreateLinearBullet({
			spawnOrigin = self:GetAbsOrigin(),
			moveSpeed = cU,
			direction = CalcDirection2D(E, self),
			distance = a0,
			ParticleCreator = function()
				local b9 = ParticleManager:CreateParticle(
					"particles/units/benediction/bottle_poison.vpcf",
					PATTACH_CUSTOMORIGIN,
					nil
				)
				ParticleManager:SetParticleControl(b9, 0, self:GetAbsOrigin())
				ParticleManager:SetParticleControl(b9, 1, E)
				ParticleManager:SetParticleControl(b9, 2, Vector(cU, 0, 0))
				return b9
			end,
			OnBulletDestroy = function(c7)
				self:PoisonPool(c7.__position, toFiniteNumber(cS))
			end,
		})
	end
	CDOTA_BaseNPC.PoisonPool = function(self, E, bK, bs)
		if bs == nil then
			bs = 200
		end
		CreateModifierThinker(
			self,
			nil,
			"modifier_poison_pool",
			{ entIndex = self:entindex(), duration = 3, radius = bs, stack = bK },
			E,
			self:GetTeamNumber(),
			false
		)
		Event:Fire("poison_pool_event", { caster = self, position = E })
	end
end
if IsServer() then
	CDOTA_BaseNPC.Laser = function(self, _, ay, s)
		if s == nil then
			s = EOM_DAMAGE_FLAGS.NONE
		end
		s = bit.bor(s, EOM_DAMAGE_FLAGS.SHIELD_DAMAGE)
		local a0 = LASER_LENGTH + GetBulletRange(self)
		local N = self
		local cf = GetLaserBounceCount(N) + GetBounceCount(N)
		print(GetLaserBounceCount(N), GetBounceCount(N))
		local S = 0.1
		local cV = N:HasItem("item_holy_auto")
		local cW
		cW = function(cX, cY, cZ)
			Bullet:CreateLinearBullet({
				caster = N,
				spawnOrigin = cX,
				direction = cY,
				radius = LASER_WIDTH,
				teamFilter = DOTA_UNIT_TARGET_TEAM_ENEMY,
				typeFilter = UNIT_AND_BUILDING,
				flagFilter = DOTA_UNIT_TARGET_FLAG_NONE,
				moveSpeed = a0 / S,
				distance = a0,
				thinker = true,
				bounce = cZ,
				OnBulletHit = function(ac)
					N:DealDamage(ac, nil, ay, EOM_DAMAGE_TYPES.DAMAGE_TYPE_NONE, s)
				end,
				OnBulletBounceEnd = function(c7)
					c7.__lifeTimeRemaining = S
					local b9 = ParticleManager:CreateParticle(
						"particles/units/benediction/holy_laser.vpcf",
						PATTACH_CUSTOMORIGIN,
						nil
					)
					ParticleManager:SetParticleControl(b9, 9, Bullet:GetData(c7.__projIndex, "bounce_position", cX))
					ParticleManager:SetParticleControl(b9, 1, c7.__position)
					Bullet:SaveData(c7.__projIndex, "bounce_position", c7.__position)
					print("OnBulletBounceEnd", cZ)
				end,
				OnBulletDestroy = function(c7)
					local b9 = ParticleManager:CreateParticle(
						"particles/units/benediction/holy_laser.vpcf",
						PATTACH_CUSTOMORIGIN,
						nil
					)
					ParticleManager:SetParticleControl(b9, 9, Bullet:GetData(c7.__projIndex, "bounce_position", cX))
					ParticleManager:SetParticleControl(b9, 1, c7.__position)
					local c_ = c7.bounce or 0
					if c_ <= 0 then
						return
					end
					local d0 = c7.__position
					local d1 = d0 + RandomVector(a0)
					if cV then
						local bB = FindEnemiesInRadius(N, d0, a0, FIND_ANY_ORDER)
						local ax = GetRandomElement(bB)
						if IsValid(ax) then
							d1 = ax:GetAbsOrigin() + RandomVector(ax:GetHullRadius())
						end
					end
					cW(d0, CalcDirection2D(d1, d0), c_ - 1)
				end,
			})
		end
		N:EmitSound("Hero_Tinker.LaserImpact")
		cW(N:GetAbsOrigin() + Vector(0, 0, 75), _, cf)
	end
end