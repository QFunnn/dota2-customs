--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


nyx_assassin_revenge_custom = class({})

nyx_assassin_revenge_custom.modifier_nyx_assassin_11 = {3,6,9}

function nyx_assassin_revenge_custom:Precache(context)
    if self:GetCaster() and self:GetCaster():IsIllusion() then return end
    PrecacheResource( "particle", "particles/units/heroes/hero_night_stalker/nightstalker_shard_hunter.vpcf", context )
end

function nyx_assassin_revenge_custom:CastFilterResultTarget( target )
	if target:HasModifier("modifier_wodacreepchampion") then
		return UF_FAIL_ANCIENT
	end
	if target:HasModifier("modifier_wodacreepchampionred") then
		return UF_FAIL_ANCIENT
	end
	local nResult = UnitFilter(
		target,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_CREEP,
		DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES + DOTA_UNIT_TARGET_FLAG_NOT_ANCIENTS + DOTA_UNIT_TARGET_FLAG_NOT_CREEP_HERO,
		self:GetCaster():GetTeamNumber()
	)
	if nResult ~= UF_SUCCESS then
		return nResult
	end
	return UF_SUCCESS
end

function nyx_assassin_revenge_custom:GetBehavior()
	if self:GetCaster():HasModifier("modifier_nyx_assassin_10") then
		return DOTA_ABILITY_BEHAVIOR_UNIT_TARGET + DOTA_ABILITY_BEHAVIOR_POINT
	end
	return DOTA_ABILITY_BEHAVIOR_UNIT_TARGET + DOTA_ABILITY_BEHAVIOR_HIDDEN
end

function nyx_assassin_revenge_custom:OnSpellStart()
	if not IsServer() then return end
	local target = self:GetCursorTarget()

    local models = 
    {
        "models/heroes/doom/doom.vmdl",
        "models/heroes/nightstalker/nightstalker.vmdl",
    }

    if target == nil then
        local random_model = models[RandomInt(1, #models)]
		target = CreateUnitByName("npc_dota_creep_badguys_melee", self:GetCursorPosition(), true, nil, nil, self:GetCaster():GetTeamNumber())
		target:SetOriginalModel(random_model)
		target:SetModel(random_model)
		target:SetMaximumGoldBounty(0)
		target:SetMinimumGoldBounty(0)
		target:SetDeathXP(0)
		target:StartGesture(ACT_DOTA_DIE)
    end

    local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_night_stalker/nightstalker_shard_hunter.vpcf", PATTACH_ABSORIGIN_FOLLOW, target)
    ParticleManager:SetParticleControl(particle, 0, target:GetAbsOrigin())
    ParticleManager:ReleaseParticleIndex(particle)

    target:EmitSound("Hero_Nightstalker.Hunter.Target")
    target:Kill(self, self:GetCaster())

    local damage_out = self:GetSpecialValueFor("illusion_damage") - 100
    local damage_inc = self:GetSpecialValueFor("incoming_damage") - 100
    local duration = self:GetSpecialValueFor("duration")
    local illusion_count = 1
    
    if self:GetCaster():HasModifier("modifier_nyx_assassin_11") then
        illusion_count = illusion_count + 1
        duration = duration + self.modifier_nyx_assassin_11[self:GetCaster():GetTalentLevel("modifier_nyx_assassin_11")]
    end

    for i=1, illusion_count do
        local illusions = CreateIllusions(self:GetCaster(), self:GetCaster(), {duration = duration, outgoing_damage=damage_out, incoming_damage = damage_inc}, 1, 150, false, true)
        if illusions and illusions[1] then
            FindClearSpaceForUnit(illusions[1], target:GetAbsOrigin(), true)
        end
    end
end