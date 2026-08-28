--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "class/client_item"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ArrayForEach
local e = {}
e.ClientItem = c()
local f = e.ClientItem
f.name = "ClientItem"
function f.prototype.____constructor(self, g, h, i, j)
	self.isDispose = false
	self.isLanded = false
	self.Quantitylimit = 9999999
	self.particleIDs = {}
	self.minOffset = 10
	self.maxOffset = 100
	self.minOffset = j and j[1] or self.minOffset
	self.maxOffset = j and j[2] or self.maxOffset
	self.playerID = g
	self.itemID = h
	self.position = GetGroundPosition(i, nil)
	self.propType = GetItemPropType(self.itemID)
	local k = GetPropRarity(self.itemID)
	self.id = DoUniqueString(tostring(h))
	self.entity = SpawnEntityFromTableSynchronous(
		"dota_prop_customtexture",
		{
			angles = "0 0 0",
			model = self:GetModel(),
			origin = i,
			skin = "default",
			targetname = "client_item",
			StartingAnim = "ACT_DOTA_IDLE",
			StartingAnimationLoopMode = "ANIM_LOOP_MODE_LOOPING",
		}
	)
	CustomNetTables:SetNetData(
		"dropped_item",
		tostring(self.entity:GetEntityIndex()),
		{
			kind = "client",
			item_id = tostring(self.itemID),
			owner_player_id = self.playerID,
			rarity = k,
			show_tip = self.propType ~= "99",
		}
	)
	self.entity:AddEffects(EF_NODRAW)
	local l = PlayerResource:GetPlayer(g)
	if l ~= nil then
		local m = ParticleManager:CreateParticleForPlayer(
			self:GetDropParticlePath(),
			PATTACH_ABSORIGIN_FOLLOW,
			self.entity,
			l
		)
		ParticleManager:SetParticleControlEnt(m, 1, self.entity, PATTACH_INVALID, nil, self.entity:GetAbsOrigin(), true)
		local n = self.particleIDs
		n[#n + 1] = m
		local o = self:GetDropRarityParticlePath(k)
		if o ~= nil then
			local p = ParticleManager:CreateParticleForPlayer(o, PATTACH_ABSORIGIN_FOLLOW, self.entity, l)
			ParticleManager:SetParticleControlEnt(
				p,
				1,
				self.entity,
				PATTACH_INVALID,
				nil,
				self.entity:GetAbsOrigin(),
				true
			)
			local q = self.particleIDs
			q[#q + 1] = p
		end
		if self.propType ~= "99" then
			local r = "Drop.Item"
			if self.propType == "9" then
				local s = GetItemEquipmentPart(self.itemID)
				if s == "1" or s == "2" then
					r = "Drop.Weapon"
				else
					r = "Drop.Equip"
				end
			end
			l:EmitSound("Drop.Weapon")
		end
	end
	local t = RandomVector(RandomInt(self.minOffset, self.maxOffset))
	self.landedPosition = Vector(self.position.x + t.x, self.position.y - math.abs(t.y), self.position.z + t.z)
	self.entity:GameTimer(0.1, function()
		self:StartDropAnimation()
	end)
end
function f.prototype.GetDropParticlePath(self)
	if self.propType == "99" then
		return "particles/generic_gameplay/boss_chest.vpcf"
	end
	return "particles/generic_gameplay/generic_client_item.vpcf"
end
function f.prototype.GetDropRarityParticlePath(self, u)
	if u == 6 then
		return "particles/generic_gameplay/items/equipment_drop_items_fx.vpcf"
	elseif u == 5 then
		return "particles/generic_gameplay/items/equipment_drop_items_01_fx.vpcf"
	elseif u == 4 then
		return "particles/generic_gameplay/items/equipment_drop_items_purple_fx.vpcf"
	elseif u == 3 then
		return "particles/generic_gameplay/items/equipment_drop_items_blue_fx.vpcf"
	elseif u == 2 then
		return "particles/generic_gameplay/items/equipment_drop_items_green_fx.vpcf"
	elseif u == 1 then
		return "particles/generic_gameplay/items/equipment_drop_items_white_fx.vpcf"
	end
end
function f.prototype.GetPropModel(self)
	local v = KeyValues.info_item_rarity[tostring(self.itemID)]
	if v ~= nil then
		v = v.model
	end
	local w = v
	if w == nil then
		w = "models/props_gameplay/halloween_candy.vmdl"
	end
	return w
end
function f.prototype.GetEquipmentModel(self)
	local s = GetItemEquipmentPart(self.itemID)
	if s == "1" then
		return "models/eom/props/booty/sword.vmdl"
	elseif s == "2" then
		return "models/eom/props/booty/shield.vmdl"
	elseif s == "3" then
		return "models/eom/props/booty/neck.vmdl"
	elseif s == "4" then
		return "models/eom/props/booty/ring.vmdl"
	elseif s == "5" then
		return "models/eom/props/booty/boots.vmdl"
	elseif s == "6" then
		return "models/eom/props/booty/arm.vmdl"
	elseif s == "7" then
		return "models/eom/props/booty/armor.vmdl"
	elseif s == "8" then
		return "models/eom/props/booty/helmet.vmdl"
	else
		return self:GetPropModel()
	end
end
function f.prototype.GetModel(self)
	local k = GetPropRarity(self.itemID)
	if self.propType == "4" then
		return ("models/eom/props/booty/trophy_" .. tostring(k)) .. ".vmdl"
	elseif self.propType == "9" then
		return self:GetEquipmentModel()
	elseif self.propType == "99" then
		return "models/eom/props/booty/chest.vmdl"
	else
		return self:GetPropModel()
	end
end
function f.prototype.GetEntityIndex(self)
	return self.entity:GetEntityIndex()
end
function f.prototype.IsLanded(self)
	return self.isLanded
end
function f.prototype.StartDropAnimation(self)
	local x = self.position
	local y = GameRules:GetGameTime()
	local z = 0.5
	local A = 180
	self.entity:GameTimer(0, function()
		local B = GameRules:GetGameTime() - y
		if B >= z then
			self.entity:SetLocalOrigin(self.landedPosition)
			self.position = self.landedPosition
			self.isLanded = true
			return nil
		end
		local C = B / z
		local D = 4 * A * C * (1 - C)
		local E = Vector(
			x.x + (self.landedPosition.x - x.x) * C,
			x.y + (self.landedPosition.y - x.y) * C,
			x.z + (self.landedPosition.z - x.z) * C + D
		)
		self.entity:SetLocalOrigin(E)
		return 0
	end)
end
function f.prototype.GetLandedPosition(self)
	return self.landedPosition
end
function f.prototype.dispose(self)
	if self.isDispose then
		return
	end
	self.isDispose = true
	if self.entity ~= nil and IsValid(self.entity) then
		CustomNetTables:SetNetData("dropped_item", tostring(self.entity:GetEntityIndex()), nil)
	end
	if IsValid(self.entity) then
		self.entity:RemoveSelf()
		self.entity = nil
	end
	d(self.particleIDs, function(F, G)
		ParticleManager:DestroyParticle(G, false)
	end)
end
return e