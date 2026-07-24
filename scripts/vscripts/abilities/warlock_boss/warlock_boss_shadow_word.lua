--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_warlock_boss_shadow_word_cd", "abilities/warlock_boss/warlock_boss_shadow_word.lua", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_warlock_boss_shadow_word_heal", "abilities/warlock_boss/warlock_boss_shadow_word.lua", LUA_MODIFIER_MOTION_NONE)

warlock_boss_shadow_word = class({})

function warlock_boss_shadow_word:Precache(context)
if self:GetCaster() and self:GetCaster():IsIllusion() then return end

PrecacheResource( "particle", "particles/warlock_aoe_cast.vpcf", context )
PrecacheResource( "particle", "particles/warlock_wave.vpcf", context )
PrecacheResource( "particle", "particles/econ/items/warlock/warlock_ti9/warlock_ti9_shadow_word_debuff.vpcf", context )
PrecacheResource( "particle", "particles/econ/items/warlock/warlock_ti9/warlock_ti9_shadow_word_buff.vpcf", context )

end

function warlock_boss_shadow_word:OnAbilityPhaseStart()

self.radius = self:GetSpecialValueFor("radius")
local particle_cast = "particles/warlock_aoe_cast.vpcf"
self.effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_CUSTOMORIGIN, self:GetCaster())
ParticleManager:SetParticleControl( self.effect_cast, 0, self:GetCaster():GetOrigin() )
ParticleManager:SetParticleControl( self.effect_cast, 1, Vector( self.radius, 0, -self.radius) )
ParticleManager:SetParticleControl( self.effect_cast, 2, Vector( 1, 0, 0 ) )

self:GetCaster():StartGestureWithPlaybackRate(ACT_DOTA_CAST_ABILITY_2, 0.6)

self.sign = ParticleManager:CreateParticle("particles/generic_gameplay/generic_has_quest.vpcf", PATTACH_OVERHEAD_FOLLOW, self:GetCaster())
return true
end


function warlock_boss_shadow_word:OnAbilityPhaseInterrupted()

ParticleManager:DestroyParticle( self.effect_cast, true )
ParticleManager:ReleaseParticleIndex( self.effect_cast )

self:GetCaster():FadeGesture(ACT_DOTA_CAST_ABILITY_2)

ParticleManager:DestroyParticle( self.sign , true )
ParticleManager:ReleaseParticleIndex( self.sign  )
end

function warlock_boss_shadow_word:OnSpellStart()
if not IsServer() then return end

self:GetCaster():FadeGesture(ACT_DOTA_CAST_ABILITY_2)

ParticleManager:DestroyParticle( self.effect_cast, true )
ParticleManager:ReleaseParticleIndex( self.effect_cast )
ParticleManager:DestroyParticle( self.sign , true )
ParticleManager:ReleaseParticleIndex( self.sign  )

self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_warlock_boss_shadow_word_cd", {duration = self:GetCooldownTimeRemaining()})

self.radius = self:GetSpecialValueFor("radius")

local wave_particle = ParticleManager:CreateParticle( "particles/warlock_wave.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetCaster() )
ParticleManager:SetParticleControl( wave_particle, 1, self:GetCaster():GetAbsOrigin() )
ParticleManager:ReleaseParticleIndex(wave_particle)

local  enemy_for_ability = FindUnitsInRadius(self:GetCaster():GetTeamNumber(), self:GetCaster():GetAbsOrigin(), nil, self.radius, DOTA_UNIT_TARGET_TEAM_BOTH, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 0 , FIND_CLOSEST, false)

local caster_heal = false

for _,enemy in pairs(enemy_for_ability) do 
	if enemy ~= self:GetCaster() then
		if enemy:GetTeamNumber() ~= self:GetCaster():GetTeamNumber() then 
			caster_heal = true
		end

		enemy:AddNewModifier(self:GetCaster(), self, "modifier_warlock_boss_shadow_word_heal", {duration = self:GetSpecialValueFor("duration")})
	end
end

if caster_heal == true then 
	self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_warlock_boss_shadow_word_heal", {duration = self:GetSpecialValueFor("duration")})
end

end




modifier_warlock_boss_shadow_word_cd = class({})

function modifier_warlock_boss_shadow_word_cd:IsHidden() return false end
function modifier_warlock_boss_shadow_word_cd:IsPurgable() return false end



modifier_warlock_boss_shadow_word_heal = class({})

function modifier_warlock_boss_shadow_word_heal:IsHidden() return self:GetParent():GetTeamNumber() == self:GetCaster():GetTeamNumber()
end

function modifier_warlock_boss_shadow_word_heal:IsPurgable() return false end

function modifier_warlock_boss_shadow_word_heal:OnCreated(table)

self.healing = self:GetAbility():GetSpecialValueFor("healing")

if not IsServer() then return end

self.particle = "particles/econ/items/warlock/warlock_ti9/warlock_ti9_shadow_word_buff.vpcf"
self.parent = self:GetParent()

self.heal = self:GetAbility():GetSpecialValueFor("heal")/100
self.damage = self:GetAbility():GetSpecialValueFor("damage")/100

if self:GetParent():GetTeamNumber() ~= self:GetCaster():GetTeamNumber() then 
	self:GetParent():EmitSound("Warlock.Word_damage")
	self.particle = "particles/econ/items/warlock/warlock_ti9/warlock_ti9_shadow_word_debuff.vpcf"
else 
	
	if self:GetParent():GetUnitName() == "npc_warlock_golem_custom" then
		self.heal = self:GetAbility():GetSpecialValueFor("heal_golem")/100
	end

	self:GetParent():EmitSound("Warlock.Word_heal")
end

self.particle_good_fx = ParticleManager:CreateParticle(self.particle, PATTACH_ABSORIGIN_FOLLOW, self.parent)
ParticleManager:SetParticleControl(self.particle_good_fx, 0, self.parent:GetAbsOrigin())
ParticleManager:SetParticleControl(self.particle_good_fx, 2, self.parent:GetAbsOrigin())
self:AddParticle(self.particle_good_fx, false, false, -1, false, false)

self:GetParent():EmitSound("Warlock.Word_loop")

self:OnIntervalThink()
self:StartIntervalThink(1)
end


function modifier_warlock_boss_shadow_word_heal:OnDestroy()
if not IsServer() then return end

self:GetParent():StopSound("Warlock.Word_loop")
end


function modifier_warlock_boss_shadow_word_heal:OnIntervalThink()
if not IsServer() then return end

if self:GetParent():GetTeamNumber() == self:GetCaster():GetTeamNumber() then 
	dota1x6:GenericHeal(self:GetParent(), self.heal*self:GetParent():GetMaxHealth(), self:GetAbility())
else
	SendOverheadEventMessage(self:GetParent(), 4, self:GetParent(), self:GetParent():GetMaxHealth()*self.damage, nil)
	DoDamage({victim = self:GetParent(), damage = self.damage*self:GetParent():GetMaxHealth(), damage_type = DAMAGE_TYPE_PURE, damage_flags = DOTA_DAMAGE_FLAG_NO_SPELL_AMPLIFICATION, attacker = self:GetCaster(), ability = self:GetAbility()})
end


end


function modifier_warlock_boss_shadow_word_heal:DeclareFunctions()
if self:GetParent():GetTeamNumber() == self:GetCaster():GetTeamNumber() then return end
return {
    --MODIFIER_PROPERTY_HEAL_AMPLIFY_PERCENTAGE_TARGET,
    MODIFIER_PROPERTY_HP_REGEN_AMPLIFY_PERCENTAGE,
    --MODIFIER_PROPERTY_LIFESTEAL_AMPLIFY_PERCENTAGE
    }
 end

function modifier_warlock_boss_shadow_word_heal:GetModifierLifestealRegenAmplify_Percentage() return self.healing end
function modifier_warlock_boss_shadow_word_heal:GetModifierHealChange() return self.healing end
function modifier_warlock_boss_shadow_word_heal:GetModifierHPRegenAmplify_Percentage() return self.healing end