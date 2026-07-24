--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


pudge_flesh_heap_lua = class({})
modifier_pudge_flesh_heap_lua = class({})
modifier_pudge_flesh_heap_lua_block = class({})

LinkLuaModifier( "modifier_pudge_flesh_heap_lua", "heroes/hero_pudge/pudge_flesh_heap_lua" ,LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_pudge_flesh_heap_lua_block", "heroes/hero_pudge/pudge_flesh_heap_lua" ,LUA_MODIFIER_MOTION_NONE )


function pudge_flesh_heap_lua:GetIntrinsicModifierName()
	return "modifier_pudge_flesh_heap_lua"
end

-- Refresh modifier on hero level up
function pudge_flesh_heap_lua:OnHeroLevelUp()
	if self:GetLevel() == 0 or (not IsServer()) then return end

	local caster = self:GetCaster()
	local modifier = caster:FindModifierByName("modifier_pudge_flesh_heap_lua")

	if not modifier or modifier:IsNull() then return end

	modifier:ForceRefresh()

end

function pudge_flesh_heap_lua:OnSpellStart()
	local caster = self:GetCaster()
	caster:AddNewModifier(caster, self, "modifier_pudge_flesh_heap_lua_block", { duration = self:GetSpecialValueFor("duration")})
end

--------------------------------------------------------------------------------
-- On created

function modifier_pudge_flesh_heap_lua_block:OnCreated( kv )
end

function modifier_pudge_flesh_heap_lua_block:IsHidden()
	return false
end

function modifier_pudge_flesh_heap_lua_block:RemoveOnDeath() return true end
function modifier_pudge_flesh_heap_lua_block:IsPurgable() return true end
function modifier_pudge_flesh_heap_lua_block:IsDebuff() return false end
function modifier_pudge_flesh_heap_lua_block:DeclareFunctions() 
	local funcs = {
		MODIFIER_PROPERTY_TOTAL_CONSTANT_BLOCK
	}
	return funcs
end

function modifier_pudge_flesh_heap_lua_block:GetModifierTotal_ConstantBlock() 
	-- print(self:GetAbility():GetSpecialValueFor("damage_block"))
	return self:GetAbility():GetSpecialValueFor("damage_block")
end


--------------------------------------------------------------------------------

function modifier_pudge_flesh_heap_lua:IsHidden()
	local ability = self:GetAbility()
	if ability and ability:GetLevel() == 0 then
		return true
	end
	return false
end

function modifier_pudge_flesh_heap_lua:RemoveOnDeath() return false end
function modifier_pudge_flesh_heap_lua:IsPurgable() return false end
function modifier_pudge_flesh_heap_lua:IsDebuff() return false end

--------------------------------------------------------------------------------
-- On created

function modifier_pudge_flesh_heap_lua:OnCreated( kv )
	self:SetHasCustomTransmitterData( true )
	if not IsServer() then return end

	self.delay = 2

	self.listener = ListenToGameEvent("dota_player_learned_ability", Dynamic_Wrap(modifier_pudge_flesh_heap_lua, "OnPlayerLearnedAbility" ), self)

	local ability = self:GetAbility() or nil
	local caster = self:GetCaster() or nil
	if not ability then
		caster:RemoveModifierByName("modifier_pudge_flesh_heap_lua")
		if caster.CalculateStatBonus then
		   caster:CalculateStatBonus(false)
		end
		if self.listener then
			StopListeningToGameEvent(self.listener)
		end
		return
	end

	self.fleshHeapRange = ability:GetSpecialValueFor( "aura_radius" ) or 0
	self.flesh_heap_buff_amount_kill = ability:GetSpecialValueFor( "strength_per_kill" ) or 0
	self.magic_resist = ability:GetSpecialValueFor( "magic_resistance" ) or 0

    if caster and not caster:IsNull() and caster.GetKills then
		self.nKills = caster:GetKills() + caster:GetAssists() or 0
		self.strength_bonus_total = self.nKills * self.flesh_heap_buff_amount_kill
		self:SetStackCount(math.floor(self.strength_bonus_total+0.5))
		if caster.CalculateStatBonus then
		   caster:CalculateStatBonus(false)
		end
    end
end

--------------------------------------------------------------------------------
-- Refresh ability

function modifier_pudge_flesh_heap_lua:OnRefresh()
	if not IsServer() then return end

	--------------------------------------------------------------------------------
	-- Check if hero does not have flesh heap, remove modifier if it doesn't

	local ability = self:GetAbility()
	local caster = self:GetCaster()
	if (not ability) or (ability:IsNull()) then
		self:GetParent():RemoveModifierByName("modifier_pudge_flesh_heap_lua")
		if self:GetParent().CalculateStatBonus then
		   self:GetParent():CalculateStatBonus(false)
		end
		return
	end

	self.flesh_heap_buff_amount_kill = ability:GetSpecialValueFor( "strength_per_kill" ) or 0
	self.magic_resist = ability:GetSpecialValueFor( "magic_resistance" ) or 0
  
    if self.nKills ==nil then
		if caster and caster.GetKills then
	      self.nKills = caster:GetKills() + caster:GetAssists()
	    else
	   	  self.nKills = 1
	    end
	end

	self.strength_bonus_total = self.nKills * self.flesh_heap_buff_amount_kill
	self:SetStackCount(math.floor(self.strength_bonus_total+0.5))

	if caster.CalculateStatBonus then
	   caster:CalculateStatBonus(false)
	end

	self:SendBuffRefreshToClients()
end

--------------------------------------------------------------------------------
-- On ability skilled

function modifier_pudge_flesh_heap_lua:OnPlayerLearnedAbility( keys )
	if IsClient() then return end
	if keys.abilityname == "special_bonus_unique_pudge_1" and self and not self:IsNull() then
		self:ForceRefresh()
	end
end

--------------------------------------------------------------------------------
-- Flesh heap gives bonus strength, magic resist and uses an on death event

function modifier_pudge_flesh_heap_lua:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_STATS_STRENGTH_BONUS,
		MODIFIER_PROPERTY_MAGICAL_RESISTANCE_BONUS,
		MODIFIER_EVENT_ON_DEATH
	}
	return funcs
end

function modifier_pudge_flesh_heap_lua:GetModifierBonusStats_Strength() return self.strength_bonus_total end
function modifier_pudge_flesh_heap_lua:GetModifierMagicalResistanceBonus() return self.magic_resist end

--------------------------------------------------------------------------------
-- On death

function modifier_pudge_flesh_heap_lua:OnDeath(keys)
	if not IsServer() or not keys.unit or not keys.attacker or keys.unit:IsReincarnating() then return end

	if keys.attacker.GetPlayerOwner == nil then
		return
	end

	local hKiller = keys.attacker:GetPlayerOwner()
	local hVictim = keys.unit
	local caster = self:GetCaster()
	local ability = self:GetAbility()
	local flKillHeroMultiple = self:GetAbility():GetSpecialValueFor("kill_hero_multiple")

	if not (hVictim and caster and ability) then return end

	if caster:GetTeamNumber() ~= hVictim:GetTeamNumber() and caster:IsAlive() then
		--召唤生物，马尔斯士兵,猴子猴孙 无效，防止开黑对刷
		if not hVictim:IsSummoned() and hVictim:GetUnitName()~="aghsfort_mars_bulwark_soldier" and (not hVictim:HasModifier("modifier_monkey_king_fur_army_soldier")) and (not hVictim:HasModifier("modifier_monkey_king_fur_army_soldier_hidden")) then
			local vToCaster = caster:GetOrigin() - hVictim:GetOrigin()
			local flDistance = vToCaster:Length2D()
			if hKiller == caster:GetPlayerOwner() or self.fleshHeapRange >= flDistance then
				local hBuff = caster:FindModifierByName( "modifier_pudge_flesh_heap_lua" )
				if not hBuff then
					caster:AddNewModifier( caster, self, "modifier_pudge_flesh_heap_lua", {} )
				end

				local nStackToAdd = 1
				--如果击杀英雄
				if hVictim:IsRealHero() and not hVictim:IsTempestDouble() and not hVictim:HasModifier("modifier_arc_warden_tempest_double_lua") then
				   nStackToAdd = flKillHeroMultiple * 1
				end

				if self.nKills ==nil then
				   if caster.GetKills then
				     self.nKills = (caster:GetKills() + caster:GetAssists())*flKillHeroMultiple +nStackToAdd
				   else
				   	 self.nKills = nStackToAdd
				   end
				else
	               self.nKills = self.nKills + nStackToAdd
				end
				
				self.strength_bonus_total = self.nKills * self.flesh_heap_buff_amount_kill
				self:SetStackCount(math.floor(self.strength_bonus_total+0.5))
                
                if caster.CalculateStatBonus then
				  caster:CalculateStatBonus(false)
				end

			end
		end
	end
end

--------------------------------------------------------------------------------
-- Set transmitter data for strength and magic resist

function modifier_pudge_flesh_heap_lua:AddCustomTransmitterData( )
	return
	{
		strength = self.strength_bonus_total,
		magic_resist = self.magic_resist,
	}
end

--------------------------------------------------------------------------------
-- Use transmitter data

function modifier_pudge_flesh_heap_lua:HandleCustomTransmitterData( data )
	self.strength_bonus_total = data.strength
	self.magic_resist = data.magic_resist
end


if not IsServer() then return end

function modifier_pudge_flesh_heap_lua:OnRemoved()
	if self.listener then
		StopListeningToGameEvent(self.listener)
	end
end