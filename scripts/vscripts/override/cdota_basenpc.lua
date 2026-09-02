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
function CalculateEquivalentDefenseIntensity(w)
	local x = w:GetProperty(PropertyFunction.DEFENSE_INTENSITY)
		* (1 + w:GetProperty(PropertyFunction.DEFENSE_INTENSITY_BOOST) * 0.01)
	return (1000 + x)
			* (1 + w:GetProperty(PropertyFunction.HERO_DEFENSE_BOOST) * 0.01)
			* (1 + w:GetProperty(PropertyFunction.FINAL_DEFENSE) * 0.01)
		- 1000
end
if BaseNPC.GetMaxHealth_Engine == nil then
	BaseNPC.GetMaxHealth_Engine = BaseNPC.GetMaxHealth
end
BaseNPC.GetMaxHealth = function(self)
	local y = CalculateEquivalentDefenseIntensity(self)
	return math.floor(
		(self:GetProperty(PropertyFunction.BASE_HEALTH) + self:GetProperty(PropertyFunction.HEALTH))
			* (1 + self:GetProperty(PropertyFunction.HEALTH_AMPLIFY) * 0.01)
			* (1 + y * INTENSITY_FACTOR * 0.01)
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
BaseNPC.HasAbilityUpgrade = function(self, z)
	return AbilityUpgrade:HasAbilityUpgrade(self, z)
end
BaseNPC.GetShield = function(self, A)
	if IsServer() then
		local B = self:FindModifierByName("modifier_shield")
		if IsValid(B) then
			if A ~= nil then
				return B:GetShieldAmount(A)
			else
				return B:GetTotalShieldAmount(A)
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
BaseNPC.GetVulnerabilityModifierValue = function(self, C)
	local B = self.__VulnerabilityModifier
	if not IsValid(B) then
		return 0
	end
	local D = B:GetVulnerabilityValue(C)
	if D == nil then
		D = 0
	end
	return D
end
BaseNPC.HasState = function(self, E)
	if IsServer() then
		return StateSystem:GetStateValue(self:entindex(), E)
	else
		return StateSystem:GetStateValueFromNetTable(self:entindex(), E)
	end
end
BaseNPC.IsBreakable = function(self)
	return self:HasState(StateEnum.BREAKABLE)
end
if IsServer() then
	if CDOTA_BaseNPC.EmitSound_Engine == nil then
		CDOTA_BaseNPC.EmitSound_Engine = CDOTA_BaseNPC.EmitSound
	end
	CDOTA_BaseNPC.EmitSound = function(self, F, G)
		if G then
			EmitSoundOnLocationWithCaster(G, F, self)
		else
			self:EmitSound_Engine(F)
		end
	end
	if CDOTA_BaseNPC.AddAbility_Engine == nil then
		CDOTA_BaseNPC.AddAbility_Engine = CDOTA_BaseNPC.AddAbility
	end
	CDOTA_BaseNPC.AddAbility = function(self, H, I)
		local J = self:AddAbility_Engine(H)
		if I ~= nil and IsValid(J) then
			J:SetLevel(I)
		end
		J:__OnCreated()
		return J
	end
	if CDOTA_BaseNPC.RemoveAbility_Engine == nil then
		CDOTA_BaseNPC.RemoveAbility_Engine = CDOTA_BaseNPC.RemoveAbility
	end
	CDOTA_BaseNPC.RemoveAbility = function(self, H)
		local J = self:FindAbilityByName(H)
		if IsValid(J) then
			self:RemoveAbilityByHandle(J)
		end
	end
	if CDOTA_BaseNPC.RemoveAbilityByHandle_Engine == nil then
		CDOTA_BaseNPC.RemoveAbilityByHandle_Engine = CDOTA_BaseNPC.RemoveAbilityByHandle
	end
	CDOTA_BaseNPC.RemoveAbilityByHandle = function(self, J)
		if IsValid(J) then
			if J.__OnDestroy ~= nil then
				J:__OnDestroy()
			end
			self:RemoveAbilityByHandle_Engine(J)
		end
	end
	CDOTA_BaseNPC.GetAttachmentPosition = function(self, K)
		if not IsValid(self) then
			return vec3_zero
		end
		return self:GetAttachmentOrigin(self:ScriptLookupAttachment(K))
	end
	if CDOTA_BaseNPC.RespawnUnit_Engine == nil then
		CDOTA_BaseNPC.RespawnUnit_Engine = CDOTA_BaseNPC.RespawnUnit
	end
	CDOTA_BaseNPC.RespawnUnit = function(self)
		if not self:UnitCanRespawn() then
			return
		end
		local L = self:FirstMoveChild()
		while L ~= nil do
			local M = L:NextMovePeer()
			if L ~= nil and L:GetClassname() ~= "" and L:GetClassname() == "dota_item_wearable" then
				UTIL_Remove(L)
			end
			L = M
		end
		self:RespawnUnit_Engine()
	end
	if CDOTA_BaseNPC.SetUnitCanRespawn_Engine == nil then
		CDOTA_BaseNPC.SetUnitCanRespawn_Engine = CDOTA_BaseNPC.SetUnitCanRespawn
	end
	CDOTA_BaseNPC.SetUnitCanRespawn = function(self, N)
		self.__unitCanRespawn_ = N
		if N == true then
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
		local O = self.__unitCanRespawn_
		if O == nil then
			O = false
		end
		return O
	end
	if CDOTA_BaseNPC.AddNewModifier_Engine == nil then
		CDOTA_BaseNPC.AddNewModifier_Engine = CDOTA_BaseNPC.AddNewModifier
	end
	CDOTA_BaseNPC.AddNewModifier = function(self, P, J, Q, R, S)
		local B = nil
		if S ~= nil then
			if IsValid(self) and bit.band(S, AddModifierFlag.IGNORE_DEATH) == AddModifierFlag.IGNORE_DEATH then
				if self.__isRemoving then
					return
				end
				local T = not self:IsAlive()
				if T then
					self:SetHealth(1)
				end
				B = self:AddNewModifier_Engine(P, J, Q, R)
				if T then
					self:SetHealth(0)
				end
			end
		else
			B = self:AddNewModifier_Engine(P, J, Q, R)
		end
		if IsValid(B) and IsValid(P) then
			local U = B:GetDuration()
			if U > 0 then
				if B:IsDebuff() then
					B:SetDuration(U * (1 + GetDebuffDuration(P, nil) * 0.01), false)
				else
					B:SetDuration(U * (1 + GetBuffDuration(P, nil) * 0.01), false)
				end
			end
		end
		return B
	end
	CDOTA_BaseNPC.ExecuteOrder = function(self, V, ...)
		local W = { ... }
		local X
		local m
		local Y
		local Z = { DOTA_UNIT_ORDER_MOVE_TO_POSITION, DOTA_UNIT_ORDER_ATTACK_MOVE }
		local _ = { DOTA_UNIT_ORDER_MOVE_TO_TARGET, DOTA_UNIT_ORDER_ATTACK_TARGET }
		local a0 = {
			DOTA_UNIT_ORDER_CAST_POSITION,
			DOTA_UNIT_ORDER_CAST_TARGET,
			DOTA_UNIT_ORDER_CAST_TARGET_TREE,
			DOTA_UNIT_ORDER_CAST_NO_TARGET,
			DOTA_UNIT_ORDER_CAST_TOGGLE,
		}
		if TableFindKey(Z, V) ~= nil then
			Y = W[1]
		elseif TableFindKey(_, V) ~= nil then
			m = W[1]
		elseif TableFindKey(a0, V) ~= nil then
			if V == DOTA_UNIT_ORDER_CAST_POSITION then
				X = W[1]
				Y = W[2]
			elseif V == DOTA_UNIT_ORDER_CAST_NO_TARGET or V == DOTA_UNIT_ORDER_CAST_TOGGLE then
				X = W[1]
			else
				X = W[1]
				m = W[2]
			end
		end
		ExecuteOrderFromTable({
			UnitIndex = self:entindex(),
			OrderType = V,
			TargetIndex = IsValid(m) and m:entindex() or nil,
			AbilityIndex = IsValid(X) and X:entindex() or nil,
			Position = Y,
			Queue = false,
		})
	end
	CDOTA_BaseNPC.Dash = function(self, a1, a2, a3, U, a4)
		if not self:IsAlive() then
			return
		end
		local a5 = GetDashDistance(self, nil)
		local a6 = { direction = a1, dash_duration = U, dash_distance = a2 + a5, dash_height = a3 }
		self:RemoveModifierByName("modifier_dash")
		local a7 = self:AddNewModifier(self, nil, "modifier_dash", a6)
		if IsValid(a7) and a4 ~= nil then
			a7.callback = a4
		end
	end
	CDOTA_BaseNPC.KnockBack = function(self, a1, a2, a3, U, a4)
		if not self:IsAlive() then
			return
		end
		if self:HasState(StateEnum.KNOCKBACK_IMMUNE) then
			return
		end
		local a6 = { direction = a1, dash_duration = U, dash_distance = a2, dash_height = a3 }
		self:RemoveModifierByName("modifier_knockback_custom")
		local a7 = self:AddNewModifier(self, nil, "modifier_knockback_custom", a6)
		if IsValid(a7) and a4 ~= nil then
			a7.callback = a4
		end
	end
	CDOTA_BaseNPC.Stagger = function(self, U, a8, a9)
		if not self:IsAlive() then
			return
		end
		local a6 = { duration = U, animation = a8 or ACT_DOTA_DISABLED, animation_rate = a9 or 1 }
		self:RemoveModifierByName("modifier_stagger")
		self:AddNewModifier(self, nil, "modifier_stagger", a6)
	end
	CDOTA_BaseNPC.Stun = function(self, P, J, U)
		if not IsValid(self) then
			return
		end
		if U <= 0 then
			return
		end
		if self:HasState(StateEnum.STUN_IMMUNE) then
			return
		end
		self:AddNewModifier(P, J, "modifier_stunned", { duration = U })
	end
	CDOTA_BaseNPC.SummonUnit = function(self, aa, G, U, ab)
		local ac = self:GetForwardVector()
		local ad = {
			MapUnitName = aa,
			angles = (((tostring(ac.x) .. " ") .. tostring(ac.y)) .. " ") .. tostring(ac.z),
			teamnumber = self:GetTeamNumber(),
			NeverMoveToClearSpace = false,
			IsSummoned = "1",
		}
		if ab ~= nil then
			ad = TableOverride(ad, ab)
		end
		local w = CreateUnitFromTable(ad, G)
		if not IsValid(w) then
			return nil
		end
		w.__Summoner = self
		if U ~= nil and U > 0 then
			w:AddNewModifier(self, nil, "modifier_kill", { duration = U })
		end
		return w
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
	CDOTA_BaseNPC.PassiveCast = function(self, J, ae, ab, af)
		if not IsValid(J) then
			return
		end
		if ab == nil then
			ab = {}
		end
		local ag = ab.castPoint or J:GetCastPoint()
		local ah = ab.castAnimation or J:GetCastAnimation()
		local ai = ab.sActivityModifier
		if ab.sActivityModifier and type(ab.sActivityModifier) == "table" then
			ai = json.encode(ab.sActivityModifier)
		end
		local aj = ag
		local ak = ag
		local al = ah
		local am = ae
		local an = ab.animationRate
		local ao = ab.position and VectorToString(ab.position) or nil
		local ap = IsValid(ab.target) and ab.target:entindex() or nil
		local aq = ab.bFadeAnimation
		local ar = ab.fadeAnimationTime
		local as = ai
		local at = ab.bIgnoreBackswing
		if at == nil then
			at = true
		end
		local au = {
			duration = aj,
			castPoint = ak,
			castAnimation = al,
			orderType = am,
			animationRate = an,
			position = ao,
			targetIndex = ap,
			bFadeAnimation = aq,
			fadeAnimationTime = ar,
			activityModifier = as,
			bIgnoreBackswing = at,
			bUseCooldown = (ab.bUseCooldown == nil or ab.bUseCooldown == true) and 1 or 0,
			bUseMana = (ab.bUseMana == nil or ab.bUseMana == true) and 1 or 0,
		}
		J.CustomAbilityPhaseStart = ab.OnAbilityPhaseStart
		J.CustomAbilityPhaseInterrupted = ab.OnAbilityPhaseInterrupted
		local B = self:AddNewModifier(self, J, "modifier_passive_cast", au)
		if IsValid(B) then
			B.callback = af
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
		for av = 0, #self.__activityModifiers - 1, 1 do
			self:AddActivityModifier_Engine(self.__activityModifiers[av + 1])
		end
	end
	CDOTA_BaseNPC.AddActivityModifier = function(self, aw)
		if self.__activityModifiers == nil then
			self.__activityModifiers = {}
		end
		local ax = self.__activityModifiers
		ax[#ax + 1] = aw
		self:UpdateActivityModifier()
	end
	CDOTA_BaseNPC.RemoveActivityModifier = function(self, aw)
		if self.__activityModifiers == nil then
			self.__activityModifiers = {}
		end
		ArrayRemove(self.__activityModifiers, aw)
		self:UpdateActivityModifier()
	end
	CDOTA_BaseNPC.DealDamage = function(self, ay, J, az, aA, aB)
		if not IsValid(self) or J ~= nil and not IsValid(J) then
			return
		end
		local aC = DOTA_DAMAGE_CATEGORY_BARRIER
		if J ~= nil then
			if aA == nil then
				aA = J:GetDamageType()
			end
			local aD = J:GetAbilityTag()
			if
				aD == AbilityTag.Skill
				or aD == AbilityTag.Dodge
				or aD == AbilityTag.Defense
				or aD == AbilityTag.Ultimate
			then
				aC = DOTA_DAMAGE_CATEGORY_SPELL
			end
		end
		if c(ay) then
			for av, aE in ipairs(ay) do
				do
					if not IsValid(aE) then
						goto aF
					end
					local aG = DamageSystem:AcquireDamageInfo()
					aG.attacker = self
					aG.target = aE
					aG.ability = J
					aG.damage = az
					aG.damage_type = aA or EOM_DAMAGE_TYPES.DAMAGE_TYPE_NONE
					aG.damage_flags = aB
					aG.damage_category = aC
					DamageSystem:DealDamage(aG, true)
				end
				::aF::
			end
		else
			if not IsValid(ay) then
				return
			end
			local aG = DamageSystem:AcquireDamageInfo()
			aG.attacker = self
			aG.target = ay
			aG.ability = J
			aG.damage = az
			aG.damage_type = aA or EOM_DAMAGE_TYPES.DAMAGE_TYPE_NONE
			aG.damage_flags = aB
			aG.damage_category = aC
			DamageSystem:DealDamage(aG, true)
		end
	end
	CDOTA_BaseNPC.Attack = function(self, ay, aG)
		local aH = aG and aG.baseDamage or self:GetAttackDamage()
		local aI = aG and aG.damageAmplify or 0
		local aJ = aG and aG.bonusDamage or 0
		local aK = aG and aG.damageType or EOM_DAMAGE_TYPES.DAMAGE_TYPE_PHYSICAL
		local aL = DamageSystem:AcquireDamageInfo()
		aL.attacker = self
		aL.target = ay
		aL.ability = self:GetAbilityByTag(AbilityTag.Attack)
		aL.damage = (aH + aJ) * (1 + aI)
		aL.damage_category = DOTA_DAMAGE_CATEGORY_ATTACK
		aL.damage_type = aK
		aL.damage_flags = aG and aG.flags or EOM_DAMAGE_FLAGS.NONE
		DamageSystem:DealDamage(aL, true)
	end
	CDOTA_BaseNPC.GetAbilityByTag = function(self, aM)
		if self:IsHero() then
			if aM == AbilityTag.Skill then
				return self:GetAbilityByIndex(0)
			end
			if aM == AbilityTag.Dodge then
				return self:GetAbilityByIndex(1)
			end
			if aM == AbilityTag.Defense then
				return self:GetAbilityByIndex(2)
			end
			if aM == AbilityTag.Ultimate then
				return self:GetAbilityByIndex(5)
			end
			if aM == AbilityTag.Attack then
				return self:GetAbilityByIndex(3)
			end
			if aM == AbilityTag.Interact then
				return self:GetAbilityByIndex(4)
			end
		else
			do
				local aN = 0
				while aN < self:GetAbilityCount() do
					local J = self:GetAbilityByIndex(aN)
					if IsValid(J) and J:GetAbilityTag() == aM then
						return J
					end
					aN = aN + 1
				end
			end
		end
	end
	CDOTA_BaseNPC.EachAbility = function(self, af)
		local aO = { AbilityTag.Attack, AbilityTag.Skill, AbilityTag.Dodge, AbilityTag.Defense, AbilityTag.Ultimate }
		for av = 0, #aO - 1, 1 do
			local aD = aO[av + 1]
			local J = self:GetAbilityByTag(aD)
			if IsValid(J) then
				af(J, aD)
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
	CDOTA_BaseNPC.AddItem = function(self, aP, aQ)
		if aQ == nil then
			aQ = true
		end
		if self.__items == nil then
			self.__items = {}
		end
		self:AddItem_Engine(aP)
		aP:__OnCreated()
		local aR = self.__items
		aR[#aR + 1] = {
			entIndex = aP:entindex(),
			itemName = aP:GetAbilityName(),
			level = aP:GetLevel(),
			stackCount = aP.__StackCount or 0,
			charge = aP.__Charge or 0,
			maxCharge = aP:GetMaxCharges(),
			chargeRestoreTime = aP.__ChargeRestoreTime or 0,
			isChargeCooldownFrozen = aP:IsChargeCooldownFrozen(),
			chargeFrozenCooldownRemaining = aP:GetChargeCooldownRemaining(),
		}
		self:TakeItem(aP)
		Event:Fire("item_added", { unit = self, item = aP })
		if aQ then
			self:UpdateAbilityNetData()
		end
		return aP
	end
	CDOTA_BaseNPC.AddItemByName = function(self, aS, I, aQ)
		if I == nil then
			I = 1
		end
		if aQ == nil then
			aQ = true
		end
		if self.__items == nil then
			self.__items = {}
		end
		local aP = self:AddItemByName_Engine(aS)
		aP:__OnCreated()
		if I > 1 then
			aP:SetLevel(I, false)
		end
		local aT = self.__items
		aT[#aT + 1] = {
			entIndex = aP:entindex(),
			itemName = aP:GetAbilityName(),
			level = aP:GetLevel(),
			stackCount = aP.__StackCount or 0,
			charge = aP.__Charge or 0,
			maxCharge = aP:GetMaxCharges(),
			chargeRestoreTime = aP.__ChargeRestoreTime or 0,
			isChargeCooldownFrozen = aP:IsChargeCooldownFrozen(),
			chargeFrozenCooldownRemaining = aP:GetChargeCooldownRemaining(),
		}
		self:TakeItem(aP)
		Event:Fire("item_added", { unit = self, item = aP })
		if aQ then
			self:UpdateAbilityNetData()
		end
		return aP
	end
	CDOTA_BaseNPC.RemoveItem = function(self, aP)
		if self.__items == nil then
			self.__items = {}
		end
		if not IsValid(aP) then
			return
		end
		Event:Fire("item_consumed", { unit = self, item = aP })
		aP:__OnDestroy()
		self.__items = d(self.__items, function(aU, au)
			return au.entIndex ~= aP:entindex()
		end)
		self:RemoveItem_Engine(aP)
		Event:Fire("item_removed", { unit = self, item = aP })
		self:UpdateAbilityNetData()
	end
	CDOTA_BaseNPC.RemoveAllItem = function(self)
		if self.__items == nil then
			self.__items = {}
		end
		local aV = self:GetAllItems()
		e(aV, function(aU, aP)
			if IsValid(aP) then
				aP:__OnDestroy()
				self.__items = d(self.__items or {}, function(aU, au)
					return au.entIndex ~= aP:entindex()
				end)
				self:RemoveItem_Engine(aP)
				Event:Fire("item_removed", { unit = self, item = aP })
			end
		end)
		self.__items = {}
		CustomNetTables:SetNetData("unit", tostring(self:entindex()), nil)
	end
	CDOTA_BaseNPC.GetAllItems = function(self)
		local aW = {}
		if self.__items == nil then
			self.__items = {}
		end
		e(self.__items, function(aU, au)
			local aP = EntIndexToHScript(au.entIndex)
			if IsValid(aP) then
				aW[#aW + 1] = aP
			end
		end)
		return aW
	end
	CDOTA_BaseNPC.GetItemByName = function(self, aS)
		if self.__items == nil then
			self.__items = {}
		end
		local aP
		f(self.__items, function(aU, au)
			if au.itemName == aS then
				aP = EntIndexToHScript(au.entIndex)
			end
		end)
		return aP
	end
	CDOTA_BaseNPC.GetItemByNameAndLevel = function(self, aS, I)
		if self.__items == nil then
			self.__items = {}
		end
		local aP
		f(self.__items, function(aU, au)
			if au.itemName == aS and au.level == I then
				aP = EntIndexToHScript(au.entIndex)
			end
		end)
		return aP
	end
	CDOTA_BaseNPC.HasItem = function(self, aS)
		if self.__items == nil then
			self.__items = {}
		end
		return g(self.__items, function(aU, au)
			return au.itemName == aS
		end)
	end
	CDOTA_BaseNPC.GetItemCount = function(self, aS)
		if self.__items == nil then
			self.__items = {}
		end
		return #d(self.__items, function(aU, au)
			return au.itemName == aS
		end)
	end
	CDOTA_BaseNPC.UpdateAbilityNetData = function(self)
		if self.__items == nil then
			self.__items = {}
		end
		e(self.__items, function(aU, au)
			local aP = EntIndexToHScript(au.entIndex)
			au.stackCount = aP.__StackCount or 0
			au.charge = aP.__Charge or 0
			au.maxCharge = aP:GetMaxCharges()
			au.chargeRestoreTime = aP.__ChargeRestoreTime or 0
			au.isChargeCooldownFrozen = aP:IsChargeCooldownFrozen()
			au.chargeFrozenCooldownRemaining = aP:GetChargeCooldownRemaining()
		end)
		local aX = {}
		local aY = self:GetAbilityByTag(AbilityTag.Attack)
		if aY then
			aX[#aX + 1] = aY
		end
		local aZ = self:GetAbilityByTag(AbilityTag.Skill)
		if aZ then
			aX[#aX + 1] = aZ
		end
		local a_ = self:GetAbilityByTag(AbilityTag.Dodge)
		if a_ then
			aX[#aX + 1] = a_
		end
		local b0 = self:GetAbilityByTag(AbilityTag.Defense)
		if b0 then
			aX[#aX + 1] = b0
		end
		local b1 = self:GetAbilityByTag(AbilityTag.Ultimate)
		if b1 then
			aX[#aX + 1] = b1
		end
		if not self:IsRealHero() then
			return
		end
		CustomNetTables:SetNetData(
			"unit",
			tostring(self:entindex()),
			{
				items = self.__items,
				abilities = f(aX, function(aU, J)
					return {
						entIndex = J:entindex() or -1,
						stackCount = J.__StackCount or 0,
						abilityName = J:GetAbilityName(),
						charge = J.__Charge or 0,
						maxCharge = J:GetMaxCharges(),
						chargeRestoreTime = J.__ChargeRestoreTime or 0,
						isChargeCooldownFrozen = J:IsChargeCooldownFrozen(),
						chargeFrozenCooldownRemaining = J:GetChargeCooldownRemaining(),
					}
				end),
			}
		)
	end
	CDOTA_BaseNPC.CallAbilityCreated = function(self)
		do
			local av = 0
			while av < self:GetAbilityCount() do
				local J = self:GetAbilityByIndex(av)
				if IsValid(J) then
					J:__OnCreated()
				end
				av = av + 1
			end
		end
	end
	CDOTA_BaseNPC.CallAbilityRefresh = function(self)
		do
			local av = 0
			while av < self:GetAbilityCount() do
				local J = self:GetAbilityByIndex(av)
				if IsValid(J) then
					J:__OnRefresh()
				end
				av = av + 1
			end
		end
	end
	CDOTA_BaseNPC.CallAbilityDestroy = function(self)
		do
			local av = 0
			while av < self:GetAbilityCount() do
				local J = self:GetAbilityByIndex(av)
				if IsValid(J) then
					J:__OnDestroy()
				end
				av = av + 1
			end
		end
		self:RemoveAllItem()
	end
	CDOTA_BaseNPC.ChangeWeapon = function(self, b2)
		if self.__weapon ~= nil then
			self.__weapon:RemoveSelf()
			self.__weapon = nil
		end
		local a6 = KeyValues.weapon[b2]
		if a6 == nil then
			return
		end
		self.__weapon = SpawnEntityFromTableSynchronous(
			"dota_prop_customtexture",
			{
				targetname = b2,
				model = a6.model,
				StartingAnim = "ACT_DOTA_IDLE",
				StartingAnimationLoopMode = "ANIM_LOOP_MODE_LOOPING",
			}
		)
		local b3 = KeyValues.weapon_asset_modifier[b2]
		self.__weapon.__asset_modifier = {}
		if b3 ~= nil then
			if b3.particle_color ~= nil then
				self.__weapon.__asset_modifier.particle_color = RGBStringToVector(b3.particle_color)
			end
		end
		self.__weapon:FollowEntity(self, true)
		self:CheckNoDraw(self.__weapon)
	end
	CDOTA_BaseNPC.SetWeaponVisible = function(self, b4)
		self.__weapon_hidden = not b4
		if IsValid(self.__weapon) then
			self:CheckNoDraw(self.__weapon)
		end
	end
	CDOTA_BaseNPC.EquipCosmetic = function(self, b5)
		b5 = tostring(b5)
		local a6 = KeyValues.info_item_cosmetic[b5]
		if a6 == nil then
			return
		end
		local b6 = tostring(a6.type)
		if self.__cosmetics == nil then
			self.__cosmetics = {}
		end
		if b6 == "MISC" then
			local b7 = { id = b5 }
			local b8 = self.__cosmetics[b6]
			if b8 ~= nil then
				b8[#b8 + 1] = b7
			else
				self.__cosmetics[b6] = { b7 }
			end
			self:AddActivityModifier(b5)
			Cosmetic:RegisterParticleReplacements(self, b6, b5)
			if a6.model == nil then
				return
			end
			local b9 = SpawnEntityFromTableSynchronous(
				"dota_prop_customtexture",
				{
					targetname = b5,
					model = a6.model,
					StartingAnim = "ACT_DOTA_IDLE",
					StartingAnimationLoopMode = "ANIM_LOOP_MODE_LOOPING",
				}
			)
			b9:FollowEntity(self, true)
			b7.entity = b9
			return
		end
		self:UnequipCosmeticByType(b6, nil, true)
		self.__cosmetics[b6] = { id = b5 }
		self:AddActivityModifier(b5)
		Cosmetic:RegisterParticleReplacements(self, b6, b5)
		print(b6, "kv.particle", a6.particle)
		if a6.particle ~= nil then
			local ba = ParticleManager:CreateParticle(tostring(a6.particle), PATTACH_ABSORIGIN_FOLLOW, self)
			self.__cosmetics[b6].particleId = ba
			return
		end
		if a6.model == nil then
			return
		end
		local b9 = SpawnEntityFromTableSynchronous(
			"dota_prop_customtexture",
			{
				targetname = b5,
				model = a6.model,
				StartingAnim = "ACT_DOTA_IDLE",
				StartingAnimationLoopMode = "ANIM_LOOP_MODE_LOOPING",
			}
		)
		b9:FollowEntity(self, true)
		self.__cosmetics[b6].entity = b9
	end
	CDOTA_BaseNPC.UnequipCosmeticByType = function(self, b6, b5, bb)
		if self.__cosmetics == nil then
			self.__cosmetics = {}
		end
		if b6 == "MISC" then
			local bc = self.__cosmetics[b6]
			if bc == nil then
				return
			end
			if b5 ~= nil then
				do
					local av = #bc - 1
					while av >= 0 do
						if bc[av + 1].id == b5 then
							self:RemoveActivityModifier(bc[av + 1].id)
							Cosmetic:UnregisterParticleReplacements(self, b6)
							if bc[av + 1].entity ~= nil and IsValid(bc[av + 1].entity) then
								bc[av + 1].entity:RemoveSelf()
							end
							table.remove(bc, av)
							break
						end
						av = av - 1
					end
				end
				if #bc == 0 then
					h(self.__cosmetics, b6)
				end
			else
				do
					local av = #bc - 1
					while av >= 0 do
						self:RemoveActivityModifier(bc[av + 1].id)
						Cosmetic:UnregisterParticleReplacements(self, b6)
						if bc[av + 1].entity ~= nil and IsValid(bc[av + 1].entity) then
							bc[av + 1].entity:RemoveSelf()
						end
						av = av - 1
					end
				end
				h(self.__cosmetics, b6)
			end
			return
		end
		local bd = self.__cosmetics[b6]
		if bd == nil then
			return
		end
		self:RemoveActivityModifier(bd.id)
		Cosmetic:UnregisterParticleReplacements(self, b6)
		if bd.particleId ~= nil then
			ParticleManager:DestroyParticle(bd.particleId, true)
		end
		if bd.entity ~= nil and IsValid(bd.entity) then
			bd.entity:RemoveSelf()
		end
		h(self.__cosmetics, b6)
		if not bb then
			local be = self:GetPlayerOwnerID()
			local bf = tostring(PlayerResource:GetSelectedHeroID(be))
			for bg, bh in pairs(KeyValues.info_item_cosmetic) do
				do
					local b7 = bh
					if tostring(b7.type) ~= b6 then
						goto bi
					end
					if tostring(b7.default) ~= "1" then
						goto bi
					end
					local bj = b7.hero_id ~= nil and tostring(b7.hero_id) or nil
					if bj == nil or bj == bf then
						self:EquipCosmetic(bg)
						break
					end
				end
				::bi::
			end
		end
	end
	CDOTA_BaseNPC.CheckNoDraw = function(self, b9)
		local b4 = not self.__NODAW
		if self.__weapon_hidden then
			b4 = false
		end
		if IsValid(b9) then
			if b4 then
				b9:RemoveEffects(EF_NODRAW)
			else
				b9:AddEffects(EF_NODRAW)
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
	CDOTA_BaseNPC.AddShield = function(self, bk, A, bl, bm)
		if bk <= 0 then
			return
		end
		local y = CalculateEquivalentDefenseIntensity(self)
		bk = bk * (1 + GetShieldAmplify(self) * 0.01) * (1 + y * INTENSITY_FACTOR * 0.01)
		local bn = A or DoUniqueString("shield")
		local bo = bl or "override"
		local bp = bm or "normal"
		self:AddNewModifier(self, nil, "modifier_shield", { shield = bk, id = bn, method = bo, type = bp })
	end
	CDOTA_BaseNPC.RemoveShield = function(self, A)
		if A == nil then
			self:RemoveModifierByName("modifier_shield")
		else
			local B = self:FindModifierByName("modifier_shield")
			if IsValid(B) then
				B:RemoveShield(A)
			end
		end
	end
	CDOTA_BaseNPC.ReduceShield = function(self, t, A, bq)
		if t <= 0 then
			return
		end
		local B = self:FindModifierByName("modifier_shield")
		if not IsValid(B) then
			return
		end
		B:ReduceShield(t, A, bq)
	end
	CDOTA_BaseNPC.AddProperty = function(self, n, br)
		if PROPERTY_MAP_REVERSE[n] ~= nil then
			PropertySystem:AddStaticProperty(
				self:entindex(),
				PROPERTY_MAP_REVERSE[n],
				DoUniqueString("static_property"),
				br
			)
		end
	end
	CDOTA_BaseNPC.EnergyStrike = function(self, bs, bt, J, bu, az, a4, ab)
		ab = ab or {}
		local bv = ab.source or self
		local bw = ab.jumpDelay or 0
		local bx = ab.jumpCount or 0
		local by = ab.jumpRadius or 600
		local K = ab.attachName or "attach_attack1"
		local bz = ab.soundName or "Hero_Zuus.ArcLightning.Cast"
		local function bA(bv, ay, bB)
			self:DealDamage(ay, J, az)
			if type(a4) == "function" then
				a4(bv, ay, bB)
			else
				local ba = ParticleManager:CreateParticle(a4, PATTACH_CUSTOMORIGIN, nil)
				ParticleManager:SetParticleControlEnt(
					ba,
					0,
					bv,
					PATTACH_POINT_FOLLOW,
					bB and K or "attach_hitloc",
					bv:GetAbsOrigin(),
					false
				)
				ParticleManager:SetParticleControlEnt(
					ba,
					1,
					ay,
					PATTACH_POINT_FOLLOW,
					"attach_hitloc",
					ay:GetAbsOrigin(),
					false
				)
				ParticleManager:ReleaseParticleIndex(ba)
			end
			EmitSoundOnLocationWithCaster(bv:GetAbsOrigin(), bz, self)
		end
		local bC = { bs }
		if bu > 0 then
			local bD = FindUnitsInRadiusWithAbility(self, bs:GetAbsOrigin(), bt, J)
			ArrayRemove(bD, bs)
			for bE, w in ipairs(bD) do
				table.insert(bC, w)
				bu = bu - 1
				if bu <= 0 then
					break
				end
			end
		end
		local bF = {}
		local bG = bx - 1
		for bE, w in ipairs(bC) do
			local bH = w
			bA(bv, bH, true)
			table.insert(bF, w)
			if bG > 0 then
				bG = bG - 1
				self:GameTimer(bw, function()
					local bI = FindUnitsInRadiusWithAbility(self, bH:GetAbsOrigin(), by, J, FIND_CLOSEST)
					for bE, bJ in ipairs(bF) do
						ArrayRemove(bI, bJ)
					end
					local bK = bI[1]
					if IsValid(bK) then
						bA(bH, bK, false)
						table.insert(bF, bK)
						if bG > 0 then
							bH = bK
							return bw
						end
					end
				end)
			end
		end
	end
	CDOTA_BaseNPC.AddExpose = function(self, ay, bL)
		if bL == nil then
			bL = 1
		end
		local B = ay:AddNewModifier(self, nil, "modifier_expose", { stack = bL, duration = 3 })
		local bM = IsValid(B) and B:GetStackCount() or 0
		Event:Fire("expose_event", { target = ay, caster = self, addStack = bL, stack = bM })
	end
	CDOTA_BaseNPC.IsExpose = function(self)
		local B = self:FindModifierByName("modifier_expose")
		return IsValid(B)
	end
	CDOTA_BaseNPC.AddIceMark = function(self, ay, bL)
		if bL == nil then
			bL = 1
		end
		local B = ay:AddNewModifier(self, nil, "modifier_ice_mark", { stack = bL, duration = 3 })
		local bN = IsValid(B) and B:GetStackCount() or 0
		Event:Fire("ice_mark_event", { target = ay, caster = self, addStack = bL, stack = bN })
	end
	CDOTA_BaseNPC.IsIceMark = function(self)
		local B = self:FindModifierByName("modifier_ice_mark")
		return IsValid(B)
	end
	CDOTA_BaseNPC.ArcLightning = function(self, ay, az, bO)
		if bO == nil then
			bO = false
		end
		local bP = BlessPerformance.Enabled
		local bQ = GameRules:GetGameTime()
		if bP then
			BlessPerformance:Increment("arc_calls")
		end
		local bC = FindUnitsInRadius(
			self:GetTeamNumber(),
			ay:GetAbsOrigin(),
			nil,
			900,
			DOTA_UNIT_TARGET_TEAM_ENEMY,
			DOTA_UNIT_TARGET_HEROES_AND_CREEPS,
			DOTA_UNIT_TARGET_FLAG_NONE,
			FIND_CLOSEST,
			false
		)
		ArrayRemove(bC, ay)
		table.insert(bC, 1, ay)
		local bR = self
		local bS = 3
		if
			self.__arcLightningSoundTime == nil
			or bQ - self.__arcLightningSoundTime >= ARC_LIGHTNING_SOUND_COOLDOWN_SECONDS
		then
			self.__arcLightningSoundTime = bQ
			self:EmitSound("Bless.ArcLightning")
		end
		for av, aE in ipairs(bC) do
			if bP then
				BlessPerformance:Increment("arc_hits")
				BlessPerformance:Increment("arc_particles")
			end
			local ba = ParticleManager:CreateParticle(
				"particles/units/benediction/zuus_arc_lightning.vpcf",
				PATTACH_CUSTOMORIGIN,
				self
			)
			if av == 0 then
				ParticleManager:SetParticleControlEnt(
					ba,
					0,
					bR,
					PATTACH_POINT_FOLLOW,
					"attach_attack1",
					bR:GetAbsOrigin(),
					false
				)
			else
				ParticleManager:SetParticleControlEnt(
					ba,
					0,
					bR,
					PATTACH_POINT_FOLLOW,
					"attach_hitloc",
					bR:GetAbsOrigin(),
					false
				)
			end
			ParticleManager:SetParticleControlEnt(
				ba,
				1,
				aE,
				PATTACH_POINT_FOLLOW,
				"attach_hitloc",
				aE:GetAbsOrigin(),
				false
			)
			ParticleManager:ReleaseParticleIndex(ba)
			self:DealDamage(aE, nil, az, EOM_DAMAGE_TYPES.DAMAGE_TYPE_NONE, EOM_DAMAGE_FLAGS.LIGHTNING_DAMAGE)
			if PRD(nil, self, GetLightningExposeChance(self), "ArcLightning") then
				self:AddExpose(aE)
			end
			bS = bS - 1
			if bS <= 0 then
				break
			end
			bR = aE
		end
		if not bO then
			local bT = GetLightningCount(self)
			if bT > 0 then
				local bU = FindUnitsInRadius(
					self:GetTeamNumber(),
					ay:GetAbsOrigin(),
					nil,
					900,
					DOTA_UNIT_TARGET_TEAM_ENEMY,
					DOTA_UNIT_TARGET_HEROES_AND_CREEPS,
					DOTA_UNIT_TARGET_FLAG_NONE,
					FIND_ANY_ORDER,
					false
				)
				ArrayRemove(bU, ay)
				local bV = 0
				for bE, w in ipairs(bU) do
					self:ArcLightning(w, az, true)
					bV = bV + 1
					if bV >= bT then
						break
					end
				end
			end
		end
	end
	CDOTA_BaseNPC.LightningStrike = function(self, ay, az, s)
		if s == nil then
			s = EOM_DAMAGE_FLAGS.NONE
		end
		local bP = BlessPerformance.Enabled
		if bP then
			BlessPerformance:Increment("lightning_requests")
		end
		local bQ = GameRules:GetGameTime()
		s = bit.bor(s, EOM_DAMAGE_FLAGS.LIGHTNING_DAMAGE)
		local bW = GetLightningRadius(self)
		local bX = ay:GetAbsOrigin()
		local bC = {}
		if bW > 0 then
			bC = FindEnemiesInRadius(self, bX, bW)
		else
			bC = { ay }
		end
		if bW > 0 then
			local bY = ArrayRemove(bC, ay)
			if bY ~= nil then
				table.insert(bC, 1, bY)
			end
		end
		local bZ = self.__lightningStrikeHitTime == bQ and (self.__lightningStrikeTargetHitCount or 0) or 0
		local b_ = math.max(0, MAX_LIGHTNING_STRIKE_TARGET_HITS_PER_FRAME - bZ)
		if #bC > b_ then
			local c0 = #bC - b_
			if bP then
				BlessPerformance:Increment("lightning_dropped", c0)
			end
			bC = i(bC, 0, b_)
		end
		if #bC == 0 then
			return
		end
		self.__lightningStrikeHitTime = bQ
		self.__lightningStrikeTargetHitCount = bZ + #bC
		if bP then
			BlessPerformance:Increment("lightning_aoe_hits", #bC)
		end
		for av, w in ipairs(bC) do
			if w == ay then
				self:DealDamage(w, nil, az, EOM_DAMAGE_TYPES.DAMAGE_TYPE_NONE, s)
			else
				self:DealDamage(w, nil, az, EOM_DAMAGE_TYPES.DAMAGE_TYPE_NONE, bit.bor(s, EOM_DAMAGE_FLAGS.NO_EXPOSE))
			end
		end
		if
			self.__lightningStrikeEffectWindowStart == nil
			or bQ - self.__lightningStrikeEffectWindowStart >= LIGHTNING_STRIKE_EFFECT_LIMIT_INTERVAL_SECONDS
		then
			self.__lightningStrikeEffectWindowStart = bQ
			self.__lightningStrikeEffectCount = 0
			self.__lightningStrikeSoundCount = 0
		end
		if (self.__lightningStrikeSoundCount or 0) < MAX_LIGHTNING_STRIKE_SOUNDS_PER_SECOND then
			self.__lightningStrikeSoundCount = (self.__lightningStrikeSoundCount or 0) + 1
			self:EmitSound("Bless.LightningStrike", bX)
		end
		if (self.__lightningStrikeEffectCount or 0) < MAX_LIGHTNING_STRIKE_EFFECTS_PER_SECOND then
			self.__lightningStrikeEffectCount = (self.__lightningStrikeEffectCount or 0) + 1
			if bP then
				BlessPerformance:Increment("lightning_particles", 2)
			end
			local ba = ParticleManager:CreateParticle(
				"particles/units/benediction/zuus_lightning_bolt.vpcf",
				PATTACH_WORLDORIGIN,
				nil
			)
			ParticleManager:SetParticleControl(ba, 0, bX + Vector(0, 0, 900))
			ParticleManager:SetParticleControl(ba, 1, bX)
			ParticleManager:ReleaseParticleIndex(ba)
			ba = ParticleManager:CreateParticle(
				"particles/units/benediction/zuus_lightning_bolt_aoe.vpcf",
				PATTACH_WORLDORIGIN,
				nil
			)
			ParticleManager:SetParticleControl(ba, 0, bX)
			ParticleManager:SetParticleControl(ba, 1, Vector(bW, 0, 0))
			ParticleManager:ReleaseParticleIndex(ba)
		end
		local c1 = GetLightningMultipleChance(self)
		if PRD(nil, self, c1, "LightningStrike") then
			self:StartThink(0.25, "LightningStrike", function()
				if IsValid(ay) then
					self:LightningStrike(ay, az, s)
				end
				return -1
			end)
		end
		Event:Fire("lightning_strike", { caster = self, target = ay, damage = az })
	end
	CDOTA_BaseNPC.LightningStorm = function(self, ay, az)
		local G = ay:GetAbsOrigin()
		local ba = ParticleManager:CreateParticle(
			"particles/units/benediction/leshrac_lightning_bolt.vpcf",
			PATTACH_ABSORIGIN,
			self
		)
		ParticleManager:SetParticleControl(ba, 0, G + Vector(0, 0, 1000))
		ParticleManager:SetParticleControlEnt(ba, 1, ay, PATTACH_POINT_FOLLOW, "attach_hitloc", ay:GetAbsOrigin(), true)
		ParticleManager:ReleaseParticleIndex(ba)
		self:EmitSound("Hero_Leshrac.Lightning_Storm")
		self:DealDamage(
			ay,
			nil,
			az,
			EOM_DAMAGE_TYPES.DAMAGE_TYPE_NONE,
			EOM_DAMAGE_FLAGS.LIGHTNING_DAMAGE + EOM_DAMAGE_FLAGS.NO_EXPOSE
		)
		Event:Fire("lightning_storm", { caster = self, target = ay, damage = az })
	end
	CDOTA_BaseNPC.LightningCloud = function(self, U)
		local c2 = U * (1 + GetLightningCloudDuration(self) * 0.01)
		self:AddNewModifier(self, nil, "modifier_lightning_cloud", { duration = c2 })
	end
	CDOTA_BaseNPC.CallSword = function(self, bS, c3, c4, c5)
		if c3 == nil then
			c3 = 0
		end
		if c4 == nil then
			c4 = 0
		end
		if c5 == nil then
			c5 = false
		end
		if self.__swordGroup == nil then
			self.__swordGroup = {}
		end
		do
			local av = #self.__swordGroup - 1
			while av >= 0 do
				local c6 = self.__swordGroup[av + 1]
				if Bullet:GetBulletData(c6) == nil then
					table.remove(self.__swordGroup, av)
				end
				av = av - 1
			end
		end
		bS = math.min(bS, MAX_CALL_SWORD_GROUP_SIZE - #self.__swordGroup)
		if bS <= 0 then
			return
		end
		local P = self
		local az = SWORD_DAMAGE * (1 + c3 * 0.01)
		local c7 = Bullet:CreateGroupSurroundBullet(bS, {
			caster = P,
			group = "CallSword" .. tostring(P:entindex()),
			circleRadius = 120,
			angularVelocity = 180,
			offset = 128,
			lifeTime = 5,
			interval = 1,
			ParticleCreator = function(c8)
				local ba =
					ParticleManager:CreateParticle("particles/abilities/custom_sword.vpcf", PATTACH_CUSTOMORIGIN, nil)
				ParticleManager:SetParticleControlEnt(
					ba,
					0,
					c8.__thinker,
					PATTACH_ABSORIGIN_FOLLOW,
					nil,
					c8.__thinker:GetAbsOrigin(),
					true
				)
				ParticleManager:SetParticleControlEnt(ba, 1, P, PATTACH_ABSORIGIN_FOLLOW, nil, P:GetAbsOrigin(), true)
				return ba
			end,
			OnIntervalThink = function(c8)
				if not IsValid(P) then
					return
				end
				local ay = FindEnemiesInRadius(P, P:GetAbsOrigin(), 1200)[1]
				if IsValid(ay) then
					local c9 = c8.__position
					c9.z = P:GetAbsOrigin().z + 128
					Bullet:CreateGuidedBullet({
						caster = P,
						target = ay,
						direction = CalcDirection2D(c9, P),
						effectName = "particles/generic_gameplay/talent_sword_projectile.vpcf",
						spawnOrigin = c9,
						angularVelocity = 360,
						ignoreBlock = true,
						radius = 64,
						moveSpeed = 1500,
						teamFilter = DOTA_UNIT_TARGET_TEAM_ENEMY,
						typeFilter = DOTA_UNIT_TARGET_HEROES_AND_CREEPS,
						OnBulletThink = function(G, c8)
							c8.angularVelocity = c8.angularVelocity + 20
							if IsValid(c8.target) and not c8.target:IsAlive() then
								c8.target = nil
							end
						end,
						OnBulletHit = function(w, G, c8)
							P:DealDamage(
								w,
								nil,
								az,
								EOM_DAMAGE_TYPES.DAMAGE_TYPE_NONE,
								EOM_DAMAGE_FLAGS.NO_CRIT + EOM_DAMAGE_FLAGS.SWORD
							)
							if c4 > 0 then
								local ca = c8.__thinker:GetAbsOrigin()
								DoCleaveAction(
									P,
									w,
									100,
									200,
									c4,
									function(cb)
										if cb == w then
											return
										end
										P:DealDamage(
											cb,
											nil,
											az,
											EOM_DAMAGE_TYPES.DAMAGE_TYPE_NONE,
											EOM_DAMAGE_FLAGS.NO_CRIT + EOM_DAMAGE_FLAGS.SWORD
										)
									end,
									DOTA_UNIT_TARGET_TEAM_ENEMY,
									DOTA_UNIT_TARGET_CREEP + DOTA_UNIT_TARGET_HERO,
									nil,
									ca
								)
								local cc = ParticleManager:CreateParticle(
									"particles/econ/items/sven/sven_ti7_sword/sven_ti7_sword_spell_great_cleave.vpcf",
									PATTACH_WORLDORIGIN,
									c8.__thinker
								)
								ParticleManager:SetParticleControl(cc, 0, ca)
								ParticleManager:SetParticleControlForward(cc, 0, w:GetAbsOrigin() - ca)
								ParticleManager:ReleaseParticleIndex(cc)
							end
							Bullet:DestroyBullet(c8)
						end,
					})
					self:EmitSound("Hero_Pangolier.PreAttack")
					Bullet:DestroyBulletByID(c8.__projIndex)
				end
				return 0.1
			end,
		})
		self.__swordGroup = j(self.__swordGroup, c7)
		Event:Fire("call_sword", { caster = self, extra = c5 })
	end
	CDOTA_BaseNPC.SwordWave = function(self, cd, a1, az, ce)
		if ce == nil then
			ce = 0
		end
		local P = self
		local cf = 1 + GetBladeSpeedAmplify(P) * 0.01
		local cg = cf > 1 and 5 or 0
		local ch = 1 + ce * SWORD_INTENT_PCT_PER_STACK * 0.01
		local a2 = 800 * ch * cf + GetBulletRange(self)
		local ci = P:HasItem("item_crit_blade")
		Bullet:CreateLinearBullet({
			caster = P,
			spawnOrigin = cd,
			direction = a1,
			moveSpeed = 3000,
			distance = a2,
			destroyOnBounce = true,
			bounce = cg,
			effectName = "particles/units/benediction/invoker_deafening_blast.vpcf",
			radius = 200,
			teamFilter = DOTA_UNIT_TARGET_TEAM_ENEMY,
			typeFilter = UNIT_AND_BUILDING,
			OnBulletBounceEnd = function(c8)
				ParticleManager:DestroyParticle(c8.__particleID, false)
				local ba = ParticleManager:CreateParticle(c8.effectName, PATTACH_CUSTOMORIGIN, c8.caster)
				ParticleManager:SetParticleControlTransformForward(ba, 0, c8.__position, c8.__velocity:Normalized())
				ParticleManager:SetParticleControl(ba, 1, c8.__velocity)
				c8.__particleID = ba
			end,
			OnBulletThink = function(G, c8)
				if ci then
					local cj = Bullet:GetBulletInLine(c8.__previous or c8.__position, c8.__position, 200)
					P:ShootDown(cj)
				end
			end,
			OnBulletHit = function(ay)
				local ck = az * ch * cf
				local aL = {
					attacker = P,
					target = ay,
					damage = ck,
					damage_type = EOM_DAMAGE_TYPES.DAMAGE_TYPE_NONE,
					damage_flags = EOM_DAMAGE_FLAGS.BLADE,
					damage_category = DOTA_DAMAGE_CATEGORY_BARRIER,
				}
				P:DealDamage(
					ay,
					nil,
					ck * (1 + GetBladeDamageAmplify(P, aL) * 0.01),
					EOM_DAMAGE_TYPES.DAMAGE_TYPE_NONE,
					EOM_DAMAGE_FLAGS.BLADE
				)
			end,
		})
		P:EmitSound("Hero_Kez.FalconRush.Sai.Target")
	end
	CDOTA_BaseNPC.SwordCircle = function(self, az, ch)
		if ch == nil then
			ch = 1
		end
		local P = self
		local cl = 300 * (1 + GetAoeAmplify(self) * 0.01)
		local ci = P:HasItem("item_crit_blade")
		local cf = 1 + GetBladeSpeedAmplify(P) * 0.01
		local cm = cl * ch * cf
		local ck = az * ch * cf
		local bC = FindEnemiesInRadius(P, P:GetAbsOrigin(), cm)
		for aU, ay in ipairs(bC) do
			local aL = {
				attacker = P,
				target = ay,
				damage = ck,
				damage_type = EOM_DAMAGE_TYPES.DAMAGE_TYPE_NONE,
				damage_flags = EOM_DAMAGE_FLAGS.BLADE,
				damage_category = DOTA_DAMAGE_CATEGORY_BARRIER,
			}
			P:DealDamage(
				ay,
				nil,
				ck * (1 + GetBladeDamageAmplify(P, aL) * 0.01),
				EOM_DAMAGE_TYPES.DAMAGE_TYPE_NONE,
				EOM_DAMAGE_FLAGS.BLADE
			)
		end
		if ci then
			local cj = Bullet:GetBulletInRadius(P:GetAbsOrigin(), cm)
			P:ShootDown(cj)
		end
		local ba = ParticleManager:CreateParticle(
			"particles/units/heroes/hero_kez/kez_hungering_blades.vpcf",
			PATTACH_ABSORIGIN,
			P
		)
		ParticleManager:SetParticleControl(ba, 2, Vector(cm, 0, 0))
		ParticleManager:ReleaseParticleIndex(ba)
		P:EmitSound("Hero_Kez.RaptorDance.Katana.Slash")
	end
	CDOTA_BaseNPC.Frozen = function(self, ay, cn)
		if cn == nil then
			cn = 1
		end
		if cn == 0 then
			return
		end
		local B = ay:AddNewModifier(self, nil, "modifier_frozen_debuff", { stack = cn, entIndex = self:entindex() })
		local bL = IsValid(B) and B:GetStackCount() or 0
		Event:Fire("frozen_event", { target = ay, caster = self, addStack = cn, stack = bL })
	end
	CDOTA_BaseNPC.IsFrozen = function(self)
		return self:HasModifier("modifier_frozen_debuff")
	end
	CDOTA_BaseNPC.Freeze = function(self, ay, U)
		if ay:IsBoss() then
			return
		end
		ay:AddNewModifier(self, nil, "modifier_freeze_debuff", { duration = U })
	end
	CDOTA_BaseNPC.IsFreeze = function(self)
		return self:HasModifier("modifier_freeze_debuff")
	end
	CDOTA_BaseNPC.TriggerDecayOnce = function(self)
		local B = self:FindModifierByName("modifier_frozen_debuff")
		if IsValid(B) then
			return B:TriggerDecayOnce()
		end
	end
	CDOTA_BaseNPC.GetFrozenStack = function(self, P)
		local B = self:FindModifierByName("modifier_frozen_debuff")
		if IsValid(B) then
			return B:GetIceStack(P:entindex())
		end
		return 0
	end
	CDOTA_BaseNPC.FrozenBurst = function(self, az, co, G, c5)
		if c5 == nil then
			c5 = false
		end
		local bC = FindUnitsInRadius(
			self:GetTeamNumber(),
			G,
			nil,
			200,
			DOTA_UNIT_TARGET_TEAM_ENEMY,
			UNIT_AND_BUILDING,
			DOTA_UNIT_TARGET_FLAG_NONE,
			FIND_ANY_ORDER,
			false
		)
		local cp = GetFrozenBurstStack(self)
		local cq = co + cp
		for av, w in ipairs(bC) do
			self:Frozen(w, co + cp)
			self:DealDamage(w, nil, az, EOM_DAMAGE_TYPES.DAMAGE_TYPE_NONE, EOM_DAMAGE_FLAGS.FREEZE_DAMAGE)
		end
		local ba = ParticleManager:CreateParticle(
			"particles/units/benediction/lich_frost_nova.vpcf",
			PATTACH_CUSTOMORIGIN,
			nil
		)
		ParticleManager:SetParticleControl(ba, 0, G)
		ParticleManager:SetParticleControl(ba, 1, Vector(200, 200, 200))
		ParticleManager:ReleaseParticleIndex(ba)
		Event:Fire(
			"frozen_burst",
			{ caster = self, position = G, base_frozen_stack = co, added_frozen = cq, targets = bC, extra = c5 }
		)
	end
	CDOTA_BaseNPC.CreateIceVortex = function(self, G, az, co, U)
		local cr, cs = self, "__iceVortexThinkers"
		if cr[cs] == nil then
			cr[cs] = {}
		end
		local ct = self.__iceVortexThinkers
		local cu = {}
		do
			local aN = #ct - 1
			while aN >= 0 do
				do
					local cv = ct[aN + 1]
					if not IsValid(cv) then
						k(ct, aN, 1)
						goto cw
					end
					local cx = cv:FindModifierByName("modifier_ice_vortex_custom")
					if not IsValid(cx) then
						k(ct, aN, 1)
						goto cw
					end
					if cx:CanMerge(G) then
						cu[#cu + 1] = cx
					end
				end
				::cw::
				aN = aN - 1
			end
		end
		if #cu > 0 then
			local cy = cu[1]
			cy:Merge(G, az, co, U)
			do
				local aN = 1
				while aN < #cu do
					do
						local cx = cu[aN + 1]
						if not IsValid(cx) then
							goto cz
						end
						local cA = cx
						cy:Merge(cA:GetParent():GetAbsOrigin(), cA.damage, cA.frozen, cA:GetRemainingTime(), cA.radius)
						cA:Destroy()
					end
					::cz::
					aN = aN + 1
				end
			end
			return
		end
		CreateModifierThinker(
			self,
			nil,
			"modifier_ice_vortex_custom",
			{ entIndex = self:entindex(), damage = az, frozen = co, duration = U, radius = 275 },
			G,
			self:GetTeamNumber(),
			false
		)
	end
	CDOTA_BaseNPC.ThrowBloodSpear = function(self, ay, J, az, c5)
		if c5 == nil then
			c5 = false
		end
		if not IsValid(ay) or not ay:IsAlive() then
			return
		end
		Bullet:CreateTrackingBullet({
			caster = self,
			target = ay,
			ability = J,
			effectName = "particles/units/benediction/huskar_burning_spear.vpcf",
			moveSpeed = 900,
			spawnOrigin = self:GetAttachmentPosition("attach_hitloc"),
			OnBulletHit = function(cB)
				local ck = toFiniteNumber(az)
				self:Bleed(cB, ck)
				if ck > 0 then
					self:DealDamage(cB, J, ck, EOM_DAMAGE_TYPES.DAMAGE_TYPE_NONE)
				end
				Event:Fire("blood_spear", { caster = self, target = cB })
				self:EmitSound("Hero_BrewMaster.CinderBrew.Ignite", cB:GetAbsOrigin())
			end,
		})
	end
	CDOTA_BaseNPC.ThrowSnowball = function(self, ay, J, co, az, c5)
		if c5 == nil then
			c5 = false
		end
		if not IsValid(ay) or not ay:IsAlive() then
			return
		end
		local cC = GetSnowballBounceCount(self)
		Bullet:CreateTrackingBullet({
			caster = self,
			target = ay,
			ability = nil,
			effectName = "particles/units/benediction/snowball_projectile.vpcf",
			moveSpeed = 900,
			spawnOrigin = self:GetAttachmentPosition("attach_hitloc"),
			OnBulletHit = function(ay, G, c8)
				self:Frozen(ay, co)
				local aH = toFiniteNumber(az)
				az = aH + GetSnowballDamage(self, { target = ay, damage = aH })
				if az > 0 then
					self:DealDamage(ay, J, az, EOM_DAMAGE_TYPES.DAMAGE_TYPE_NONE, EOM_DAMAGE_FLAGS.FREEZE_DAMAGE)
				end
				self:EmitSound("FrostivusConsumable.Snowball.Target", ay:GetAbsOrigin())
				if cC > 0 then
					local bC = FindEnemiesInRadius(self, G, 500, FIND_CLOSEST)
					ArrayRemove(bC, ay)
					if #bC > 0 then
						c8.target = bC[1]
						if c8.__particleID ~= nil then
							ParticleManager:SetParticleControlTransformForward(
								c8.__particleID,
								0,
								G,
								c8.__velocity:Normalized()
							)
							ParticleManager:SetParticleControlEnt(
								c8.__particleID,
								1,
								c8.target,
								PATTACH_POINT_FOLLOW,
								"attach_hitloc",
								c8.target:GetAbsOrigin(),
								false
							)
						end
						cC = cC - 1
						return false
					end
				end
			end,
		})
		Event:Fire("throw_snowball", { caster = self, target = ay, extra = c5 })
	end
	CDOTA_BaseNPC.IceStrike = function(self, ay, J, az, c5)
		if az == nil then
			az = 0
		end
		if c5 == nil then
			c5 = false
		end
		local ba = ParticleManager:CreateParticle(
			"particles/generic_gameplay/sect_ice_freezing_attack.vpcf",
			PATTACH_CUSTOMORIGIN,
			nil
		)
		ParticleManager:SetParticleControlEnt(ba, 0, ay, PATTACH_ABSORIGIN_FOLLOW, nil, ay:GetAbsOrigin(), false)
		ParticleManager:SetParticleControl(
			ba,
			1,
			ay:GetAbsOrigin() + RandomVector(RandomInt(0, 150)) + Vector(0, 0, 1200)
		)
		ParticleManager:ReleaseParticleIndex(ba)
		self:StartThink(0.2, DoUniqueString("ice_delay"), function()
			if IsValid(ay) and IsValid(self) then
				local be = self:GetPlayerOwnerID()
				if Privilege:HasPrivilege("privilege_myth_005", be) then
					local bt = Privilege:GetPlayerDynamicValue("privilege_myth_005", be, "value")
					local cD = FindEnemiesInRadius(self, ay:GetAbsOrigin(), bt, FIND_CLOSEST)
					self:DealDamage(cD, J, az, EOM_DAMAGE_TYPES.DAMAGE_TYPE_NONE, EOM_DAMAGE_FLAGS.FREEZE_DAMAGE)
				else
					self:DealDamage(ay, J, az, EOM_DAMAGE_TYPES.DAMAGE_TYPE_NONE, EOM_DAMAGE_FLAGS.FREEZE_DAMAGE)
				end
				self:EmitSound("Frostivus.Item.Snowball.Target", ay:GetAbsOrigin())
			end
			return -1
		end)
		Event:Fire("ice_strike", { caster = self, target = ay, extra = c5 })
	end
	CDOTA_BaseNPC.Bleed = function(self, ay, bL)
		ay:AddNewModifier(self, nil, "modifier_bleed", { stack = bL, entIndex = self:entindex() })
	end
	CDOTA_BaseNPC.IsBleed = function(self)
		local B = self:FindModifierByName("modifier_bleed")
		return IsValid(B)
	end
	CDOTA_BaseNPC.GetBleedStack = function(self, P)
		local B = self:FindModifierByName("modifier_bleed")
		if IsValid(B) then
			return B:GetBleedStack(P:entindex())
		end
		return 0
	end
	CDOTA_BaseNPC.TriggerBleed = function(self, P, ch)
		if ch == nil then
			ch = 1
		end
		local B = self:FindModifierByName("modifier_bleed")
		if IsValid(B) then
			return B:TriggerBleed(P, ch)
		end
	end
	CDOTA_BaseNPC.Burning = function(self, ay, J, bL)
		ay:AddNewModifier(
			self,
			J,
			"modifier_burning",
			{ stack = math.floor(bL), entIndex = self:entindex(), duration = 5 }
		)
	end
	CDOTA_BaseNPC.IsBurning = function(self)
		local B = self:FindModifierByName("modifier_burning")
		return IsValid(B)
	end
	CDOTA_BaseNPC.GetBurningStack = function(self, P)
		local B = self:FindModifierByName("modifier_burning")
		if IsValid(B) then
			return B:GetBurningStack(P:entindex())
		end
		return 0
	end
	CDOTA_BaseNPC.TriggerBurning = function(self, P)
		local B = self:FindModifierByName("modifier_burning")
		if IsValid(B) then
			return B:TriggerBurning(P)
		end
	end
	CDOTA_BaseNPC.AddInvulnerable = function(self, U)
		self:AddNewModifier(self, nil, "modifier_invulnerable_buff", { duration = U })
	end
	CDOTA_BaseNPC.CreateWisp = function(self, aa, aG)
		local B = self:AddNewModifier(self, nil, "modifier_wisps", { unit_name = aa })
		if IsValid(B) then
			return B:CreateWisp(aa, aG)
		end
	end
	CDOTA_BaseNPC.RemoveWisp = function(self, cE)
		local B = self:FindModifierByName("modifier_wisps")
		if IsValid(B) then
			B:RemoveWisp(cE)
		end
	end
	CDOTA_BaseNPC.ShootDown = function(self, cF, cG)
		if cG == nil then
			cG = self:HasItem("item_holy_reflect")
		end
		local az = GetReflectDamage(self)
		for av, c8 in ipairs(cF) do
			if IsValid(c8.caster) and Bullet:IsReflectable(c8) and not c8.caster:IsFriendly(self) then
				if Bullet:IsLinearBullet(c8) then
					if cG then
						Bullet:CreateLinearBullet({
							caster = self,
							direction = -c8.direction:Normalized(),
							spawnOrigin = c8.__position,
							effectName = c8.effectName,
							moveSpeed = c8.moveSpeed * 3,
							radius = c8.radius,
							distance = c8.distance,
							teamFilter = DOTA_UNIT_TARGET_TEAM_ENEMY,
							typeFilter = DOTA_UNIT_TARGET_HEROES_AND_CREEPS,
							OnBulletHit = function(ay, G, c8)
								self:DealDamage(
									ay,
									nil,
									az,
									EOM_DAMAGE_TYPES.DAMAGE_TYPE_NONE,
									EOM_DAMAGE_FLAGS.REFLECT_DAMAGE
								)
							end,
							ParticleCreator = c8.ParticleCreator,
						})
					end
					Bullet:DestroyBulletByID(c8.__projIndex)
				elseif Bullet:IsGuidedBullet(c8) then
					if cG then
						Bullet:CreateGuidedBullet({
							caster = self,
							direction = -c8.__velocity:Normalized(),
							effectName = c8.effectName,
							spawnOrigin = c8.__position,
							moveSpeed = c8.moveSpeed * 3,
							radius = c8.radius,
							lifeTime = c8.lifeTime,
							teamFilter = DOTA_UNIT_TARGET_TEAM_ENEMY,
							typeFilter = DOTA_UNIT_TARGET_HEROES_AND_CREEPS,
							OnBulletHit = function(ay, G, c8)
								self:DealDamage(ay, nil, az)
								return true
							end,
							ParticleCreator = c8.ParticleCreator,
						})
					end
					Bullet:DestroyBulletByID(c8.__projIndex)
				end
			end
		end
		if #cF > 0 then
			Event:Fire("avoid_damage", { unit = self })
		end
	end
	CDOTA_BaseNPC.Weaken = function(self, ay, bL)
		if bL == nil then
			bL = 1
		end
		ay:AddNewModifier(self, nil, "modifier_weak_debuff", { stack = bL, duration = WEAK_DURATION })
	end
	CDOTA_BaseNPC.IsWeaken = function(self)
		local B = self:FindModifierByName("modifier_weak_debuff")
		return IsValid(B)
	end
	CDOTA_BaseNPC.GetWeakenStack = function(self, P)
		local B = self:FindModifierByName("modifier_weak_debuff")
		if IsValid(B) then
			return B:GetWeakenStack(P:entindex())
		end
		return 0
	end
	CDOTA_BaseNPC.AddExecuteThreshold = function(self, ay, bL)
		ay:AddNewModifier(self, nil, "modifier_execute_threshold", { stack = math.floor(bL), duration = 5 })
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
	CDOTA_BaseNPC.SimulateCast = function(self, cH)
		self:RemoveModifierByName("modifier_simulate_cast")
		local ag = cH.castPoint or 0
		local U = math.max(cH.duration or 0, ag or 0)
		local au = {
			duration = U,
			castPoint = ag,
			castAnimation = cH.castAnimation,
			orderType = cH.orderType,
			animationRate = cH.animationRate or 1,
			animationFadeIn = cH.animationFadeIn,
			animationFadeOut = cH.animationFadeOut,
			position = cH.position and VectorToString(cH.position) or nil,
			targetIndex = IsValid(cH.target) and cH.target:entindex() or nil,
			activityModifier = cH.activityModifier,
		}
		local B = self:AddNewModifier(self, nil, "modifier_simulate_cast", au)
		if IsValid(B) then
			B.OnSpellStart = cH.OnSpellStart
			B.OnFinish = cH.OnFinish
		end
	end
end
if IsServer() then
	CDOTA_BaseNPC.PushOff = function(self, G)
		if self:HasState(StateEnum.KNOCKBACK_IMMUNE) then
			return
		end
		self:SetAbsOrigin(G)
		local cI = self:GetHullRadius() + 50
		local cJ = FindEnemiesInRadius(self, G, cI)
		for aU, ay in ipairs(cJ) do
			ay:KnockBack(CalcDirection2D(ay, G), cI - CalcDistance(ay, G), 0, 0.06)
		end
		FindClearSpaceForUnit(self, G, true)
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
BaseNPC.IsCloseRange = function(self, ay)
	return CalcDistance(self, ay) <= CLOSE_RANGE
end
BaseNPC.IsFarRange = function(self, ay)
	return CalcDistance(self, ay) >= FAR_RANGE
end
if IsServer() then
	CDOTA_BaseNPC.Poison = function(self, ay, bL)
		if bL <= 0 then
			return
		end
		ay:AddNewModifier(self, nil, "modifier_poison_custom", { stack = bL, entIndex = self:entindex() })
		Event:Fire("poison_event", { target = ay, caster = self, addStack = bL, stack = ay:GetPoisonStack(self) })
	end
	CDOTA_BaseNPC.IsPoisoned = function(self)
		local B = self:FindModifierByName("modifier_poison_custom")
		return IsValid(B)
	end
	CDOTA_BaseNPC.GetPoisonStack = function(self, P)
		local B = self:FindModifierByName("modifier_poison_custom")
		if IsValid(B) then
			return B:GetPoisonStack(P:entindex())
		end
		return 0
	end
	CDOTA_BaseNPC.TriggerPoison = function(self, P)
		local B = self:FindModifierByName("modifier_poison_custom")
		return B and B:TriggerPoison(P)
	end
	CDOTA_BaseNPC.PoisionBottle = function(self, U, cK, bt, cL)
		if bt == nil then
			bt = 100
		end
		if cL == nil then
			cL = 180
		end
		if self.__poisonGroup == nil then
			self.__poisonGroup = {}
		end
		local be = self:GetPlayerOwnerID()
		if Privilege:HasPrivilege("privilege_myth_024", be) then
			local br = Privilege:GetPrivilegeSpecialValue("privilege_myth_024", 1, "value", self)
			U = U * (1 + br * 0.01)
			cK = cK * (1 + br * 0.01)
		end
		do
			local av = #self.__poisonGroup - 1
			while av >= 0 do
				local cM = self.__poisonGroup[av + 1]
				if Bullet:GetBulletData(cM) == nil then
					k(self.__poisonGroup, av, 1)
				end
				av = av - 1
			end
		end
		while POISON_BOTTLE_MAX_COUNT > 0 and #self.__poisonGroup >= POISON_BOTTLE_MAX_COUNT do
			local cN = 0
			local cO = math.huge
			do
				local av = 0
				while av < #self.__poisonGroup do
					local c8 = Bullet:GetBulletData(self.__poisonGroup[av + 1])
					local cP = c8 and c8.__lifeTimeRemaining
					if cP == nil then
						cP = 0
					end
					local cQ = cP
					if cQ < cO then
						cO = cQ
						cN = av
					end
					av = av + 1
				end
			end
			local cM = self.__poisonGroup[cN + 1]
			k(self.__poisonGroup, cN, 1)
			Bullet:DestroyBulletByID(cM)
		end
		local c7 = Bullet:CreateGroupSurroundBullet(1, {
			caster = self,
			group = "PoisionBottle" .. tostring(self:entindex()),
			circleRadius = bt,
			angularVelocity = cL,
			offset = 128,
			lifeTime = U,
			effectName = "particles/abilities/dupingzi.vpcf",
			interval = 1,
			teamFilter = DOTA_UNIT_TARGET_TEAM_ENEMY,
			typeFilter = DOTA_UNIT_TARGET_HEROES_AND_CREEPS,
			radius = 100,
			OnBulletCreated = function(c8)
				c8.poisionStack = cK
			end,
			OnBulletThink = function(G, c8)
				if c8.circleRadius < bt then
					c8.circleRadius = c8.circleRadius + 1
				end
			end,
			OnBulletHit = function(ay, cR, c8)
				local cS = toFiniteNumber(c8.poisionStack)
				self:Poison(ay, cS)
				if Privilege:HasPrivilege("privilege_suit_026", self:GetPlayerOwnerID()) then
					c8.poisionStack = cS
						+ Privilege:GetPrivilegeSpecialValue("privilege_suit_026", 1, "extra_count", self)
				end
			end,
			OnBulletDestroy = function(c8)
				c8.poisionStack = nil
			end,
		})
		self.__poisonGroup = j(self.__poisonGroup, c7)
		return c7
	end
	CDOTA_BaseNPC.ThrowPoisonBottle = function(self, G, J, cT, U)
		local cd = self:GetAbsOrigin()
		local a2 = CalcDistance(G, cd)
		local cU = U or a2 / 900
		local cV = cU > 0 and a2 / cU or 900
		Bullet:CreateLinearBullet({
			spawnOrigin = self:GetAbsOrigin(),
			moveSpeed = cV,
			direction = CalcDirection2D(G, self),
			distance = a2,
			ParticleCreator = function()
				local ba = ParticleManager:CreateParticle(
					"particles/units/benediction/bottle_poison.vpcf",
					PATTACH_CUSTOMORIGIN,
					nil
				)
				ParticleManager:SetParticleControl(ba, 0, self:GetAbsOrigin())
				ParticleManager:SetParticleControl(ba, 1, G)
				ParticleManager:SetParticleControl(ba, 2, Vector(cV, 0, 0))
				return ba
			end,
			OnBulletDestroy = function(c8)
				self:PoisonPool(c8.__position, toFiniteNumber(cT))
			end,
		})
	end
	CDOTA_BaseNPC.PoisonPool = function(self, G, bL, bt)
		if bt == nil then
			bt = 200
		end
		CreateModifierThinker(
			self,
			nil,
			"modifier_poison_pool",
			{ entIndex = self:entindex(), duration = 3, radius = bt, stack = bL },
			G,
			self:GetTeamNumber(),
			false
		)
		Event:Fire("poison_pool_event", { caster = self, position = G })
	end
end
if IsServer() then
	CDOTA_BaseNPC.Laser = function(self, a1, az, s)
		if s == nil then
			s = EOM_DAMAGE_FLAGS.NONE
		end
		s = bit.bor(s, EOM_DAMAGE_FLAGS.SHIELD_DAMAGE)
		local a2 = LASER_LENGTH + GetBulletRange(self)
		local P = self
		local cg = GetLaserBounceCount(P) + GetBounceCount(P)
		print(GetLaserBounceCount(P), GetBounceCount(P))
		local U = 0.1
		local cW = P:HasItem("item_holy_auto")
		local cX
		cX = function(cY, cZ, c_)
			Bullet:CreateLinearBullet({
				caster = P,
				spawnOrigin = cY,
				direction = cZ,
				radius = LASER_WIDTH,
				teamFilter = DOTA_UNIT_TARGET_TEAM_ENEMY,
				typeFilter = UNIT_AND_BUILDING,
				flagFilter = DOTA_UNIT_TARGET_FLAG_NONE,
				moveSpeed = a2 / U,
				distance = a2,
				thinker = true,
				bounce = c_,
				OnBulletHit = function(w)
					P:DealDamage(w, nil, az, EOM_DAMAGE_TYPES.DAMAGE_TYPE_NONE, s)
				end,
				OnBulletBounceEnd = function(c8)
					c8.__lifeTimeRemaining = U
					local ba = ParticleManager:CreateParticle(
						"particles/units/benediction/holy_laser.vpcf",
						PATTACH_CUSTOMORIGIN,
						nil
					)
					ParticleManager:SetParticleControl(ba, 9, Bullet:GetData(c8.__projIndex, "bounce_position", cY))
					ParticleManager:SetParticleControl(ba, 1, c8.__position)
					Bullet:SaveData(c8.__projIndex, "bounce_position", c8.__position)
					print("OnBulletBounceEnd", c_)
				end,
				OnBulletDestroy = function(c8)
					local ba = ParticleManager:CreateParticle(
						"particles/units/benediction/holy_laser.vpcf",
						PATTACH_CUSTOMORIGIN,
						nil
					)
					ParticleManager:SetParticleControl(ba, 9, Bullet:GetData(c8.__projIndex, "bounce_position", cY))
					ParticleManager:SetParticleControl(ba, 1, c8.__position)
					local d0 = c8.bounce or 0
					if d0 <= 0 then
						return
					end
					local d1 = c8.__position
					local d2 = d1 + RandomVector(a2)
					if cW then
						local bC = FindEnemiesInRadius(P, d1, a2, FIND_ANY_ORDER)
						local ay = GetRandomElement(bC)
						if IsValid(ay) then
							d2 = ay:GetAbsOrigin() + RandomVector(ay:GetHullRadius())
						end
					end
					cX(d1, CalcDirection2D(d2, d1), d0 - 1)
				end,
			})
		end
		P:EmitSound("Hero_Tinker.LaserImpact")
		cX(P:GetAbsOrigin() + Vector(0, 0, 75), a1, cg)
	end
end