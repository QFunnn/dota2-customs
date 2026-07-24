--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_naga_siren_song_of_the_siren_custom_aura", "abilities/naga_siren_song_of_the_siren_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_naga_siren_song_of_the_siren_custom_debuff", "abilities/naga_siren_song_of_the_siren_custom", LUA_MODIFIER_MOTION_NONE)

naga_siren_song_of_the_siren_custom = class({}) 

function naga_siren_song_of_the_siren_custom:OnUpgrade()
	if not IsServer() then return end
	local dance = self:GetCaster():FindAbilityByName("naga_siren_song_of_the_siren_cancel_custom")
	if dance then
		dance:SetLevel(1)
	end
end

function naga_siren_song_of_the_siren_custom:GetManaCost(level)
    return self.BaseClass.GetManaCost(self, level)
end

function naga_siren_song_of_the_siren_custom:GetCooldown(level)
    return self.BaseClass.GetCooldown( self, level )
end

function naga_siren_song_of_the_siren_custom:GetCastRange(location, target)
	return self:GetSpecialValueFor("radius")
end

function naga_siren_song_of_the_siren_custom:OnSpellStart()
	if not IsServer() then return end
	local duration = self:GetSpecialValueFor("duration")
	local pfx = ParticleManager:CreateParticle("particles/units/heroes/hero_siren/naga_siren_siren_song_cast.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetCaster())
	self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_naga_siren_song_of_the_siren_custom_aura", {duration = duration})
	ParticleManager:ReleaseParticleIndex(pfx)
end

modifier_naga_siren_song_of_the_siren_custom_aura = class({})

function modifier_naga_siren_song_of_the_siren_custom_aura:IsPurgable() return false end
function modifier_naga_siren_song_of_the_siren_custom_aura:IsPurgeException() return false end
function modifier_naga_siren_song_of_the_siren_custom_aura:IsAura() return true end
function modifier_naga_siren_song_of_the_siren_custom_aura:GetAuraDuration() return 0.5 end
function modifier_naga_siren_song_of_the_siren_custom_aura:GetAuraRadius() return self:GetAbility():GetSpecialValueFor("radius") end
function modifier_naga_siren_song_of_the_siren_custom_aura:GetAuraSearchFlags() return DOTA_UNIT_TARGET_FLAG_INVULNERABLE + DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES end
function modifier_naga_siren_song_of_the_siren_custom_aura:GetAuraSearchTeam() return DOTA_UNIT_TARGET_TEAM_ENEMY end
function modifier_naga_siren_song_of_the_siren_custom_aura:GetAuraSearchType() return DOTA_UNIT_TARGET_ALL end
function modifier_naga_siren_song_of_the_siren_custom_aura:GetModifierAura() return "modifier_naga_siren_song_of_the_siren_custom_debuff" end

function modifier_naga_siren_song_of_the_siren_custom_aura:OnCreated()
	if not IsServer() then return end
	self:GetCaster():EmitSound("Hero_NagaSiren.SongOfTheSiren")
	self.pfx = ParticleManager:CreateParticle("particles/units/heroes/hero_siren/naga_siren_song_aura.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetCaster())
	self:GetCaster():SwapAbilities(self:GetAbility():GetAbilityName(), "naga_siren_song_of_the_siren_cancel_custom", false, true)
	self:StartIntervalThink(FrameTime())
end

function modifier_naga_siren_song_of_the_siren_custom_aura:OnIntervalThink()
	if not IsServer() then return end
	if not self:GetCaster():HasShard() then return end
	local heal = self:GetCaster():GetMaxHealth() / 100 * self:GetAbility():GetSpecialValueFor("heal_pct")
	self:GetCaster():Heal(heal*FrameTime(), self:GetAbility())
end

function modifier_naga_siren_song_of_the_siren_custom_aura:OnDestroy()
	if not IsServer() then return end
	if self.pfx then
		ParticleManager:DestroyParticle(self.pfx, false)
		ParticleManager:ReleaseParticleIndex(self.pfx)
	end
	self:GetCaster():StopSound("Hero_NagaSiren.SongOfTheSiren")
	self:GetCaster():SwapAbilities(self:GetAbility():GetAbilityName(), "naga_siren_song_of_the_siren_cancel_custom", true, false)
end

modifier_naga_siren_song_of_the_siren_custom_debuff = class({})

function modifier_naga_siren_song_of_the_siren_custom_debuff:IsDebuff() return true end
function modifier_naga_siren_song_of_the_siren_custom_debuff:IsPurgable() return false end
function modifier_naga_siren_song_of_the_siren_custom_debuff:IsPurgeException() return false end

function modifier_naga_siren_song_of_the_siren_custom_debuff:OnCreated()
	if not IsServer() then return end
	self:StartIntervalThink(FrameTime())
	self:OnIntervalThink()
	self.pfx = ParticleManager:CreateParticle("particles/units/heroes/hero_siren/naga_siren_song_debuff.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
end

function modifier_naga_siren_song_of_the_siren_custom_debuff:OnIntervalThink()
	if not IsServer() then return end

end

function modifier_naga_siren_song_of_the_siren_custom_debuff:OnDestroy()
	if not IsServer() then return end
	if self.pfx then
		ParticleManager:DestroyParticle(self.pfx, false)
		ParticleManager:ReleaseParticleIndex(self.pfx)
	end
end

function modifier_naga_siren_song_of_the_siren_custom_debuff:CheckState()
	if self:GetParent():IsHero() then
		local state = 
	    {
			[MODIFIER_STATE_NIGHTMARED] = true,
			[MODIFIER_STATE_STUNNED] = true,
			[MODIFIER_STATE_INVULNERABLE] = true,
	    }
	    return state
	end
    local state = 
    {
		[MODIFIER_STATE_NIGHTMARED] = true,
		[MODIFIER_STATE_STUNNED] = true,
    }
    return state
end

naga_siren_song_of_the_siren_cancel_custom = class({})

function naga_siren_song_of_the_siren_cancel_custom:OnSpellStart()
	if not IsServer() then return end
	self:GetCaster():RemoveModifierByName("modifier_naga_siren_song_of_the_siren_custom_aura")
	self:GetCaster():EmitSound("Hero_NagaSiren.SongOfTheSiren.Cancel")
end