--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_generic_ring_lua_terrorblade", "heroes/npc_dota_hero_terrorblade_custom/terrorblade_terror_wave_custom", LUA_MODIFIER_MOTION_NONE)

terrorblade_terror_wave_custom = class({})

function terrorblade_terror_wave_custom:OnSpellStart(duration)
    local fear_duration = self:GetSpecialValueFor("fear_duration")
    local scepter_radius = self:GetSpecialValueFor("scepter_radius")
    local scepter_speed = self:GetSpecialValueFor("scepter_speed")
    local damage = self:GetSpecialValueFor("damage")
    local scepter_spawn_delay = self:GetSpecialValueFor("scepter_spawn_delay")
    local scepter_meta_duration = self:GetSpecialValueFor("scepter_meta_duration")

    local delay = FrameTime()
    local effect_cast = ParticleManager:CreateParticle( "particles/units/heroes/hero_terrorblade/terrorblade_scepter.vpcf", PATTACH_WORLDORIGIN, nil )
    ParticleManager:SetParticleControl( effect_cast, 0, self:GetCaster():GetAbsOrigin())
    ParticleManager:SetParticleControl( effect_cast, 1, Vector( scepter_speed, scepter_speed, scepter_speed ) )
    if self:GetCaster():HasModifier("modifier_terrorblade_16") then
        ParticleManager:SetParticleControl( effect_cast, 15, Vector( 0, 255, 0 ) )
        ParticleManager:SetParticleControl( effect_cast, 16, Vector( 1, 1, 1 ) )
    end

    local pulse = self:GetCaster():AddNewModifier( self:GetCaster(),  self, 
        "modifier_generic_ring_lua_terrorblade", 
        {
            end_radius = scepter_radius,
            speed = scepter_speed,
            target_team = DOTA_UNIT_TARGET_TEAM_ENEMY,
            target_type = DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
        } 
    )

    pulse:SetCallback( function( enemy )
        print(enemy)
        ApplyDamage({attacker = self:GetCaster(), victim = enemy, damage = damage, damage_type = DAMAGE_TYPE_MAGICAL, ability = self})
    end)

    Timers:CreateTimer(scepter_radius/scepter_speed,function()
        ParticleManager:DestroyParticle(effect_cast, false)
        ParticleManager:ReleaseParticleIndex(effect_cast)
    end)
    local terrorblade_metamorphosis_custom = self:GetCaster():FindAbilityByName("terrorblade_metamorphosis_custom")
    if self:GetCaster():HasModifier("modifier_terrorblade_16") then
        local terrorblade_demon_hunter = self:GetCaster():FindAbilityByName("terrorblade_demon_hunter")
        self:GetCaster():AddNewModifier(self:GetCaster(), terrorblade_demon_hunter, "modifier_terrorblade_demon_hunter", {duration = scepter_meta_duration})
    else
        if self:GetCaster():HasModifier("modifier_terrorblade_21") then return end
        self:GetCaster():AddNewModifier(self:GetCaster(), terrorblade_metamorphosis_custom, "modifier_custom_terrorblade_metamorphosis_transform", {duration = delay, meta_duration = scepter_meta_duration})
        for _, unit in pairs(FindUnitsInRadius(self:GetCaster():GetTeamNumber(), self:GetCaster():GetAbsOrigin(), nil, terrorblade_metamorphosis_custom:GetSpecialValueFor("metamorph_aura_tooltip"), DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_HERO, DOTA_UNIT_TARGET_FLAG_NOT_CREEP_HERO + DOTA_UNIT_TARGET_FLAG_PLAYER_CONTROLLED + DOTA_UNIT_TARGET_FLAG_INVULNERABLE + DOTA_UNIT_TARGET_FLAG_OUT_OF_WORLD, FIND_ANY_ORDER, false)) do
            if unit ~= self:GetCaster() and unit:IsIllusion() and unit:GetPlayerOwnerID() == self:GetCaster():GetPlayerOwnerID() and unit:GetName() == self:GetCaster():GetName() then
                unit:AddNewModifier(self:GetCaster(), terrorblade_metamorphosis_custom, "modifier_custom_terrorblade_metamorphosis_transform", {duration = delay, meta_duration = -1})
            end
        end
    end
end

modifier_generic_ring_lua_terrorblade = class({})

function modifier_generic_ring_lua_terrorblade:IsHidden()
	return true
end

function modifier_generic_ring_lua_terrorblade:IsDebuff()
	return false
end

function modifier_generic_ring_lua_terrorblade:IsStunDebuff()
	return false
end

function modifier_generic_ring_lua_terrorblade:IsPurgable()
	return false
end

function modifier_generic_ring_lua_terrorblade:RemoveOnDeath()
	return false
end

function modifier_generic_ring_lua_terrorblade:GetAttributes()
	return MODIFIER_ATTRIBUTE_MULTIPLE
end

function modifier_generic_ring_lua_terrorblade:OnCreated( kv )
	if not IsServer() then return end
	self.origin = self:GetParent():GetAbsOrigin()
	self.start_radius = kv.start_radius or 0
	self.end_radius = kv.end_radius or 0
	self.width = kv.width or 100
	self.speed = kv.speed or 0
	self.outward = self.end_radius>=self.start_radius
	if not self.outward then
		self.speed = -self.speed
	end

	self.target_team = kv.target_team or 0
	self.target_type = kv.target_type or 0
	self.target_flags = kv.target_flags or 0

	self.IsCircle = kv.IsCircle or 1

	self.targets = {}
end

function modifier_generic_ring_lua_terrorblade:OnDestroy()
	if self.EndCallback then
		self.EndCallback()
	end
	if not IsServer() then return end
	if self:GetParent():GetClassname()=="npc_dota_thinker" then
		UTIL_Remove( self:GetParent() )
	end
end

function modifier_generic_ring_lua_terrorblade:SetCallback( callback )
	self.Callback = callback
	self:StartIntervalThink( 0.03 )
	self:OnIntervalThink()
end

function modifier_generic_ring_lua_terrorblade:SetEndCallback( callback )
	self.EndCallback = callback
end

function modifier_generic_ring_lua_terrorblade:OnIntervalThink()
	local radius = self.start_radius + self.speed * self:GetElapsedTime()
	if not self.outward and radius<self.end_radius then
		self:Destroy()
		return
	elseif self.outward and radius>self.end_radius then
		self:Destroy()
		return
	end
    local fear_duration = self:GetAbility():GetSpecialValueFor("fear_duration")
	local targets = FindUnitsInRadius( self:GetParent():GetTeamNumber(), self.origin, nil, radius, self.target_team, self.target_type, DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES, 0, false )
	for _,target in pairs(targets) do
		if not self.targets[target] then
			if ((not self.IsCircle) or (target:GetOrigin()-self.origin):Length2D()>(radius-self.width))  then
				self.targets[target] = true
				local caster = self:GetParent()
				if not target:IsMagicImmune() then 
					target:AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_terrorblade_fear", {duration = fear_duration * (1 - target:GetStatusResistance())})
				end
                self.Callback( target )
			end
		end
	end
end