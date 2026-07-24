--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_vengefulspirit_magic_missile_custom_stack_debuff", "heroes/npc_dota_hero_vengefulspirit_custom/vengefulspirit_magic_missile_custom", LUA_MODIFIER_MOTION_NONE)

vengefulspirit_magic_meteor = class({})

function vengefulspirit_magic_meteor:Precache(context)
    if self:GetCaster() and self:GetCaster():IsIllusion() then return end
    PrecacheResource( "particle", "particles/vengeful_spirit/meteor_cast.vpcf", context )
    PrecacheResource( "particle", "particles/veng_meteor_spell.vpcf", context )
end

function vengefulspirit_magic_meteor:OnSpellStart()
	if not IsServer() then return end
	local position	= self:GetCursorPosition()
	AddFOWViewer(self:GetCaster():GetTeam(), position, self:GetSpecialValueFor("radius"), self:GetSpecialValueFor("land_time")+0.5, false)

	self:GetCaster():EmitSound("DOTA_Item.MeteorHammer.Cast")

	local land_time = self:GetSpecialValueFor("land_time")
	local radius = self:GetSpecialValueFor("radius")

	local ground_particle = ParticleManager:CreateParticleForTeam("particles/vengeful_spirit/meteor_cast.vpcf", PATTACH_WORLDORIGIN, self:GetCaster(), self:GetCaster():GetTeam())
	ParticleManager:SetParticleControl(ground_particle, 0, position)
	ParticleManager:SetParticleControl(ground_particle, 1, Vector(radius, 1, 1))
	
	local meteor_hammer	= ParticleManager:CreateParticle("particles/veng_meteor_spell.vpcf", PATTACH_WORLDORIGIN, self:GetCaster())
	ParticleManager:SetParticleControl(meteor_hammer, 0, position + Vector(0, 0, 1000))
	ParticleManager:SetParticleControl(meteor_hammer, 1, position)
	ParticleManager:SetParticleControl(meteor_hammer, 2, Vector(land_time, 0, 0))
	ParticleManager:ReleaseParticleIndex(meteor_hammer)

	local stun_duration = 0
	local damage = 0

	local vengefulspirit_magic_missile_custom = self:GetCaster():FindAbilityByName("vengefulspirit_magic_missile_custom")
	if vengefulspirit_magic_missile_custom and vengefulspirit_magic_missile_custom:GetLevel() > 0 then
		stun_duration = vengefulspirit_magic_missile_custom:GetSpecialValueFor("magic_missile_stun")
		
		damage = vengefulspirit_magic_missile_custom:GetSpecialValueFor("magic_missile_damage")

		if self:GetCaster():HasModifier("modifier_vengefulspirit_18") then
			damage = damage + (self:GetCaster():GetMana() / 100 * vengefulspirit_magic_missile_custom.modifier_vengefulspirit_18[self:GetCaster():GetTalentLevel("modifier_vengefulspirit_18")])
		end

		stun_duration = stun_duration / 100 * self:GetSpecialValueFor("stun_missile")
		damage = damage / 100 * self:GetSpecialValueFor("damage_missile")
	end

	Timers:CreateTimer(land_time, function()
		if not self:IsNull() then
			ParticleManager:DestroyParticle(ground_particle, false)
			GridNav:DestroyTreesAroundPoint(position, radius, true)
			EmitSoundOnLocationWithCaster(position, "DOTA_Item.MeteorHammer.Impact", self:GetCaster())
		
			local enemies = FindUnitsInRadius(self:GetCaster():GetTeamNumber(), position, nil, radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BUILDING + DOTA_UNIT_TARGET_BASIC, 0, FIND_ANY_ORDER, false)
			
			for _, enemy in pairs(enemies) do
                enemy:AddNewModifier(self:GetCaster(), self, "modifier_vengefulspirit_magic_missile_custom_stack_debuff", {duration = 3})
				enemy:EmitSound("DOTA_Item.MeteorHammer.Damage")
				enemy:AddNewModifier(self:GetCaster(), self, "modifier_stunned", {duration = stun_duration * (1 - enemy:GetStatusResistance())})
				ApplyDamage({ victim = enemy, damage = damage, damage_type = DAMAGE_TYPE_MAGICAL, damage_flags = DOTA_DAMAGE_FLAG_NONE, attacker = self:GetCaster(), ability = self })
			end
		end
	end)
end