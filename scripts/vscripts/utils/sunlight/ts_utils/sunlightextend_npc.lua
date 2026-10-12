--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


-- utils/sunlight/ts_utils/SunLightExtend_NPC.lua
local ____debugRuntime = require("utils.debug_runtime")
local debug = ____debugRuntime.safe_debug
--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
____debugRuntime.register(
	"utils/sunlight/ts_utils/SunLightExtend_NPC.lua",
	{
		["8"] = "98:5",
		["9"] = "99:9",
		["10"] = "98:30",
		["11"] = "102:5",
		["12"] = "109:13",
		["13"] = "110:13",
		["14"] = "110:41",
		["15"] = "110:75",
		["17"] = "110:75",
		["19"] = "110:13",
		["21"] = "112:9",
		["22"] = "102:60",
		["23"] = "115:5",
		["24"] = "115:69",
		["25"] = "115:69",
		["27"] = "117:9",
		["28"] = "117:28",
		["29"] = "117:41",
		["30"] = "118:17",
		["31"] = "119:21",
		["32"] = "120:22",
		["33"] = "121:21",
		["35"] = "123:21",
		["36"] = "124:21",
		["37"] = "124:46",
		["38"] = "124:55",
		["39"] = "124:64",
		["40"] = "124:39",
		["41"] = "125:21",
		["42"] = "125:41",
		["43"] = "125:48",
		["44"] = "125:21",
		["46"] = "127:17",
		["47"] = "127:39",
		["48"] = "127:45",
		["49"] = "127:66",
		["50"] = "127:17",
		["51"] = "128:23",
		["52"] = "129:17",
		["54"] = "117:41",
		["55"] = "117:9",
		["56"] = "115:38",
		["57"] = "134:5",
		["58"] = "135:15",
		["59"] = "136:9",
		["60"] = "134:54",
		["61"] = "139:5",
		["62"] = "140:15",
		["63"] = "141:15",
		["65"] = "142:18",
		["66"] = "142:29",
		["67"] = "143:19",
		["68"] = "144:17",
		["69"] = "145:17",
		["71"] = "142:52",
		["74"] = "148:9",
		["75"] = "139:38",
		["76"] = "151:5",
		["77"] = "152:15",
		["78"] = "153:13",
		["79"] = "154:13",
		["80"] = "155:13",
		["81"] = "156:13",
		["82"] = "157:13",
		["83"] = "158:13",
		["84"] = "152:49",
		["85"] = "160:13",
		["86"] = "160:37",
		["88"] = "162:9",
		["89"] = "163:13",
		["90"] = "165:17",
		["91"] = "166:17",
		["92"] = "167:17",
		["93"] = "168:17",
		["94"] = "169:17",
		["96"] = "171:17",
		["98"] = "173:20",
		["99"] = "175:17",
		["100"] = "176:17",
		["101"] = "177:17",
		["102"] = "178:24",
		["103"] = "179:17",
		["105"] = "181:17",
		["106"] = "182:17",
		["107"] = "183:17",
		["108"] = "184:17",
		["109"] = "185:17",
		["111"] = "187:17",
		["113"] = "189:20",
		["114"] = "191:13",
		["115"] = "192:13",
		["116"] = "193:13",
		["117"] = "194:20",
		["118"] = "196:13",
		["119"] = "197:13",
		["120"] = "198:13",
		["122"] = "200:9",
		["123"] = "151:39",
		["124"] = "203:5",
		["125"] = "204:9",
		["126"] = "203:52",
		["127"] = "207:5",
		["128"] = "208:9",
		["129"] = "207:53",
		["130"] = "211:5",
		["131"] = "212:15",
		["132"] = "213:13",
		["133"] = "214:9",
		["134"] = "215:17",
		["135"] = "216:34",
		["137"] = "216:34",
		["139"] = "216:17",
		["140"] = "217:21",
		["141"] = "218:21",
		["145"] = "222:9",
		["146"] = "211:46",
		["147"] = "225:5",
		["148"] = "226:14",
		["151"] = "228:13",
		["152"] = "229:13",
		["153"] = "230:21",
		["154"] = "231:21",
		["158"] = "235:13",
		["159"] = "236:13",
		["160"] = "237:21",
		["161"] = "238:21",
		["165"] = "243:13",
		["167"] = "244:22",
		["168"] = "244:33",
		["169"] = "245:23",
		["170"] = "246:21",
		["171"] = "247:21",
		["173"] = "244:46",
		["177"] = "252:13",
		["178"] = "253:13",
		["179"] = "254:21",
		["180"] = "255:21",
		["184"] = "260:13",
		["185"] = "261:19",
		["186"] = "261:54",
		["187"] = "261:71",
		["188"] = "261:29",
		["189"] = "262:17",
		["190"] = "263:17",
		["191"] = "264:25",
		["192"] = "265:25",
		["197"] = "271:9",
		["198"] = "272:9",
		["199"] = "225:38",
		["200"] = "275:5",
		["201"] = "276:15",
		["203"] = "277:18",
		["204"] = "277:29",
		["205"] = "278:19",
		["206"] = "279:17",
		["207"] = "280:17",
		["209"] = "277:73",
		["212"] = "283:9",
		["213"] = "275:34",
		["214"] = "286:5",
		["215"] = "287:9",
		["216"] = "286:38",
		["217"] = "290:5",
		["218"] = "291:9",
		["219"] = "290:41",
	}
)
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