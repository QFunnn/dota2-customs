--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_kunkka_torrent_custom_damage", "heroes/npc_dota_hero_kunkka_custom/kunkka_torrent_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_kunkka_torrent_custom_debuff", "heroes/npc_dota_hero_kunkka_custom/kunkka_torrent_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_kunkka_torrent_custom_talent", "heroes/npc_dota_hero_kunkka_custom/kunkka_torrent_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_kunkka_torrent_custom_talent_cooldown", "heroes/npc_dota_hero_kunkka_custom/kunkka_torrent_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_kunkka_torrent_custom_puddle", "heroes/npc_dota_hero_kunkka_custom/kunkka_torrent_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_kunkka_torrent_custom_puddle_buff", "heroes/npc_dota_hero_kunkka_custom/kunkka_torrent_custom", LUA_MODIFIER_MOTION_NONE)

kunkka_torrent_custom = class({})

function kunkka_torrent_custom:Precache(context)
    if self:GetCaster() and self:GetCaster():IsIllusion() then return end
    PrecacheResource( "particle", "particles/units/heroes/hero_kunkka/kunkka_spell_torrent_bubbles.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_kunkka/kunkka_spell_torrent_bubbles_bonus.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_kunkka/kunkka_spell_torrent_splash.vpcf", context )
    PrecacheResource( "particle", "particles/econ/items/kunkka/kunkka_weapon_whaleblade_retro/kunkka_spell_torrent_retro_splash_whaleblade.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_kunkka/kunkka_spell_torrent_splash_bonus.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_slardar/slardar_water_puddle_test.vpcf", context )
end

kunkka_torrent_custom.modifier_kunkka_1_cooldown = {45,30,15}
kunkka_torrent_custom.modifier_kunkka_1_chance = 25
kunkka_torrent_custom.modifier_kunkka_2 = {80,120,160}
kunkka_torrent_custom.modifier_kunkka_3 = {-0.7,-1,4}
kunkka_torrent_custom.modifier_kunkka_7_radius = 80
kunkka_torrent_custom.modifier_kunkka_7_regen = 80
kunkka_torrent_custom.modifier_kunkka_7_duration = 5

function kunkka_torrent_custom:GetAOERadius()
	local bonus = 0
	if self:GetCaster():HasModifier("modifier_kunkka_7") then
		bonus = self.modifier_kunkka_7_radius
	end
	return self:GetSpecialValueFor("radius") + bonus
end

function kunkka_torrent_custom:GetIntrinsicModifierName()
	return "modifier_kunkka_torrent_custom_talent"
end

function kunkka_torrent_custom:OnSpellStart(new_point)
	if not IsServer() then return end
	local radius = self:GetSpecialValueFor("radius")
	local movespeed_bonus = self:GetSpecialValueFor("movespeed_bonus")
	local slow_duration = self:GetSpecialValueFor("slow_duration")
	local stun_duration = self:GetSpecialValueFor("stun_duration")
	local delay = self:GetSpecialValueFor("delay")
	local torrent_damage = self:GetSpecialValueFor("torrent_damage")
	local damage_tick_interval = self:GetSpecialValueFor("damage_tick_interval")

	local point = self:GetCursorPosition()

	if self:GetCaster():HasModifier("modifier_kunkka_7") then
		radius = radius + self.modifier_kunkka_7_radius
	end

	if self:GetCaster():HasModifier("modifier_kunkka_3") then
		delay = delay + self.modifier_kunkka_3[self:GetCaster():GetTalentLevel("modifier_kunkka_3")]
	end

	if new_point ~= nil then
		point = new_point
	end

	EmitSoundOnLocationForAllies(point, "Ability.pre.Torrent", self:GetCaster())

	local bubbles_pfx = ParticleManager:CreateParticleForTeam("particles/units/heroes/hero_kunkka/kunkka_spell_torrent_bubbles.vpcf", PATTACH_WORLDORIGIN, nil, self:GetCaster():GetTeamNumber())
	ParticleManager:SetParticleControl(bubbles_pfx, 0, point)
	ParticleManager:SetParticleControl(bubbles_pfx, 1, Vector(radius,0,0))

	local bonus_particle = nil

	if self:GetCaster():HasModifier("modifier_kunkka_7") then
		local bonus_particle = ParticleManager:CreateParticleForTeam("particles/units/heroes/hero_kunkka/kunkka_spell_torrent_bubbles_bonus.vpcf", PATTACH_WORLDORIGIN, nil, self:GetCaster():GetTeamNumber())
		ParticleManager:SetParticleControl(bonus_particle, 0, point)
		ParticleManager:SetParticleControl(bonus_particle, 1, Vector(radius,0,0))
	end

	AddFOWViewer(self:GetCaster():GetTeamNumber(), point, radius, delay+0.5, false)

	Timers:CreateTimer(delay, function()
		if bubbles_pfx then
			ParticleManager:DestroyParticle(bubbles_pfx, true )
			ParticleManager:ReleaseParticleIndex( bubbles_pfx )
		end
		if bonus_particle then
			ParticleManager:DestroyParticle(bonus_particle, true )
			ParticleManager:ReleaseParticleIndex( bonus_particle )
		end
		self:CreateTorrent(point)
	end)
end

function kunkka_torrent_custom:CreateTorrent(origin)
	if not IsServer() then return end

	local radius = self:GetSpecialValueFor("radius")
	local stun_duration = self:GetSpecialValueFor("stun_duration")

	if self:GetCaster():HasModifier("modifier_kunkka_7") then
		radius = radius + self.modifier_kunkka_7_radius
	end

	local particle = "particles/units/heroes/hero_kunkka/kunkka_spell_torrent_splash.vpcf"

	if self:GetCaster():HasModifier("modifier_kunkka_2") then
		particle = "particles/econ/items/kunkka/kunkka_weapon_whaleblade_retro/kunkka_spell_torrent_retro_splash_whaleblade.vpcf"
	end

	local torrent_fx = ParticleManager:CreateParticle(particle, PATTACH_WORLDORIGIN, nil)
	ParticleManager:SetParticleControl(torrent_fx, 0, origin)
	ParticleManager:SetParticleControl(torrent_fx, 1, Vector(radius,0,0))
	ParticleManager:ReleaseParticleIndex(torrent_fx)

	if self:GetCaster():HasModifier("modifier_kunkka_7") then
		local torrent_fx = ParticleManager:CreateParticle("particles/units/heroes/hero_kunkka/kunkka_spell_torrent_splash_bonus.vpcf", PATTACH_WORLDORIGIN, nil)
		ParticleManager:SetParticleControl(torrent_fx, 0, origin)
		ParticleManager:SetParticleControl(torrent_fx, 1, Vector(radius,0,0))
		ParticleManager:ReleaseParticleIndex(torrent_fx)
	end


	if self:GetCaster():HasModifier("modifier_kunkka_7") then
		CreateModifierThinker(self:GetCaster(), self, "modifier_kunkka_torrent_custom_puddle", {duration = self.modifier_kunkka_7_duration}, origin, self:GetCaster():GetTeamNumber(), false)
	end

	EmitSoundOnLocationWithCaster(origin, "Ability.Torrent", self:GetCaster())

	local knockback =
	{
		should_stun = 1,
		knockback_duration = stun_duration,
		duration = stun_duration,
		knockback_distance = 0,
		knockback_height = 400,
	}

    local ability = self
    local caster = self:GetCaster()
    local dmg_duration = stun_duration
    local damage_tick_interval = self:GetSpecialValueFor("damage_tick_interval")

    Timers:CreateTimer(FrameTime(), function()
        local enemies = FindUnitsInRadius(caster:GetTeamNumber(), origin, nil, radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 0, 0, false)
	    for _,enemy in pairs(enemies) do
            enemy:AddNewModifier(caster, ability, "modifier_kunkka_torrent_custom_damage", {duration = math.min(dmg_duration, damage_tick_interval)})
        end
        dmg_duration = dmg_duration - FrameTime()
        if dmg_duration <= 0 then return end
        return FrameTime()
    end)

	local enemies = FindUnitsInRadius(self:GetCaster():GetTeamNumber(), origin, nil, radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 0, 0, false)
	for _,enemy in pairs(enemies) do
		self:GetCaster():EmitSound("Hero_Kunkka.TidalWave.Target")
		enemy:RemoveModifierByName("modifier_knockback")
		enemy:AddNewModifier(self:GetCaster(), self, "modifier_knockback", knockback)
	end
end

modifier_kunkka_torrent_custom_damage = class({})

function modifier_kunkka_torrent_custom_damage:IsHidden() return true end

function modifier_kunkka_torrent_custom_damage:OnCreated()
	if not IsServer() then return end
	self.slow_duration = self:GetAbility():GetSpecialValueFor("slow_duration")
	self.torrent_damage = self:GetAbility():GetSpecialValueFor("torrent_damage")
	if self:GetCaster():HasModifier("modifier_kunkka_2") then
		self.torrent_damage = self.torrent_damage + (self:GetCaster():GetHealthRegen() / 100 * self:GetAbility().modifier_kunkka_2[self:GetCaster():GetTalentLevel("modifier_kunkka_2")])
	end
    self.torrent_damage = self.torrent_damage / self:GetAbility():GetSpecialValueFor("stun_duration")
	self.damage_tick_interval = self:GetAbility():GetSpecialValueFor("damage_tick_interval")
	self.damage = self.torrent_damage * self.damage_tick_interval
	self:StartIntervalThink(self.damage_tick_interval)
end

function modifier_kunkka_torrent_custom_damage:OnIntervalThink()
	if not IsServer() then return end
    self:GetParent():AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_kunkka_torrent_custom_debuff", {duration = self.slow_duration})
	ApplyDamage({victim = self:GetParent(), attacker = self:GetCaster(), ability = self:GetAbility(), damage = self.damage, damage_type = DAMAGE_TYPE_MAGICAL})
end

function modifier_kunkka_torrent_custom_damage:OnDestroy()
	if not IsServer() then return end
	self:GetParent():AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_kunkka_torrent_custom_debuff", {duration = self.slow_duration})
end

modifier_kunkka_torrent_custom_debuff = class({})

function modifier_kunkka_torrent_custom_debuff:OnCreated()
	self.movespeed_bonus = self:GetAbility():GetSpecialValueFor("movespeed_bonus")
end

function modifier_kunkka_torrent_custom_debuff:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE
	}
end

function modifier_kunkka_torrent_custom_debuff:GetModifierMoveSpeedBonus_Percentage()
	return self.movespeed_bonus
end

modifier_kunkka_torrent_custom_talent = class({})
function modifier_kunkka_torrent_custom_talent:IsHidden() return true end
function modifier_kunkka_torrent_custom_talent:IsPurgable() return false end
function modifier_kunkka_torrent_custom_talent:IsPurgeException() return false end
function modifier_kunkka_torrent_custom_talent:DeclareFunctions() return { } end
function modifier_kunkka_torrent_custom_talent:OnAttackLanded(params)
	if not IsServer() then return end
	if params.target ~= self:GetParent() then return end
	if params.attacker == params.target then return end
	if not self:GetParent():HasModifier("modifier_kunkka_1") then return end
	if self:GetParent():HasModifier("modifier_kunkka_torrent_custom_talent_cooldown") then return end
	if RollPercentage(self:GetAbility().modifier_kunkka_1_chance) then
		self:GetCaster():AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_kunkka_torrent_custom_talent_cooldown", {duration = self:GetAbility().modifier_kunkka_1_cooldown[self:GetCaster():GetTalentLevel("modifier_kunkka_1")]})
		self:GetAbility():OnSpellStart(params.attacker:GetAbsOrigin())
	end
end

modifier_kunkka_torrent_custom_talent_cooldown = class({})
function modifier_kunkka_torrent_custom_talent_cooldown:IsPurgable() return false end
function modifier_kunkka_torrent_custom_talent_cooldown:IsPurgeException() return false end
function modifier_kunkka_torrent_custom_talent_cooldown:IsDebuff() return true end
function modifier_kunkka_torrent_custom_talent_cooldown:GetTexture() return "kunkka_1" end

modifier_kunkka_torrent_custom_puddle = class({})
function modifier_kunkka_torrent_custom_puddle:IsHidden() return true end
function modifier_kunkka_torrent_custom_puddle:IsPurgable() return false end

function modifier_kunkka_torrent_custom_puddle:OnCreated(params)
	if not IsServer() then return end
	self.radius = self:GetAbility():GetSpecialValueFor("radius")
	if self:GetCaster():HasModifier("modifier_kunkka_7") then
		self.radius = self.radius + self:GetAbility().modifier_kunkka_7_radius
	end
	local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_slardar/slardar_water_puddle_test.vpcf", PATTACH_WORLDORIGIN, nil)
	ParticleManager:SetParticleControl(particle, 0, self:GetParent():GetAbsOrigin())
	ParticleManager:SetParticleControl(particle, 1, Vector(self.radius,1,1))
	self:AddParticle(particle, false, false, -1, false, false)
end

function modifier_kunkka_torrent_custom_puddle:IsAura()
    return true
end

function modifier_kunkka_torrent_custom_puddle:GetModifierAura()
    return "modifier_kunkka_torrent_custom_puddle_buff"
end

function modifier_kunkka_torrent_custom_puddle:GetAuraRadius()
    return self.radius
end

function modifier_kunkka_torrent_custom_puddle:GetAuraDuration()
    return 0.5
end

function modifier_kunkka_torrent_custom_puddle:GetAuraSearchTeam()
    return DOTA_UNIT_TARGET_TEAM_FRIENDLY
end

function modifier_kunkka_torrent_custom_puddle:GetAuraSearchType()
    return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
end

function modifier_kunkka_torrent_custom_puddle:GetAuraSearchFlags()
    return DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES + DOTA_UNIT_TARGET_FLAG_INVULNERABLE
end

modifier_kunkka_torrent_custom_puddle_buff = class({})
function modifier_kunkka_torrent_custom_puddle_buff:IsPurgable() return false end
function modifier_kunkka_torrent_custom_puddle_buff:IsPurgeException() return false end

function modifier_kunkka_torrent_custom_puddle_buff:DeclareFunctions() 
    return 
    {
        MODIFIER_PROPERTY_RESTORATION_AMPLIFICATION,
    } 
end

function modifier_kunkka_torrent_custom_puddle_buff:GetModifierPropertyRestorationAmplification()
    return self:GetAbility().modifier_kunkka_7_regen
end

LinkLuaModifier("modifier_kunkka_torrent_storm_custom", "heroes/npc_dota_hero_kunkka_custom/kunkka_torrent_custom", LUA_MODIFIER_MOTION_NONE)

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
	self.timers = {}
	self:StartTorrentStorm()
end

function modifier_kunkka_torrent_storm_custom:OnRefresh()
	self:StartTorrentStorm()
end

function modifier_kunkka_torrent_storm_custom:StartTorrentStorm()
	if not IsServer() then return end
	local caster = self:GetParent()
	local delay_spawn = self:GetAbility():GetSpecialValueFor("torrent_interval")
	local radius = self:GetAbility():GetSpecialValueFor("torrent_max_distance")
	local duration = self:GetAbility():GetSpecialValueFor("torrent_duration")

	local count = duration / delay_spawn

	if #self.timers > 0 then 
		for _,timer in pairs(self.timers) do
			if timer then 
				Timers:RemoveTimer(timer)
			end
		end
	end

	for i = 0, count do
		self.timers[i] = Timers:CreateTimer(delay_spawn * i, function()
			if not caster:IsAlive() then
				return
			end
			local random_point = caster:GetAbsOrigin() + RandomVector(RandomInt(0, radius))
			local kunkka_torrent_custom = self:GetCaster():FindAbilityByName("kunkka_torrent_custom")
			if kunkka_torrent_custom then
				kunkka_torrent_custom:OnSpellStart(random_point)
			end
		end)
	end
end