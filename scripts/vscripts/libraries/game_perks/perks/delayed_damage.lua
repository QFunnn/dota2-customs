--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


require("libraries/game_perks/perks/base_game_perk")

MODIFIERS_BLACK_LIST_FOR_APPLY_DELAYED_DAMAGE = {
	["modifier_skeleton_king_reincarnation_scepter_active"] = true,
}

delayed_damage = class(base_game_perk)

function delayed_damage:IsAppliedUnitForDelayDamage()
	if not self.parent or self.parent:IsNull() then
		return false
	end
	if self.parent.IsClone and self.parent:IsClone() then
		return true
	end
	if self.parent:IsRealHero() then
		return true
	end
	return false
end

function delayed_damage:__OnCreated()
	if not IsServer() then
		return
	end

	if not self:IsAppliedUnitForDelayDamage() then
		return
	end

	self.delay_damage_by_perk = self.pct / 100
	self.delay_damage_by_perk_duration = self.time

	if not self.parent:HasAbility("delayed_damage_perk") then
		self.delay_ability = self.parent:AddAbility("delayed_damage_perk")
		self.delay_ability:SetLevel(1)
	end

	self.delayed_damage_instances = {}

	self.black_list_for_delay = {
		["delayed_damage_perk"] = true,
		["skeleton_king_reincarnation"] = true,
	}

	self:StartIntervalThink(self.interval)
end

function delayed_damage:OnIntervalThink()
	if not IsServer() then
		return
	end

	for _modifier_name, _ in pairs(MODIFIERS_BLACK_LIST_FOR_APPLY_DELAYED_DAMAGE) do
		if self.parent:HasModifier(_modifier_name) then
			return
		end
	end

	local marked_for_removal = {}
	local is_any_expired = false

	-- to display in tooltip
	self.total_damage_remaining = 0

	-- one would wish to batch this damage into single instance
	for index, data in pairs(self.delayed_damage_instances) do
		local damage = 0
		data.damage_accumulator = data.damage_accumulator + data.damage_per_tick

		if data.ticks > 1 then
			damage, data.damage_accumulator = math.modf(data.damage_accumulator)
		else
			damage = data.damage_accumulator
		end

		if damage >= 1 then
			ApplyDamage({
				victim = self.parent,
				attacker = data.attacker,
				damage = damage,
				damage_type = data.damage_type,
				damage_flags = DOTA_DAMAGE_FLAG_IGNORES_MAGIC_ARMOR
					+ DOTA_DAMAGE_FLAG_IGNORES_PHYSICAL_ARMOR
					+ DOTA_DAMAGE_FLAG_BYPASSES_PHYSICAL_BLOCK
					+ DOTA_DAMAGE_FLAG_HPLOSS
					+ DOTA_DAMAGE_FLAG_NO_DAMAGE_MULTIPLIERS
					+ DOTA_DAMAGE_FLAG_NON_LETHAL,
				ability = self.delay_ability,
			})
		end

		data.ticks = data.ticks - 1

		self.total_damage_remaining = self.total_damage_remaining + data.damage_per_tick * data.ticks

		-- avoid mutating table while iterating it - otherwise we'll skip some items when removal happens
		if data.ticks <= 0 then
			marked_for_removal[index] = true
			is_any_expired = true
		end
	end

	-- rebuild damage instances table if we have any expired ones
	if is_any_expired then
		self.delayed_damage_instances = table.array_filter(self.delayed_damage_instances, function(k, v, t)
			return not marked_for_removal[k]
		end)
	end

	if self:GetStackCount() ~= self.total_damage_remaining then
		self:SetStackCount(self.total_damage_remaining)
	end
end

function delayed_damage:DeclareFunctions()
	if IsClient() then
		return {
			MODIFIER_PROPERTY_TOOLTIP, -- OnTooltip
			MODIFIER_PROPERTY_TOOLTIP2, -- OnTooltip2
		}
	end

	return {
		MODIFIER_PROPERTY_TOTAL_CONSTANT_BLOCK,
		MODIFIER_EVENT_ON_DEATH,
	}
end

function delayed_damage:OnTooltip()
	return self.time
end

function delayed_damage:OnTooltip2()
	return self:GetStackCount()
end

function delayed_damage:OnDeath(event)
	if event.unit ~= self.parent then
		return
	end

	self.delayed_damage_instances = {}
	self:SetStackCount(0)
end

function delayed_damage:GetModifierTotal_ConstantBlock(keys)
	if keys.inflictor == self.delay_ability then
		return
	end

	if not self:IsAppliedUnitForDelayDamage() then
		return
	end

	local damage = keys.damage
	local ability_name = keys.inflictor and keys.inflictor:GetAbilityName() or ""

	if damage > 10 and not self.black_list_for_delay[ability_name] then
		local delayed_damage = damage * self.delay_damage_by_perk

		table.insert(self.delayed_damage_instances, {
			attacker = keys.attacker,
			damage_type = keys.damage_type,
			damage_per_tick = delayed_damage / self.delay_damage_by_perk_duration * self.interval,
			ticks = self.delay_damage_by_perk_duration / self.interval,
			damage_accumulator = 0,
		})

		return delayed_damage
	end
end

delayed_damage_perk = delayed_damage_perk or class({})