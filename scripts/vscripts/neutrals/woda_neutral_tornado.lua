--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_woda_neutral_tornado", "neutrals/woda_neutral_tornado", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_neutral_cast", "neutrals/modifier_neutral_cast", LUA_MODIFIER_MOTION_NONE)

woda_neutral_tornado = class({})

function woda_neutral_tornado:Precache(context)
    PrecacheResource( "particle", "particles/neutral_fx/tornado_ambient.vpcf", context )
end

function woda_neutral_tornado:OnSpellStart()
	if not IsServer() then return end
	local target = self:GetCursorTarget()
	self:GetCaster():StartGestureWithPlaybackRate(ACT_DOTA_CAST_ABILITY_1, 1)
	self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_neutral_cast", {})


	Timers:CreateTimer(0, function()
		if not self:GetCaster():IsAlive() then return end
		self:GetCaster():EmitSound("n_creep_Wildkin.SummonTornado")
		local tornado = CreateUnitByName("npc_dota_enraged_wildkin_tornado", target:GetAbsOrigin(), true, nil, nil, DOTA_TEAM_NEUTRALS)
		tornado:SetOwner(self:GetCaster())
		self:GetCaster():EmitSound("n_creep_Wildkin.SummonTornado")
		tornado:AddNewModifier(self:GetCaster(), self, "modifier_woda_neutral_tornado", { duration = self:GetSpecialValueFor("duration") })
		self:GetCaster():RemoveModifierByName("modifier_neutral_cast")
	end)
end

modifier_woda_neutral_tornado = class({})

function modifier_woda_neutral_tornado:OnCreated()
	if not IsServer() then return end
	self.radius = self:GetAbility():GetSpecialValueFor("radius")
	self.damage = self:GetAbility():GetSpecialValueFor("damage") * 0.25
	local particle = ParticleManager:CreateParticle("particles/neutral_fx/tornado_ambient.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
	ParticleManager:SetParticleControl(particle, 0, self:GetParent():GetAbsOrigin())
	self:AddParticle(particle, false, false, -1, false, false)
	self:GetParent():EmitSound("n_creep_Wildkin.Tornado")
	self:StartIntervalThink(0.25)
end

function modifier_woda_neutral_tornado:OnIntervalThink()
	if not IsServer() then return end
	local enemies = FindUnitsInRadius( self:GetCaster():GetTeamNumber(), self:GetParent():GetOrigin(), nil, self.radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 0, 0, false )
	for _, enemy in pairs(enemies) do
		local damage = enemy:GetMaxHealth() / 100 * self.damage
		ApplyDamage({victim = enemy, attacker = self:GetCaster(), damage = damage, damage_type = DAMAGE_TYPE_MAGICAL, ability = self:GetAbility()})
	end
end

function modifier_woda_neutral_tornado:CheckState()
	return {
		[MODIFIER_STATE_INVULNERABLE] = true,
		[MODIFIER_STATE_NO_HEALTH_BAR] = true,
		[MODIFIER_STATE_OUT_OF_GAME] = true,
	}
end

function modifier_woda_neutral_tornado:OnDestroy()
	if not IsServer() then return end
	self:GetParent():StopSound("n_creep_Wildkin.Tornado")
    self:GetParent():Destroy()
end