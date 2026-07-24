--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_witch_doctor_voodoo_restoration_custom", "heroes/npc_dota_hero_witch_doctor_custom/witch_doctor_voodoo_restoration_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_witch_doctor_voodoo_restoration_custom_heal", "heroes/npc_dota_hero_witch_doctor_custom/witch_doctor_voodoo_restoration_custom", LUA_MODIFIER_MOTION_NONE)

witch_doctor_voodoo_restoration_custom = class({})

witch_doctor_voodoo_restoration_custom.modifier_witch_doctor_1_mana = {15,30}
witch_doctor_voodoo_restoration_custom.modifier_witch_doctor_2_radius = {50,100}
witch_doctor_voodoo_restoration_custom.modifier_witch_doctor_3_movespeed = {7,14}
witch_doctor_voodoo_restoration_custom.modifier_witch_doctor_4_str = {12,24,36}
witch_doctor_voodoo_restoration_custom.modifier_witch_doctor_6_max_health_bonus = {0.2,0.4,0.6}

function witch_doctor_voodoo_restoration_custom:Precache(context)
    if self:GetCaster() and self:GetCaster():IsIllusion() then return end
    PrecacheResource( "particle", "particles/units/heroes/hero_witchdoctor/witchdoctor_voodoo_restoration.vpcf", context )
end

function witch_doctor_voodoo_restoration_custom:GetCastRange()
	local bonus = 0
	if self:GetCaster():HasModifier("modifier_witch_doctor_2") then
		bonus = self.modifier_witch_doctor_2_radius[self:GetCaster():GetTalentLevel("modifier_witch_doctor_2")]
	end
	return self:GetSpecialValueFor("radius") + bonus
end

function witch_doctor_voodoo_restoration_custom:GetManaCost(level)
	local bonus = 0
	if self:GetCaster():HasModifier("modifier_witch_doctor_1") then
		bonus = self.BaseClass.GetManaCost(self, level) / 100 * self.modifier_witch_doctor_1_mana[self:GetCaster():GetTalentLevel("modifier_witch_doctor_1")]
	end
    return self.BaseClass.GetManaCost(self, level) - bonus
end

function witch_doctor_voodoo_restoration_custom:OnToggle()
	if self:GetToggleState() then
		EmitSoundOn("Hero_WitchDoctor.Voodoo_Restoration", self:GetCaster())
		EmitSoundOn("Hero_WitchDoctor.Voodoo_Restoration.Loop", self:GetCaster())
		self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_witch_doctor_voodoo_restoration_custom", {})
	else
		EmitSoundOn("Hero_WitchDoctor.Voodoo_Restoration.Off", self:GetCaster())
		StopSoundEvent("Hero_WitchDoctor.Voodoo_Restoration.Loop", self:GetCaster())
		self:GetCaster():RemoveModifierByName("modifier_witch_doctor_voodoo_restoration_custom")
	end
end

modifier_witch_doctor_voodoo_restoration_custom = class({})

function modifier_witch_doctor_voodoo_restoration_custom:OnCreated()
	if not IsServer() then return end
	local ability = self:GetAbility()
	self.interval = ability:GetSpecialValueFor("heal_interval")
	self.radius = ability:GetSpecialValueFor("radius")
	self:StartIntervalThink( self.interval )

	self.particle = ParticleManager:CreateParticle("particles/units/heroes/hero_witchdoctor/witchdoctor_voodoo_restoration.vpcf", PATTACH_POINT_FOLLOW, self:GetParent())
	ParticleManager:SetParticleControl(self.particle, 0, self:GetParent():GetAbsOrigin())
	ParticleManager:SetParticleControl(self.particle, 1, Vector( self.radius, self.radius, self.radius ) )
	ParticleManager:SetParticleControlEnt(self.particle, 2, self:GetParent(), PATTACH_POINT_FOLLOW, "attach_staff", self:GetParent():GetAbsOrigin(), true)
	self:AddParticle(self.particle, false, false, -1, false, false)
end

function modifier_witch_doctor_voodoo_restoration_custom:OnIntervalThink()
	if not IsServer() then return end
	local bonus = 0
	if self:GetCaster():HasModifier("modifier_witch_doctor_2") then
		bonus = self:GetAbility().modifier_witch_doctor_2_radius[self:GetCaster():GetTalentLevel("modifier_witch_doctor_2")]
	end
	if self.particle then
		ParticleManager:SetParticleControl(self.particle, 1, Vector( self.radius + bonus, self.radius + bonus, self.radius + bonus ) )
	end
    local manacost = self:GetAbility():GetSpecialValueFor("mana_per_second")
    if self:GetCaster():HasModifier("modifier_witch_doctor_1") then
		manacost = manacost - (manacost / 100 * self:GetAbility().modifier_witch_doctor_1_mana[self:GetCaster():GetTalentLevel("modifier_witch_doctor_1")])
	end
    manacost = manacost * self.interval

	if self:GetParent() == self:GetCaster() then
		if self:GetCaster():GetMana() >= manacost then
			self:GetCaster():Script_ReduceMana(manacost, self:GetAbility())
		else
			self:GetAbility():ToggleAbility()
		end
	end
end

function modifier_witch_doctor_voodoo_restoration_custom:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE
	}
end

function modifier_witch_doctor_voodoo_restoration_custom:GetModifierMoveSpeedBonus_Percentage()
	if self:GetCaster():HasModifier("modifier_witch_doctor_3") then
		return self:GetAbility().modifier_witch_doctor_3_movespeed[self:GetCaster():GetTalentLevel("modifier_witch_doctor_3")]
	end
	return 0
end

function modifier_witch_doctor_voodoo_restoration_custom:IsAura()
	return true
end

function modifier_witch_doctor_voodoo_restoration_custom:IsAuraActiveOnDeath()
	return false
end

function modifier_witch_doctor_voodoo_restoration_custom:GetAuraRadius()
	local bonus = 0
	if self:GetCaster():HasModifier("modifier_witch_doctor_2") then
		bonus = self:GetAbility().modifier_witch_doctor_2_radius[self:GetCaster():GetTalentLevel("modifier_witch_doctor_2")]
	end
	return self.radius + bonus
end

function modifier_witch_doctor_voodoo_restoration_custom:GetAuraSearchTeam()
	return DOTA_UNIT_TARGET_TEAM_BOTH
end

function modifier_witch_doctor_voodoo_restoration_custom:GetAuraSearchType()
	return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
end

function modifier_witch_doctor_voodoo_restoration_custom:GetModifierAura()
	return "modifier_witch_doctor_voodoo_restoration_custom_heal"
end

function modifier_witch_doctor_voodoo_restoration_custom:IsHidden()
	return true
end

modifier_witch_doctor_voodoo_restoration_custom_heal = class({})

function modifier_witch_doctor_voodoo_restoration_custom_heal:IsDebuff() return self:GetParent():GetTeamNumber() ~= self:GetCaster():GetTeamNumber() end
function modifier_witch_doctor_voodoo_restoration_custom_heal:IsHidden() return false end
function modifier_witch_doctor_voodoo_restoration_custom_heal:IsPurgable() return false end
function modifier_witch_doctor_voodoo_restoration_custom_heal:IsPurgeException() return false end
function modifier_witch_doctor_voodoo_restoration_custom_heal:IsStunDebuff() return false end
function modifier_witch_doctor_voodoo_restoration_custom_heal:RemoveOnDeath() return true end
function modifier_witch_doctor_voodoo_restoration_custom_heal:GetAttributes() return MODIFIER_ATTRIBUTE_MULTIPLE end

function modifier_witch_doctor_voodoo_restoration_custom_heal:OnCreated()
	if not IsServer() then return end
	self.interval = self:GetAbility():GetSpecialValueFor("heal_interval")
	self:StartIntervalThink( self.interval )
end

function modifier_witch_doctor_voodoo_restoration_custom_heal:OnIntervalThink()
	if not IsServer() then return end
    if self:GetCaster():HasModifier("modifier_disconnect_player_no_damage") then
        return
    end
	local bonus = 0
	local dificit_bonus = 1
    local heal = self:GetAbility():GetSpecialValueFor("heal")
	if self:GetCaster():HasModifier("modifier_witch_doctor_4") then
		bonus = self:GetCaster():GetStrength() / 100 * self:GetAbility().modifier_witch_doctor_4_str[self:GetCaster():GetTalentLevel("modifier_witch_doctor_4")]
	end
	if self:GetCaster():HasModifier("modifier_witch_doctor_6") then
		bonus = bonus + self:GetCaster():GetMaxHealth() / 100 * self:GetAbility().modifier_witch_doctor_6_max_health_bonus[self:GetCaster():GetTalentLevel("modifier_witch_doctor_6")]
	end
	if self:GetCaster():HasModifier("modifier_witch_doctor_7") then
		local health_dificit = (self:GetCaster():GetHealthDeficit() / self:GetCaster():GetMaxHealth()) / 2
		dificit_bonus = dificit_bonus + health_dificit
	end
    heal = ((heal + bonus) * dificit_bonus) * self.interval
	if self:GetParent():GetTeamNumber() ~= self:GetCaster():GetTeamNumber() then
        if self:GetCaster():HasModifier("modifier_witch_doctor_1") then
		    ApplyDamage({victim = self:GetParent(), attacker = self:GetCaster(), damage = heal, ability = self:GetAbility(), damage_type = self:GetAbility():GetAbilityDamageType()})
        end
	else
		self:GetParent():Heal(heal, self:GetAbility())
		SendOverheadEventMessage(self:GetParent(), OVERHEAD_ALERT_HEAL, self:GetParent(), heal, self:GetParent())
	end
end