--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_mid_teleport_cd", "abilities/mid_teleport", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_mid_teleport_cast", "abilities/mid_teleport", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_mid_teleport_cast_anim", "abilities/mid_teleport", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_mid_teleport_speed", "abilities/mid_teleport", LUA_MODIFIER_MOTION_NONE)

mid_teleport = class ({})

function mid_teleport:GetChannelTime() return 3 end

function mid_teleport:OnSpellStart()
local caster = self:GetCaster()

if not self.teleport then
	caster:Stop()
	return 
end

local tp_ent = Entities:FindByName(nil, "global_teleport_"..tostring(self.teleport:GetName()))
if not tp_ent then 
	tp_ent = Entities:FindByName(nil, tostring(self.teleport:GetName()).."_point")
end

if not tp_ent then
	caster:Stop()
	return 
end

self.point = tp_ent:GetAbsOrigin()
AddFOWViewer(caster:GetTeamNumber(), self.point, 1400, 3, false)

caster:AddNewModifier(caster, self, "modifier_mid_teleport_cast", {target = self.teleport:entindex()})	

self.teleport:AddNewModifier(self.teleport, nil, "modifier_mid_teleport_cast_anim", {})


self.teleport_center = CreateUnitByName("npc_dota_companion", self.point, false, nil, nil, 0)

EmitSoundOn("UI.Base_teleport_loop", self.teleport_center)
self.teleport_center:AddNewModifier(self.teleport_center, nil, "modifier_phased", {})
self.teleport_center:AddNewModifier(self.teleport_center, nil, "modifier_invulnerable", {})

self.teleport_center:SetAbsOrigin(self.point)

self.teleportToEffect = ParticleManager:CreateParticle("particles/items2_fx/teleport_end.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.teleport_center)
ParticleManager:SetParticleControlEnt(self.teleportToEffect, 1, self.teleport_center, PATTACH_ABSORIGIN_FOLLOW, "attach_hitloc", self.teleport_center:GetAbsOrigin(), true)
ParticleManager:SetParticleControlEnt(self.teleportToEffect, 3, caster, PATTACH_ABSORIGIN_FOLLOW, "attach_hitloc", self.teleport_center:GetAbsOrigin(), true)
ParticleManager:SetParticleControl(self.teleportToEffect, 4, Vector(0.9, 0, 0))
ParticleManager:SetParticleControlEnt(self.teleportToEffect, 5, self.teleport_center, PATTACH_POINT_FOLLOW, "attach_hitloc", self.teleport_center:GetAbsOrigin(), true)
end



function mid_teleport:OnChannelFinish(bInterrupted)
if not self.point then return end
if not self.teleport then return end

local caster = self:GetCaster()

start_quest:CheckQuest({id = caster:GetId(), quest_name = "Quest_9"})

caster:RemoveModifierByName("modifier_mid_teleport_cast")

local mod = self.teleport:FindModifierByName("modifier_mid_teleport_cast_anim")
if mod then
	mod:ReduceStack()
end

ParticleManager:DestroyParticle(self.teleportToEffect, false)
ParticleManager:ReleaseParticleIndex(self.teleportToEffect)


StopSoundOn("UI.Base_teleport_loop", self.teleport_center)
UTIL_Remove(self.teleport_center)

if bInterrupted then 
  return 
end   

local particle = ParticleManager:CreateParticle("particles/econ/events/fall_2021/blink_dagger_fall_2021_end.vpcf", PATTACH_WORLDORIGIN, nil)
ParticleManager:SetParticleControl(particle, 0, caster:GetAbsOrigin())   
ParticleManager:ReleaseParticleIndex(particle)

--caster:AddNewModifier(caster, nil, "modifier_mid_teleport_speed", {duration = 10} )

self.teleport:EmitSound("UI.Base_teleport_end_caster")

EmitSoundOnLocationWithCaster(self.point, "UI.Base_teleport_loop_end", caster)
caster:SetAbsOrigin(self.point)
FindClearSpaceForUnit(caster, self.point, true)

caster:Stop()
caster:Interrupt()
end


modifier_mid_teleport_cd = class({})

function modifier_mid_teleport_cd:IsDebuff() return true end
function modifier_mid_teleport_cd:IsPurgable() return false end
function modifier_mid_teleport_cd:RemoveOnDeath() return false end
function modifier_mid_teleport_cd:GetTexture() return "item_tpscroll" end

function modifier_mid_teleport_cd:OnDestroy()
if not IsServer() then return end

EmitSoundOnEntityForPlayer("Outpost.Captured.Notification", self:GetParent(), self:GetParent():GetPlayerOwnerID())

end



modifier_mid_teleport_cast = class({})

function modifier_mid_teleport_cast:IsHidden() return true end
function modifier_mid_teleport_cast:IsPurgable() return false end


function modifier_mid_teleport_cast:OrderEvent( params )
local target = params.target

if params.order_type == DOTA_UNIT_ORDER_MOVE_TO_TARGET or
	params.order_type == DOTA_UNIT_ORDER_MOVE_TO_POSITION or
	params.order_type == DOTA_UNIT_ORDER_MOVE_TO_DIRECTION 
	or (params.order_type == DOTA_UNIT_ORDER_ATTACK_TARGET and target and target:GetUnitName() == "npc_teleport") then 
 return 0 
end

if params.order_type==DOTA_UNIT_ORDER_ATTACK_TARGET or
	params.order_type==DOTA_UNIT_ORDER_STOP or 
	params.order_type==DOTA_UNIT_ORDER_HOLD_POSITION then
	self.parent:Stop()
end	

end

function modifier_mid_teleport_cast:DamageEvent_inc(params)
if not IsServer() then return end 
if self:GetParent() ~= params.unit then return end 
if not params.attacker then return end 
if params.attacker == self:GetParent() then return end 
if not params.attacker:IsHero() then return end
if (params.attacker:GetAbsOrigin() - self:GetParent():GetAbsOrigin()):Length2D() >= 1000 then return end
if not params.attacker:IsAlive() then return end
if self.parent:IsFieldInvun(params.attacker) then return end

self:GetParent():Interrupt()
end


function modifier_mid_teleport_cast:OnCreated(table)
if not IsServer() then return end

self.parent = self:GetParent()


self.parent:StartGesture(ACT_DOTA_TELEPORT)

if self.parent:IsRealHero() then 
	self.parent:AddOrderEvent(self)
  self.parent:AddDamageEvent_inc(self, true)
end 

self.target = EntIndexToHScript(table.target)

self:GetParent():SetForwardVector((self.target:GetAbsOrigin() - self:GetParent():GetAbsOrigin()):Normalized())
self:GetParent():FaceTowards(self.target:GetAbsOrigin())

local particle = ParticleManager:CreateParticle("particles/base_static/team_portal_pull.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
ParticleManager:SetParticleControl(particle, 0, self:GetParent():GetAbsOrigin())   
ParticleManager:SetParticleControl(particle, 1, self.target:GetAbsOrigin())
self:AddParticle(particle, false, false, -1, false, false)
end



function modifier_mid_teleport_cast:OnDestroy()
if not IsServer() then return end 

self.parent:RemoveGesture(ACT_DOTA_TELEPORT)
end

modifier_mid_teleport_speed = class({})
function modifier_mid_teleport_speed:IsHidden() return false end
function modifier_mid_teleport_speed:IsPurgable() return false end
function modifier_mid_teleport_speed:GetTexture() return "rune_haste" end
function modifier_mid_teleport_speed:OnCreated(table)

self.move_speed = 15

if not IsServer() then return end

self.parent = self:GetParent()
if self.parent:IsRealHero() then 
    self.parent:AddDamageEvent_inc(self, true)
end 

end

function modifier_mid_teleport_speed:GetEffectName()
return "particles/generic_gameplay/rune_haste_owner.vpcf"
end

function modifier_mid_teleport_speed:DeclareFunctions()
return
{
  MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
}
end


function modifier_mid_teleport_speed:GetModifierMoveSpeedBonus_Percentage()
return self.move_speed
end


function modifier_mid_teleport_speed:DamageEvent_inc(params)
if not IsServer() then return end
if self:GetParent() ~= params.unit then return end
if self:GetParent() == params.atttacker then return end

self:Destroy()
end




modifier_mid_teleport_cast_anim = class(mod_hidden)
function modifier_mid_teleport_cast_anim:OnCreated()
if not IsServer() then return end

self.teleport = self:GetParent()
self.teleport:StartGesture(ACT_DOTA_CHANNEL_ABILITY_1)
self.teleport:EmitSound("UI.Base_teleport_channel")

self.blight_spot = ParticleManager:CreateParticle("particles/base_static/team_portal_active.vpcf", PATTACH_CUSTOMORIGIN, self.teleport)
ParticleManager:SetParticleControlEnt(self.blight_spot, 0, self.teleport, PATTACH_POINT_FOLLOW, "attach_portal", self.teleport:GetAbsOrigin(), true)

local number = tonumber(self.teleport:GetName())

if IsDire(self.teleport:GetName()) then
	ParticleManager:SetParticleControl(self.blight_spot, 12, Vector(1, 0, 0))
end
self:AddParticle(self.blight_spot, false, false, -1, false, false)

self:IncrementStackCount()
end

function modifier_mid_teleport_cast_anim:OnRefresh(table)
if not IsServer() then return end
self:IncrementStackCount()
end

function modifier_mid_teleport_cast_anim:ReduceStack()
if not IsServer() then return end

self:DecrementStackCount()
if self:GetStackCount() <= 0 then
	self:Destroy()
end

end


function modifier_mid_teleport_cast_anim:OnDestroy()
if not IsServer() then return end

self.teleport:StopSound("UI.Base_teleport_channel")
self.teleport:RemoveGesture(ACT_DOTA_CHANNEL_ABILITY_1)
end