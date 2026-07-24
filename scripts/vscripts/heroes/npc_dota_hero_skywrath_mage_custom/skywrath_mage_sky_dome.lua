--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_skywrath_mage_sky_dome", "heroes/npc_dota_hero_skywrath_mage_custom/skywrath_mage_sky_dome", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_skywrath_mage_sky_dome_buff", "heroes/npc_dota_hero_skywrath_mage_custom/skywrath_mage_sky_dome", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_skywrath_mage_sky_dome_enemy", "heroes/npc_dota_hero_skywrath_mage_custom/skywrath_mage_sky_dome", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_skywrath_mage_sky_dome_debuff", "heroes/npc_dota_hero_skywrath_mage_custom/skywrath_mage_sky_dome", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_drow_ranger_wave_of_silence_custom_knockback", "heroes/npc_dota_hero_drow_ranger_custom/drow_ranger_wave_of_silence_custom", LUA_MODIFIER_MOTION_BOTH )

skywrath_mage_sky_dome = class({})

skywrath_mage_sky_dome.modifier_skywrath_mage_11 = {2,4,6}
skywrath_mage_sky_dome.modifier_skywrath_mage_12_damage = {100,150,200}

function skywrath_mage_sky_dome:Precache(context)
    if self:GetCaster() and self:GetCaster():IsIllusion() then return end
    PrecacheResource( "particle", "particles/units/heroes/hero_arc_warden/arc_warden_magnetic_cast.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_arc_warden/arc_warden_magnetic.vpcf", context )
end

function skywrath_mage_sky_dome:OnSpellStart()
	if not IsServer() then return end
	local duration = self:GetSpecialValueFor("duration")

	self:GetCaster():EmitSound("Hero_ArcWarden.MagneticField.Cast")
	
	local cast_particle = ParticleManager:CreateParticle("particles/units/heroes/hero_arc_warden/arc_warden_magnetic_cast.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetCaster())
	ParticleManager:SetParticleControlEnt(cast_particle, 0, self:GetCaster(), PATTACH_POINT_FOLLOW, "attach_attack1", self:GetCaster():GetAbsOrigin(), true)
	ParticleManager:ReleaseParticleIndex(cast_particle)

	CreateModifierThinker(self:GetCaster(), self, "modifier_skywrath_mage_sky_dome", {duration = duration }, self:GetCaster():GetAbsOrigin(), self:GetCaster():GetTeamNumber(), false)
	if not self:GetCaster():HasModifier("modifier_skywrath_mage_12") then return end
	CreateModifierThinker(self:GetCaster(), self, "modifier_skywrath_mage_sky_dome_enemy", {duration = duration }, self:GetCaster():GetAbsOrigin(), self:GetCaster():GetTeamNumber(), false)
end

modifier_skywrath_mage_sky_dome = class({})

function modifier_skywrath_mage_sky_dome:OnCreated()
	self.radius = self:GetAbility():GetSpecialValueFor("radius")
	if not IsServer() then return end
	self:GetParent():EmitSound("Hero_ArcWarden.MagneticField")
	self.particle = ParticleManager:CreateParticle("particles/units/heroes/hero_arc_warden/arc_warden_magnetic.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
	ParticleManager:SetParticleControl(self.particle, 1, Vector(self.radius, self.radius, 1))
	self:AddParticle(self.particle, false, false, 1, false, false)

	local units = FindUnitsInRadius( self:GetParent():GetTeamNumber(), self:GetParent():GetAbsOrigin(), nil, self.radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES, FIND_ANY_ORDER, false)
	for _, target in pairs(units) do
		local dir = target:GetAbsOrigin() - self:GetParent():GetAbsOrigin()
		dir.z = 0
		local distance = 200
		dir = dir:Normalized()
		target:AddNewModifier( self:GetCaster(), self, "modifier_drow_ranger_wave_of_silence_custom_knockback", { duration = 0.3, distance = distance, direction_x = dir.x, direction_y = dir.y } )
	end
end

function modifier_skywrath_mage_sky_dome:OnDestroy()
	if not IsServer() then return end
	self:GetParent():StopSound("Hero_ArcWarden.MagneticField")
end

function modifier_skywrath_mage_sky_dome:IsAura() return true end
function modifier_skywrath_mage_sky_dome:IsAuraActiveOnDeath() return false end
function modifier_skywrath_mage_sky_dome:GetAuraDuration() return 0.1 end
function modifier_skywrath_mage_sky_dome:GetAuraRadius() return self.radius end
function modifier_skywrath_mage_sky_dome:GetAuraSearchFlags() return DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES + DOTA_UNIT_TARGET_FLAG_INVULNERABLE end
function modifier_skywrath_mage_sky_dome:GetAuraSearchTeam() return DOTA_UNIT_TARGET_TEAM_FRIENDLY end
function modifier_skywrath_mage_sky_dome:GetAuraSearchType() return DOTA_UNIT_TARGET_ALL end
function modifier_skywrath_mage_sky_dome:GetModifierAura() return "modifier_skywrath_mage_sky_dome_buff" end

modifier_skywrath_mage_sky_dome_buff = class({})

function modifier_skywrath_mage_sky_dome_buff:OnCreated()
	if not IsServer() then return end
end

function modifier_skywrath_mage_sky_dome_buff:GetTexture() return "skywrath_mage_11" end

function modifier_skywrath_mage_sky_dome_buff:DeclareFunctions()
	return 
	{
		MODIFIER_PROPERTY_EVASION_CONSTANT,
		MODIFIER_PROPERTY_HEALTH_REGEN_PERCENTAGE,
	}
end

function modifier_skywrath_mage_sky_dome_buff:GetModifierEvasion_Constant(keys)
	if keys.attacker and self:GetAuraOwner() and self:GetAuraOwner():HasModifier("modifier_skywrath_mage_sky_dome") and self:GetAuraOwner():FindModifierByName("modifier_skywrath_mage_sky_dome").radius and (keys.attacker:GetAbsOrigin() - self:GetAuraOwner():GetAbsOrigin()):Length2D() > self:GetAuraOwner():FindModifierByName("modifier_skywrath_mage_sky_dome").radius then
		return 100
	end
end

function modifier_skywrath_mage_sky_dome_buff:GetModifierHealthRegenPercentage()
	if not self:GetCaster():HasModifier("modifier_skywrath_mage_11") then return end
	return self:GetAbility().modifier_skywrath_mage_11[self:GetCaster():GetTalentLevel("modifier_skywrath_mage_11")]
end

modifier_skywrath_mage_sky_dome_enemy = class({})

function modifier_skywrath_mage_sky_dome_enemy:IsAura() return true end
function modifier_skywrath_mage_sky_dome_enemy:IsAuraActiveOnDeath() return false end
function modifier_skywrath_mage_sky_dome_enemy:GetAuraDuration() return 0.1 end
function modifier_skywrath_mage_sky_dome_enemy:GetAuraRadius() return self:GetAbility():GetSpecialValueFor("radius") end
function modifier_skywrath_mage_sky_dome_enemy:GetAuraSearchFlags() return DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES + DOTA_UNIT_TARGET_FLAG_INVULNERABLE end
function modifier_skywrath_mage_sky_dome_enemy:GetAuraSearchTeam() return DOTA_UNIT_TARGET_TEAM_ENEMY end
function modifier_skywrath_mage_sky_dome_enemy:GetAuraSearchType() return DOTA_UNIT_TARGET_ALL end
function modifier_skywrath_mage_sky_dome_enemy:GetModifierAura() return "modifier_skywrath_mage_sky_dome_debuff" end

modifier_skywrath_mage_sky_dome_debuff = class({})

function modifier_skywrath_mage_sky_dome_debuff:GetTexture() return "skywrath_mage_12" end

function modifier_skywrath_mage_sky_dome_debuff:OnCreated()
	if not IsServer() then return end
	self:StartIntervalThink(0.5)
end

function modifier_skywrath_mage_sky_dome_debuff:OnIntervalThink()
	if not IsServer() then return end
	local damage = self:GetCaster():GetAgility() / 100 * self:GetAbility().modifier_skywrath_mage_12_damage[self:GetCaster():GetTalentLevel("modifier_skywrath_mage_12")]
	ApplyDamage({victim = self:GetParent(), attacker = self:GetCaster(), ability = self:GetAbility(), damage = damage * 0.5, damage_type = DAMAGE_TYPE_MAGICAL})
end