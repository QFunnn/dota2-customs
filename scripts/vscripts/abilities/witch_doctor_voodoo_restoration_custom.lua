--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_witch_doctor_voodoo_restoration_custom", "abilities/witch_doctor_voodoo_restoration_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_witch_doctor_voodoo_restoration_custom_heal", "abilities/witch_doctor_voodoo_restoration_custom", LUA_MODIFIER_MOTION_NONE)

witch_doctor_voodoo_restoration_custom = class({})

function witch_doctor_voodoo_restoration_custom:Precache(context)
    PrecacheResource( "particle", "particles/units/heroes/hero_witchdoctor/witchdoctor_voodoo_restoration.vpcf", context )
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
	self.manacost = ability:GetSpecialValueFor("mana_per_second") * self.interval
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
	if self.particle then
		ParticleManager:SetParticleControl(self.particle, 1, Vector( self.radius + bonus, self.radius + bonus, self.radius + bonus ) )
	end
	if self:GetParent() == self:GetCaster() then
		local caster = self:GetCaster()
		if caster:HasModifier("modifier_huskar_blood_magic") then
			if caster:GetHealth() > self.manacost then
				caster:SetHealth(caster:GetHealth() - self.manacost)
			else
				self:GetAbility():ToggleAbility()
			end
		else
			if caster:GetMana() >= self:GetAbility():GetManaCost(-1) then
				caster:Script_ReduceMana(self.manacost, self:GetAbility())
			else
				self:GetAbility():ToggleAbility()
			end
		end
	end
end

function modifier_witch_doctor_voodoo_restoration_custom:IsAura()
	return true
end

function modifier_witch_doctor_voodoo_restoration_custom:IsAuraActiveOnDeath()
	return false
end

function modifier_witch_doctor_voodoo_restoration_custom:GetAuraRadius()
	return self.radius
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
function modifier_witch_doctor_voodoo_restoration_custom_heal:IsHidden() return true end
function modifier_witch_doctor_voodoo_restoration_custom_heal:IsPurgable() return false end
function modifier_witch_doctor_voodoo_restoration_custom_heal:IsPurgeException() return false end
function modifier_witch_doctor_voodoo_restoration_custom_heal:IsStunDebuff() return false end
function modifier_witch_doctor_voodoo_restoration_custom_heal:RemoveOnDeath() return true end
function modifier_witch_doctor_voodoo_restoration_custom_heal:GetAttributes() return MODIFIER_ATTRIBUTE_MULTIPLE end

function modifier_witch_doctor_voodoo_restoration_custom_heal:OnCreated()
	self.heal = self:GetAbility():GetSpecialValueFor("heal")
    self.damage = self:GetAbility():GetSpecialValueFor("damage")
	if not IsServer() then return end
	self.interval = self:GetAbility():GetSpecialValueFor("heal_interval")
	self:StartIntervalThink( self.interval )
end

function modifier_witch_doctor_voodoo_restoration_custom_heal:OnIntervalThink()
	if not IsServer() then return end
	local heal = self.heal + (self:GetParent():GetMaxHealth() / 100 * self:GetCaster():FindTalentValue("special_bonus_unique_witch_doctor_2"))
    local damage = self.damage + (self:GetParent():GetMaxHealth() / 100 * self:GetCaster():FindTalentValue("special_bonus_unique_witch_doctor_2"))
	if self:GetParent():GetTeamNumber() ~= self:GetCaster():GetTeamNumber() then
		ApplyDamage({victim = self:GetParent(), attacker = self:GetCaster(), damage = damage * self.interval, ability = self:GetAbility(), damage_type = self:GetAbility():GetAbilityDamageType()})
	else
		self:GetParent():Heal(heal*self.interval, self:GetAbility())
		SendOverheadEventMessage(self:GetParent(), OVERHEAD_ALERT_HEAL, self:GetParent(), heal * self.interval, self:GetParent())
	end
end