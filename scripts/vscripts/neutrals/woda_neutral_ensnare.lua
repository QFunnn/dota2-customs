--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_woda_neutral_ensnare_debuff", "neutrals/woda_neutral_ensnare", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_neutral_cast", "neutrals/modifier_neutral_cast", LUA_MODIFIER_MOTION_NONE)

woda_neutral_ensnare = class({})

function woda_neutral_ensnare:Precache(context)
    PrecacheResource( "particle", "particles/neutral_fx/dark_troll_ensnare_proj.vpcf", context )
    PrecacheResource( "particle", "particles/neutral_fx/dark_troll_ensnare.vpcf", context )
end

function woda_neutral_ensnare:OnSpellStart(new_caster, new_target)
    if not IsServer() then return end
    local target = self:GetCursorTarget()
    self:GetCaster():StartGestureWithPlaybackRate(ACT_DOTA_CAST_ABILITY_1, 1)
    self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_neutral_cast", {})


    Timers:CreateTimer(0, function()
        if not self:GetCaster():IsAlive() then return end
        local info = {
            EffectName = "particles/neutral_fx/dark_troll_ensnare_proj.vpcf",
            Ability = self,
            iMoveSpeed = 1500,
            Source = self:GetCaster(),
            Target = target,
            iSourceAttachment = DOTA_PROJECTILE_ATTACHMENT_ATTACK_2
        }

        ProjectileManager:CreateTrackingProjectile( info )

        self:GetCaster():EmitSound("Hero_NagaSiren.Ensnare.Cast")
        self:GetCaster():RemoveModifierByName("modifier_neutral_cast")
    end)
end

function woda_neutral_ensnare:OnProjectileHit_ExtraData(target, vLocation, hExtraData)
	if not IsServer() then return end
    if target == nil then return end
    if target:IsMagicImmune() then return end
    target:EmitSound("n_creep_TrollWarlord.Ensnare")
    local duration = self:GetSpecialValueFor("duration")
    target:AddNewModifier(self:GetCaster(), self, "modifier_woda_neutral_ensnare_debuff", {duration = duration * (1 - target:GetStatusResistance())})
end

modifier_woda_neutral_ensnare_debuff = class({})

function modifier_woda_neutral_ensnare_debuff:IsPurgable() return true end
function modifier_woda_neutral_ensnare_debuff:GetEffectName() return "particles/neutral_fx/dark_troll_ensnare.vpcf" end
function modifier_woda_neutral_ensnare_debuff:GetEffectAttachType() return PATTACH_ABSORIGIN end

function modifier_woda_neutral_ensnare_debuff:CheckState() 
	return 
	{
    	[MODIFIER_STATE_ROOTED] = true,
	} 
end