--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]



modifier_undying_tombstone_lua = class({})

---------------------------------------------------------

function modifier_undying_tombstone_lua:IsHidden()
	return true
end

---------------------------------------------------------

function modifier_undying_tombstone_lua:IsPurgable()
	return false
end

---------------------------------------------------------

function modifier_undying_tombstone_lua:CheckState()
	local state =
	{
		[MODIFIER_STATE_MAGIC_IMMUNE] = true,
		[MODIFIER_STATE_ROOTED] = true,
		[MODIFIER_STATE_DISARMED] = true,
	}

	return state
end

---------------------------------------------------------

function modifier_undying_tombstone_lua:OnCreated()
	if IsServer() then
		self.hSkeletons = {}

		self.radius = 500
		self.zombie_duration = self:GetAbility():GetSpecialValueFor( "zombie_duration" )
		self.zombie_interval = self:GetAbility():GetSpecialValueFor( "zombie_interval" )
		self.max_zombie = self:GetAbility():GetSpecialValueFor( "max_zombie" )
      self.zombie_health = self:GetAbility():GetSpecialValueFor( "zombie_health" )
      self.zombie_damage = self:GetAbility():GetSpecialValueFor( "zombie_damage" )
      self.radius = self:GetAbility():GetSpecialValueFor( "radius" )

		EmitSoundOn( "Hero_Tusk.FrozenSigil", self:GetParent() )
      self:SummonZombie()
      self.nIntervalCount=0
		self:StartIntervalThink( self.zombie_interval/10 )
 
	end
end
---------------------------------------------------------

function modifier_undying_tombstone_lua:OnIntervalThink()
	if IsServer() then

	   self.nIntervalCount = self.nIntervalCount + 1
	   for k, hSkeleton in pairs( self.hSkeletons ) do
		  if hSkeleton == nil or hSkeleton:IsNull() or hSkeleton:IsAlive() == false then
			  table.remove( self.hSkeletons, k )
		  end
		  if hSkeleton.hEnemy == nil or hSkeleton.hEnemy:IsNull() or hSkeleton.hEnemy:IsAlive() == false then
			  hSkeleton:ForceKill(false)
			  table.remove( self.hSkeletons, k )
		  end
	   end
       if self.nIntervalCount%10==0 then
          self:SummonZombie()
       end
	end
end

--------------------------------------------------------------------------------
function modifier_undying_tombstone_lua:SummonZombie()
	if IsServer() then

		local enemies = FindUnitsInRadius(self:GetParent():GetTeamNumber(), self:GetParent():GetOrigin(), nil, self.radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_ALL, DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES, FIND_CLOSEST, false)
        
        if #enemies>0 then
           EmitSoundOn( "Tombstone.RaiseDead", self:GetParent())
        end

        for _,hEnemy in ipairs(enemies) do
        	if #self.hSkeletons < self.max_zombie and not hEnemy:IsNull() and hEnemy:IsAlive() and not hEnemy:IsOther() then
				local vSpawnPos = hEnemy:GetAbsOrigin() + RandomVector( 150 )
                
                local sZombieName = "npc_dota_creature_tombstone_zombie"
                
                --50概率召唤爬行僵尸
                if RandomInt(1, 100)<50 then
                   sZombieName="npc_dota_creature_tombstone_zombie_torso"
                end
                
                if self:GetAbility() then
					local hSkeleton = CreateUnitByName(sZombieName, vSpawnPos, true, self:GetAbility():GetCaster(), self:GetAbility():GetCaster(), self:GetParent():GetTeamNumber() )
					if hSkeleton ~= nil then
						table.insert( self.hSkeletons, hSkeleton )
						hSkeleton.hEnemy=hEnemy
	               --hSkeleton:SetControllableByPlayer(nil, false)
	               hSkeleton:SetOwner(self:GetAbility():GetCaster())
	               hSkeleton:SetBaseMaxHealth(self.zombie_health)
	               hSkeleton:SetMaxHealth(self.zombie_health)
	               hSkeleton:SetHealth(self.zombie_health)

						hSkeleton:SetBaseDamageMax(self.zombie_damage+3)
		            hSkeleton:SetBaseDamageMin(self.zombie_damage-3)
		            hSkeleton:AddNewModifier( self:GetParent(), self:GetAbility(), "modifier_kill", { duration = self.zombie_duration } )

						ParticleManager:ReleaseParticleIndex( ParticleManager:CreateParticle( "particles/neutral_fx/skeleton_spawn.vpcf", PATTACH_ABSORIGIN, hSkeleton ) )

                  --其他ai写在bot_ai里面
						ExecuteOrderFromTable({
	                   UnitIndex = hSkeleton:entindex(),
	                   OrderType = DOTA_UNIT_ORDER_ATTACK_MOVE,
	                   Position =  hSkeleton:GetOrigin()
		            })

					end
				end
		    end
        end
	end
end