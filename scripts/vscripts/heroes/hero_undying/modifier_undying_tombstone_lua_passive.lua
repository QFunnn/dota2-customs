--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_undying_tombstone_lua_passive = modifier_undying_tombstone_lua_passive or class({})

function modifier_undying_tombstone_lua_passive:IsHidden() return true end

function modifier_undying_tombstone_lua_passive:DeclareFunctions()
	local funcs = {
		MODIFIER_EVENT_ON_ATTACK_LANDED,	
	}
	return funcs
end

function modifier_undying_tombstone_lua_passive:OnCreated(  )
	if IsServer() then
		self.hCaster = self:GetCaster()
		self.zombie_duration = self:GetAbility():GetSpecialValueFor( "zombie_duration" )
		self.zombie_health = self:GetAbility():GetSpecialValueFor( "zombie_health" )
		self.zombie_damage = self:GetAbility():GetSpecialValueFor( "zombie_damage" )
		self.passive_max_zombie = 10
		self.hZombies = {}
		self:StartIntervalThink(0.5)
	end
end


function modifier_undying_tombstone_lua_passive:OnRefresh(  )
	if IsServer() then
		self.zombie_duration = self:GetAbility():GetSpecialValueFor( "zombie_duration" )
		self.zombie_health = self:GetAbility():GetSpecialValueFor( "zombie_health" )
		self.zombie_damage = self:GetAbility():GetSpecialValueFor( "zombie_damage" )
		self.passive_max_zombie = 10
	end
end


function modifier_undying_tombstone_lua_passive:OnIntervalThink()
	if IsServer() then	   
	   --将死去的僵尸移除队列
	   for k, hZombie in pairs( self.hZombies ) do
		  if hZombie == nil or hZombie:IsNull() or hZombie:IsAlive() == false then
			  table.remove( self.hZombies, k )
		  end
	   end
	end
end


function modifier_undying_tombstone_lua_passive:OnAttackLanded( keys )
	
	local hAbility = keys.ability
	local hAttacker = keys.attacker
    
    if hAttacker ~= self:GetParent() and self.hCaster ~= hAttacker 
    	then return 
    end

    if self:GetParent():HasModifier("modifier_item_aghanims_shard") and self:GetParent():HasModifier("modifier_undying_flesh_golem") then        
        
        if #self.hZombies < self.passive_max_zombie then

	        local sZombieName = "npc_dota_creature_tombstone_zombie"               
	        --50概率召唤爬行僵尸
	        if RandomInt(1, 100)<50 then
	           sZombieName="npc_dota_creature_tombstone_zombie_torso"
	        end

	        local hZombie = CreateUnitByName(sZombieName, self:GetParent():GetAbsOrigin(), true, self:GetParent(), self:GetParent(), self:GetParent():GetTeamNumber() )
			  if hZombie ~= nil then
			  	 table.insert( self.hZombies, hZombie )
			    hZombie:SetOwner(self:GetParent())
			    hZombie:SetBaseMaxHealth(self.zombie_health)
			    hZombie:SetMaxHealth(self.zombie_health)
			    hZombie:SetHealth(self.zombie_health)
				 hZombie:SetBaseDamageMax(self.zombie_damage+3)
		       hZombie:SetBaseDamageMin(self.zombie_damage-3)
		       hZombie:AddNewModifier( self:GetParent(), self:GetAbility(), "modifier_kill", { duration = self.zombie_duration } )
				 ParticleManager:ReleaseParticleIndex( ParticleManager:CreateParticle( "particles/neutral_fx/skeleton_spawn.vpcf", PATTACH_ABSORIGIN, hZombie ) )
			  end

		  end

    end

end