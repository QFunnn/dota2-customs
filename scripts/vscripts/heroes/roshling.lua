--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_gold_roshan_spell", "heroes/roshling", LUA_MODIFIER_MOTION_NONE)

gold_roshan_spell = class({})

function gold_roshan_spell:GetIntrinsicModifierName()
	return "modifier_gold_roshan_spell"
end

modifier_gold_roshan_spell = class({})

function modifier_gold_roshan_spell:IsHidden() return true end
function modifier_gold_roshan_spell:IsPurgable() return false end
function modifier_gold_roshan_spell:IsPurgeException() return false end

function modifier_gold_roshan_spell:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_ABSORB_SPELL,
		MODIFIER_PROPERTY_STATUS_RESISTANCE
	}
end

function modifier_gold_roshan_spell:GetAbsorbSpell( params )
	if not IsServer() then return end
	if self:GetAbility():IsFullyCastable() then
		if params.ability:GetCaster():GetTeamNumber() == self:GetParent():GetTeamNumber() then
        	return nil
        end
		self:GetAbility():UseResources( false, false, false, true )
		local particle = ParticleManager:CreateParticle("particles/items_fx/immunity_sphere.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
		ParticleManager:SetParticleControlEnt(particle, 0, self:GetParent(), PATTACH_POINT_FOLLOW, "attach_hitloc", self:GetParent():GetAbsOrigin(), true)
		ParticleManager:ReleaseParticleIndex(particle)

		self:GetCaster():EmitSound("DOTA_Item.LinkensSphere.Activate")
		return 1
	end
end

function modifier_gold_roshan_spell:GetModifierStatusResistance( params )
	return 25
end

LinkLuaModifier("modifier_gold_roshan_bash", "heroes/roshling", LUA_MODIFIER_MOTION_NONE)

gold_roshan_bash = class({})

function gold_roshan_bash:GetIntrinsicModifierName()
	return "modifier_gold_roshan_bash"
end

modifier_gold_roshan_bash = class({})

function modifier_gold_roshan_bash:IsHidden() return true end
function modifier_gold_roshan_bash:IsPurgable() return false end
function modifier_gold_roshan_bash:IsPurgeException() return false end

function modifier_gold_roshan_bash:AttackLandedModifier(params)
	if not IsServer() then return end
	if params.attacker ~= self:GetParent() then return end
	if RollPercentage(self:GetAbility():GetSpecialValueFor("chance")) and self:GetAbility():IsFullyCastable() then
		self:GetParent():EmitSound("Roshan.Bash")
		self:GetAbility():UseResources(false, false, false, true)
		params.target:AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_bashed", {duration = self:GetAbility():GetSpecialValueFor("duration") * (1-params.target:GetStatusResistance()) })
	end
end

LinkLuaModifier("modifier_gold_roshan_clap", "heroes/roshling", LUA_MODIFIER_MOTION_NONE)

gold_roshan_clap = class({})

function gold_roshan_clap:OnSpellStart()
	if not IsServer() then return end

	local enemies = FindUnitsInRadius(self:GetCaster():GetTeamNumber(), self:GetCaster():GetOrigin(), nil,self:GetSpecialValueFor("radius"), DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 0, FIND_CLOSEST, false)
    
	local damage = self:GetSpecialValueFor("damage")

	local particle = ParticleManager:CreateParticle("particles/neutral_fx/roshan_slam.vpcf", PATTACH_WORLDORIGIN, self:GetCaster())
	ParticleManager:SetParticleControl(particle, 0, self:GetCaster():GetAbsOrigin())
	ParticleManager:SetParticleControl(particle, 1, Vector(self:GetSpecialValueFor("radius"), self:GetSpecialValueFor("radius"), self:GetSpecialValueFor("radius")))
    ParticleManager:ReleaseParticleIndex(particle)
	self:GetCaster():EmitSound("Roshan.Slam")

    for _,enemy in pairs(enemies) do
    	ApplyDamage({victim = enemy, attacker = self:GetCaster(), ability = self, damage = damage, damage_type = DAMAGE_TYPE_MAGICAL})
    	enemy:AddNewModifier(self:GetCaster(), self, "modifier_gold_roshan_clap", {duration = self:GetSpecialValueFor("duration")})
    end
end

modifier_gold_roshan_clap = class({})

function modifier_gold_roshan_clap:OnCreated()
	self.slow = self:GetAbility():GetSpecialValueFor("slow")
	self.slow_2 = self:GetAbility():GetSpecialValueFor("slow_2")
end

function modifier_gold_roshan_clap:DeclareFunctions()
	return 
	{
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
	}
end

function modifier_gold_roshan_clap:GetModifierMoveSpeedBonus_Percentage()
	return self.slow
end

function modifier_gold_roshan_clap:GetModifierAttackSpeedBonus_Constant()
	return self.slow_2
end

roshan_phys_immune = class({})