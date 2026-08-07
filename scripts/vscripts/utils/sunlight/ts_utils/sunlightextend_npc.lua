--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
local ____exports = {}
do
	CDOTA_BaseNPC.HasShard = function(self)
		return self:HasModifier("modifier_item_aghanims_shard")
	end
	CDOTA_BaseNPC.AddNewModifierConsiderStatusResistance = function(self, caster, ability, modifierName, modifierTable)
		if modifierTable and modifierTable.duration and modifierTable.duration > 0 then
			local ____modifierTable_2 = modifierTable
			local ____modifierTable_duration_1 = modifierTable.duration
			local ____temp_0 = self:GetStatusResistance()
			if ____temp_0 == nil then
				____temp_0 = 0
			end
			____modifierTable_2.duration = ____modifierTable_duration_1 * (1 - ____temp_0)
		end
		return self:AddNewModifier(caster, ability, modifierName, modifierTable)
	end
	CDOTA_BaseNPC.SetOnClearGround = function(self, interruptMotionController)
		if interruptMotionController == nil then
			interruptMotionController = false
		end
		Timers:CreateTimer(FrameTime(), function()
			if IsValid(self) then
				local p_pos = self:GetAbsOrigin()
				if not GridNav:CanFindPath(p_pos, p_pos) then
					p_pos = SLGrid:FindNearestValidGrid(p_pos, 2000)
				end
				if p_pos then
					self:SetAbsOrigin(Vector(p_pos.x, p_pos.y, GetGroundHeight(p_pos, self)))
					ResolveNPCPositions(p_pos, self:GetHullRadius())
				end
				FindClearSpaceForUnit(self, self:GetAbsOrigin(), interruptMotionController)
				local forWard = SLVector:Normalized2D(self:GetForwardVector())
				self:SetForwardVectorWithoutInterrupt(forWard)
			end
		end)
	end
	CDOTA_BaseNPC.SetForwardVectorWithoutInterrupt = function(self, direction)
		local angle = VectorToAngles(direction)
		self:SetAbsAngles(angle.x, angle.y, angle.z)
	end
	CDOTA_BaseNPC.FindAllAbilities = function(self)
		local abilityCounts = self:GetAbilityCount()
		local result = {}
		do
			local index = 0
			while index < abilityCounts do
				local ability = self:GetAbilityByIndex(index)
				if IsValid(ability) then
					result[#result + 1] = ability
				end
				index = index + 1
			end
		end
		return result
	end
	CDOTA_BaseNPC.CastAbilityCustom = function(self, ability, target)
		local orderTable = {
			UnitIndex = self:GetEntityIndex(),
			OrderType = nil,
			TargetIndex = nil,
			AbilityIndex = ability:GetEntityIndex(),
			Position = nil,
			Queue = false,
		}
		if ability:GetLevel() < 1 then
			return false
		end
		self:Stop()
		if ability:HasBehavior(DOTA_ABILITY_BEHAVIOR_UNIT_TARGET) then
			if SLType:Is_CDOTA_BaseNPC(target) then
				orderTable.OrderType = DOTA_UNIT_ORDER_CAST_TARGET
				orderTable.TargetIndex = target:GetEntityIndex()
				ExecuteOrderFromTable(orderTable)
				return true
			else
				return false
			end
		elseif ability:HasBehavior(DOTA_ABILITY_BEHAVIOR_POINT) then
			local pos
			if SLType:Is_CDOTA_BaseNPC(target) then
				pos = target:GetAbsOrigin()
			elseif SLType:Is_Vector(target) then
				pos = target
			end
			if pos then
				orderTable.OrderType = DOTA_UNIT_ORDER_CAST_POSITION
				orderTable.Position = pos
				ExecuteOrderFromTable(orderTable)
				return true
			else
				return false
			end
		elseif ability:HasBehavior(DOTA_ABILITY_BEHAVIOR_NO_TARGET) then
			orderTable.OrderType = DOTA_UNIT_ORDER_CAST_NO_TARGET
			ExecuteOrderFromTable(orderTable)
			return true
		elseif ability:IsToggle() then
			orderTable.OrderType = DOTA_UNIT_ORDER_CAST_TOGGLE
			ExecuteOrderFromTable(orderTable)
			return true
		end
		return false
	end
	CDOTA_BaseNPC.IsCurrentlyAnyMotionControlled = function(self)
		return self:IsCurrentlyHorizontalMotionControlled() or self:IsCurrentlyVerticalMotionControlled()
	end
	CDOTA_BaseNPC.IsCurrentlyBothMotionControlled = function(self)
		return self:IsCurrentlyHorizontalMotionControlled() and self:IsCurrentlyVerticalMotionControlled()
	end
	CDOTA_BaseNPC.FindRecentModifierByName = function(self, modifierName)
		local modifiers = self:FindAllModifiersByName(modifierName)
		local recentModifier
		for ____, modifier in ipairs(modifiers) do
			if IsValid(modifier) then
				local ____recentModifier_3 = recentModifier
				if ____recentModifier_3 == nil then
					____recentModifier_3 = modifier
				end
				recentModifier = ____recentModifier_3
				if modifier:GetCreationTime() > recentModifier:GetCreationTime() then
					recentModifier = modifier
				end
			end
		end
		return recentModifier
	end
	CDOTA_BaseNPC.RemoveSelfSafely = function(self, removeAnythingBelong)
		if not IsValid(self) then
			return
		end
		if self.FindAllAbilities then
			for ____, modifier in ipairs(self:FindAllModifiers()) do
				if IsValid(modifier) then
					modifier:Destroy()
				end
			end
		end
		if self.FindAllAbilities then
			for ____, ability in ipairs(self:FindAllAbilities()) do
				if IsValid(ability) then
					self:RemoveAbilityByHandle(ability)
				end
			end
		end
		if self.HasInventory and self:HasInventory() then
			do
				local index = 0
				while index <= 18 do
					local item = self:GetItemInSlot(index)
					if IsValid(item) then
						self:RemoveItem(item)
					end
					index = index + 1
				end
			end
		end
		if self.GetChildren then
			for ____, child in ipairs(self:GetChildren()) do
				if IsValid(child) then
					UTIL_Remove(child)
				end
			end
		end
		if removeAnythingBelong then
			local allEnts = Entities:FindAllInSphere(Vector(0, 0, 0), 999999)
			if allEnts then
				for ____, ent in ipairs(allEnts) do
					if IsValid(ent) and ent.GetOwner and ent:GetOwner() == self then
						UTIL_Remove(ent)
					end
				end
			end
		end
		self:SetAbsOrigin(Vector(0, 0, -9999))
		UTIL_Remove(self)
	end
	CDOTA_BaseNPC.FindAllItems = function(self)
		local result = {}
		do
			local index = 0
			while index <= DOTA_ITEM_TRANSIENT_CAST_ITEM do
				local item = self:GetItemInSlot(index)
				if IsValid(item) then
					result[#result + 1] = item
				end
				index = index + 1
			end
		end
		return result
	end
	CDOTA_BaseNPC.AddShardModifier = function(self)
		self:AddNewModifier(self, nil, "modifier_item_aghanims_shard", {})
	end
	CDOTA_BaseNPC.RemoveShardModifier = function(self)
		self:RemoveAllModifiersOfName("modifier_item_aghanims_shard")
	end
end
return ____exports