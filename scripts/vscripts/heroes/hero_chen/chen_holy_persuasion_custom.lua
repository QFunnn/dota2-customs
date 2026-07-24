--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


chen_holy_persuasion_custom = class({})

chen_holy_persuasion_custom.unit_information = {
	["npc_dota_beastmaster_boar"] = {
		["duration"] = 60,
		["type"] = "basic",
		["count"] = 1,
		["units"] = {"npc_dota_beastmaster_boar", "npc_dota_beastmaster_boar", "npc_dota_beastmaster_boar", "npc_dota_beastmaster_boar"}
	},
	["npc_dota_lycan_wolf"] = {
		["duration"] = 50,
		["type"] = "basic",
		["count"] = 1,
		["units"] = {"npc_dota_lycan_wolf1", "npc_dota_lycan_wolf2", "npc_dota_lycan_wolf3", "npc_dota_lycan_wolf4"}
	},
	["npc_dota_unit_undying_zombie"] = {
		["duration"] = 30,
		["type"] = "basic",
		["count"] = 3,
		["units"] = {"npc_dota_unit_undying_zombie", "npc_dota_unit_undying_zombie", "npc_dota_unit_undying_zombie", "npc_dota_unit_undying_zombie"}
	},
	["npc_dota_wraith_king_skeleton_warrior"] = {
		["duration"] = 60,
		["type"] = "basic",
		["count"] = 2,
		["units"] = {"npc_dota_wraith_king_skeleton_warrior", "npc_dota_wraith_king_skeleton_warrior", "npc_dota_wraith_king_skeleton_warrior", "npc_dota_wraith_king_skeleton_warrior"}
	},
	["npc_dota_broodmother_spiderling"] = {
		["duration"] = 60,
		["type"] = "basic",
		["count"] = 2,
		["units"] = {"npc_dota_broodmother_spiderling", "npc_dota_broodmother_spiderling", "npc_dota_broodmother_spiderling", "npc_dota_broodmother_spiderling"}
	},
	["npc_dota_clinkz_skeleton_archer"] = {
		["duration"] = 30,
		["type"] = "basic",
		["count"] = 1,
		["units"] = {"npc_dota_clinkz_skeleton_archer_custom", "npc_dota_clinkz_skeleton_archer_custom", "npc_dota_clinkz_skeleton_archer_custom", "npc_dota_clinkz_skeleton_archer_custom"}
	},
	["npc_dota_venomancer_plague_ward"] = {
		["duration"] = 40,
		["type"] = "basic",
		["count"] = 2,
		["units"] = {"npc_dota_venomancer_plague_ward_1", "npc_dota_venomancer_plague_ward_2", "npc_dota_venomancer_plague_ward_3", "npc_dota_venomancer_plague_ward_4"}
	},
	["npc_dota_eidolon"] = {
		["duration"] = 40,
		["type"] = "basic",
		["count"] = 2,
		["units"] = {"npc_dota_eidolon", "npc_dota_eidolon", "npc_dota_eidolon", "npc_dota_eidolon"}
	},
	["npc_dota_invoker_forged_spirit"] = {
		["duration"] = 80,
		["type"] = "basic",
		["count"] = 1,
		["units"] = {"npc_dota_invoker_forged_spirit", "npc_dota_invoker_forged_spirit", "npc_dota_invoker_forged_spirit", "npc_dota_invoker_forged_spirit"}
	},
	["npc_dota_furion_treant"] = {
		["duration"] = 60,
		["type"] = "basic",
		["count"] = 2,
		["units"] = {"npc_dota_furion_treant", "npc_dota_furion_treant", "npc_dota_furion_treant", "npc_dota_furion_treant"}
	},
	["npc_dota_warlock_golem"] = {
		["duration"] = 60,
		["type"] = "ultimate",
		["count"] = 1,
		["units"] = {"npc_dota_warlock_golem", "npc_dota_warlock_golem", "npc_dota_warlock_golem", "npc_dota_warlock_golem"}
	},
	["npc_dota_visage_familiar"] = {
		["duration"] = 999999,
		["type"] = "ultimate",
		["count"] = 1,
		["units"] = {"npc_dota_visage_familiar1", "npc_dota_visage_familiar1", "npc_dota_visage_familiar2", "npc_dota_visage_familiar3"}
	},
	["npc_dota_shadow_shaman_ward"] = {
		["duration"] = 60,
		["type"] = "ultimate",
		["count"] = 2,
		["units"] = {"npc_dota_shadow_shaman_ward_1", "npc_dota_shadow_shaman_ward_1", "npc_dota_shadow_shaman_ward_2", "npc_dota_shadow_shaman_ward_3"}
	},
	["npc_dota_furion_treant_large"] = {
		["duration"] = 60,
		["type"] = "ultimate",
		["count"] = 1,
		["units"] = {"npc_dota_furion_treant_large", "npc_dota_furion_treant_large", "npc_dota_furion_treant_large", "npc_dota_furion_treant_large"}
	},
	["npc_dota_brewmaster_earth"] = {
		["duration"] = 20,
		["type"] = "ultimate",
		["count"] = 1,
		["units"] = {"npc_dota_brewmaster_earth_1", "npc_dota_brewmaster_earth_1", "npc_dota_brewmaster_earth_2", "npc_dota_brewmaster_earth_3"}
	},
	["npc_dota_brewmaster_storm"] = {
		["duration"] = 20,
		["type"] = "ultimate",
		["count"] = 1,
		["units"] = {"npc_dota_brewmaster_storm_1", "npc_dota_brewmaster_storm_1", "npc_dota_brewmaster_storm_2", "npc_dota_brewmaster_storm_3"}
	},
	["npc_dota_brewmaster_fire"] = {
		["duration"] = 20,
		["type"] = "ultimate",
		["count"] = 1,
		["units"] = {"npc_dota_brewmaster_fire_1", "npc_dota_brewmaster_fire_1", "npc_dota_brewmaster_fire_2", "npc_dota_brewmaster_fire_3"}
	},
	["npc_dota_brewmaster_void"] = {
		["duration"] = 20,
		["type"] = "ultimate",
		["count"] = 1,
		["units"] = {"npc_dota_brewmaster_void_1", "npc_dota_brewmaster_void_1", "npc_dota_brewmaster_void_2", "npc_dota_brewmaster_void_3"}
	},
}

chen_holy_persuasion_custom.created_units = {}

function chen_holy_persuasion_custom:OnSpellStart()
	local random_unit = nil
	local count = nil
	local duration = nil
	local health_min = self:GetSpecialValueFor("health_min")
	local movement_speed_bonus = self:GetSpecialValueFor("movement_speed_bonus")
	local damage_bonus = self:GetSpecialValueFor("damage_bonus")
	local ultimate_unit = self:GetSpecialValueFor("ultimate_unit")
	local basic_unit = self:GetSpecialValueFor("basic_unit")
	local group_count = self:GetSpecialValueFor("group_count")
	self:GetCaster():EmitSound("Hero_Chen.HolyPersuasionCast")

	for i = #self.created_units, 1, -1 do
        if self.created_units[i] ~= nil then
        	if not self.created_units[i]:IsNull() and self.created_units[i]:IsAlive() and self.created_units[i]:GetTeamNumber() == self:GetCaster():GetTeamNumber() then
        		self.created_units[i]:Kill(self, self:GetCaster())
        	end
        	if not self.created_units[i]:IsNull() and self.created_units[i]:GetTeamNumber() == self:GetCaster():GetTeamNumber() then
            	table.remove(self.created_units, i)
            end
        end
    end

	for group = 1, group_count do

		local table_unit = self:FindCreep()

		if table_unit then
			if table_unit["type"] == "basic" then
				random_unit = table_unit["units"][basic_unit]
			elseif table_unit["type"] == "ultimate" then
				random_unit = table_unit["units"][ultimate_unit]
			end
			count = table_unit["count"]
			duration = table_unit["duration"]
		end

		if random_unit ~= nil and count ~= nil and duration ~= nil then
			for i = 1, count do
				local unit = CreateUnitByName(random_unit, self:GetCaster():GetAbsOrigin()+self:GetCaster():GetForwardVector()*RandomInt(200, 500), true, self:GetCaster(), self:GetCaster(), self:GetCaster():GetTeamNumber())
				if unit then
					print("[CHEN DEBUG] Spawned: " .. random_unit .. " | Model: " .. unit:GetModelName())
					table.insert(self.created_units, unit)
					FindClearSpaceForUnit(unit, unit:GetAbsOrigin(), true)
					unit:AddNewModifier(self:GetCaster(), self, "modifier_phased", {duration = 0.2})
					local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_chen/chen_holy_persuasion.vpcf", PATTACH_ABSORIGIN_FOLLOW, unit)
					ParticleManager:SetParticleControl(particle, 0, unit:GetAbsOrigin())
					ParticleManager:SetParticleControl(particle, 1, unit:GetAbsOrigin())
					ParticleManager:ReleaseParticleIndex(particle)

					unit:SetControllableByPlayer(self:GetCaster():GetPlayerID(), true)
					unit:SetBaseMaxHealth(math.max(unit:GetBaseMaxHealth(), health_min))
					unit:SetHealth(unit:GetBaseMaxHealth())
					unit:SetHealth(unit:GetMaxHealth())
					unit:SetBaseMoveSpeed(unit:GetBaseMoveSpeed() + movement_speed_bonus)
					unit:SetBaseDamageMin(unit:GetBaseDamageMin() + damage_bonus)
					unit:SetBaseDamageMax(unit:GetBaseDamageMax() + damage_bonus)
					unit:AddNewModifier(self:GetCaster(), self, "modifier_kill", {duration = duration})

					for i=0, unit:GetAbilityCount()-1 do
						local ability = unit:GetAbilityByIndex(i)
						if ability then
							if i==0 then
								ability:SetHidden(false)
							end
							ability:SetLevel(math.min(self:GetLevel(),3))
						end
					end
				end
			end
		end
	end
end

function chen_holy_persuasion_custom:FindCreep()
	local table_unit = nil
	repeat
		if RollPercentage(2) then
			table_unit = self.unit_information["npc_dota_brewmaster_void"]
		elseif RollPercentage(4) then
			table_unit = self.unit_information["npc_dota_brewmaster_fire"]
		elseif RollPercentage(3) then
			table_unit = self.unit_information["npc_dota_brewmaster_storm"]
		elseif RollPercentage(2) then
			table_unit = self.unit_information["npc_dota_brewmaster_earth"]
		elseif RollPercentage(4) then
			table_unit = self.unit_information["npc_dota_furion_treant_large"]
		elseif RollPercentage(2) then
			table_unit = self.unit_information["npc_dota_shadow_shaman_ward"]
		elseif RollPercentage(4) then
			table_unit = self.unit_information["npc_dota_visage_familiar"]
		elseif RollPercentage(2) then
			table_unit = self.unit_information["npc_dota_warlock_golem"]
		elseif RollPercentage(7) then
			table_unit = self.unit_information["npc_dota_furion_treant"]
		elseif RollPercentage(7) then
			table_unit = self.unit_information["npc_dota_invoker_forged_spirit"]
		elseif RollPercentage(7) then
			table_unit = self.unit_information["npc_dota_eidolon"]
		elseif RollPercentage(7) then
			table_unit = self.unit_information["npc_dota_venomancer_plague_ward"]
		elseif RollPercentage(7) then
			table_unit = self.unit_information["npc_dota_clinkz_skeleton_archer"]
		elseif RollPercentage(7) then
			table_unit = self.unit_information["npc_dota_broodmother_spiderling"]
		elseif RollPercentage(7) then
			table_unit = self.unit_information["npc_dota_wraith_king_skeleton_warrior"]
		elseif RollPercentage(7) then
			table_unit = self.unit_information["npc_dota_unit_undying_zombie"]
		elseif RollPercentage(7) then
			table_unit = self.unit_information["npc_dota_lycan_wolf"]
		elseif RollPercentage(7) then
			table_unit = self.unit_information["npc_dota_beastmaster_boar"]
		end
	until table_unit ~= nil
	
	return table_unit
end