--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/privilege/privilege_treasure_002"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = {}
local g = require("abilities.eom_privilege")
local h = g.EOMPrivilege
local i = g.PrivilegeValue
local j = g.RegisterPrivilege
local k = c()
k.name = "privilege_treasure_002"
d(k, h)
function k.prototype.____constructor(self, ...)
	h.prototype.____constructor(self, ...)
	self.collectionDamageAmplify = 0
	self.targetRarity = 3
end
function k.prototype.OnCreated(self)
	self:RefreshCollectionDamageAmplify()
end
function k.prototype.OnRefresh(self)
	h.prototype.OnRefresh(self)
	self:RefreshCollectionDamageAmplify()
end
function k.prototype.OnDestroy(self)
	local l = self:GetCaster()
	if not l or not IsValid(l) then
		return
	end
	PropertySystem:RemoveStaticProperty(l:entindex(), "privilege_treasure_002")
end
function k.prototype.EventListener(self)
	return {
		service_data_change = function(m, n)
			if n.playerID ~= self:GetPlayerID() then
				return
			end
			if n.key ~= "player_collections" then
				return
			end
			self:RefreshCollectionDamageAmplify()
		end,
	}
end
function k.prototype.RefreshCollectionDamageAmplify(self)
	if self.per_level <= 0 then
		self.collectionDamageAmplify = 0
		return
	end
	local o = PlayerData:GetCollectionTotalLevelByRarity(self:GetPlayerID(), self.targetRarity, "collection")
	local p = math.floor(o / self.per_level) * self.per_level_effect
	self.collectionDamageAmplify = math.min(self.effect_max, p)
	print(
		(((("[" .. self.privilegeName) .. "] totalLevel: ") .. tostring(o)) .. ", collectionDamageAmplify: ")
			.. tostring(self.collectionDamageAmplify)
	)
	local l = self:GetCaster()
	if not l or not IsValid(l) then
		return
	end
	PropertySystem:RemoveStaticProperty(l:entindex(), "privilege_treasure_002")
	PropertySystem:AddStaticProperty(
		l:entindex(),
		"spell_damage_boost",
		"privilege_treasure_002",
		self.collectionDamageAmplify
	)
	PropertySystem:AddStaticProperty(
		l:entindex(),
		"attack_damage_boost",
		"privilege_treasure_002",
		self.collectionDamageAmplify
	)
end
e({ i(nil) }, k.prototype, "per_level", nil)
e({ i(nil) }, k.prototype, "per_level_effect", nil)
e({ i(nil) }, k.prototype, "effect_max", nil)
k = e({ j(nil) }, k)
return f