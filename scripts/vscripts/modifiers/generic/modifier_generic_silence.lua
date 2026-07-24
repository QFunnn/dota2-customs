--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]



modifier_generic_silence = class({})

function modifier_generic_silence:IsHidden() return false end
function modifier_generic_silence:IsPurgable() return true end
function modifier_generic_silence:GetTexture() return "silencer_last_word" end
function modifier_generic_silence:OnCreated(table)
if not IsServer() then return end
self.parent = self:GetParent()

if table.use_sound == 1 then
	self.parent:EmitSound("Sf.Raze_Silence")
end

if not table.sound then return end
self:GetParent():EmitSound(table.sound)
end

function modifier_generic_silence:CheckState()
return
{
	[MODIFIER_STATE_SILENCED] = true,
}
end


function modifier_generic_silence:GetEffectName() return "particles/generic_gameplay/generic_silenced.vpcf" end

function modifier_generic_silence:ShouldUseOverheadOffset() return true end
function modifier_generic_silence:GetEffectAttachType() return PATTACH_OVERHEAD_FOLLOW end