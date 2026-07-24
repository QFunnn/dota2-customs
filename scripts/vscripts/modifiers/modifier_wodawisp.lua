--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_wodawisp = class({})

function modifier_wodawisp:IsPurgable() 
	return false
end

function modifier_wodawisp:IsPurgeException()
	return false
end

function modifier_wodawisp:RemoveOnDeath()
	return false
end

function modifier_wodawisp:OnCreated()
	if not IsServer() then return end
	self:GetParent():AddEffects( EF_NODRAW )
	Timers:CreateTimer(0.1,function()
        if GetMapName() == "rating_duo" or GetMapName() == "rating_duo_300" then
            for i=0, PlayerResource:GetPlayerCount()-1 do
                if PlayerResource:GetPlayer( i ) then
                    local particle_name = "particles/friendly_wisp_ambient.vpcf"
                    if PlayerResource:GetTeam(i) ~= self:GetParent():GetTeamNumber() or i == self:GetParent():GetPlayerOwnerID() then
                        particle_name = "particles/units/heroes/hero_wisp/woda_ambient.vpcf"
                    end
                    local particle = ParticleManager:CreateParticleForPlayer(particle_name, PATTACH_CUSTOMORIGIN, nil, PlayerResource:GetPlayer( i ))
                    ParticleManager:SetParticleControlEnt(particle, 0, self:GetParent(), PATTACH_POINT_FOLLOW, "attach_hitloc", self:GetParent():GetAbsOrigin(), true)
                    self:AddParticle(particle, false, false, -1, false, false)
                end
            end
        else
            self.wisp_particle = ParticleManager:CreateParticle( "particles/units/heroes/hero_wisp/woda_ambient.vpcf", PATTACH_CUSTOMORIGIN, nil )
            ParticleManager:SetParticleControlEnt(self.wisp_particle, 0, self:GetParent(), PATTACH_POINT_FOLLOW, "attach_hitloc", self:GetParent():GetAbsOrigin(), true)
            self:AddParticle(self.wisp_particle, false, false, -1, false, false)
        end
	end)
	self:StartIntervalThink(FrameTime())
end

function modifier_wodawisp:OnIntervalThink()
	if not IsServer() then return end
	CustomGameEventManager:Send_ServerToAllClients( 'set_map_hidden_wisp', {visible = 0})
end

function modifier_wodawisp:CheckState()
	return {
		[MODIFIER_STATE_MAGIC_IMMUNE] = true,
		[MODIFIER_STATE_ATTACK_IMMUNE] = true,
		[MODIFIER_STATE_UNSELECTABLE] = true, 
		[MODIFIER_STATE_DISARMED] = true, 
		[MODIFIER_STATE_SILENCED] = true,
		[MODIFIER_STATE_MUTED] = true, 
		[MODIFIER_STATE_UNTARGETABLE] = true, 
		[MODIFIER_STATE_NO_HEALTH_BAR] = true, 
		[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
		[MODIFIER_STATE_NOT_ON_MINIMAP_FOR_ENEMIES] = true,
	}
end

function modifier_wodawisp:DeclareFunctions() 
    return 
    {
    	MODIFIER_PROPERTY_MOVESPEED_ABSOLUTE, 
    	MODIFIER_PROPERTY_MODEL_CHANGE, 
    	MODIFIER_PROPERTY_TOTALDAMAGEOUTGOING_PERCENTAGE,
    	MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_PHYSICAL,
		MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_MAGICAL,
		MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_PURE,
    } 
end

function modifier_wodawisp:GetModifierTotalDamageOutgoing_Percentage()
	return -1000
end

function modifier_wodawisp:GetModifierMoveSpeed_Absolute()
    return 350
end

function modifier_wodawisp:GetModifierModelChange()
	return "models/heroes/wisp/wisp.vmdl"
end

function modifier_wodawisp:OnDestroy()
	if not IsServer() then return end
	self:GetParent():RemoveEffects( EF_NODRAW )
	CustomGameEventManager:Send_ServerToAllClients( 'set_map_hidden_wisp', {visible = 1})
end

function modifier_wodawisp:GetTexture()
	return "wodawisp"
end

function modifier_wodawisp:GetAbsoluteNoDamagePhysical()
	return 1
end

function modifier_wodawisp:GetAbsoluteNoDamageMagical()
	return 1
end

function modifier_wodawisp:GetAbsoluteNoDamagePure()
	return 1
end