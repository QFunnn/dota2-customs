--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


innateExceptions = 
{
	modifier_faceless_void_time_walk_tracker = true,
	modifier_weaver_timelapse = true,
	modifier_ember_spirit_fire_remnant_charge_counter = true,
	modifier_ember_spirit_fire_remnant_thinker = true,
	modifier_ember_spirit_fire_remnant_timer = true,
}

delayForDanger = 
{
	morphling_waveform = 5.0,
	huskar_life_break = 3.0,
	tusk_snowball = 5.0,
	ember_spirit_fire_remnant = 5.0,
	rattletrap_hookshot = 3.0,
	faceless_void_time_walk = 5.0,
	faceless_void_time_walk_reverse = 5.0,
	batrider_sticky_napalm = 12.0,
}

function CDOTABaseAbility:ClearInnateModifiers()
	for _,hModifier in ipairs(self:GetCaster():FindAllModifiers()) do
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
        if self.OnChannelFinish then
            self:OnChannelFinish(true)
        end
	end
	if self:GetToggleState() then
		self:ToggleAbility()
	end
	if self:GetAutoCastState() then
		self:ToggleAutoCast()
	end
	self:ClearInnateModifiers()
	self:SetLevel(0)
	self:ClearInnateModifiers()
	self:SetHidden(true)
	self._bCustomDisabled = true
end

function CDOTABaseAbility:SetRemovalTimer()
    local flDelay = FrameTime()
    if self and self:GetAbilityName() then
       	if delayForDanger[self:GetAbilityName()] then
          	flDelay = delayForDanger[self:GetAbilityName()]   
       	end
    end
	self.sRemovalTimer=Timers:CreateTimer(flDelay, function()
		if self and not self:IsNull() then
			if self:NumModifiersUsingAbility() <= 0 and not self:IsChanneling() then
				self.sRemovalTimer = nil

				local caster = self:GetCaster()
				if caster and not caster:IsNull() then
					for i = self:GetAbilityIndex(), caster:GetAbilityCount()-1 do
						local Ability = caster:GetAbilityByIndex(i)
						local NextAbility = caster:GetNextAbilityFromIndex(i)
						if Ability and NextAbility then
							local NextAbilityName = NextAbility:GetName()
							caster:SwapAbilities(Ability:GetAbilityName(), NextAbilityName, Ability:IsShouldEnabledInSwap(), NextAbility:IsShouldEnabledInSwap())
						end
					end
				end

				RemoveAbilitySpawnGroupIfNoUsed(self)

				self:ClearInnateModifiers()
				self:RemoveSelf()
			else
				self:Disable()
				return 0.1
			end
		else
            if self and not self:IsNull() and self.sRemovalTimer then
			    self.sRemovalTimer = nil
            end
			return nil
		end
	end)
end

function CDOTABaseAbility:IsShouldEnabledInSwap()
	if self:IsHidden() then
        return false
    end

	if self:IsHiddenAbility() then
        return false
    end

	return true
end

function CDOTABaseAbility:IsHiddenAbility()
	-- Список абилок, которые внезапно появляются
	local Exceptions = {}

	if table.contains(Exceptions, self:GetAbilityName()) then return true end

	local kv = self:GetAbilityKeyValues() or {}

	if string.find(kv.AbilityBehavior, "DOTA_ABILITY_BEHAVIOR_INNATE_UI") ~= nil then
		return true
	end

    if kv.Innate == "1" then
		local hasManaCost = self:GetManaCost(-1) > 0
        local hasCooldown = self:GetCooldown(-1) > 0
        local isPassive = self:HasBehaviorUint(DOTA_ABILITY_BEHAVIOR_PASSIVE)
        if not hasManaCost and not hasCooldown and isPassive then
            return true
        end
	end

	return false
end

function CDOTABaseAbility:HasBehaviorUint(b)
	local a = tonumber(tostring(self:GetBehavior()))
	b = tonumber(tostring(b))
	local p,c,d=1,0,b
	while a>0 and b>0 do
		local ra,rb=a%2,b%2
		if ra+rb>1 then c=c+p end
		a,b,p=(a-ra)/2,(b-rb)/2,p*2
	end
	return c==d
end

-- Двигает абилку на ближайшую активную кнопку
function CDOTABaseAbility:UpdateAbilitySlot()
	local caster = self:GetCaster()
	if caster and not caster:IsNull() and not self:IsHidden() then
		local index = self:GetAbilityIndex()

		if self:IsPassive() then
			for i = 0, math.max(index - 1, 0) do
				local Ability = caster:GetAbilityByIndex(i)
				if Ability and not Ability:IsAttributeBonus() and Ability:IsHidden() and Ability ~= self then
					caster:SwapAbilities(Ability:GetAbilityName(), self:GetAbilityName(), Ability:IsShouldEnabledInSwap(), self:IsShouldEnabledInSwap())

					caster:ResolvePassivesPositions()
					break
				end
			end
		else
			for i = 0, math.max(index - 1, 0) do
				local Ability = caster:GetAbilityByIndex(i)
				if Ability and not Ability:IsAttributeBonus() and (Ability:IsHidden() or Ability:IsPassive() ) and Ability ~= self then
					caster:SwapAbilities(Ability:GetAbilityName(), self:GetAbilityName(), Ability:IsShouldEnabledInSwap(), self:IsShouldEnabledInSwap())

					caster:ResolvePassivesPositions()
					break
				end
			end
		end
	end
end

function CDOTABaseAbility:SetAbilityToSlot(Slot)
	local caster = self:GetCaster()
	if caster and not caster:IsNull() then
		local SlotAbility = caster:GetAbilityByIndex(Slot)
		if SlotAbility then
			local prevAbility = self
			for i = Slot, self:GetAbilityIndex() do
				local Ability = caster:GetAbilityByIndex(i)
				-- Таланты (IsAttributeBonus) живут на канонических слотах Ability10-17
				-- (индексы 9-16) — встроенный talent tree UI читает их по этим индексам.
				-- Каскадный своп через них смещает таланты на чужие уровни.
				if Ability and not Ability:IsAttributeBonus() then
					caster:SwapAbilities(Ability:GetAbilityName(), prevAbility:GetAbilityName(), Ability:IsShouldEnabledInSwap(), prevAbility:IsShouldEnabledInSwap())
					prevAbility = Ability
				end
			end
		end

		caster:ResolvePassivesPositions()
	end
end

function CDOTABaseAbility:PrintBehaviorFlags()
    local behavior = self:GetBehavior()
    print("Ability:", self:GetAbilityName())
    for bit = 0, 63 do
        local mask = 2^bit
        if self:HasBehaviorUint(mask) then
            print("Bit", bit, "=", mask)
        end
    end
end

function CDOTABaseAbility:HasBehavior(behavior)
	if not self or self:IsNull() then return end
	local abilityBehavior = tonumber(tostring(self:GetBehaviorInt()))
	return bit:_and(abilityBehavior, behavior) == behavior
end