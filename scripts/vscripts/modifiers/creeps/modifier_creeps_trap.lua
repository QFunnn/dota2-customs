--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_creeps_trap = class({})

function modifier_creeps_trap:GetTexture() return "techies_stasis_trap"  end


function modifier_creeps_trap:IsHidden() return false end
function modifier_creeps_trap:IsPurgable() return true end
function modifier_creeps_trap:GetStatusEffectName() return "particles/status_fx/status_effect_techies_stasis.vpcf" end
function modifier_creeps_trap:GetEffectName() return "particles/generic_gameplay/generic_sleep.vpcf" end
function modifier_creeps_trap:GetEffectAttachType() return PATTACH_OVERHEAD_FOLLOW end
function modifier_creeps_trap:CheckState()
return
{
	[MODIFIER_STATE_STUNNED] = true
}
end



function modifier_creeps_trap:DamageEvent_inc(params)
if not IsServer() then return end
if not params.attacker then return end
if self.parent ~= params.unit then  return end
if (self.parent:GetAbsOrigin() - params.attacker:GetAbsOrigin()):Length2D() >= 2000 then return end

self:Destroy()
end



function modifier_creeps_trap:OnCreated(table)
if not IsServer() then return end

self.parent = self:GetParent()
self.team = table.team

self.parent:AddDamageEvent_inc(self, true)

self.ids = dota1x6:FindPlayers(self.team)

self:StartIntervalThink(FrameTime())
end

function modifier_creeps_trap:OnIntervalThink()
if not IsServer() then return end

if not self.ids then return end

for _,id in pairs(self.ids) do
	CustomGameEventManager:Send_ServerToPlayer(PlayerResource:GetPlayer(id), 'TrapAlert_think',  {time = self:GetRemainingTime(), max = Trap_Duration})
end

end


function modifier_creeps_trap:OnDestroy()
if not IsServer() then return end

self.parent:AddNewModifier(nil, nil, "modifier_creeps_movespeed" , {duration = 5})

if not self.ids then return end
for _,id in pairs(self.ids) do
	CustomGameEventManager:Send_ServerToPlayer(PlayerResource:GetPlayer(id), 'TrapAlert_hide',  {})
end

end


modifier_creeps_movespeed = class({})
function modifier_creeps_movespeed:IsHidden() return true end
function modifier_creeps_movespeed:IsPurgable() return false end
function modifier_creeps_movespeed:DeclareFunctions()
return
{
	MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE
}

end

function modifier_creeps_movespeed:GetModifierMoveSpeedBonus_Percentage()
return -100
end