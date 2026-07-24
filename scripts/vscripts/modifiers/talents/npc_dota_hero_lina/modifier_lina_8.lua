--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]



LinkLuaModifier("modifier_lina_8_buff", "modifiers/talents/npc_dota_hero_lina/modifier_lina_8", LUA_MODIFIER_MOTION_NONE)

modifier_lina_8=class({})

function modifier_lina_8:IsHidden() return true end
function modifier_lina_8:IsPurgable() return false end
function modifier_lina_8:IsPurgeException() return false end
function modifier_lina_8:RemoveOnDeath() return false end

function modifier_lina_8:OnCreated()
    self.bonus = {6,5,4}
    self.attacks_ = {}
	if not IsServer() then return end
    self.lina_fiery_soul_custom = self:GetCaster():FindAbilityByName("lina_fiery_soul_custom")
	self:SetStackCount(1)
end

function modifier_lina_8:OnRefresh()
    self.bonus = {6,5,4}
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
end

function modifier_lina_8:DeclareFunctions()
    return
    {
        MODIFIER_EVENT_ON_ATTACK,
         
        MODIFIER_PROPERTY_PROJECTILE_NAME,
    }
end

function modifier_lina_8:OnAttack(params)
    if not IsServer() then return end
    if params.attacker ~= self:GetParent() then return end
    local modifier_lina_8_buff = self:GetParent():FindModifierByName("modifier_lina_8_buff")
    if modifier_lina_8_buff == nil then
        modifier_lina_8_buff = self:GetParent():AddNewModifier(self:GetParent(), nil, "modifier_lina_8_buff", {})
    end
    modifier_lina_8_buff:IncrementStackCount()
    if modifier_lina_8_buff:GetStackCount() >= self.bonus[self:GetStackCount()] then
        self.attacks_[params.record] = true
        modifier_lina_8_buff:Destroy()
    end
end

function modifier_lina_8:OnAttackLanded(params)
    if not IsServer() then return end
    if params.attacker ~= self:GetParent() then return end
    if self.attacks_[params.record] then
        self.attacks_[params.record] = nil
        local units = FindUnitsInRadius( self:GetParent():GetTeamNumber(), params.target:GetOrigin(), nil, 350, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 0, 0, false )
        for _, unit in pairs(units) do
            ApplyDamage({attacker = self:GetParent(), victim = unit, damage = (25 + (self:GetCaster():GetAgility() / 100 * 80)), damage_type = DAMAGE_TYPE_MAGICAL, ability = self.lina_fiery_soul_custom})
        end
        local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_ember_spirit/ember_spirit_hit.vpcf", PATTACH_ABSORIGIN_FOLLOW, params.target)
        ParticleManager:ReleaseParticleIndex(particle)
        params.target:EmitSound("Hero_EmberSpirit.FireRemnant.Explode")
    end
end

function modifier_lina_8:GetModifierProjectileName()
    local modifier_lina_8_buff = self:GetParent():FindModifierByName("modifier_lina_8_buff")
    if modifier_lina_8_buff and modifier_lina_8_buff:GetStackCount() >= (self.bonus[self:GetStackCount()] - 1) then
        return "particles/units/heroes/hero_lina/lina_base_attack_large.vpcf"
    end
end

modifier_lina_8_buff = class({})
function modifier_lina_8_buff:GetTexture() return "lina_8" end
function modifier_lina_8_buff:IsPurgable() return false end
function modifier_lina_8_buff:IsPurgeException() return false end
function modifier_lina_8_buff:RemoveOnDeath() return false end