--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_kunkka_torrent_storm_custom", "abilities/kunkka_torrent_storm_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_kunkka_torrent_custom_damage", "abilities/kunkka_torrent_storm_custom", LUA_MODIFIER_MOTION_NONE)

kunkka_torrent_storm_custom = class({})

function kunkka_torrent_storm_custom:GetAOERadius()
	return self:GetSpecialValueFor("torrent_max_distance")
end

function kunkka_torrent_storm_custom:OnSpellStart()
	if not IsServer() then return end
	local duration = self:GetSpecialValueFor("torrent_duration")
	local point = self:GetCursorPosition()
	CreateModifierThinker(self:GetCaster(), self, "modifier_kunkka_torrent_storm_custom", {duration = duration}, point, self:GetCaster():GetTeamNumber(), false)
end

modifier_kunkka_torrent_storm_custom = class({})

function modifier_kunkka_torrent_storm_custom:IsHidden() return false end
function modifier_kunkka_torrent_storm_custom:IsPurgable() return false end

function modifier_kunkka_torrent_storm_custom:OnCreated()
	if not IsServer() then return end
    self.ability = self:GetAbility()
    self.parent = self:GetParent()
	self.delay_spawn = self.ability:GetSpecialValueFor("torrent_interval")
	self.radius = self.ability:GetSpecialValueFor("torrent_max_distance")
	self.duration = self.ability:GetSpecialValueFor("torrent_duration")
	self.timers = {}
	self:StartTorrentStorm()
end

function modifier_kunkka_torrent_storm_custom:OnRefresh()
	self:StartTorrentStorm()
end

function modifier_kunkka_torrent_storm_custom:StartTorrentStorm()
	
	local position = self.parent:GetAbsOrigin()
	local count = self.duration / self.delay_spawn
	if #self.timers > 0 then 
		for _,timer in pairs(self.timers) do
			if timer then 
				Timers:RemoveTimer(timer)
			end
		end
	end
	for i = 0, count do
		self.timers[i] = Timers:CreateTimer(self.delay_spawn * i, function()
			local random_point = position + RandomVector(RandomInt(0, self.radius))
			self.ability:StartTorrent(random_point)
		end)
	end
end

function kunkka_torrent_storm_custom:StartTorrent(new_point)
	if not IsServer() then return end
	local radius = self:GetSpecialValueFor("radius")
	local movespeed_bonus = self:GetSpecialValueFor("movespeed_bonus")
	local slow_duration = self:GetSpecialValueFor("slow_duration")
	local stun_duration = self:GetSpecialValueFor("stun_duration")
	local delay = self:GetSpecialValueFor("delay")
	local torrent_damage = self:GetSpecialValueFor("torrent_damage")
	local damage_tick_interval = self:GetSpecialValueFor("damage_tick_interval")
	local point = new_point
	EmitSoundOnLocationForAllies(point, "Ability.pre.Torrent", self:GetCaster())

	local bubbles_pfx = ParticleManager:CreateParticleForTeam("particles/units/heroes/hero_kunkka/kunkka_spell_torrent_bubbles.vpcf", PATTACH_WORLDORIGIN, nil, self:GetCaster():GetTeamNumber())
	ParticleManager:SetParticleControl(bubbles_pfx, 0, point)
	ParticleManager:SetParticleControl(bubbles_pfx, 1, Vector(radius,0,0))

	AddFOWViewer(self:GetCaster():GetTeamNumber(), point, radius, delay+0.5, false)

	Timers:CreateTimer(delay, function()
		if bubbles_pfx then
			ParticleManager:DestroyParticle(bubbles_pfx, true )
			ParticleManager:ReleaseParticleIndex( bubbles_pfx )
		end
		self:CreateTorrent(point)
	end)
end

function kunkka_torrent_storm_custom:CreateTorrent(origin)
	if not IsServer() then return end

	local radius = self:GetSpecialValueFor("radius")
	local stun_duration = self:GetSpecialValueFor("stun_duration")

	local particle = "particles/units/heroes/hero_kunkka/kunkka_spell_torrent_splash.vpcf"

	local torrent_fx = ParticleManager:CreateParticle(particle, PATTACH_WORLDORIGIN, nil)
	ParticleManager:SetParticleControl(torrent_fx, 0, origin)
	ParticleManager:SetParticleControl(torrent_fx, 1, Vector(radius,0,0))
	ParticleManager:ReleaseParticleIndex(torrent_fx)

	self:GetCaster():EmitSound("Ability.Torrent")

	local knockback =
	{
		should_stun = 1,
		knockback_duration = stun_duration,
		duration = stun_duration,
		knockback_distance = 0,
		knockback_height = 400,
	}

	local enemies = FindUnitsInRadius(self:GetCaster():GetTeamNumber(), origin, nil, radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 0, 0, false)
	for _,enemy in pairs(enemies) do
		self:GetCaster():EmitSound("Hero_Kunkka.TidalWave.Target")
		enemy:RemoveModifierByName("modifier_knockback")
		enemy:AddNewModifier(self:GetCaster(), self, "modifier_kunkka_torrent_custom_damage", {duration = stun_duration})
		enemy:AddNewModifier(self:GetCaster(), self, "modifier_knockback", knockback)
	end
end

modifier_kunkka_torrent_custom_damage = class({})

function modifier_kunkka_torrent_custom_damage:IsHidden() return true end
function modifier_kunkka_torrent_custom_damage:IsPurgable() return false end

function modifier_kunkka_torrent_custom_damage:OnCreated()
	if not IsServer() then return end
    self.ability = self:GetAbility()
    self.parent = self:GetParent()
    self.caster = self:GetCaster()
	self.slow_duration = self.ability:GetSpecialValueFor("slow_duration")
	self.torrent_damage = self.ability:GetSpecialValueFor("torrent_damage")
	self.damage_tick_interval = self.ability:GetSpecialValueFor("damage_tick_interval")
	self.damage = self.torrent_damage * self.damage_tick_interval
	self:StartIntervalThink(self.damage_tick_interval)
end

function modifier_kunkka_torrent_custom_damage:OnIntervalThink()
	if not IsServer() then return end
	
	local damage = {
		victim = self.parent,
		attacker = self.caster,
		damage = self.damage,
		damage_type = DAMAGE_TYPE_MAGICAL,
		ability = self.ability
	}
	
	ApplyDamage(damage)
end

function modifier_kunkka_torrent_custom_damage:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE
	}
end

function modifier_kunkka_torrent_custom_damage:GetModifierMoveSpeedBonus_Percentage()
	return self.ability:GetSpecialValueFor("movespeed_bonus")
end