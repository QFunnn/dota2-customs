--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_slardar_stun", "abilities/npc_slardar_stun.lua", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_slardar_stun_cd", "abilities/npc_slardar_stun.lua", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_stun_aura", "abilities/npc_slardar_stun.lua", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_stun_thinker", "abilities/npc_slardar_stun.lua", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_stun_kdr", "abilities/npc_slardar_stun.lua", LUA_MODIFIER_MOTION_NONE)


npc_slardar_stun = class({})

function npc_slardar_stun:OnSpellStart()
    self.damage = self:GetSpecialValueFor("damage")
    self.kdr = self:GetSpecialValueFor("kdr")
    self.stun = self:GetSpecialValueFor("stun")
    self.radius = self:GetSpecialValueFor("radius")
    self.duration = self:GetSpecialValueFor("duration")

	local caster = self:GetCaster()
	if not IsValidEntity(caster) then return end

    caster:AddNewModifier(caster, self, "modifier_slardar_stun_cd", {
        duration = self:GetCooldownTimeRemaining()
    })

    if not IsServer() then
        return
    end

    caster:EmitSound("Hero_Slardar.Slithereen_Crush")
    local trail_pfx = ParticleManager:CreateParticle("particles/units/heroes/hero_slardar/slardar_crush.vpcf",
        PATTACH_ABSORIGIN, caster)
    ParticleManager:SetParticleControl(trail_pfx, 1, Vector(self.radius, 0, 0))
    ParticleManager:ReleaseParticleIndex(trail_pfx)

    local enemy = FindUnitsInRadius(caster:GetTeamNumber(), caster:GetAbsOrigin(), nil, self.radius,
        DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 0, FIND_CLOSEST, false)
    if #enemy > 0 then
        for _, i in pairs(enemy) do
            if IsValidEntity(i) and not i:IsMagicImmune() then
                DoDamage({
                    victim = i,
                    attacker = caster,
                    ability = self,
                    damage = self.damage,
                    damage_type = DAMAGE_TYPE_PHYSICAL
                })
                i:AddNewModifier(caster, self, "modifier_stunned", {
                    duration = self.stun * (1 - i:GetStatusResistance())
                })
            end
        end
    end

    CreateModifierThinker(caster, self, "modifier_stun_thinker", {
        duration = self.duration
    }, caster:GetAbsOrigin(), caster:GetTeamNumber(), false)

end









modifier_stun_thinker = class({})

function modifier_stun_thinker:IsHidden() return false end

function modifier_stun_thinker:IsPurgable() return false end

function modifier_stun_thinker:IsAura() return true end

function modifier_stun_thinker:GetAuraDuration() return 0.1 end

function modifier_stun_thinker:GetAuraRadius()
    return 600
end

function modifier_stun_thinker:OnCreated(table)
    if not IsServer() then
        return
    end
    self.puddle_particle = ParticleManager:CreateParticle("particles/units/heroes/hero_slardar/slardar_water_puddle.vpcf", PATTACH_WORLDORIGIN, self:GetParent())
    ParticleManager:SetParticleControl(self.puddle_particle, 0, self:GetParent():GetAbsOrigin())
    ParticleManager:SetParticleControl(self.puddle_particle, 1, Vector(600, 0, 0))
    self:AddParticle(self.puddle_particle, false, false, -1, false, false)
end

function modifier_stun_thinker:OnDestroy()
    if not IsServer() then
        return
    end
    ParticleManager:DestroyParticle(self.puddle_particle, true)
    ParticleManager:ReleaseParticleIndex(self.puddle_particle)
end


function modifier_stun_thinker:GetAuraSearchTeam() return DOTA_UNIT_TARGET_TEAM_FRIENDLY end

function modifier_stun_thinker:GetAuraSearchType() return DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_HERO end

function modifier_stun_thinker:GetModifierAura() return "modifier_stun_kdr" end



modifier_stun_kdr = class({})
function modifier_stun_kdr:IsHidden() return false end
function modifier_stun_kdr:IsPurgable() return false end

function modifier_stun_kdr:OnTooltip() return self.kdr end
function modifier_stun_kdr:OnTooltip2() return self.heal end

function modifier_stun_kdr:GetTexture() return "slardar_slithereen_crush" end
function modifier_stun_kdr:IsDebuff() return false end
function modifier_stun_kdr:DeclareFunctions()
    return {
		MODIFIER_PROPERTY_COOLDOWN_PERCENTAGE,
		MODIFIER_PROPERTY_TOOLTIP,
		MODIFIER_PROPERTY_TOOLTIP2,
        MODIFIER_PROPERTY_HEALTH_REGEN_PERCENTAGE
	}
end




function modifier_stun_kdr:OnCreated(table)
    self.kdr = 0
    self.heal = 0

	local ability = self:GetAbility()
	if IsValidEntity(ability) then
		self.kdr = ability:GetSpecialValueFor("kdr")
		self.heal = ability:GetSpecialValueFor("heal")
	end
end


function modifier_stun_kdr:GetModifierHealthRegenPercentage() return self.heal end

function modifier_stun_kdr:GetModifierPercentageCooldown() return self.kdr end





modifier_slardar_stun_cd = class({})

function modifier_slardar_stun_cd:IsHidden() return false end
function modifier_slardar_stun_cd:IsPurgable() return false end