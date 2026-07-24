--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_invul_necronomicon", "items/item_necronomicon_custom", LUA_MODIFIER_MOTION_NONE)

item_necronomicon_custom = class({})

function item_necronomicon_custom:OnSpellStart()
	if not IsServer() then return end

	for _, unit in pairs(FindUnitsInRadius(self:GetCaster():GetTeamNumber(), self:GetCaster():GetAbsOrigin(), nil, FIND_UNITS_EVERYWHERE, DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_PLAYER_CONTROLLED, FIND_ANY_ORDER, false)) do
        if unit:GetUnitName() == "npc_dota_necronomicon_archer_3" and unit:GetOwner() == self:GetCaster() then
            unit:ForceKill(false)               
        end
    end

	local summon_duration = self:GetSpecialValueFor("summon_duration")
	local caster_loc = self:GetCaster():GetAbsOrigin()
	local caster_direction = self:GetCaster():GetForwardVector()
	local ranged_summon_name = "npc_dota_necronomicon_archer_3"
	self:GetCaster():EmitSound("DOTA_Item.Necronomicon.Activate")
	local ranged_loc = RotatePosition(caster_loc, QAngle(0, -30, 0), caster_loc + caster_direction * 180)
	GridNav:DestroyTreesAroundPoint(caster_loc + caster_direction * 180, 180, false)
	local ranged_summon = CreateUnitByName(ranged_summon_name, ranged_loc, true, self:GetCaster(), self:GetCaster(), self:GetCaster():GetTeam())

	local particle_2 = ParticleManager:CreateParticle("particles/items_fx/necronomicon_spawn.vpcf", PATTACH_ABSORIGIN_FOLLOW, ranged_summon)
	ParticleManager:ReleaseParticleIndex(particle_2)
	
	ranged_summon:SetControllableByPlayer(self:GetCaster():GetPlayerID(), true)
	ranged_summon:AddNewModifier(self:GetCaster(), self, "modifier_kill", {duration = summon_duration})
	ranged_summon:AddNewModifier(self:GetCaster(), self, "modifier_invul_necronomicon", {})
    FindClearSpaceForUnit(ranged_summon, ranged_summon:GetAbsOrigin(), true)

	local ranged_abilities = {
		"necronomicon_archer_purge",
		"necronomicon_archer_mana_burn",
		"necronomicon_archer_aoe",
	}

	for _, ranged_ability in pairs(ranged_abilities) do
		if ranged_summon:FindAbilityByName(ranged_ability) then
			if ranged_summon:FindAbilityByName(ranged_ability):GetMaxLevel() > 1 then
				ranged_summon:FindAbilityByName(ranged_ability):SetLevel(3)
			else
				ranged_summon:FindAbilityByName(ranged_ability):SetLevel(1)
			end
		end
	end
end

item_necronomicon_melee_custom = class({})

function item_necronomicon_melee_custom:OnSpellStart()
	if not IsServer() then return end

	for _, unit in pairs(FindUnitsInRadius(self:GetCaster():GetTeamNumber(), self:GetCaster():GetAbsOrigin(), nil, FIND_UNITS_EVERYWHERE, DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_PLAYER_CONTROLLED, FIND_ANY_ORDER, false)) do
        if unit:GetUnitName() == "npc_dota_necronomicon_warrior_3" and unit:GetOwner() == self:GetCaster() then
            unit:ForceKill(false)               
        end
    end

	local summon_duration = self:GetSpecialValueFor("summon_duration")
	local caster_loc = self:GetCaster():GetAbsOrigin()
	local caster_direction = self:GetCaster():GetForwardVector()
	local melee_summon_name = "npc_dota_necronomicon_warrior_3"
	self:GetCaster():EmitSound("DOTA_Item.Necronomicon.Activate")

	local melee_loc = RotatePosition(caster_loc, QAngle(0, 30, 0), caster_loc + caster_direction * 180)
	local melee_summon = CreateUnitByName(melee_summon_name, melee_loc, true, self:GetCaster(), self:GetCaster(), self:GetCaster():GetTeam())
	
	local particle_2 = ParticleManager:CreateParticle("particles/items_fx/necronomicon_spawn_warrior.vpcf", PATTACH_ABSORIGIN_FOLLOW, melee_summon)
	ParticleManager:ReleaseParticleIndex(particle_2)

	melee_summon:SetControllableByPlayer(self:GetCaster():GetPlayerID(), true)
	melee_summon:AddNewModifier(self:GetCaster(), self, "modifier_kill", {duration = summon_duration})
	melee_summon:AddNewModifier(self:GetCaster(), self, "modifier_invul_necronomicon", {})
    FindClearSpaceForUnit(melee_summon, melee_summon:GetAbsOrigin(), true)

	local melee_abilities = {
		"necronomicon_warrior_mana_burn",
		"necronomicon_warrior_last_will",
	}

	for _, melee_ability in pairs(melee_abilities) do
		if melee_summon:FindAbilityByName(melee_ability) then
			if melee_summon:FindAbilityByName(melee_ability):GetMaxLevel() > 1 then
				melee_summon:FindAbilityByName(melee_ability):SetLevel(3)
			else
				melee_summon:FindAbilityByName(melee_ability):SetLevel(1)
			end
		end
	end
end

modifier_invul_necronomicon = class({})
function modifier_invul_necronomicon:IsPurgable() return false end
function modifier_invul_necronomicon:IsHidden() return true end
function modifier_invul_necronomicon:IsPurgeException() return false end

function modifier_invul_necronomicon:CheckState()
    return 
    {
        [MODIFIER_STATE_INVULNERABLE] = true,
        [MODIFIER_STATE_NO_HEALTH_BAR] = true,
    }
end

function modifier_invul_necronomicon:OnDestroy(params)
	if not IsServer() then return end
	if self:GetParent():GetUnitName() ~= "npc_dota_necronomicon_warrior_3" then return end
	local enemies = FindUnitsInRadius( self:GetCaster():GetTeamNumber(), self:GetParent():GetOrigin(), nil, 300, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 0, 0, false )
	for _, enemy in pairs(enemies) do
		ApplyDamage({attacker = self:GetCaster(), victim = enemy, ability = self:GetAbility(), damage = self:GetAbility():GetSpecialValueFor("explosion"), damage_type = DAMAGE_TYPE_MAGICAL})
		local particle = ParticleManager:CreateParticle("particles/items_fx/necronomicon_warrior_last_will.vpcf", PATTACH_CUSTOMORIGIN, self:GetParent())
		ParticleManager:SetParticleControlEnt(particle, 0, self:GetParent(), PATTACH_POINT_FOLLOW, "attach_hitloc", self:GetParent():GetAbsOrigin(), true)
		ParticleManager:SetParticleControlEnt(particle, 1, enemy, PATTACH_POINT_FOLLOW, "attach_hitloc", enemy:GetAbsOrigin(), true)
		ParticleManager:ReleaseParticleIndex(particle)
	end
end