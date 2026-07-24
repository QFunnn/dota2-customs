--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_bane_fiends_grip_lua", "heroes/hero_bane/bane_fiends_grip_lua.lua", LUA_MODIFIER_MOTION_NONE)
-- LinkLuaModifier("modifier_bane_fiends_grip_lua_tick", "heroes/hero_bane/bane_fiends_grip_lua.lua", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_bane_fiends_grip_lua_illusion", "heroes/hero_bane/bane_fiends_grip_lua.lua", LUA_MODIFIER_MOTION_NONE)
--Abilities
if bane_fiends_grip_lua == nil then
	bane_fiends_grip_lua = class({})
end
function bane_fiends_grip_lua:GetChannelAnimation()
	return ACT_DOTA_CHANNEL_ABILITY_4
end
function bane_fiends_grip_lua:OnSpellStart()
	local hCaster = self:GetCaster()
	local hTarget = self:GetCursorTarget()
	self.target = hTarget
	local illusion_count = self:GetSpecialValueFor("illusion_count")
	local duration = math.max(self:GetChannelTime(), 4.75)

	if self.tTargets == nil then
		self.tTargets = {}
	end

	local bTriggerSpellAbsorb = false
	if not hCaster:IsIllusion() then
		bTriggerSpellAbsorb = hTarget:TriggerSpellAbsorb(self)
	else
		hTarget:TriggerSpellReflect(self)
	end
	if (not bTriggerSpellAbsorb) and IsValid(hTarget) and hTarget:IsAlive() then
		hTarget:AddNewModifier(hCaster, self, "modifier_bane_fiends_grip_lua", { duration = self:GetChannelTime() * hTarget:GetStatusResistanceFactor(hCaster) })
		self.tTargets[hTarget:entindex()] = true

		if not hCaster:IsIllusion() then
			-- hCaster:AddNewModifier(hCaster, self, "modifier_bane_fiends_grip_lua_tick", { duration = self:GetChannelTime() * hTarget:GetStatusResistanceFactor(hCaster), target_index = hTarget:entindex() })

			for i = 1, illusion_count do
				local dir = hCaster:GetRightVector()
				local pos = hCaster:GetAbsOrigin() + (3 - 2 * i) * dir * 400
				if IsValid(hTarget) and hTarget:IsAlive() then
					CreateUnitByNameAsync(hCaster:GetUnitName(), pos, true, hCaster, hCaster, hCaster:GetTeamNumber(), function(illusion)
						for i = 1, hCaster:GetLevel() - 1 do
							illusion:HeroLevelUp(false)
						end

						illusion:AddNewModifier(hCaster, self, "modifier_illusion", { duration = duration })
						illusion:AddNewModifier(hCaster, self, "modifier_bane_fiends_grip_lua_illusion", { duration = duration })

						illusion:SetControllableByPlayer(hCaster:GetPlayerOwnerID(), false)

						if IsValid(self) and IsValid(hTarget) and hTarget:IsAlive() then
							illusion:SetContextThink(DoUniqueString("bane_fiends_grip_lua"), function()
								local ability = illusion:FindAbilityByName("bane_fiends_grip_lua")
								if IsValid(ability) then
									ability:SetLevel(self:GetLevel())
									ExecuteOrderFromTable({
										UnitIndex = illusion:entindex(),
										OrderType = DOTA_UNIT_ORDER_CAST_TARGET,
										TargetIndex = hTarget:entindex(),
										AbilityIndex = ability:entindex(),
										Queue = false,
									})
									illusion:MakeIllusion()
								else
									illusion:MakeIllusion()
									illusion:ForceKill(false)
								end

								return nil
							end, 0)
						else
							illusion:MakeIllusion()
							illusion:ForceKill(false)
						end
					end)
				end
			end

		end
	end

end
function bane_fiends_grip_lua:OnChannelThink(flInterval)
	local hCaster = self:GetCaster()
	local hTarget = self.target
	local bShouldStop = false

	if not IsValid(hTarget) then
		bShouldStop = true
	elseif not hTarget:IsAlive() then
		bShouldStop = true
	end
	if IsValid(hTarget) and not hTarget:HasModifier("modifier_bane_fiends_grip_lua") then
		bShouldStop = true
	end
	if bShouldStop then
		if IsValid(hCaster) then
			hCaster:InterruptChannel()
		end
	end
end
function bane_fiends_grip_lua:OnChannelFinish(bInterrupted)
	local hCaster = self:GetCaster()
	local hTarget = self:GetCursorTarget()

	if IsValid(hTarget) then
		hTarget:RemoveModifierByName("modifier_bane_fiends_grip_lua")
	else
		if self.tTargets and type(self.tTargets) == "table" then
			for index, bIsTarget in pairs(self.tTargets) do
				local hLoopTarget = EntIndexToHScript(index)
				if IsValid(hLoopTarget) and hLoopTarget:IsAlive() and hLoopTarget:HasModifier("modifier_bane_fiends_grip_lua") then
					hLoopTarget:RemoveModifierByName("modifier_bane_fiends_grip_lua")
				end
				self.tTargets[index] = nil
			end
		end
	end
	self.tTargets = nil
	if hCaster:IsIllusion() then
		hCaster:ForceKill(false)
	end
end
---------------------------------------------------------------------
--Modifiers
if modifier_bane_fiends_grip_lua == nil then
	modifier_bane_fiends_grip_lua = class({})
end
function modifier_bane_fiends_grip_lua:OnCreated(params)
	self.fiend_grip_mana_drain = self:GetAbilitySpecialValueFor("fiend_grip_mana_drain")
	self.fiend_grip_damage = self:GetAbilitySpecialValueFor("fiend_grip_damage")
	self.fiend_grip_tick_interval = self:GetAbilitySpecialValueFor("fiend_grip_tick_interval")
	if IsServer() then
		self:StartIntervalThink(self.fiend_grip_tick_interval)
		self:OnIntervalThink()
	end
end
function modifier_bane_fiends_grip_lua:OnRefresh(params)
	self.fiend_grip_mana_drain = self:GetAbilitySpecialValueFor("fiend_grip_mana_drain")
	self.fiend_grip_damage = self:GetAbilitySpecialValueFor("fiend_grip_damage")
	self.fiend_grip_tick_interval = self:GetAbilitySpecialValueFor("fiend_grip_tick_interval")
	if IsServer() then
	end
end
function modifier_bane_fiends_grip_lua:OnDestroy()
	if IsServer() then
	end
end
function modifier_bane_fiends_grip_lua:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_OVERRIDE_ANIMATION
	}
end
function modifier_bane_fiends_grip_lua:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end
function modifier_bane_fiends_grip_lua:GetEffectName()
	return "particles/units/heroes/hero_bane/bane_fiends_grip.vpcf"
end
function modifier_bane_fiends_grip_lua:CheckState()
	return {
		[MODIFIER_STATE_STUNNED] = true
	}
end
function modifier_bane_fiends_grip_lua:GetAttributes()
	return MODIFIER_ATTRIBUTE_MULTIPLE
end
function modifier_bane_fiends_grip_lua:GetOverrideAnimation()
	return ACT_DOTA_FLAIL
end
function modifier_bane_fiends_grip_lua:OnIntervalThink()
	local hCaster = self:GetCaster()
	local name = self:GetName()
	local hParent = self:GetParent()
	local buffs = hParent:FindAllModifiersByName(name)


	if IsValid(hParent) and IsValid(hCaster) and hCaster:IsAlive() and hParent:IsAlive() then
		if self == buffs[1] then
			ApplyDamage {
				victim = hParent,
				attacker = hCaster,
				damage = self.fiend_grip_damage * self.fiend_grip_tick_interval,
				damage_type = DAMAGE_TYPE_PURE,
				ability = self:GetAbility()
			}

			hCaster:GiveMana(hParent:GetMaxMana() * self.fiend_grip_mana_drain * 0.01 * self.fiend_grip_tick_interval)
			hParent:Script_ReduceMana(hParent:GetMaxMana() * self.fiend_grip_mana_drain * 0.01 * self.fiend_grip_tick_interval, self:GetAbility())
		end
	else
		self:Destroy()
	end
end
---------------------------------------------------------------------
--Modifiers
if modifier_bane_fiends_grip_lua_illusion == nil then
	modifier_bane_fiends_grip_lua_illusion = class({})
end
function modifier_bane_fiends_grip_lua_illusion:IsHidden()
	return true
end
function modifier_bane_fiends_grip_lua_illusion:IsDebuff()
	return false
end
function modifier_bane_fiends_grip_lua_illusion:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE,
		MODIFIER_PROPERTY_CASTTIME_PERCENTAGE,
		MODIFIER_PROPERTY_CAST_RANGE_BONUS,
	}
end
function modifier_bane_fiends_grip_lua_illusion:OnCreated(params)
	self.scepter_incoming_illusion_damage = self:GetAbilitySpecialValueFor("scepter_incoming_illusion_damage")
	if IsServer() then
		self:StartIntervalThink(0.3)
	end
end
function modifier_bane_fiends_grip_lua_illusion:OnRefresh(params)
	self.scepter_incoming_illusion_damage = self:GetAbilitySpecialValueFor("scepter_incoming_illusion_damage")
	if IsServer() then
	end
end
function modifier_bane_fiends_grip_lua_illusion:GetModifierIncomingDamage_Percentage()
	return self.scepter_incoming_illusion_damage
end
function modifier_bane_fiends_grip_lua_illusion:GetModifierPercentageCasttime()
	return 100
end
function modifier_bane_fiends_grip_lua_illusion:GetModifierCastRangeBonus()
	return 1000
end
function modifier_bane_fiends_grip_lua_illusion:OnIntervalThink()
	local hParent = self:GetParent()
	if not hParent:IsChanneling() then
		hParent:MakeIllusion()
		hParent:ForceKill(false)
	end
end