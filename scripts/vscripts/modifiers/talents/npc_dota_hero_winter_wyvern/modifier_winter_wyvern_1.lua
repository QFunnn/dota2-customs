--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_winter_wyvern_1=class({})

function modifier_winter_wyvern_1:IsHidden() return true end
function modifier_winter_wyvern_1:IsPurgable() return false end
function modifier_winter_wyvern_1:IsPurgeException() return false end
function modifier_winter_wyvern_1:RemoveOnDeath() return false end

function modifier_winter_wyvern_1:OnCreated()
    self.bonus = {30}
	if not IsServer() then return end
	self:SetStackCount(1)
end

function modifier_winter_wyvern_1:OnRefresh()
    self.bonus = {30}
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
end

function modifier_winter_wyvern_1:DeclareFunctions()
    return
    {
         
    }
end

function modifier_winter_wyvern_1:OnAttackLanded(params)
    if not IsServer() then return end
    if params.attacker ~= self:GetParent() then return end
    if params.no_attack_cooldown then return end
    local particle = ParticleManager:CreateParticle("particles/custom/shrapnel_wyvern.vpcf", PATTACH_WORLDORIGIN, nil)
	ParticleManager:SetParticleControl(particle, 0, params.target:GetAbsOrigin())
	ParticleManager:ReleaseParticleIndex(particle)
    local units = FindUnitsInRadius(self:GetParent():GetTeamNumber(), params.target:GetAbsOrigin(), nil, 250, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_ALL, DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES + DOTA_UNIT_TARGET_FLAG_INVULNERABLE + DOTA_UNIT_TARGET_FLAG_OUT_OF_WORLD, FIND_ANY_ORDER, false)
    for _, unit in pairs(units) do
        if unit ~= params.target then
            ApplyDamage({ victim = unit, attacker = params.attacker, damage = params.original_damage / 100 * self.bonus[self:GetStackCount()], damage_type = DAMAGE_TYPE_PHYSICAL, damage_flags = DOTA_DAMAGE_FLAG_NO_SPELL_AMPLIFICATION})
        end
    end
end