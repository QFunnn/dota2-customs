--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_dark_seer_wall_of_replica_nb2017 = class({})

--------------------------------------------------------------------------------

function modifier_dark_seer_wall_of_replica_nb2017:IsHidden()
	return true;
end

--------------------------------------------------------------------------------

function modifier_dark_seer_wall_of_replica_nb2017:IsPurgable()
	return true;
end

--------------------------------------------------------------------------------

function modifier_dark_seer_wall_of_replica_nb2017:OnCreated( kv )
	self.width = self:GetAbility():GetSpecialValueFor( "width" )
	self.replica_damage_incoming = self:GetAbility():GetSpecialValueFor( "replica_damage_incoming" )
	self.replica_damage_outgoing = self:GetAbility():GetSpecialValueFor( "replica_damage_outgoing" )
	self.slow_duration = self:GetAbility():GetSpecialValueFor( "slow_duration" )
	self.max_illusion = self:GetAbility():GetSpecialValueFor( "max_illusion" )

	if IsServer() then
		self.replica_damage_outgoing = self:GetAbility():GetSpecialValueFor( "replica_damage_outgoing" )	
		self.vWallDirection = Vector( kv["dir_x"], kv["dir_y"], kv["dir_z"] )
		self:GetParent():SetForwardVector( self.vWallDirection )
		self.vWallRight = self:GetParent():GetRightVector() * self.width / 2		
		local nFXIndex = ParticleManager:CreateParticle( "particles/units/heroes/hero_dark_seer/dark_seer_wall_of_replica.vpcf", PATTACH_CUSTOMORIGIN, nil );
		ParticleManager:SetParticleControlForward( nFXIndex, 0, self.vWallDirection );
		ParticleManager:SetParticleControl( nFXIndex, 0, ( self:GetParent():GetOrigin() + self.vWallRight ) );
		ParticleManager:SetParticleControl( nFXIndex, 1, ( self:GetParent():GetOrigin() - self.vWallRight ) );
		ParticleManager:SetParticleControl( nFXIndex, 2, self.vWallDirection );
		self:AddParticle( nFXIndex, false, false, -1, false, false )

		self:StartIntervalThink( 0.0 )
		self:GetParent():EmitSound("Hero_Dark_Seer.Wall_of_Replica_Start")
		self:GetParent():EmitSoundParams( "Hero_Dark_Seer.Wall_of_Replica_lp", 100, 0.0, self:GetDuration() )
        
        --幻象集合
		self.replicatedUnits = {}
        
        --每个英雄能控制的幻象数量
		if self:GetCaster().replicas==nil then
		   self:GetCaster().replicas = {}
		end
	end
end

--------------------------------------------------------------------------------

function modifier_dark_seer_wall_of_replica_nb2017:OnDestroy()
	if IsServer() then
		StopSoundOn( "Hero_Dark_Seer.Wall_of_Replica_lp", self:GetParent() )
		UTIL_Remove( self:GetParent() )
        
        --遍历幻象，所有死亡幻象移除队列
	    if self:GetCaster() and self:GetCaster().replicas then
	        for i = 1,#self:GetCaster().replicas do
				local unit = self:GetCaster().replicas[i]
				if (not unit) or (unit:IsNull()) or (not unit:IsAlive()) then
					table.remove( self:GetCaster().replicas, i )
				end
			end
		end

	end
end

--------------------------------------------------------------------------------

function modifier_dark_seer_wall_of_replica_nb2017:OnIntervalThink()
	if IsServer() then
		local vLineA = self:GetParent():GetOrigin() + self.vWallRight * ( self.width * 0.5 )
		local vLineB = self:GetParent():GetOrigin() - self.vWallRight * ( self.width * 0.5 )
		local enemies = FindUnitsInRadius( self:GetParent():GetTeamNumber(), self:GetParent():GetOrigin(), self:GetParent(), self.width, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_NOT_ANCIENTS, 0, false )
		
		if not self:GetCaster() then
		   return
		end

        if self:GetCaster().replicas==nil then
		   self:GetCaster().replicas = {}
		end

		--遍历幻象，所有死亡幻象移除队列
	    if self:GetCaster() and self:GetCaster().replicas then
	        for i = 1,#self:GetCaster().replicas do
				local unit = self:GetCaster().replicas[i]
				if (not unit) or (unit:IsNull()) or (not unit:IsAlive()) then
					table.remove( self:GetCaster().replicas, i )
				end
			end
		end

		if #enemies > 0 then
			for _,enemy in pairs(enemies) do
				local bTryCreate = true
                
                if self:GetCaster().replicas and #self:GetCaster().replicas>=self.max_illusion then
                	bTryCreate = false
                end

				for _, replicated in pairs( self.replicatedUnits ) do
					if enemy == replicated then
				       bTryCreate = false
				    end
				end

			    if bTryCreate == true then 
			    	local flDistOffLine = CalcDistanceToLineSegment2D( enemy:GetOrigin(), vLineA, vLineB )
			    	if flDistOffLine <= ( enemy:GetPaddedCollisionRadius() + 50.0 ) then
			    		table.insert( self.replicatedUnits, enemy )
			    		local flDuration = self:GetDieTime() - GameRules:GetGameTime()
			    		local kv =
			    		{
			    			duration = flDuration,
			    			outgoing_damage = self.replica_damage_outgoing,
			    			replica_damage_incoming = self.replica_damage_incoming,
			    		}

			    		local replica
                        
                        --对英雄使用专用幻象逻辑
                        if enemy:IsHero() then
                        	local illusions = CreateIllusions(self:GetCaster(), enemy, {duration = flDuration,outgoing_damage = self.replica_damage_outgoing, incoming_damage=self.replica_damage_incoming}, 1, enemy:GetHullRadius(), false, true)
			                local replica = illusions[1]
			                replica.IsRealHero = function() return false end
			                replica.IsMainHero = function() return false end
                        else
                           replica = CreateUnitByName( enemy:GetUnitName(), enemy:GetOrigin() + RandomVector( enemy:GetPaddedCollisionRadius() + 50.0 ), true, self:GetCaster(), self:GetCaster(), self:GetCaster():GetTeamNumber() )			    	
			    		end

			    		if replica ~= nil then
			    			local nFXIndex = ParticleManager:CreateParticle( "particles/units/heroes/hero_dark_seer/dark_seer_wall_of_replica_replicate.vpcf", PATTACH_ABSORIGIN_FOLLOW, enemy );
							ParticleManager:SetParticleControlEnt( nFXIndex, 1, replica, PATTACH_ABSORIGIN_FOLLOW, nil, enemy:GetOrigin(), true );
							ParticleManager:ReleaseParticleIndex( nFXIndex );

			    			replica:AddNewModifier( self:GetCaster(), self:GetAbility(), "modifier_illusion", kv )
			    			replica:AddNewModifier( self:GetCaster(), self:GetAbility(), "modifier_darkseer_wallofreplica_illusion", { duration = flDuration } )
			    			replica:SetControllableByPlayer( self:GetCaster():GetPlayerID(), true )
			    			replica:SetIdleAcquire( true )
			    			FindClearSpaceForUnit( replica, replica:GetOrigin(), true )
                            
							if self:GetCaster().replicas then
							   table.insert( self:GetCaster().replicas, replica )
							end

				    	end

			    		local kv2 =
			    		{
			    			duration = self.slow_duration
			    		}
			    		enemy:AddNewModifier( self:GetCaster(), self:GetAbility(), "modifier_dark_seer_wall_slow", kv2 )
			    	end
			    end
			end
			
		end
	end
end

function modifier_dark_seer_wall_of_replica_nb2017:OnDeathEvent( params )
	if IsServer() then
		local hUnit = params.unit
		for i = 1,#self.replicatedUnits do
			local unit = self.replicatedUnits[i]
			if unit == hUnit then
				table.remove( self.replicatedUnits, i )
				return 0
			end
		end					
	end

	return 0
end

--------------------------------------------------------------------------------