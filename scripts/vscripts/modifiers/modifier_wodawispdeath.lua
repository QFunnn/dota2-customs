--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_wodawispdeath = class({})

LinkLuaModifier("modifier_wodawispdeath_wisp", "modifiers/modifier_wodawispdeath", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_wodawispdeath_invisible", "modifiers/modifier_wodawispdeath", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_woda_pve_creep_timeout_cooldown", "modifiers/modifier_woda_pve_creep_timeout", LUA_MODIFIER_MOTION_NONE)

function modifier_wodawispdeath:IsPurgable() 
	return false
end

function modifier_wodawispdeath:IsPurgeException()
	return false
end

function modifier_wodawispdeath:IsHidden() 
	return true 
end

function modifier_wodawispdeath:RemoveOnDeath() 
	return false
end

function modifier_wodawispdeath:OnCreated()
	if not IsServer() then return end
	self.wisp = nil
end

function modifier_wodawispdeath:DeclareFunctions()
	return {MODIFIER_EVENT_ON_DEATH,MODIFIER_EVENT_ON_RESPAWN}
end

function modifier_wodawispdeath:OnDeath(params)
	if not IsServer() then return end
	if params.unit == self:GetParent() then

        if params.reincarnate then return end

		-- Убиваем юнитов подконтрольных челу
		for _, unit in pairs(FindUnitsInRadius(self:GetParent():GetTeamNumber(), self:GetParent():GetAbsOrigin(), nil, FIND_UNITS_EVERYWHERE, DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_PLAYER_CONTROLLED + DOTA_UNIT_TARGET_FLAG_INVULNERABLE + MODIFIER_STATE_OUT_OF_GAME, FIND_ANY_ORDER, false)) do
       		if unit:GetOwner() == self:GetParent() then
        	    unit:ForceKill(false)
       		end
    	end

    	-- Если чел на дуэли или же уже проиграл
    	if self:GetParent():HasModifier("modifier_wodaduel1") then return end
        if self:GetParent():HasModifier("modifier_wodaduel_duo") then return end
    	if self:GetParent():HasModifier("modifier_wodaduel2") then return end
    	if self:GetParent():HasModifier("modifier_wodaduel_boss_pve") then return end
    	if self:GetParent():HasModifier("modifier_wodaduel_boss_pve_end") then return end
    	
    	if GetMapName() == "arena" then
    		if arena_system:GetAegisCount(self:GetParent()) <= 0 then return end
    	end

    	if player_system:IsLose(self:GetParent():GetPlayerID()) then return end

    	-- Спавним виспа
		self.wisp = CreateUnitByName("npc_woda_wisp_death", self:GetParent():GetAbsOrigin(), false, self:GetParent(), nil, self:GetParent():GetTeamNumber())
		self.wisp:AddNewModifier(self.wisp, nil, "modifier_wodawispdeath_invisible", {})
		self.wisp:AddNewModifier(self.wisp, nil, "modifier_wodawispdeath_wisp", {owner = self:GetParent():GetPlayerOwnerID()})
		self.wisp:SetOwner(self:GetParent())
		self.wisp:SetControllableByPlayer(self:GetParent():GetPlayerID(), true)

		-- Делаем информацию что владелец подох и телепортируем его в центр арены
		self:GetParent().death = true

		if GetMapName() == "arena" then
			Timers:CreateTimer({ endTime = 0.01, callback = function()
				self:GetParent():SetCamera(self.wisp)
				self:GetParent():SetUnit(self.wisp)
				PlayerResource:SetOverrideSelectionEntity(self:GetParent():GetPlayerID(), self.wisp)
		    end})
		else
			local teleport_point=Entities:FindByName(nil, ARENA_SPAWN_POINTS[CURRENT_ARENA][RandomInt(1, #ARENA_SPAWN_POINTS[CURRENT_ARENA])])
			if teleport_point then 
				Timers:CreateTimer({ endTime = 0.01, callback = function()
		            FindClearSpaceForUnit(self.wisp, teleport_point:GetAbsOrigin(), true)
					self:GetParent():SetCamera(self.wisp)
					self:GetParent():SetUnit(self.wisp)
					PlayerResource:SetOverrideSelectionEntity(self:GetParent():GetPlayerID(), self.wisp)
			    end})
			end
		end
	end
end

function modifier_wodawispdeath:OnRespawn(params)
	if not IsServer() then return end
	-- Дефолтные проверки что чел этот висп живой итд
	if params.unit ~= self:GetParent() then return end
	if self.wisp == nil then return end
	if not self.wisp:IsAlive() then return end
	if GetMapName() == "arena" then
        if not self:GetParent():IsReincarnating() then
            local modifier_aegis_arena_pve = params.unit:FindModifierByName("modifier_aegis_arena_pve")
            if modifier_aegis_arena_pve then
                modifier_aegis_arena_pve:AegisDrop()
            end
        end
		self:GetParent():AddNewModifier(self:GetParent(), nil, "modifier_woda_pve_creep_timeout_cooldown", {duration = 5})
	end
	-- Избавляемся от виспа
	GridNav:DestroyTreesAroundPoint(self.wisp:GetAbsOrigin(), 150, true)
    local modifier_woda_emblem = self:GetParent():FindModifierByName("modifier_woda_emblem")
    if modifier_woda_emblem then
        local status_effect = modifier_woda_emblem.status_effect
        local effect_id = modifier_woda_emblem.effect_id
        modifier_woda_emblem:Destroy()
        player_system:AddPlayerEmblem(effect_id, self:GetParent())
    end
	FindClearSpaceForUnit(self:GetParent(), self.wisp:GetAbsOrigin(), true)
	UTIL_Remove(self.wisp)
	self.wisp = nil
	self:GetParent().death = nil
end

-- Модификаторы виспа

modifier_wodawispdeath_wisp = class({})

function modifier_wodawispdeath_wisp:IsPurgable() 
	return false
end

function modifier_wodawispdeath_wisp:OnCreated(params)
	if not IsServer() then return end
    if GetMapName() == "rating_duo" or GetMapName() == "rating_duo_300" then
        for i=0, PlayerResource:GetPlayerCount()-1 do
            if PlayerResource:GetPlayer( i ) then
                local particle_name = "particles/friendly_wisp_ambient.vpcf"
                if PlayerResource:GetTeam(i) ~= self:GetParent():GetTeamNumber() or i == params.owner then
                    particle_name = "particles/units/heroes/hero_wisp/woda_ambient.vpcf"
                end
                local particle = ParticleManager:CreateParticleForPlayer(particle_name, PATTACH_CUSTOMORIGIN, self:GetParent(), PlayerResource:GetPlayer( i ))
                ParticleManager:SetParticleControlEnt(particle, 0, self:GetParent(), PATTACH_POINT_FOLLOW, "attach_hitloc", self:GetParent():GetAbsOrigin(), true)
                self:AddParticle(particle, false, false, -1, false, false)
            end
        end
    else
        self.wisp_particle = ParticleManager:CreateParticle( "particles/units/heroes/hero_wisp/woda_ambient.vpcf", PATTACH_CUSTOMORIGIN, self:GetParent() )
        ParticleManager:SetParticleControlEnt(self.wisp_particle, 0, self:GetParent(), PATTACH_POINT_FOLLOW, "attach_hitloc", self:GetParent():GetAbsOrigin(), true)
        self:AddParticle(self.wisp_particle, false, false, -1, false, false)
    end
end

function modifier_wodawispdeath_wisp:CheckState()
	local states =
    {
		[MODIFIER_STATE_INVULNERABLE] = true, 
		[MODIFIER_STATE_DISARMED] = true, 
		[MODIFIER_STATE_SILENCED] = true,
		[MODIFIER_STATE_MUTED] = true, 
		[MODIFIER_STATE_UNTARGETABLE] = true, 
		[MODIFIER_STATE_NO_HEALTH_BAR] = true,
		[MODIFIER_STATE_NOT_ON_MINIMAP_FOR_ENEMIES] = true, 
		[MODIFIER_STATE_NO_UNIT_COLLISION] = true, 
		[MODIFIER_STATE_UNSELECTABLE] = true, 
		[MODIFIER_STATE_ALLOW_PATHING_THROUGH_TREES] = true
	}
    if IsServer() and GetMapName() == "arena" then
        states[MODIFIER_STATE_FLYING_FOR_PATHING_PURPOSES_ONLY] = true
    end
    return states
end

function modifier_wodawispdeath_wisp:DeclareFunctions() 
    return 
    {
    	MODIFIER_PROPERTY_MOVESPEED_ABSOLUTE,
    } 
end

function modifier_wodawispdeath_wisp:GetModifierMoveSpeed_Absolute()
    return 350
end

function modifier_wodawispdeath_wisp:GetTexture()
	return "wodawisp"
end

modifier_wodawispdeath_invisible = class({})

function modifier_wodawispdeath_invisible:IsPurgable() 
	return false
end

function modifier_wodawispdeath_invisible:IsPurgeException()
	return false
end

function modifier_wodawispdeath_invisible:IsHidden() 
	return false 
end

function modifier_wodawispdeath_invisible:RemoveOnDeath() 
	return false
end

function modifier_wodawispdeath_invisible:OnCreated()
    if not IsServer() then return end
    self:StartIntervalThink(FrameTime())
end

function modifier_wodawispdeath_invisible:OnIntervalThink()
    if not IsServer() then return end
    self:GetParent():RemoveModifierByName("modifier_item_dustofappearance")
    self:GetParent():RemoveModifierByName("modifier_truesight")
end

function modifier_wodawispdeath_invisible:DeclareFunctions()
    return {
        MODIFIER_PROPERTY_INVISIBILITY_LEVEL,
    }
end

function modifier_wodawispdeath_invisible:GetModifierInvisibilityLevel()
    return 1
end

function modifier_wodawispdeath_invisible:CheckState()
    return 
    {
        [MODIFIER_STATE_INVISIBLE] = true,
        [MODIFIER_STATE_TRUESIGHT_IMMUNE] = true,
        [MODIFIER_STATE_NO_UNIT_COLLISION] = true,
    }
end

function modifier_wodawispdeath_invisible:GetTexture()
	return "wodawispinvis"
end