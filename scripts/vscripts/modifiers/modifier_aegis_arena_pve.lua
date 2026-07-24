--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_aegis_arena_pve = class({})

function modifier_aegis_arena_pve:IsHidden()
	return (self:GetStackCount()<=0)
end

function modifier_aegis_arena_pve:GetTexture()
	return "item_aegis"
end

function modifier_aegis_arena_pve:IsPermanent()
	return true
end

function modifier_aegis_arena_pve:IsPurgable()
	return false
end

function modifier_aegis_arena_pve:AegisDrop()
	if not IsServer() then return end
  	if self:GetStackCount() >= 1 then
	  	local nStackCount = self:GetStackCount()
      	self:SetStackCount(nStackCount-1)
        CustomGameEventManager:Send_ServerToAllClients("event_update_scoreboard_data", {table_name = "aegis_count", player_id = self:GetParent():GetPlayerOwnerID(), data = {aegis = self:GetStackCount()}})
    end
end