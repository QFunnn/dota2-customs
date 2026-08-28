--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "abilities/equipment/item_equipment_128"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = b.__TS__ArrayIncludes
local g = b.__TS__Delete
local h = b.__TS__SourceMapTraceBack
h(
	debug.getinfo(1).short_src,
	{
		["10"] = 1,
		["11"] = 1,
		["12"] = 1,
		["13"] = 2,
		["14"] = 2,
		["15"] = 2,
		["16"] = 4,
		["17"] = 5,
		["18"] = 4,
		["19"] = 5,
		["20"] = 6,
		["21"] = 7,
		["22"] = 6,
		["23"] = 5,
		["24"] = 4,
		["25"] = 5,
		["27"] = 5,
		["28"] = 11,
		["29"] = 20,
		["30"] = 11,
		["31"] = 20,
		["32"] = 21,
		["33"] = 22,
		["36"] = 24,
		["37"] = 25,
		["38"] = 25,
		["39"] = 25,
		["40"] = 25,
		["41"] = 21,
		["42"] = 28,
		["43"] = 29,
		["46"] = 31,
		["47"] = 32,
		["50"] = 34,
		["51"] = 35,
		["52"] = 36,
		["53"] = 36,
		["54"] = 36,
		["55"] = 36,
		["56"] = 37,
		["57"] = 37,
		["59"] = 37,
		["61"] = 37,
		["62"] = 38,
		["63"] = 39,
		["65"] = 41,
		["66"] = 42,
		["69"] = 44,
		["70"] = 44,
		["71"] = 45,
		["72"] = 46,
		["73"] = 46,
		["75"] = 46,
		["77"] = 46,
		["78"] = 47,
		["79"] = 48,
		["80"] = 49,
		["82"] = 52,
		["83"] = 53,
		["84"] = 53,
		["86"] = 53,
		["88"] = 53,
		["89"] = 54,
		["90"] = 55,
		["91"] = 56,
		["93"] = 44,
		["97"] = 60,
		["98"] = 60,
		["100"] = 61,
		["101"] = 62,
		["102"] = 62,
		["104"] = 63,
		["105"] = 63,
		["107"] = 63,
		["109"] = 63,
		["110"] = 64,
		["111"] = 65,
		["112"] = 66,
		["113"] = 67,
		["117"] = 60,
		["120"] = 71,
		["121"] = 72,
		["122"] = 73,
		["123"] = 74,
		["127"] = 78,
		["128"] = 80,
		["130"] = 80,
		["133"] = 28,
		["134"] = 20,
		["135"] = 11,
		["136"] = 11,
		["137"] = 11,
		["138"] = 11,
		["139"] = 11,
		["140"] = 11,
		["141"] = 11,
		["142"] = 11,
		["143"] = 11,
		["144"] = 20,
		["146"] = 20,
	}
)
local i = {}
local j = require("lib.dota_ts_adapter")
local k = j.BaseItem
local l = j.registerAbility
local m = require("modifiers.eom_modifier")
local n = m.EOMModifier
local o = m.registerEOMModifier
i.item_equipment_128 = c()
local p = i.item_equipment_128
p.name = "item_equipment_128"
d(p, k)
function p.prototype.GetIntrinsicModifierName(self)
	return "modifier_item_equipment_128"
end
p = e({ l(nil) }, p)
i.item_equipment_128 = p
i.modifier_item_equipment_128 = c()
local q = i.modifier_item_equipment_128
q.name = "modifier_item_equipment_128"
d(q, n)
function q.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	local r = self:GetParent()
	GameTimer(0, function()
		return self:ConsumePreviousEquipment(r)
	end)
end
function q.prototype.ConsumePreviousEquipment(self, r)
	if not IsValid(r) then
		return
	end
	local s = PlayerData:getHero(r:GetPlayerOwnerID())
	if not s then
		return
	end
	local t = false
	local u = false
	if not f(s:getItemList("all"), "item_equipment_128") then
		local v = tonumber
		local w = KeyValues.EquipmentKv.item_equipment_128
		if w ~= nil then
			w = w.ItemLevel
		end
		local x = v(w) or 4
		while s.itemList[x] ~= nil or s.overrideItemList[x] ~= nil do
			x = x + 1
		end
		s.itemList[x] = "item_equipment_128"
		t = true
	end
	do
		local y = 1
		while y <= 2 do
			local z = s.itemList[y]
			local A = tonumber
			local B = KeyValues.EquipmentKv[z]
			if B ~= nil then
				B = B.ItemLevel
			end
			local x = A(B) or y
			if z ~= nil and x <= 2 then
				g(s.itemList, y)
				t = true
			end
			local C = s.overrideItemList[y]
			local D = tonumber
			local E = KeyValues.EquipmentKv[C]
			if E ~= nil then
				E = E.ItemLevel
			end
			local F = D(E) or y
			if C ~= nil and F <= 2 then
				g(s.overrideItemList, y)
				t = true
			end
			y = y + 1
		end
	end
	do
		local G = 0
		while G < 8 do
			do
				local H = r:GetItemInSlot(G)
				if not IsValid(H) or H:GetName() == "item_equipment_128" then
					goto I
				end
				local J = tonumber
				local K = KeyValues.EquipmentKv[H:GetName()]
				if K ~= nil then
					K = K.ItemLevel
				end
				local x = J(K)
				if x ~= nil and x <= 2 then
					r:TakeItem(H)
					H:Remove()
					u = true
				end
			end
			::I::
			G = G + 1
		end
	end
	if t then
		s:updateItemNetTable()
		if GameState:isCeaseFireState() then
			s:addItem(r)
			return
		end
	end
	if u then
		local L = r:FindModifierByName("modifier_hero")
		if L ~= nil then
			L:RefreshInventory()
		end
	end
end
q = e(
	{
		o(
			a,
			{
				IsHidden = true,
				IsDebuff = false,
				IsPurgable = false,
				IsPurgeException = false,
				AllowIllusionDuplicate = false,
				GetPriority = MODIFIER_PRIORITY_LOW,
				GetAttributes = MODIFIER_ATTRIBUTE_MULTIPLE + MODIFIER_ATTRIBUTE_PERMANENT,
			}
		),
	},
	q
)
i.modifier_item_equipment_128 = q
return i