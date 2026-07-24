--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_duel_buff", "heroes/hero_legion_commander/custom_legion_commander_duel", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_duel_damage", "heroes/hero_legion_commander/custom_legion_commander_duel", LUA_MODIFIER_MOTION_NONE)

custom_legion_commander_duel = class({})

custom_legion_commander_duel.bRoundDueled = false

function custom_legion_commander_duel:GetCastRange( vLocation, hTarget )
  	return self.BaseClass.GetCastRange(self, vLocation, hTarget)
end

function custom_legion_commander_duel:OnSpellStart()
  	if not IsServer() then return end
  	local target = self:GetCursorTarget()
  	local duration = self:GetSpecialValueFor("duration")
  	if target:TriggerSpellAbsorb(self) then return end
  	local duration = (1 - target:GetStatusResistance()) * duration
    self:GetCaster():EmitSound("Hero_LegionCommander.Duel.Cast")
    self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_duel_buff", {duration = duration, target = target:entindex()})
    target:AddNewModifier(self:GetCaster(), self, "modifier_duel_buff", {duration = duration, target = self:GetCaster():entindex()})
end

function custom_legion_commander_duel:WinDuel(winner, loser)
  	if not IsServer() then return end
  	local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_legion_commander/legion_commander_duel_victory.vpcf", PATTACH_OVERHEAD_FOLLOW, winner)
    ParticleManager:ReleaseParticleIndex(particle)
  	winner:EmitSound("Hero_LegionCommander.Duel.Victory")
  	if winner:IsHero() then
        local modifier_duel_damage = winner:FindModifierByName("modifier_duel_damage")
        local damage = self:GetSpecialValueFor("reward_damage")
        if modifier_duel_damage == nil then
            modifier_duel_damage = winner:AddNewModifier(winner, self, "modifier_duel_damage", {})
        end
        if not loser:IsHero() then
            if self.bRoundDueled then
                return
            else
                self.bRoundDueled = true
            end
        end
        if modifier_duel_damage then
            modifier_duel_damage.winner_counter = (modifier_duel_damage.winner_counter or 0) + 1
            modifier_duel_damage.winner_damage = (modifier_duel_damage.winner_damage or 0) + damage
  		end
  	end
end

modifier_duel_buff = class({})
function modifier_duel_buff:IsPurgable() return false end
function modifier_duel_buff:IsDebuff() return self:GetParent():GetTeamNumber() ~= self:GetCaster():GetTeamNumber() end
function modifier_duel_buff:GetAttributes() return MODIFIER_ATTRIBUTE_MULTIPLE end
function modifier_duel_buff:OnCreated(table)
 	if not IsServer() then return end	
  	self.target = EntIndexToHScript(table.target)
  	-- self:GetParent():SetForceAttackTarget(self.target)
  	self:GetParent():MoveToTargetToAttack(self.target)
  	self.duel_end = false
  	if self:GetCaster() == self:GetParent() then 
  		self:GetCaster().particle = ParticleManager:CreateParticle("particles/units/heroes/hero_legion_commander/legion_duel_ring.vpcf", PATTACH_ABSORIGIN, self:GetCaster())
		self:GetCaster():EmitSound("Hero_LegionCommander.Duel")
    	local center_point = self.target:GetAbsOrigin() + ((self:GetCaster():GetAbsOrigin() - self.target:GetAbsOrigin()) / 1)
    	ParticleManager:SetParticleControl(self:GetCaster().particle, 0, center_point)
    	ParticleManager:SetParticleControl(self:GetCaster().particle, 7, center_point)
        self:AddParticle(self:GetCaster().particle, false, false, -1, false, false)
  	end
  	self:StartIntervalThink(0.1)
end
function modifier_duel_buff:DeclareFunctions()
  	return
  	{
    	MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE,
  	}
end
function modifier_duel_buff:CheckState()
	return 
	{
  		-- [MODIFIER_STATE_COMMAND_RESTRICTED] = true,
		[MODIFIER_STATE_IGNORING_MOVE_AND_ATTACK_ORDERS]=true,
		[MODIFIER_STATE_IGNORING_STOP_ORDERS]=true,
  		[MODIFIER_STATE_TAUNTED] = true, 
  		[MODIFIER_STATE_SILENCED] = true,
		[MODIFIER_STATE_MUTED] = true,
	}
end

function modifier_duel_buff:GetModifierIncomingDamage_Percentage(params)
	if not IsServer() then return end
	if not self:GetCaster():HasScepter() then return end
	if params.attacker == self.target then return end
	return -50
end

function modifier_duel_buff:OnDeathEvent(params)
    if params.unit == self.target then
    	if not self.duel_end then
	    	self.duel_end = true
	        self:GetAbility():WinDuel(self:GetParent(), self.target)
	        self:Destroy()
	    end
    end
end

function modifier_duel_buff:OnIntervalThink()
	if not IsServer() then return end	
  	-- self:GetParent():SetForceAttackTarget(self.target)
  	self:GetParent():MoveToTargetToAttack(self.target)
  	if not self.target:IsAlive() or self.target:IsNull() then
  		if not self.duel_end then
  			self.duel_end = true
	       	self:GetAbility():WinDuel(self:GetParent(), self.target)
	       	self:Destroy()
         	return
      	end
  	end
  	if not self.target:HasModifier("modifier_duel_buff") then
  		if not self.duel_end then
	      	self.duel_end = true
	      	self:SetDuration(0.1, true)
	      	return
	    end
 	 end
end

function modifier_duel_buff:OnDestroy()
  	if not IsServer() then return end
 	self:GetCaster():StopSound("Hero_LegionCommander.Duel")
  	if self:GetCaster().particle then 
  		ParticleManager:DestroyParticle(self:GetCaster().particle, false)
  	end
  	-- self:GetParent():SetForceAttackTarget(nil)
  	-- self:GetParent():MoveToPositionAggressive(self:GetParent():GetAbsOrigin())
	ExecuteOrderFromTable({
		UnitIndex = self:GetParent():entindex(),
		OrderType = DOTA_UNIT_ORDER_ATTACK_MOVE,
		Position = self:GetParent():GetAbsOrigin(),
		Queue = false,
	})
    -- local parent = self:GetParent()
    -- Timers:CreateTimer(0.25, function()
    --     parent:SetForceAttackTarget(nil)
    -- end)
end

modifier_duel_damage = class({})
function modifier_duel_damage:IsPurgable() return false end
function modifier_duel_damage:RemoveOnDeath() return false end
function modifier_duel_damage:GetTexture() return "legion_commander_duel" end
function modifier_duel_damage:OnCreated()
    if not IsServer() then return end
    self.shard_duel_damage_bonus = self:GetAbility():GetSpecialValueFor("shard_duel_damage_bonus")
    self:StartIntervalThink(0.25)
end
function modifier_duel_damage:OnIntervalThink()
    if not IsServer() then return end
    local stack_count = 0
    if self.winner_damage then
        stack_count = self.winner_damage
    end
    if self.winner_counter and self:GetCaster():HasShard() then
        stack_count = stack_count + (self.shard_duel_damage_bonus * self.winner_counter)
    end
    self:SetStackCount(stack_count)
end
function modifier_duel_damage:DeclareFunctions()
	return
	{
		MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE
	}
end
function modifier_duel_damage:GetModifierPreAttack_BonusDamage(params)
	local bonus = self:GetStackCount()
	if _G.Players and _G.Players.QueueAttackBonus and params and params.attacker and params.target then
		_G.Players:QueueAttackBonus(params.attacker, params.target, bonus, "legion_commander_duel_damage", DAMAGE_TYPE_PHYSICAL)
	end
	return bonus
end