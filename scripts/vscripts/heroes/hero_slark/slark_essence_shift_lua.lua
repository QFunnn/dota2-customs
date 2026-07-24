--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier('modifier_slark_essence_shift_lua', 'heroes/hero_slark/slark_essence_shift_lua.lua', LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier('modifier_slark_essence_shift_lua_agi', 'heroes/hero_slark/slark_essence_shift_lua.lua', LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier('modifier_slark_essence_shift_lua_agi_debuff', 'heroes/hero_slark/slark_essence_shift_lua.lua', LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier('modifier_slark_essence_shift_lua_agi_permenant', 'heroes/hero_slark/slark_essence_shift_lua.lua', LUA_MODIFIER_MOTION_NONE)


slark_essence_shift_lua = class({})

function slark_essence_shift_lua:GetIntrinsicModifierName()
	return 'modifier_slark_essence_shift_lua'
end

--------------------------------------------------------------------------------
--== Main Modifier ==--

modifier_slark_essence_shift_lua = class({})

function modifier_slark_essence_shift_lua:IsHidden()
	return true
end

function modifier_slark_essence_shift_lua:IsDebuff() return false end
function modifier_slark_essence_shift_lua:IsPurgable() return false end

function modifier_slark_essence_shift_lua:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_PROCATTACK_FEEDBACK,
		MODIFIER_EVENT_ON_MODIFIER_ADDED,
	}
	return funcs
end

function modifier_slark_essence_shift_lua:OnRefresh(keys)
	self.parent = self:GetParent()
	self.ability = self:GetAbility()
	self.duration = self.ability:GetSpecialValueFor('duration')
end


-- Set creep stacks to 0 when entering the fountain
function modifier_slark_essence_shift_lua:OnModifierAdded(keys)
	if IsServer() and keys.unit == self.parent and self.parent:HasModifier('modifier_hero_refreshing') then self:SetStackCount(0) end
end

function modifier_slark_essence_shift_lua:OnDeathEvent(keys)
	if keys.unit == self.parent 
		then self:SetStackCount(0) 
	end
  local unit_killed = keys.unit
  
  if unit_killed and  unit_killed:IsRealHero()  and self.parent:GetTeamNumber() ~= unit_killed:GetTeamNumber() and  (not unit_killed:IsIllusion()) and (not unit_killed:IsTempestDouble()) and (not unit_killed:HasModifier("modifier_arc_warden_tempest_double_lua"))  then
     local flDistance =  (self.parent:GetOrigin() - unit_killed:GetOrigin()):Length2D()
     if flDistance<1000 then
         if self.parent:HasModifier("modifier_slark_essence_shift_lua_agi_permenant") then
         	  local nStack = self.parent:GetModifierStackCount("modifier_slark_essence_shift_lua_agi_permenant",self.parent)
         	  self.parent:FindModifierByName("modifier_slark_essence_shift_lua_agi_permenant"):SetStackCount(nStack+1)
         else
         	  local hModifier=self.parent:AddNewModifier(self.parent, self.ability, "modifier_slark_essence_shift_lua_agi_permenant", {})
              if hModifier and (not hModifier:IsNull()) then
                hModifier:SetStackCount(1)
              end
         end
     end
  end

end

function modifier_slark_essence_shift_lua:GetModifierProcAttack_Feedback(keys)
	if keys.no_attack_cooldown then
		return
	end
	
	if keys.target== nil then
		return
	end
	
	if keys.target:IsNull() then
		return
	end

	if not keys.target:IsAlive() then
		return
	end

	if self.parent:IsIllusion() or self.parent:PassivesDisabled() then return end
	if keys.target:GetTeam() == self.parent:GetTeam() then return end

	local particle_cast = ParticleManager:GetParticleReplacement('particles/units/heroes/hero_slark/slark_essence_shift.vpcf', self.parent)
	local effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_ABSORIGIN_FOLLOW, keys.target)
	ParticleManager:SetParticleControl(effect_cast, 0, keys.target:GetAbsOrigin() + Vector(0, 0, 64))
	ParticleManager:SetParticleControl(effect_cast, 1, self.parent:GetAbsOrigin() + Vector(0, 0, 64))
	ParticleManager:ReleaseParticleIndex(effect_cast)

	local modifier = self.parent:AddNewModifier(self.parent, self:GetAbility(), "modifier_slark_essence_shift_lua_agi", {duration = self.duration})
	if modifier and not modifier:IsNull() then
		modifier:AddIndependentStack(self.duration, nil, true, {stacks=1})
	end

	if keys.target:IsRealHero() then
		local modifier_enemy = keys.target:AddNewModifier(self.parent, self:GetAbility(), "modifier_slark_essence_shift_lua_agi_debuff", {duration = self.duration})
		if modifier_enemy and not modifier_enemy:IsNull() then
			modifier_enemy:AddIndependentStack(self.duration, nil, true, {stacks=1})
		end
	end
end

modifier_slark_essence_shift_lua_agi = class({})

function modifier_slark_essence_shift_lua_agi:GetTexture() return "slark_essence_shift"  end
function modifier_slark_essence_shift_lua_agi:IsHidden()
	return self:GetStackCount() == 0
end
function modifier_slark_essence_shift_lua_agi:IsDebuff() return false end
function modifier_slark_essence_shift_lua_agi:IsPurgable() return false end
function modifier_slark_essence_shift_lua_agi:GetAttributes() return MODIFIER_ATTRIBUTE_PERMANENT end

function modifier_slark_essence_shift_lua_agi:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_STATS_AGILITY_BONUS
	}
end

function modifier_slark_essence_shift_lua_agi:GetModifierBonusStats_Agility()
	local ability = self:GetAbility()
	local bonus = 0
	if ability then
		bonus = ability:GetSpecialValueFor("agi_gain")
	end
	return self:GetStackCount() * bonus
end

modifier_slark_essence_shift_lua_agi_debuff = class({})

function modifier_slark_essence_shift_lua_agi_debuff:GetTexture() return "slark_essence_shift"  end
function modifier_slark_essence_shift_lua_agi_debuff:IsHidden()
	return self:GetStackCount() == 0
end

function modifier_slark_essence_shift_lua_agi_debuff:IsDebuff() return true end
function modifier_slark_essence_shift_lua_agi_debuff:IsPurgable() return false end

function modifier_slark_essence_shift_lua_agi_debuff:OnCreated()
	self:OnRefresh()
end

function modifier_slark_essence_shift_lua_agi_debuff:OnRefresh()
	local ability = self:GetAbility()
	if ability then
		self.StatsLossPerStack = ability:GetSpecialValueFor("stat_loss")
	end
end

function modifier_slark_essence_shift_lua_agi_debuff:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_STATS_AGILITY_BONUS,
		MODIFIER_PROPERTY_STATS_STRENGTH_BONUS,
		MODIFIER_PROPERTY_STATS_INTELLECT_BONUS,
		MODIFIER_PROPERTY_TOOLTIP,
	}
end

function modifier_slark_essence_shift_lua_agi_debuff:GetModifierBonusStats_Agility()
	return self:GetStackCount() * -(self.StatsLossPerStack or 0)
end

function modifier_slark_essence_shift_lua_agi_debuff:GetModifierBonusStats_Strength()
	return self:GetStackCount() * -(self.StatsLossPerStack or 0)
end

function modifier_slark_essence_shift_lua_agi_debuff:GetModifierBonusStats_Intellect()
	return self:GetStackCount() * -(self.StatsLossPerStack or 0)
end

function modifier_slark_essence_shift_lua_agi_debuff:OnTooltip()
	return self:GetStackCount()
end

modifier_slark_essence_shift_lua_agi_permenant = class({})

function modifier_slark_essence_shift_lua_agi_permenant:GetTexture() return "slark_essence_shift"  end
function modifier_slark_essence_shift_lua_agi_permenant:IsHidden()
	return self:GetStackCount() == 0
end

function modifier_slark_essence_shift_lua_agi_permenant:IsPermanent()
	return true
end
function modifier_slark_essence_shift_lua_agi_permenant:IsDebuff() return false end
function modifier_slark_essence_shift_lua_agi_permenant:IsPurgable() return false end
function modifier_slark_essence_shift_lua_agi_permenant:GetAttributes() return MODIFIER_ATTRIBUTE_PERMANENT end

function modifier_slark_essence_shift_lua_agi_permenant:OnCreated()
	if not IsServer() then return end
end

function modifier_slark_essence_shift_lua_agi_permenant:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_STATS_AGILITY_BONUS
	}
end

function modifier_slark_essence_shift_lua_agi_permenant:GetModifierBonusStats_Agility()
	return self:GetStackCount()
end