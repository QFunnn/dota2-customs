--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_item_clumsy_net_custom", "abilities/items/neutral/item_clumsy_net_custom", LUA_MODIFIER_MOTION_NONE)

item_clumsy_net_custom = class({})

function item_clumsy_net_custom:Precache(context)
if self:GetCaster() and self:GetCaster():IsIllusion() then return end
PrecacheResource( "particle", "particles/items5_fx/clumsy_net_proj.vpcf", context )
PrecacheResource( "particle", "particles/neutral_fx/dark_troll_ensnare.vpcf", context )

end


function item_clumsy_net_custom:OnSpellStart()
local caster = self:GetCaster()
caster:EmitSound("n_creep_TrollWarlord.Ensnare")


local info = 
{
   Target = self:GetCursorTarget(),
   Source = caster,
   Ability = self, 
   EffectName = "particles/items5_fx/clumsy_net_proj.vpcf",
   iMoveSpeed = self:GetSpecialValueFor("speed"),
   bReplaceExisting = false,                         
   bProvidesVision = true,                           
   iVisionRadius = 30,        
   iVisionTeamNumber = caster:GetTeamNumber()      
}
ProjectileManager:CreateTrackingProjectile(info)
end


function item_clumsy_net_custom:OnProjectileHit(hTarget, vLocation)
if not IsServer() then return end
if hTarget==nil then return end

hTarget:AddNewModifier(self:GetCaster(), self, "modifier_item_clumsy_net_custom", {duration = self:GetSpecialValueFor("duration")*(1 - hTarget:GetStatusResistance())})
hTarget:EmitSound("Hero_Meepo.Earthbind.Target")
end




modifier_item_clumsy_net_custom = class({})
function modifier_item_clumsy_net_custom:IsHidden() return true end
function modifier_item_clumsy_net_custom:IsPurgable() return true end
function modifier_item_clumsy_net_custom:GetEffectName() return "particles/neutral_fx/dark_troll_ensnare.vpcf" end
function modifier_item_clumsy_net_custom:CheckState()
return
{
    [MODIFIER_STATE_ROOTED] = true
}
end