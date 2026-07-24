--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


function CDOTA_BaseNPC:HasTalent(talentName)
	if self and not self:IsNull() and self:HasAbility(talentName) then
		if self:FindAbilityByName(talentName):GetLevel() > 0 then return true end
	end

	return false
end


function CDOTA_BaseNPC:FindTalentValue(talentName, key)
	if self:HasAbility(talentName) then
		local value_name = key or "value"
		return self:FindAbilityByName(talentName):GetSpecialValueFor(value_name)
	end

	return 0
end


function CDOTA_BaseNPC:HasShard()
	return self:HasModifier("modifier_item_aghanims_shard")
end


function CDOTA_BaseNPC:GetClones()
	if self:GetUnitName() ~= "npc_dota_hero_meepo" then return {} end

	local clones = {}

	for _, hero in pairs(HeroList:GetAllHeroes()) do
		if hero:IsClone() and hero:GetCloneSource() == self then
			table.insert(clones, hero)
		end
	end

	return clones
end


-- Update max health and current health accordingly
function CDOTA_BaseNPC:SetBaseMaxHealthUpdate(new_health)
	local current_health_pct = self:GetHealthPercent() * 0.01

	self:SetBaseMaxHealth(new_health)

	Timers:CreateTimer(0.01, function()
		self:SetHealth(new_health * current_health_pct)
	end)
end


-- Get attack point accounting for a non 100 attack speed
function CDOTA_BaseNPC:GetRealAttackPoint()
	return self:GetAttackAnimationPoint() * 100 / self:GetDisplayAttackSpeed()
end


function CDOTA_BaseNPC:IsSpiritBear()
	return self:GetUnitLabel() == "spirit_bear"
end


function CDOTA_BaseNPC:IsMonkeyKingSoldier()
	return self:HasModifier("modifier_monkey_king_fur_army_soldier") or self:HasModifier("modifier_monkey_king_fur_army_soldier_hidden")
end


---@param caster CDOTA_BaseNPC
function CDOTA_BaseNPC:ApplyStatusResistance(value, caster)
	local debuff_amp = 1

	if IsValidEntity(caster) then
		local modifiers = caster:FindAllModifiers()

		for _, modifier in pairs(modifiers) do
			if modifier.GetModifierStatusResistanceCaster then
				local amp = modifier:GetModifierStatusResistanceCaster()

				if type(amp) == "number" then
					debuff_amp = debuff_amp * (1 - amp * 0.01)
				end
			end
		end
	end

	return value * (1 - self:GetStatusResistance()) * debuff_amp
end

--- Add a modifier to this unit, applies status resistance to duration.
---@param caster CDOTA_BaseNPC
---@param ability CDOTABaseAbility
---@param modifier_name string
---@param modifier_table table
function CDOTA_BaseNPC:AddNewModifierSR(caster, ability, modifier_name, modifier_table)
	if modifier_table and modifier_table.duration then
		modifier_table.original_duration = modifier_table.duration
		modifier_table.duration = self:ApplyStatusResistance(modifier_table.duration, caster)
	end

	return self:AddNewModifier(caster, ability, modifier_name, modifier_table)
end