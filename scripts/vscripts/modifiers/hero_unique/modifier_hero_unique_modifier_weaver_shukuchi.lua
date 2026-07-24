--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_hero_unique_modifier_weaver_shukuchi = class({})
function modifier_hero_unique_modifier_weaver_shukuchi:IsHidden() return true end
function modifier_hero_unique_modifier_weaver_shukuchi:IsPurgable() return false end
function modifier_hero_unique_modifier_weaver_shukuchi:IsPurgeException() return false end
function modifier_hero_unique_modifier_weaver_shukuchi:RemoveOnDeath() return false end

function modifier_hero_unique_modifier_weaver_shukuchi:OnCreated(params)
    if not IsServer() then return end
    self.parent = self:GetParent()
    self.ability = self:GetAbility()
    self:StartIntervalThink(1)
end

function modifier_hero_unique_modifier_weaver_shukuchi:OnIntervalThink()
    if not IsServer() then return end
    if self.ability == nil or self.ability:IsNull() then
        self:Destroy()
    end
end

function modifier_hero_unique_modifier_weaver_shukuchi:TakeDamageScriptModifier(params)
    if params.inflictor == nil and not self:GetParent():IsIllusion() and not self:FlagExist( params.damage_flags, DOTA_DAMAGE_FLAG_REFLECTION ) then 
        local heal = 30 / 100 * params.damage
        self:GetParent():Heal(heal, nil)
    end
    if params.inflictor ~= nil and not self:GetParent():IsIllusion() and not self:FlagExist( params.damage_flags, DOTA_DAMAGE_FLAG_REFLECTION ) then 
        local heal = 30 / 100 * params.damage
        self:GetParent():Heal(heal, params.inflictor)
    end
end

function modifier_hero_unique_modifier_weaver_shukuchi:FlagExist(a,b)
    local p,c,d=1,0,b
    while a>0 and b>0 do
        local ra,rb=a%2,b%2
        if ra+rb>1 then c=c+p end
        a,b,p=(a-ra)/2,(b-rb)/2,p*2
    end
    return c==d
end