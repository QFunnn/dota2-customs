--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_furion_force_of_nature_custom",  "heroes/npc_dota_hero_furion_custom/furion_force_of_nature_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier("modifier_furion_force_of_nature_custom_immortal",  "heroes/npc_dota_hero_furion_custom/furion_force_of_nature_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier("modifier_furion_force_of_nature_custom_barrier",  "heroes/npc_dota_hero_furion_custom/furion_force_of_nature_custom", LUA_MODIFIER_MOTION_NONE )

furion_force_of_nature_custom = class({})
furion_force_of_nature_custom.modifier_furion_1 = {10,20}
furion_force_of_nature_custom.modifier_furion_2 = {11,22,33}
furion_force_of_nature_custom.modifier_furion_3 = {1,1.5,2}
furion_force_of_nature_custom.modifier_furion_3_radius = 300
furion_force_of_nature_custom.modifier_furion_4_damage = {30,50}
furion_force_of_nature_custom.modifier_furion_4_radius = 300
furion_force_of_nature_custom.modifier_furion_5 = {70,140}
furion_force_of_nature_custom.modifier_furion_6 = 600
furion_force_of_nature_custom.modifier_furion_7 = 7

function furion_force_of_nature_custom:Precache(context)
    if self:GetCaster() and self:GetCaster():IsIllusion() then return end
    PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_techies.vsndevts", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_furion/furion_force_of_nature_cast.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_warlock/warlock_imp_explode.vpcf", context )
end

function furion_force_of_nature_custom:GetAOERadius()
	return self:GetSpecialValueFor( "area_of_effect" )
end

function furion_force_of_nature_custom:GetIntrinsicModifierName()
	return "modifier_furion_force_of_nature_custom_immortal"
end

function furion_force_of_nature_custom:GetCooldown(level)
	if self:GetCaster():HasModifier("modifier_furion_7") then
		return self.modifier_furion_7
	end
    return self.BaseClass.GetCooldown( self, level )
end

function furion_force_of_nature_custom:OnSpellStart()
	if not IsServer() then return end
	local area_of_effect = self:GetSpecialValueFor( "area_of_effect" )
	local max_treants = self:GetSpecialValueFor( "max_treants" )
	local duration = self:GetSpecialValueFor( "duration" )
	local point = self:GetCursorPosition()
	local trees = GridNav:GetAllTreesAroundPoint( point, area_of_effect, true )
	local nTreeCount = #trees

	if self:GetCaster():HasModifier("modifier_furion_7") then
		duration =  self.modifier_furion_7
	end

	local nFXIndex = ParticleManager:CreateParticle( "particles/units/heroes/hero_furion/furion_force_of_nature_cast.vpcf", PATTACH_CUSTOMORIGIN, self:GetCaster() )
	ParticleManager:SetParticleControlEnt( nFXIndex, 0, self:GetCaster(), PATTACH_POINT_FOLLOW, "attach_staff_base", self:GetCaster():GetOrigin(), true )
	ParticleManager:SetParticleControl( nFXIndex, 1, point )
	ParticleManager:SetParticleControl( nFXIndex, 2, Vector( area_of_effect, 0, 0 ) )
	ParticleManager:ReleaseParticleIndex( nFXIndex )

	GridNav:DestroyTreesAroundPoint( point, area_of_effect, true )

	if nTreeCount == 0 then
		return
	end
    local furion_spirit_of_the_forest_custom = self:GetCaster():FindAbilityByName("furion_spirit_of_the_forest_custom")
	local nTreantsToSpawn = math.min( max_treants, nTreeCount )
	while nTreantsToSpawn > 0 do
		local hTreant = CreateUnitByName( "npc_dota_furion_treant_"..self:GetLevel(), point, true, self:GetCaster(), self:GetCaster():GetOwner(), self:GetCaster():GetTeamNumber() )
		if hTreant ~= nil then
			hTreant:SetControllableByPlayer( self:GetCaster():GetPlayerID(), false )
			hTreant:SetOwner( self:GetCaster() )
			hTreant:AddNewModifier( self:GetCaster(), self, "modifier_kill", {duration = duration} )
			hTreant:AddNewModifier( self:GetCaster(), self, "modifier_furion_force_of_nature_custom", {duration = duration} )
            if self:GetCaster():HasModifier("modifier_furion_1") then
                hTreant:AddNewModifier( self:GetCaster(), self, "modifier_furion_force_of_nature_custom_barrier", {} )
            end
            hTreant:AddNewModifier(self:GetCaster(), furion_spirit_of_the_forest_custom, "modifier_furion_spirit_of_the_forest_custom", {})
		end
		nTreantsToSpawn = nTreantsToSpawn - 1
	end

	EmitSoundOnLocationWithCaster( point, "Hero_Furion.ForceOfNature", self:GetCaster() )
end

modifier_furion_force_of_nature_custom = class({})

function modifier_furion_force_of_nature_custom:IsHidden() return true end
function modifier_furion_force_of_nature_custom:IsPurgable() return false end

function modifier_furion_force_of_nature_custom:OnCreated()
	if not IsServer() then return end

	if self:GetCaster():HasModifier("modifier_furion_2") then
		local new_health = self:GetParent():GetBaseMaxHealth() + (self:GetCaster():GetMaxHealth() / 100 * self:GetAbility().modifier_furion_2[self:GetCaster():GetTalentLevel("modifier_furion_2")] )
		self:GetParent():SetBaseMaxHealth(new_health)
		self:GetParent():SetMaxHealth(new_health)
		self:GetParent():SetHealth(new_health)
	end

	self:StartIntervalThink(1)
end

function modifier_furion_force_of_nature_custom:DeclareFunctions()
	return 
	{
		MODIFIER_PROPERTY_MOVESPEED_BONUS_CONSTANT,
        MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
	}
end

function modifier_furion_force_of_nature_custom:GetModifierPreAttack_BonusDamage(params)
    if params.target and params.target:IsHero() then
        return self:GetAbility():GetSpecialValueFor("treant_bonus_hero_damage")
    end
end

function modifier_furion_force_of_nature_custom:GetModifierMoveSpeedBonus_Constant()
	if not self:GetCaster():HasModifier("modifier_furion_5") then return end
	return self:GetAbility().modifier_furion_5[self:GetCaster():GetTalentLevel("modifier_furion_5")]
end

function modifier_furion_force_of_nature_custom:OnIntervalThink()
	if not IsServer() then return end
	if not self:GetCaster():HasModifier("modifier_furion_3") then return end
	local units = FindUnitsInRadius(self:GetCaster():GetTeamNumber(), self:GetParent():GetAbsOrigin(), nil, self:GetAbility().modifier_furion_3_radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_NONE, FIND_ANY_ORDER, false)
	for _, enemy in pairs(units) do
		local damage = self:GetParent():GetBaseMaxHealth() / 100 * self:GetAbility().modifier_furion_3[self:GetCaster():GetTalentLevel("modifier_furion_3")]
		ApplyDamage({ victim = enemy, attacker = self:GetCaster(), damage = damage, damage_type = DAMAGE_TYPE_MAGICAL, damage_flags = DOTA_DAMAGE_FLAG_NONE, ability = self:GetAbility() })
	end
end

function modifier_furion_force_of_nature_custom:OnDestroy( params )
    if not IsServer() then return end
	if self:GetCaster():HasModifier("modifier_furion_4") then
		local units = FindUnitsInRadius(self:GetCaster():GetTeamNumber(), self:GetParent():GetAbsOrigin(), nil, self:GetCaster():GetAoeBonus(self:GetAbility().modifier_furion_4_radius), DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_NONE, FIND_ANY_ORDER, false)
		for _, enemy in pairs(units) do
			local damage = self:GetParent():GetBaseMaxHealth() / 100 * self:GetAbility().modifier_furion_4_damage[self:GetCaster():GetTalentLevel("modifier_furion_4")]
			ApplyDamage({ victim = enemy, attacker = self:GetCaster(), damage = damage, damage_type = DAMAGE_TYPE_MAGICAL, damage_flags = DOTA_DAMAGE_FLAG_NONE, ability = self:GetAbility() })
		end
		self:GetParent():EmitSound("Hero_Techies.Suicide")
		local particle_explosion_fx = ParticleManager:CreateParticle("particles/units/heroes/hero_warlock/warlock_imp_explode.vpcf", PATTACH_WORLDORIGIN, self:GetParent())
    	ParticleManager:SetParticleControl(particle_explosion_fx, 0, self:GetParent():GetAbsOrigin())
        ParticleManager:SetParticleControl(particle_explosion_fx, 3, Vector(self:GetCaster():GetAoeBonus(self:GetAbility().modifier_furion_4_radius), self:GetCaster():GetAoeBonus(self:GetAbility().modifier_furion_4_radius),self:GetCaster():GetAoeBonus(self:GetAbility().modifier_furion_4_radius)))
    	ParticleManager:DestroyParticle(particle_explosion_fx, false)
	end
end

modifier_furion_force_of_nature_custom_immortal = class({})

function modifier_furion_force_of_nature_custom_immortal:IsHidden() return self:GetStackCount() == 0 end

function modifier_furion_force_of_nature_custom_immortal:OnCreated()
	if not IsServer() then return end
	self:StartIntervalThink(FrameTime())
end

function modifier_furion_force_of_nature_custom_immortal:OnIntervalThink()
	if not IsServer() then return end
	if not self:GetCaster():HasModifier("modifier_furion_6") then return end
	local count = 0
	for _, unit in pairs(FindUnitsInRadius(self:GetCaster():GetTeamNumber(), self:GetCaster():GetAbsOrigin(), nil, self:GetAbility().modifier_furion_6, DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_PLAYER_CONTROLLED, FIND_ANY_ORDER, false)) do
        if unit and unit:GetOwner() == self:GetCaster() and (unit:GetUnitName() == "npc_dota_furion_treant_1" or unit:GetUnitName() == "npc_dota_furion_treant_2" or unit:GetUnitName() == "npc_dota_furion_treant_3" or unit:GetUnitName() == "npc_dota_furion_treant_4") then  
            count = count + 1         
        end
    end
    self:SetStackCount(count)
end

function modifier_furion_force_of_nature_custom_immortal:DeclareFunctions()
	return 
	{
		MODIFIER_PROPERTY_MIN_HEALTH
	}
end

function modifier_furion_force_of_nature_custom_immortal:GetMinHealth()
	if self:GetStackCount() <= 0 then return end
	return 1
end

modifier_furion_force_of_nature_custom_barrier = class({})

function modifier_furion_force_of_nature_custom_barrier:OnCreated( kv )
	self.caster = self:GetCaster()
	self.parent = self:GetParent()
	if not IsServer() then return end
    self.barrier = self:GetAbility().modifier_furion_1[self:GetCaster():GetTalentLevel("modifier_furion_1")] / 100 * self:GetParent():GetMaxHealth()
	self.max_shield = self.barrier
	self.current_shield = self.barrier
	self:SetHasCustomTransmitterData( true )
end

function modifier_furion_force_of_nature_custom_barrier:AddCustomTransmitterData()
	local data =
    {
		max_shield = self.max_shield,
		current_shield = self.current_shield
	}
	return data
end

function modifier_furion_force_of_nature_custom_barrier:HandleCustomTransmitterData( data )
	self.max_shield = data.max_shield
	self.current_shield = data.current_shield
end

function modifier_furion_force_of_nature_custom_barrier:DeclareFunctions()
	return
    {
		MODIFIER_PROPERTY_INCOMING_DAMAGE_CONSTANT,
	}
end

function modifier_furion_force_of_nature_custom_barrier:GetModifierIncomingDamageConstant( params )
	if not IsServer() then
		if params.report_max then
			return self.max_shield
		else
			return self.current_shield
		end
	end
	if params.damage >= self.current_shield then
		self:Destroy()
		return -self.current_shield
	else
		self.current_shield = self.current_shield-params.damage
		self:SendBuffRefreshToClients()
		return -params.damage
	end
end