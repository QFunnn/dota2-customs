--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "class/shop_item"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ArrayForEach
local e = {}
local f = require("class.entity_pool")
local g = f.EntityPool
e.ShopItem = c()
local h = e.ShopItem
h.name = "ShopItem"
function h.prototype.____constructor(self, i, j, k, l, m, n)
	if l == nil then
		l = false
	end
	if n == nil then
		n = "Default"
	end
	self.isFree = false
	self.isDispose = false
	self.Quantitylimit = 9999999
	self.particleIDs = {}
	self.itemName = i
	self.rarity = j
	self.position = k
	self.isFree = l
	self.ownerPlayerID = m
	self.source = n
	self.id = DoUniqueString(i)
	local o = KeyValues.items[i]
	if o.Quantitylimit ~= nil and o.Quantitylimit ~= "" then
		self.Quantitylimit = toFiniteNumber(o.Quantitylimit)
	end
	self.entity = g:Acquire(
		e.ShopItem.EntityPoolKey,
		e.ShopItem.Classname,
		{
			glowcolor = "0 255 0 255",
			angles = m == nil and "0 -90 0" or "90 0 0",
			model = "models/props_gameplay/neutral_box.vmdl",
			origin = k,
			scales = "1.2 1.2 1.2",
			targetname = "shop_item",
			StartingAnim = "capsule_idle_translate",
			StartingAnimationLoopMode = "ANIM_LOOP_MODE_LOOPING",
		}
	)
	if m ~= nil then
		local p = PlayerResource:GetPlayer(m)
		if p ~= nil then
			self.entity:AddEffects(EF_NODRAW)
			local q = ParticleManager:CreateParticleForPlayer(
				"particles/generic_gameplay/generic_client_item.vpcf",
				PATTACH_ABSORIGIN_FOLLOW,
				self.entity,
				p
			)
			ParticleManager:SetParticleControlEnt(
				q,
				1,
				self.entity,
				PATTACH_INVALID,
				nil,
				self.entity:GetAbsOrigin(),
				true
			)
			local r = self.particleIDs
			r[#r + 1] = q
		end
	end
	CustomNetTables:SetNetData(
		"dropped_item",
		tostring(self.entity:GetEntityIndex()),
		{ kind = "shop", item_name = i, rarity = j, is_free = l, owner_player_id = m, show_tip = true }
	)
end
function h.Prewarm(self)
	g:Prewarm(
		e.ShopItem.EntityPoolKey,
		e.ShopItem.Classname,
		{
			glowcolor = "0 255 0 255",
			angles = "0 -90 0",
			model = "models/props_gameplay/neutral_box.vmdl",
			scales = "1.2 1.2 1.2",
			targetname = "pooled_shop_item",
			StartingAnim = "capsule_idle_translate",
			StartingAnimationLoopMode = "ANIM_LOOP_MODE_LOOPING",
		},
		16
	)
end
function h.prototype.GetEntityIndex(self)
	if self.entity == nil or not IsValid(self.entity) then
		return -1
	end
	return self.entity:GetEntityIndex()
end
function h.prototype.dispose(self)
	if self.isDispose then
		return
	end
	self.isDispose = true
	if self.entity ~= nil and IsValid(self.entity) then
		CustomNetTables:SetNetData("dropped_item", tostring(self.entity:GetEntityIndex()), nil)
	end
	if IsValid(self.entity) then
		g:Release(e.ShopItem.EntityPoolKey, self.entity)
		self.entity = nil
	end
	d(self.particleIDs, function(s, t)
		ParticleManager:DestroyParticle(t, false)
	end)
end
h.Classname = "dota_prop_customtexture"
h.EntityPoolKey = "shop_item:neutral_box"
return e