--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


undying_soul_rip_custom = class({})

function undying_soul_rip_custom:Precache(context)
    if self:GetCaster() and self:GetCaster():IsIllusion() then return end
    PrecacheResource( "particle", "particles/units/heroes/hero_undying/undying_soul_rip_damage.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_undying/undying_soul_rip_heal.vpcf", context )
end

undying_soul_rip_custom.modifier_undying_19 = {20,15}

function IsUndyingZombie(unit)
	if unit.GetClassname then
		if unit:GetClassname() == "npc_dota_unit_undying_zombie" then
			return true
		end
	end

	return false
end

function IsUndyingTombstone(unit)
	if unit.GetClassname then
		if unit:GetClassname() == "npc_dota_unit_undying_tombstone" then
			return true
		end
	end

	return false
end

function undying_soul_rip_custom:CastFilterResultTarget(target)
	if IsUndyingTombstone(target) and target:GetTeamNumber() == self:GetCaster():GetTeamNumber() then
		return UF_SUCCESS
	elseif IsUndyingZombie(target) then
		return UF_FAIL
	else
		return UnitFilter(target, DOTA_UNIT_TARGET_TEAM_BOTH, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_NONE, self:GetCaster():GetTeamNumber())
	end
end

function undying_soul_rip_custom:GetCooldown(iLevel)
    local bonus = 0
    if self:GetCaster():HasModifier("modifier_undying_18") then
        bonus = 0
    end
    return self.BaseClass.GetCooldown(self, iLevel) + bonus
end

function undying_soul_rip_custom:OnSpellStart()
	if not IsServer() then return end

	local radius = self:GetSpecialValueFor("radius")
	local damage_per_unit = self:GetSpecialValueFor("damage_per_unit")
	local max_units = self:GetSpecialValueFor("max_units")
	local tombstone_heal = self:GetSpecialValueFor("tombstone_heal")

	if self:GetCaster():HasModifier("modifier_undying_19") then
		print("manaregen", self:GetCaster():GetManaRegen())
		max_units = max_units + (self:GetCaster():GetManaRegen() / self.modifier_undying_19[self:GetCaster():GetTalentLevel("modifier_undying_19")])
	end

	self:GetCaster():EmitSound("Hero_Undying.SoulRip.Cast")

	local target = self:GetCursorTarget()

	if target:IsMagicImmune() then return end

	if target:GetTeamNumber() ~= self:GetCaster():GetTeamNumber() then
		if target:TriggerSpellAbsorb(self) then return end
	end

	local units = FindUnitsInRadius(self:GetCaster():GetTeamNumber(), self:GetCaster():GetAbsOrigin(), nil, radius, DOTA_UNIT_TARGET_TEAM_BOTH, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_NO_INVIS + DOTA_UNIT_TARGET_FLAG_FOW_VISIBLE, FIND_ANY_ORDER, false)

	local units_ripped      = 0
	local damage_particle   = nil
	
	for _, unit in pairs(units) do
		if unit ~= self:GetCaster() and unit ~= target then

			if target:GetTeamNumber() ~= self:GetCaster():GetTeamNumber() then
				damage_particle = ParticleManager:CreateParticle("particles/units/heroes/hero_undying/undying_soul_rip_damage.vpcf", PATTACH_ABSORIGIN_FOLLOW, target)
			else
				damage_particle = ParticleManager:CreateParticle("particles/units/heroes/hero_undying/undying_soul_rip_heal.vpcf", PATTACH_ABSORIGIN_FOLLOW, target)
			end
			
			ParticleManager:SetParticleControlEnt(damage_particle, 1, unit, PATTACH_POINT_FOLLOW, "attach_hitloc", unit:GetAbsOrigin(), true)
			ParticleManager:ReleaseParticleIndex(damage_particle)
		              
			if not IsUndyingZombie(unit) then
				unit:SetHealth(math.max(1, unit:GetHealth() - damage_per_unit))
			end
			
			units_ripped = units_ripped + 1
			
			if units_ripped >= max_units then
				break
			end
		end
	end

	if self:GetCaster():HasModifier("modifier_undying_18") then
		units_ripped = max_units
	end
	
	if units_ripped >= 1 then
		if target:GetTeamNumber() ~= self:GetCaster():GetTeamNumber() and not target:TriggerSpellAbsorb(self) then
			target:EmitSound("Hero_Undying.SoulRip.Enemy")
			ApplyDamage({ victim = target, damage = damage_per_unit * units_ripped, damage_type = DAMAGE_TYPE_MAGICAL, damage_flags = DOTA_DAMAGE_FLAG_NONE, attacker = self:GetCaster(), ability = self})
		elseif target:GetTeamNumber() == self:GetCaster():GetTeamNumber() and not IsUndyingTombstone(target) then
			target:EmitSound("Hero_Undying.SoulRip.Ally")
			target:Heal(damage_per_unit * units_ripped, self:GetCaster())
			SendOverheadEventMessage(nil, OVERHEAD_ALERT_HEAL, target, damage_per_unit * units_ripped, nil)
		elseif target:GetTeamNumber() == self:GetCaster():GetTeamNumber() and IsUndyingTombstone(target) then
			target:EmitSound("Hero_Undying.SoulRip.Ally")
			target:Heal(tombstone_heal, self:GetCaster())
			SendOverheadEventMessage(nil, OVERHEAD_ALERT_HEAL, target, tombstone_heal, nil)
		end
	end
end