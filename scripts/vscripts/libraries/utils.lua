--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


--------------------------- DECORATOR FOR ApplyDamage  ----------------------------------------------------------

if not _G.OriginalApplyDamage then
	_G.OriginalApplyDamage = _G.ApplyDamage
end

_G.ApplyDamage = function(damageTable)
	local damage_flags = damageTable.damage_flags
	if
		damage_flags
		and bit.band(damage_flags, DOTA_DAMAGE_FLAG_DONT_DISPLAY_DAMAGE_IF_SOURCE_HIDDEN)
			== DOTA_DAMAGE_FLAG_DONT_DISPLAY_DAMAGE_IF_SOURCE_HIDDEN
	then
		return _G.OriginalApplyDamage(damageTable)
	end

	local attacker = damageTable.attacker
	if not attacker or attacker:IsNull() or not attacker:IsRealHero() then
		return _G.OriginalApplyDamage(damageTable)
	end

	local victim = damageTable.victim
	if victim == attacker then
		return _G.OriginalApplyDamage(damageTable)
	end

	local set_modifier = attacker:FindModifierByName("modifier_sets")
	if
		set_modifier
		and set_modifier.magic_crit
		and set_modifier.magic_crit > 0
		and RollPercentage(set_modifier.magic_crit)
	then
		-- damageTable.damage = damageTable.damage * ((set_modifier.magic_crit + 100) * set_modifier.full_set  / 100)
		damageTable.damage_type = DAMAGE_TYPE_PURE
	else
		return _G.OriginalApplyDamage(damageTable)
	end

	local finalDamage = _G.OriginalApplyDamage(damageTable)
	if finalDamage <= 0 then
		return finalDamage
	end

	if not victim or victim:IsNull() then
		return finalDamage
	end

	local particle_damage = math.floor(finalDamage)
	local particle = ParticleManager:CreateParticle("particles/msg_fx/msg_damage.vpcf", PATTACH_OVERHEAD_FOLLOW, victim)

	ParticleManager:SetParticleControl(particle, 1, Vector(0, particle_damage, 4))
	ParticleManager:SetParticleControl(particle, 2, Vector(2, string.len(tostring(particle_damage)) + 1, 0))
	ParticleManager:SetParticleControl(particle, 3, Vector(58, 154, 255))
	ParticleManager:ReleaseParticleIndex(particle)

	return finalDamage
end

--------------------------- DECORATOR FOR --- SetControllableByPlayer --- and --- GetPlayerID  ----------------------------------------------------------

local function SafeGetIDDecorator(originalFunc)
	return function(self)
		if not self or self:IsNull() then
			return -1
		end

		if not originalFunc then
			return -1
		end

		local is_hero = false
		pcall(function()
			is_hero = self:IsRealHero()
		end)

		if not is_hero then
			return -1
		end
		return originalFunc(self)
	end
end

if CDOTA_BaseNPC.GetPlayerID then
	CDOTA_BaseNPC.GetPlayerID = SafeGetIDDecorator(CDOTA_BaseNPC.GetPlayerID)
else
	CDOTA_BaseNPC.GetPlayerID = function(self)
		return -1
	end
end

local function RealPlayerOnly(originalFunc)
	return function(self, playerID, bForced)
		if not self or self:IsNull() or not originalFunc then
			return nil
		end
		if not playerID or playerID < 0 then
			return nil
		end
		local is_fake = PlayerResource:IsFakeClient(playerID)
		local hero = PlayerResource:GetSelectedHeroEntity(playerID)
		if not is_fake and hero and hero:IsRealHero() then
			return originalFunc(self, playerID, bForced)
		end
		return nil
	end
end

if CDOTA_BaseNPC.SetControllableByPlayer then
	CDOTA_BaseNPC.SetControllableByPlayer = RealPlayerOnly(CDOTA_BaseNPC.SetControllableByPlayer)
end

--------------------------------------------DECORATOR --- GetAgility---GetStrength---GetIntellect--------------------------------------------------------------

-- Список без аргументов
local simple_stats = { "GetAgility", "GetStrength" }

for _, methodName in pairs(simple_stats) do
	local originalMethod = CDOTA_BaseNPC_Hero[methodName]
	CDOTA_BaseNPC[methodName] = function(self)
		if self:IsHero() and originalMethod then
			return originalMethod(self)
		end
		local owner = self:GetOwner()
		if owner and owner.IsHero and owner:IsHero() and owner[methodName] then
			return owner[methodName](owner)
		end
		return 1
	end
end

-- Интеллект с поддержкой аргумента
local originalInt = CDOTA_BaseNPC_Hero.GetIntellect
CDOTA_BaseNPC.GetIntellect = function(self, bUseBonus)
	if self:IsHero() and originalInt then
		-- Пробрасываем аргумент только сюда
		return originalInt(self, bUseBonus)
	end
	local owner = self:GetOwner()
	if owner and owner.IsHero and owner:IsHero() then
		return owner:GetIntellect(bUseBonus)
	end
	return 1
end

--------------------------------------------------------------------------------------------------------------------------------------------------------

innateExceptions = {
	modifier_faceless_void_time_walk_tracker = true,
	modifier_weaver_timelapse = true,
	modifier_ember_spirit_fire_remnant_charge_counter = true,
	modifier_ember_spirit_fire_remnant_thinker = true,
	modifier_ember_spirit_fire_remnant_timer = true,
}

delayForDanger = {
	morphling_waveform = 5.0,
	huskar_life_break = 3.0,
	--tusk _snowball = 5.0, --- tusk_snow ball был удален
	ember_spirit_fire_remnant = 5.0,
	rattletrap_hookshot = 3.0,
	faceless_void_time_walk = 5.0,
	faceless_void_time_walk_reverse = 5.0,
	batrider_sticky_napalm = 10.0,
	pudge_meat_hook = 5.0,
	primal_beast_pulverize = 10.0,
}

function CDOTABaseAbility:ClearInnateModifiers()
	for _, hModifier in ipairs(self:GetCaster():FindAllModifiers()) do
		if hModifier and not hModifier:IsNull() and hModifier:GetAbility() == self then
			if not innateExceptions[hModifier:GetName()] then
				hModifier:Destroy()
			end
		end
	end
end

function CDOTABaseAbility:Disable()
	if self:IsChanneling() then
		self:SetChanneling(false)
	end
	if self:GetToggleState() then
		self:ToggleAbility()
	end
	if self:GetAutoCastState() then
		self:ToggleAutoCast()
	end
	self:ClearInnateModifiers() -- remove ability modifiers before set level to prevent crash Dark Pact
	self:SetLevel(0)
	self:ClearInnateModifiers() -- remove intrinsic ability modifiers that applies after set level
	self:SetHidden(true)
	self:OnChannelFinish(true)
end

function CDOTABaseAbility:SetRemovalTimer()
	local flDelay = 0.25
	if self and self:GetAbilityName() then
		if delayForDanger[self:GetAbilityName()] then
			flDelay = delayForDanger[self:GetAbilityName()]
		end
	end
	self.sRemovalTimer = Timers:CreateTimer(flDelay, function()
		if self and not self:IsNull() then
			if self:NumModifiersUsingAbility() ~= 0 or self:IsChanneling() then
				return 0.25
			end
			self:ClearInnateModifiers()
			self:RemoveSelf()
		end
	end)
end

function CDOTABaseAbility:HasBehavior(behavior)
	if not self or self:IsNull() then
		return
	end
	local abilityBehavior = tonumber(tostring(self:GetBehaviorInt()))
	return bit.band(abilityBehavior, behavior) == behavior
end

----------------------------------------------------------------

function CDOTA_BaseNPC:IsMonkeyClone()
	return (
		self:HasModifier("modifier_monkey_king_fur_army_soldier") or self:HasModifier(
			"modifier_wukongs_command_warrior"
		)
	)
end

function CDOTA_BaseNPC:IsMainHero()
	return self
		and (not self:IsNull())
		and self:IsRealHero()
		and (not self:IsTempestDouble())
		and (not self:IsMonkeyClone())
end

function CDOTA_BaseNPC:HasShard()
	if not self or self:IsNull() then
		return
	end
	return self:HasModifier("modifier_item_aghanims_shard")
end

function CDOTA_BaseNPC:HasTalent(talent_name)
	if not self or self:IsNull() then
		return
	end

	local talent = self:FindAbilityByName(talent_name)
	if talent and talent:GetLevel() > 0 then
		return true
	end
end

function CDOTA_BaseNPC:FindTalentValue(talent_name, key)
	if self:HasTalent(talent_name) then
		local value_name = key or "value"
		return self:FindAbilityByName(talent_name):GetSpecialValueFor(value_name)
	end
	return 0
end

function CDOTA_BaseNPC:ExtraIntelligenceDamage()
	if self:IsRealHero() and self:GetIntellect(true) then
		return self:GetIntellect(true)
	end
	return 0
end

function CDOTA_BaseNPC:GetTalentValue(talent_name)
	local talent = self:FindAbilityByName(talent_name)
	if talent and talent:GetLevel() >= 1 then
		return talent:GetSpecialValueFor("value")
	end

	return 0
end

function CDOTA_BaseNPC:RemoveAbilityForEmpty(ability_name)
	local ability = self:FindAbilityByName(ability_name)
	if not ability then
		return
	end
	local index = ability:GetAbilityIndex()
	ability:Disable()
	if index <= 5 then -- only swap if we get assigned hotkey, otherwise pointless
		self:SwapAbilities(ability_name, "empty_" .. index, false, false)
	end
	ability:SetRemovalTimer()
end

function CDOTA_BaseNPC:RemoveAbilityWithRestructure(ability_name)
	local ability = self:FindAbilityByName(ability_name)
	if not ability then
		return
	end
	ability:Disable()
	local index = ability:GetAbilityIndex()
	local placeholder_name = "empty_" .. index

	self:SwapAbilities(ability_name, placeholder_name, false, false)

	ability:SetRemovalTimer()

	if index > 5 then
		return
	end
	Timers:CreateTimer(function()
		for i = index, 25 do
			local next_ability = self:GetAbilityByIndex(i + 1)
			if next_ability and not next_ability.placeholder and not next_ability:IsHidden() then
				local next_ability_name = next_ability:GetAbilityName()
				if not next_ability_name:find("special_bonus") then
					self:SwapAbilities(placeholder_name, next_ability_name, false, true)
				end
			end
		end
	end)
end

function CDOTA_BaseNPC:RemoveSafely()
	self:AddNoDraw()
	self:AddNewModifier(self, nil, "modifier_hero_hidden", {})

	self:ForceKill(false)

	Timers:CreateTimer(0.5, function()
		for i = 0, 30 do
			local hAbility = self:GetAbilityByIndex(i)
			if hAbility and hAbility.GetAbilityName then
				local sAbilityName = hAbility:GetAbilityName()
				if (not string.find(sAbilityName, "special_bonus")) and (not string.find(sAbilityName, "empty_")) then
					hAbility:Disable()
					hAbility:SetRemovalTimer()
				end
			end
		end
	end)

	Timers:CreateTimer(1, function()
		if (not self) or (self:IsNull()) then
			return nil
		end
		local bSafe = true
		for i = 0, 30 do
			local hAbility = self:GetAbilityByIndex(i)
			if hAbility and hAbility.GetAbilityName then
				local sAbilityName = hAbility:GetAbilityName()
				if (not string.find(sAbilityName, "special_bonus")) and (not string.find(sAbilityName, "empty_")) then
					bSafe = false
				end
			end
		end

		if bSafe then
			print(self:GetUnitName() .. "Safe to Remove")
			UTIL_Remove(self)
			return nil
		else
			return 0.5
		end
	end)
end

function CDOTA_BaseNPC:FindHotKeyForAbility(sAbilityName)
	Timers:CreateTimer(function()
		for i = 0, 25 do
			local hPlaceholderAability = self:GetAbilityByIndex(i)
			if hPlaceholderAability and hPlaceholderAability:GetAbilityName() then
				local sPlaceholderAbilityName = hPlaceholderAability:GetAbilityName()
				if sPlaceholderAbilityName == sAbilityName then
					break
				end
				if hPlaceholderAability.nPlaceholder then
					self:SwapAbilities(sPlaceholderAbilityName, sAbilityName, false, true)
					break
				end
			end
		end
	end)
end

local defaultRangedProjectileNames = {}

CDOTA_BaseNPC_SetRangedProjectileName = CDOTA_BaseNPC_SetRangedProjectileName or CDOTA_BaseNPC.SetRangedProjectileName
function CDOTA_BaseNPC:SetRangedProjectileName(projectileName)
	if self:IsRealHero() and not defaultRangedProjectileNames[self] then
		defaultRangedProjectileNames[self] = self:GetRangedProjectileName()
	end

	CDOTA_BaseNPC_SetRangedProjectileName(self, projectileName)
end

function CDOTA_BaseNPC:ResetRangedProjectileName()
	if not defaultRangedProjectileNames[self] then
		return
	end

	CDOTA_BaseNPC_SetRangedProjectileName(self, defaultRangedProjectileNames[self])
end