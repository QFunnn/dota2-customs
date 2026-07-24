--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


innateExceptions = {
	modifier_faceless_void_time_walk_tracker = true,
	modifier_weaver_timelapse = true,
	modifier_ember_spirit_fire_remnant_charge_counter = true,
	modifier_ember_spirit_fire_remnant_thinker = true,
	modifier_ember_spirit_fire_remnant_timer = true,
}

--Для этих способностей нужно немного увеличить время удаления — лучше дождаться завершения применения навыка, прежде чем удалять, иначе может вылететь игра
delayForDanger = {
	morphling_waveform = 5,
	huskar_life_break = 3,
	tusk_snowball = 5,
	ember_spirit_fire_remnant = 5,
	rattletrap_hookshot = 3,
	faceless_void_time_walk = 5,
	faceless_void_time_walk_reverse = 5,
	batrider_sticky_napalm = 12,
	pudge_meat_hook = 5,
	dragon_knight_fireball = 10
}

function CDOTABaseAbility:ClearInnateModifiers()
	if IsValid(self) then
		for _, modifier in ipairs(self:GetCaster():FindAllModifiers()) do
			if IsValid(modifier) and modifier:GetAbility() == self then
				if not innateExceptions[modifier:GetName()] then
					modifier:Destroy()
				end
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

---Таймер удаления навыка
---Отложенное удаление для предотвращения сбоев игры
function CDOTABaseAbility:SetRemovalTimer()

	local flDelay = 0.25

	if self and self:GetAbilityName() then
		if delayForDanger[self:GetAbilityName()] then
			flDelay = delayForDanger[self:GetAbilityName()]
		end
	end

	self.sRemovalTimer = Timers:CreateTimer(flDelay, function()
		if self and not self:IsNull() then
			local hCaster = self:GetCaster()
			if self:NumModifiersUsingAbility() ~= 0 or self:IsChanneling() then
				return 0.25
			end
			self:ClearInnateModifiers()
			self:RemoveSelf()
		end
	end)
end

local UINT32 = 4294967296

local function ToUInt32(x)
    x = tonumber(x) or 0
    x = x % UINT32
    if x < 0 then x = x + UINT32 end
    return x
end

---@param behavior number
---@return boolean
function CDOTABaseAbility:HasBehavior(behavior)
    if not self or self:IsNull() then return false end

    local flags64 = tonumber(tostring(self:GetBehavior())) or 0
    local flags32 = ToUInt32(flags64) -- младшие 32 бита

    return bit.band(flags32, behavior) == behavior
end

function CDOTABaseAbility:IsSealingAbility()
    local sAbilityName = self:GetAbilityName() or ""
    if HeroBuilder.SealingAbilities and
        HeroBuilder.SealingAbilities[sAbilityName] and
        HeroBuilder.SealingAbilities[sAbilityName].IsSealingAbility == 1 then
        return true
    else
        return false
    end
end