--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_woda_neutral_fireball_thinker", "neutrals/woda_neutral_fireball", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_neutral_cast", "neutrals/modifier_neutral_cast", LUA_MODIFIER_MOTION_NONE)

woda_neutral_fireball = class({})

function woda_neutral_fireball:Precache(context)
    PrecacheResource( "particle", "particles/neutral_fx/black_dragon_fireball.vpcf", context )
end

function woda_neutral_fireball:OnSpellStart()
	if not IsServer() then return end
	local point = self:GetCursorPosition()
	local duration = self:GetSpecialValueFor("duration")
	self:GetCaster():StartGestureWithPlaybackRate(ACT_DOTA_CAST_ABILITY_1, 1)
	self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_neutral_cast", {})

	Timers:CreateTimer(0, function()
		if not self:GetCaster():IsAlive() then return end
		self:GetCaster():EmitSound("n_black_dragon.Fireball.Cast")
		CreateModifierThinker(self:GetCaster(), self, "modifier_woda_neutral_fireball_thinker", {duration = duration}, point, self:GetCaster():GetTeamNumber(), false)
		self:GetCaster():RemoveModifierByName("modifier_neutral_cast")
	end)
end

modifier_woda_neutral_fireball_thinker = class({})

function modifier_woda_neutral_fireball_thinker:IsHidden() return false end
function modifier_woda_neutral_fireball_thinker:IsPurgable() return false end

function modifier_woda_neutral_fireball_thinker:OnCreated(table)
	if not IsServer() then return end
	
	local duration = self:GetAbility():GetSpecialValueFor("duration")
	
	self.particle = ParticleManager:CreateParticle( "particles/neutral_fx/black_dragon_fireball.vpcf", PATTACH_WORLDORIGIN, nil );
	ParticleManager:SetParticleControl( self.particle, 0, self:GetParent():GetOrigin() )
	ParticleManager:SetParticleControl( self.particle, 1, self:GetParent():GetOrigin() )
	ParticleManager:SetParticleControl( self.particle, 2, Vector( duration, 0, 0 ) )
	self:GetParent():EmitSound("n_black_dragon.Fireball.Target")
	self:StartIntervalThink(0.5)
end

function modifier_woda_neutral_fireball_thinker:OnDestroy()
	if not IsServer() then return end
	if self.particle then
		ParticleManager:DestroyParticle(self.particle, true)
		ParticleManager:ReleaseParticleIndex( self.particle )
	end
	self:GetParent():StopSound("n_black_dragon.Fireball.Target")
end

function modifier_woda_neutral_fireball_thinker:OnIntervalThink()
	if not IsServer() then return end

	local damage = self:GetAbility():GetSpecialValueFor("damage")
	local radius = self:GetAbility():GetSpecialValueFor("radius")

	local enemies = FindUnitsInRadius( self:GetParent():GetTeamNumber(), self:GetParent():GetOrigin(), self:GetParent(), radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 0, 0, false )
	for _,enemy in pairs( enemies ) do
		if enemy ~= nil then
			local enemy_damage = enemy:GetHealth() / 100 * damage
			ApplyDamage({victim = enemy, attacker = self:GetCaster(), damage = enemy_damage, damage_type = DAMAGE_TYPE_MAGICAL, ability = self:GetAbility()})
		end
	end
end