--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_bat_handler = class({})

function modifier_bat_handler:IsHidden()
	return true
end

function modifier_bat_handler:IsPermanent()
	return true
end

function modifier_bat_handler:IsPurgable()
	return false
end

function modifier_bat_handler:OnCreated()
	if IsServer() then
		self.herobat = self:GetParent():GetBaseAttackTime(false)
	end
	self.original_herobat = self:GetParent():GetBaseAttackTime(false)
	self:SetStackCount(self:GetParent():GetBaseAttackTime(false) * 100)
end

function modifier_bat_handler:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_BASE_ATTACK_TIME_CONSTANT, -- GetModifierBaseAttackTimeConstant
		MODIFIER_EVENT_ON_MODIFIER_ADDED, -- OnModifierAdded
	}
end

function modifier_bat_handler:GetModifierBaseAttackTimeConstant()
	-- This modifier must be created first before later modifiers that use this function
	-- Logic shows that the base attack time change will occur only at the first modifier that has this function
	return self:GetStackCount() * 0.01
end

function modifier_bat_handler:GetOriginalBaseAttackTime()
	return self.original_herobat
end

function modifier_bat_handler:OnModifierAdded(kv)
	if IsClient() then return end
	if not self or self:IsNull() then return end
	if kv.unit ~= self:GetParent() then return end
	--for k,v in pairs(kv) do print (k,v) end
	local modtable = self:GetParent():FindAllModifiers()

	-- Solution:
	-- Set a base-line for the final BAT buff (unit's BAT)
	-- Iterate through the modifier table and find those that mod base attack time
	-- Find the lowest one
	local final_bat = self.herobat
	local direct_bonus = 0
	for _,mod in pairs(modtable) do
		if tostring(mod:GetName()) ~= "modifier_bat_handler" then
			local modBAT = self:CalculateBAT(mod)
			local duration = mod:GetRemainingTime() -- Except this assumes the modifier cant be removed ever
			if modBAT < final_bat then
				final_bat = modBAT
				if duration and duration > 0 then
					-- Workaround for early expiry bug, not the prettiest
					Timers:CreateTimer(0, function()
						print(mod, mod:IsNull())
						if mod:IsNull() then
							self:OnModifierAdded(kv)
						else
							return 0
						end
					end)
				end
			end

			if mod.GetBaseAttackTimeDirectBonus then
				direct_bonus = direct_bonus + mod:GetBaseAttackTimeDirectBonus()
			end
		end
	end --print(final_bat * 100)

	final_bat = final_bat + direct_bonus

	-- All heroes have different BAT and some can change their own,
	-- I've capped it at 0.1 BAT right now
	self:SetStackCount(math.max(final_bat * 100, 0.1))
end

modifier_bat_handler.vanillaBATmodifiers = {
	"modifier_alchemist_chemical_rage",
	"modifier_snapfire_lil_shredder_buff",
	"modifier_troll_warlord_berserkers_rage",
	"modifier_lone_druid_true_form",
	"modifier_broodmother_insatiable_hunger",
}

function modifier_bat_handler:CalculateBAT(selectedModifier)
	-- If this is a lua modifier that is reducing base attack time
	if selectedModifier.GetModifierBaseAttackTimeConstant ~= nil and selectedModifier:GetModifierBaseAttackTimeConstant() ~= nil then --print(mod:GetName(), "has function") --print(mod:GetModifierBaseAttackTimeConstant() < final_bat)
		return selectedModifier:GetModifierBaseAttackTimeConstant()
	end

	-- If this is a non-lua modifier (reduces BAT without going through lua :/)
	for _,modName in pairs(self.vanillaBATmodifiers) do
		local modifier_ability = selectedModifier:GetAbility()
		if selectedModifier:GetName() == modName and modifier_ability and (not modifier_ability:IsNull()) then
			return modifier_ability:GetSpecialValueFor("base_attack_time")
		end
	end

	return self.herobat
end