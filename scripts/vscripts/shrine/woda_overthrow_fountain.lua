--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_woda_overthrow_fountain", "shrine/woda_overthrow_fountain", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_woda_overthrow_fountain_regen", "shrine/woda_overthrow_fountain", LUA_MODIFIER_MOTION_NONE)

woda_overthrow_fountain = class({})

function woda_overthrow_fountain:Spawn()
	if not IsServer() then return end
	if not self:IsTrained() then
		self:SetLevel(1)
	end
end

function woda_overthrow_fountain:GetIntrinsicModifierName()
	return "modifier_woda_overthrow_fountain"
end

modifier_woda_overthrow_fountain = class({})

function modifier_woda_overthrow_fountain:IsHidden()
	return true 
end

function modifier_woda_overthrow_fountain:IsPurgable()
	return false 
end

function modifier_woda_overthrow_fountain:DestroyOnExpire()
	return false
end

function modifier_woda_overthrow_fountain:OnCreated()
	if not IsServer() then return end
	self:GetParent():RemoveModifierByName("modifier_fountain_aura")
	local Origin = self:GetParent():GetAbsOrigin()
	self:StartIntervalThink(0.5)
end

function modifier_woda_overthrow_fountain:OnIntervalThink()
	if not IsServer() then return end
	self:GetParent():RemoveModifierByName("modifier_fountain_aura")
	if player_system.starting_overthrow == nil then return end
	local color = 
	{
		[DOTA_TEAM_GOODGUYS] = { 61, 210, 150 },
		[DOTA_TEAM_BADGUYS] = { 243, 201, 9 } ,
		[DOTA_TEAM_CUSTOM_1] = { 197, 77, 168 },
		[DOTA_TEAM_CUSTOM_2] = { 255, 108, 0 } ,
		[DOTA_TEAM_CUSTOM_3] = { 52, 85, 255 } ,
		[DOTA_TEAM_CUSTOM_4] = { 101, 212, 19 },
		[DOTA_TEAM_CUSTOM_5] = { 129, 83, 54 } ,
		[DOTA_TEAM_CUSTOM_6] = { 27, 192, 216 },
		[DOTA_TEAM_CUSTOM_7] = { 199, 228, 13 },
		[DOTA_TEAM_CUSTOM_8] = { 140, 42, 244 },
	}
	if self:GetParent().particle == nil then
		self:GetParent().particle = ParticleManager:CreateParticle("particles/shrine_teams.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
		ParticleManager:SetParticleControl(self:GetParent().particle, 15, Vector(color[self:GetParent():GetTeamNumber()][1],color[self:GetParent():GetTeamNumber()][2],color[self:GetParent():GetTeamNumber()][3]))
		ParticleManager:SetParticleControl(self:GetParent().particle, 16, Vector(1,1,1))
	end
end

function modifier_woda_overthrow_fountain:IsAura() return true end
function modifier_woda_overthrow_fountain:IsAuraActiveOnDeath() return false end

function modifier_woda_overthrow_fountain:GetAuraRadius()
    return self:GetAbility():GetSpecialValueFor("radius")
end

function modifier_woda_overthrow_fountain:GetAuraSearchFlags()
    return DOTA_UNIT_TARGET_FLAG_INVULNERABLE + DOTA_UNIT_TARGET_FLAG_OUT_OF_WORLD
end

function modifier_woda_overthrow_fountain:GetAuraSearchTeam()
    return DOTA_UNIT_TARGET_TEAM_FRIENDLY
end

function modifier_woda_overthrow_fountain:GetAuraSearchType()
    return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
end

function modifier_woda_overthrow_fountain:GetModifierAura()
    return "modifier_woda_overthrow_fountain_regen"
end

function modifier_woda_overthrow_fountain:GetAuraDuration()
    return 0.5
end

function modifier_woda_overthrow_fountain:CheckState()
	return
	{
		[MODIFIER_STATE_CANNOT_MISS] = true,
	}
end

modifier_woda_overthrow_fountain_regen = class({})

function modifier_woda_overthrow_fountain_regen:IsPurchasable()
	return false
end

function modifier_woda_overthrow_fountain_regen:GetTexture()
	return "fountain_regen"
end

function modifier_woda_overthrow_fountain_regen:DeclareFunctions()
    local funcs = 
    {
        MODIFIER_PROPERTY_HEALTH_REGEN_PERCENTAGE,
        MODIFIER_PROPERTY_MANA_REGEN_TOTAL_PERCENTAGE,
        MODIFIER_PROPERTY_INVISIBILITY_LEVEL
    }
    return funcs
end

function modifier_woda_overthrow_fountain_regen:GetModifierInvisibilityLevel( params )
    return 1
end

function modifier_woda_overthrow_fountain_regen:GetModifierTotalPercentageManaRegen( params )
    return self:GetAbility():GetSpecialValueFor("mana")
end

function modifier_woda_overthrow_fountain_regen:GetModifierHealthRegenPercentage( params )
    return self:GetAbility():GetSpecialValueFor("health")
end

function modifier_woda_overthrow_fountain_regen:GetEffectName()
	return "particles/generic_gameplay/radiant_fountain_regen.vpcf"
end

function modifier_woda_overthrow_fountain_regen:CheckState()
	return
	{
		[MODIFIER_STATE_INVISIBLE] = true,
		[MODIFIER_STATE_TRUESIGHT_IMMUNE] = true,
	}
end