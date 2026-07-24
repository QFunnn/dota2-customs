--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_oracle_purifying_flames_custom", "heroes/npc_dota_hero_oracle_custom/oracle_purifying_flames_custom", LUA_MODIFIER_MOTION_NONE)

oracle_purifying_flames_custom = class({})

function oracle_purifying_flames_custom:Precache(context)
    if self:GetCaster() and self:GetCaster():IsIllusion() then return end
    PrecacheResource( "particle", "particles/units/heroes/hero_oracle/oracle_purifyingflames_hit.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_oracle/oracle_purifyingflames_cast.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_oracle/oracle_purifyingflames.vpcf", context )
    PrecacheResource("particle", "particles/new_year/anniversary_10th_hat_ambient_npc_dota_hero_oracle.vpcf", context)
    PrecacheResource("particle", "particles/new_year_2/anniversary_10th_hat_ambient_npc_dota_hero_oracle.vpcf", context)
    PrecacheResource("particle", "particles/econ/events/anniversary_10th/anniversary_10th_hat_ambient_npc_dota_hero_oracle.vpcf", context)
end

oracle_purifying_flames_custom.modifier_oracle_6 = 10
oracle_purifying_flames_custom.modifier_oracle_15_radius = 300
oracle_purifying_flames_custom.modifier_oracle_15 = {1,2}
oracle_purifying_flames_custom.modifier_oracle_20 = {40,80}

function oracle_purifying_flames_custom:OnSpellStart()
	if not IsServer() then return end
	local target = self:GetCursorTarget()
	self:CastFlames(target)

	if self:GetCaster():HasModifier("modifier_oracle_15") then
		local count_current = 0
		local count = self.modifier_oracle_15[self:GetCaster():GetTalentLevel("modifier_oracle_15")]
		local nearby_enemies = FindUnitsInRadius(self:GetCaster():GetTeamNumber(), target:GetAbsOrigin(), nil, self.modifier_oracle_15_radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_BASIC, 0, FIND_ANY_ORDER, false)
		for _, enemy in pairs(nearby_enemies) do
			if enemy ~= target then
				if count_current < count then
					self:CastFlames(enemy)
					count_current = count_current + 1
				else
					break
				end
			end
		end
	end
end

function oracle_purifying_flames_custom:CastFlames(target)
	if not IsServer() then return end
	local damage_flag = DOTA_DAMAGE_FLAG_NON_LETHAL

	if target:GetTeamNumber() ~= self:GetCaster():GetTeamNumber() then
		if target:TriggerSpellAbsorb(self) then return end
		damage_flag = DOTA_DAMAGE_FLAG_NONE
	end

	target:EmitSound("Hero_Oracle.PurifyingFlames.Damage")
	target:EmitSound("Hero_Oracle.PurifyingFlames")

	self.purifying_particle = ParticleManager:CreateParticle("particles/units/heroes/hero_oracle/oracle_purifyingflames_hit.vpcf", PATTACH_ABSORIGIN_FOLLOW, target)
	ParticleManager:SetParticleControlEnt(self.purifying_particle, 1, target, PATTACH_POINT_FOLLOW, "attach_hitloc", target:GetAbsOrigin(), true)
	ParticleManager:ReleaseParticleIndex(self.purifying_particle)
	
	self.purifying_cast_particle = ParticleManager:CreateParticle("particles/units/heroes/hero_oracle/oracle_purifyingflames_cast.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetCaster())
	ParticleManager:SetParticleControlEnt(self.purifying_cast_particle, 1, self:GetCaster(), PATTACH_POINT_FOLLOW, "attach_attack1", self:GetCaster():GetAbsOrigin(), true)
	ParticleManager:ReleaseParticleIndex(self.purifying_cast_particle)
	
	local damage = self:GetSpecialValueFor("damage")
	if self:GetCaster():HasModifier("modifier_oracle_20") then
		damage = damage + (self:GetCaster():GetManaRegen() / 100 * self.modifier_oracle_20[self:GetCaster():GetTalentLevel("modifier_oracle_20")])
	end

	ApplyDamage({ victim = target, damage = damage, damage_type = self:GetAbilityDamageType(), damage_flags = damage_flag, attacker = self:GetCaster(), ability = self})
	if self:GetCaster():HasModifier("modifier_oracle_20") then
		if target:GetTeamNumber() ~= self:GetCaster():GetTeamNumber() then return end
	end
    if target:GetUnitName() == "npc_woda_pig" or target:GetUnitName() == "npc_woda_frog" or target:GetUnitName() == "npc_woda_pig_pve" or target:GetUnitName() == "npc_woda_frog_pve" or target:GetUnitName() == "npc_dota_weaver_swarm" then
        return
    end
	target:AddNewModifier(self:GetCaster(), self, "modifier_oracle_purifying_flames_custom", {duration = self:GetSpecialValueFor("duration")})
end

modifier_oracle_purifying_flames_custom = class({})
function modifier_oracle_purifying_flames_custom:IsDebuff() return false end
function modifier_oracle_purifying_flames_custom:GetAttributes() return MODIFIER_ATTRIBUTE_MULTIPLE end

function modifier_oracle_purifying_flames_custom:GetEffectName()
	return "particles/units/heroes/hero_oracle/oracle_purifyingflames.vpcf"
end

function modifier_oracle_purifying_flames_custom:OnCreated()
	self.heal_per_second = self:GetAbility():GetSpecialValueFor("heal_per_second")
	self.tick_rate = self:GetAbility():GetSpecialValueFor("tick_rate")
	if not IsServer() then return end
	self:StartIntervalThink(self.tick_rate)
end

function modifier_oracle_purifying_flames_custom:OnIntervalThink()
	if not IsServer() then return end
	if self:GetCaster():HasModifier("modifier_oracle_20") then
		if self:GetParent():GetTeamNumber() ~= self:GetCaster():GetTeamNumber() then return end
	end
	local heal = self.heal_per_second
	if self:GetCaster():HasModifier("modifier_oracle_6") then
		heal = heal + self:GetCaster():GetStrength() / 100 * self:GetAbility().modifier_oracle_6
	end
	self:GetParent():Heal(heal, self:GetAbility())
	SendOverheadEventMessage(nil, OVERHEAD_ALERT_HEAL, self:GetParent(), heal, nil)
end