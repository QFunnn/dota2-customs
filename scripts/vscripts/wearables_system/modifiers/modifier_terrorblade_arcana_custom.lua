--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_terrorblade_arcana_custom = class({})
function modifier_terrorblade_arcana_custom:IsHidden() return true end
function modifier_terrorblade_arcana_custom:IsPurgable() return false end
function modifier_terrorblade_arcana_custom:IsPurgeException() return false end
function modifier_terrorblade_arcana_custom:RemoveOnDeath() return false end

function modifier_terrorblade_arcana_custom:OnCreated()
    if not IsServer() then return end
    self.parent = self:GetParent()
    self.parent:AddDamageEvent_out(self, true)
end

function modifier_terrorblade_arcana_custom:DamageEvent_out(params)
    local target = params.unit
    if not target:IsRealHero() then return end
    local attacker = params.attacker
    if attacker.owner then
        attacker = attacker.owner
    end
    if attacker ~= self.parent then return end
    if target:IsReincarnating() then return end
    target:AddNewModifier(self.parent, nil, "modifier_terrorblade_arcana_custom_death", {duration = 5})
end

modifier_terrorblade_arcana_custom_death = class({})
function modifier_terrorblade_arcana_custom_death:IsHidden() return true end
function modifier_terrorblade_arcana_custom_death:IsPurgable() return false end
function modifier_terrorblade_arcana_custom_death:RemoveOnDeath() return false end
function modifier_terrorblade_arcana_custom_death:OnCreated()
    if not IsServer() then return end
    self.parent = self:GetParent()
    self.caster = self:GetCaster()
    self:OnRefresh()
end

function modifier_terrorblade_arcana_custom_death:OnRefresh(table)
    if not IsServer() then return end
    if self.parent:IsAlive() or self.parent:IsReincarnating() then return end
    self.interval = 0.02
    self.rgb = self.caster:GetTerrorbladeColor()
    self:SetDuration(-1, false)

    self.death_particle = ParticleManager:CreateParticle("particles/econ/items/terrorblade/terrorblade_horns_arcana/terrorblade_arcana_enemy_death_custom.vpcf", PATTACH_CUSTOMORIGIN_FOLLOW, self.parent)
    ParticleManager:SetParticleControlEnt(self.death_particle, 0, self.parent, PATTACH_POINT_FOLLOW, "attach_hitloc", self.parent:GetAbsOrigin(), true)
    ParticleManager:SetParticleControl(self.death_particle, 16, Vector(1,1,1))
    ParticleManager:SetParticleControl(self.death_particle, 15, self.rgb)
    self:AddParticle(self.death_particle, false, false, -1, false, false)

    self.current_z = self.parent:GetAbsOrigin().z
    self.delta_k = 50*self.interval
    self.ended = false
    self.timer = 0
    self.max_timer = 3
    if self.parent:GetUnitName() == "npc_dota_hero_nevermore" or self.parent:GetUnitName() == "npc_dota_hero_phantom_assassin" then
        self.max_timer = 1.5
    end
    self.slow_anim = false
    self:StartIntervalThink(self.interval)
end

function modifier_terrorblade_arcana_custom_death:OnIntervalThink()
    if not IsServer() then return end
    if self.parent:IsAlive() then
        self:Destroy()
        return
    end
    self.timer = self.timer + self.interval
    local origin = self.parent:GetAbsOrigin()
    if self.slow_anim == false then
        self.slow_anim = true
        self.parent:RemoveGesture(ACT_DOTA_DIE)
        self.parent:RemoveGesture(ACT_DOTA_DIE_SPECIAL)
        self.parent:StartGestureWithPlaybackRate(ACT_DOTA_DISABLED, 0.2)
    end
    if self:GetElapsedTime() >= 2 and self.ended == false then
        self.current_z = self.current_z + self.delta_k
        local abs = Vector(origin.x, origin.y, self.current_z)
        self.parent:SetAbsOrigin(abs)
    end
    if self.timer >= self.max_timer and self.ended == false then
        self.parent:AddNoDraw()
        self.parent:NoDraw(self)
        self.ended = true
        self:DestroyEffect()
        local particle = ParticleManager:CreateParticle("particles/econ/items/terrorblade/terrorblade_horns_arcana/terrorblade_arcana_enemy_death_custom_pop.vpcf", PATTACH_WORLDORIGIN, nil)
        ParticleManager:SetParticleControl(particle, 0, origin + Vector(0, 0, 100))
        ParticleManager:ReleaseParticleIndex(particle)
    end
end

function modifier_terrorblade_arcana_custom_death:DestroyEffect()
    if self.death_particle then
        ParticleManager:DestroyParticle(self.death_particle, false)
        ParticleManager:ReleaseParticleIndex(self.death_particle)
        self.death_particle = nil
    end
end

function modifier_terrorblade_arcana_custom_death:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_SUPPRESS_FULLSCREEN_DEATH_FX
    }
end

function modifier_terrorblade_arcana_custom_death:GetModifierSuppressFullscreenDeathFX()
    return 1
end

function modifier_terrorblade_arcana_custom_death:OnDestroy()
    if not IsServer() then return end
    self:DestroyEffect()
    self.parent:RemoveNoDraw()
    self.parent:RemoveGesture(ACT_DOTA_FLAIL)
end