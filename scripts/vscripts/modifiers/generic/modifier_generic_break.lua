--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]



modifier_generic_break = class({})

function modifier_generic_break:IsHidden() return true end
function modifier_generic_break:IsPurgable() return false end
function modifier_generic_break:GetTexture() return "buffs/soul_damage" end
function modifier_generic_break:OnCreated(table)
if not IsServer() then return end
if not table.sound then return end
self:GetParent():EmitSound(table.sound)
end

function modifier_generic_break:CheckState()
return
{
	[MODIFIER_STATE_PASSIVES_DISABLED] = true
}
end


function modifier_generic_break:GetEffectName() return "particles/generic_gameplay/generic_break.vpcf" end

function modifier_generic_break:ShouldUseOverheadOffset() return true end
function modifier_generic_break:GetEffectAttachType() return PATTACH_OVERHEAD_FOLLOW end

