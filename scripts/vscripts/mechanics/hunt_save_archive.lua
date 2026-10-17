--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


local a = "mechanics/hunt_save_archive"
local b = require("lualib_bundle")
local c = b.Set
local d = b.__TS__SparseArrayNew
local e = b.__TS__SparseArrayPush
local f = b.__TS__SparseArraySpread
local g = b.__TS__New
local h = b.__TS__Class
local i = b.__TS__ClassExtends
local j = b.__TS__NumberIsFinite
local k = b.__TS__ObjectAssign
local l = b.__TS__Delete
local m = b.__TS__ObjectRest
local n = b.__TS__DecorateLegacy
local o = {}
local p = require("lib.tstl-utils")
local q = p.reloadable
local r = c
local s = d(unpack(TAVERN_ITEMS))
e(
	s,
	"item_tome_of_prop_single",
	"item_ball_attack_single",
	"item_ball_health_single",
	"privilege_019",
	"privilege_023",
	"privilege_weapon_030",
	"privilege_weapon_041",
	"privilege_weapon_038",
	"privilege_weapon_039",
	"privilege_weapon_040",
	"privilege_weapon_046",
	"privilege_weapon_047",
	"privilege_weapon_049"
)
local t = g(r, { f(s) })
local u = h()
u.name = "CHuntSaveArchive"
i(u, CModule)
function u.prototype.____constructor(self, ...)
	CModule.prototype.____constructor(self, ...)
	self.playerStates = {}
	self.preparedSaves = {}
	self.playerAttributes = {}
	self.restoredSaves = {}
end
function u.prototype.init(self, v)
	if self.playerAttributes == nil then
		self.playerAttributes = {}
	end
	if self.restoredSaves == nil then
		self.restoredSaves = {}
	end
	if not v then
		self.playerStates = {}
		self.preparedSaves = {}
	end
	if self.propertyAddedEventID ~= nil then
		Event:Unregister(self.propertyAddedEventID)
	end
	self.propertyAddedEventID = Event:Register("property_added", self.OnPropertyAdded, self)
	CustomUIEvent("hunt_save_archive_save", function(w, x)
		self:SaveSnapshot(x.PlayerID, x.slot_id)
	end, self)
end
function u.prototype.OnPropertyAdded(self, y)
	local z
	local A
	local B
	local C
	C = y.unit
	B = y.property
	A = y.value
	z = y.source
	if not t:has(z) or not IsValid(C) or not j(A) then
		return
	end
	local D = PROPERTY_MAP_REVERSE[B]
	local E = C:GetPlayerOwnerID()
	if D == nil or PropertySystem:GetScopeOfProperty(D) ~= PropertyScope.UNIT or Player:GetHero(E) ~= C then
		return
	end
	if self.playerAttributes == nil then
		self.playerAttributes = {}
	end
	local F, G = self.playerAttributes, E
	if F[G] == nil then
		F[G] = { attributes = {} }
	end
	local H = self.playerAttributes[E]
	local I = H.attributes[D]
	H.attributes[D] = I == nil and A or PropertySystem:AggregatePropertyValues(D, I, A)
end
function u.prototype.GetAttributes(self, E)
	local J = self.playerAttributes
	local H = J and J[E]
	return H == nil and {} or k({}, H.attributes)
end
function u.prototype.CreateSnapshot(self, E, C)
	if self.playerStates[E] ~= nil then
		self:Sync(E)
		return
	end
	local K = {}
	for w, L in ipairs(C:GetAllItems()) do
		do
			if not IsValid(L) or KeyValues.artifact[L:GetAbilityName()] == nil then
				goto M
			end
			K[#K + 1] = { item_name = L:GetAbilityName(), level = L:GetLevel() }
		end
		::M::
	end
	local N = {}
	for w, O in ipairs(AbilityUpgrade:GetAbilityUpgrades(C)) do
		if not AbilityUpgrade:IsServiceUpgrade(O.name) then
			N[#N + 1] = { name = O.name, level = O.level }
		end
	end
	self.playerStates[E] = { hasSaved = false }
	local P = self.Sync
	local Q = E
	local R = math.floor(Login:GetServiceTimestamp())
	local S = CustomNetTables:GetNetData("common", "difficulty_key")
	local T = S and S.key_data
	local U = T and T.intensity
	local V = C:GetUnitName()
	local W = math.floor
	local X = DamageCounter:GetPlayerDamageCount(E)
	P(
		self,
		Q,
		{
			time = R,
			strength = U,
			hero_name = V,
			total_damage = W(X and X.totalDamage or 0),
			blessings = Bless:GetPlayerBlessDetails(E),
			artifacts = K,
			ability_upgrades = N,
			attributes = self:GetAttributes(E),
		}
	)
end
function u.prototype.GetAutoSelectSlotID(self, E, Y)
	local C = Player:GetHero(E)
	if not IsValid(C) then
		return nil
	end
	local Z = toFiniteNumber
	local _ = KeyValues.hunt_intelligence
	local a0 = _ and _[tostring(Y)]
	if a0 ~= nil then
		a0 = a0.dungeon_diff
	end
	local a1 = Z(a0, 0)
	if a1 < 1 then
		return nil
	end
	local a2 = CommonService:GetPlayerServiceNetTable(E, "player_hunt_save_datas") or {}
	local a3
	local a4 = -1
	for a5, a6 in pairs(a2) do
		do
			if a6.diff < a1 or a6.data == "" then
				goto a7
			end
			local a8 = json.decode(a6.data)
			local a9 = a8
			if (a9 and a9.hero_name) ~= C:GetUnitName() then
				goto a7
			end
			local aa = toFiniteNumber(a9.total_damage, 0)
			if a3 == nil or aa > a4 or aa == a4 and a6.slot_id < a3 then
				a3 = a6.slot_id
				a4 = aa
			end
		end
		::a7::
	end
	return a3
end
function u.prototype.PrepareSelectedSave(self, E, ab, ac)
	local ad = CommonService:GetPlayerServiceNetTable(E, "player_hunt_save_datas")
	local a6 = ad and ad[tostring(ab)]
	if a6 == nil or a6.diff <= 0 or a6.data == "" then
		self:print(
			(
				(
					((("[HuntSaveArchive] prepare failed player=" .. tostring(E)) .. " slot=") .. tostring(ab))
					.. " match="
				) .. tostring(ac)
			) .. " save missing"
		)
		return false
	end
	self.preparedSaves[E] = { matchID = ac, slotID = ab, save = k({}, a6) }
	return true
end
function u.prototype.GetSelectedSave(self, E, ab)
	local ae = self.preparedSaves[E]
	if (ae and ae.matchID) == Match:GetMatchID() and ae.slotID == ab then
		return ae.save
	end
	local af = CommonService:GetPlayerServiceNetTable(E, "player_hunt_save_datas")
	return af and af[tostring(ab)]
end
function u.prototype.ClearPreparedSaves(self, ac)
	for E, ae in pairs(self.preparedSaves) do
		if (ae and ae.matchID) == ac then
			l(self.preparedSaves, E)
		end
	end
end
function u.prototype.reset(self)
	self.playerStates = {}
	self.preparedSaves = {}
	self.playerAttributes = {}
	self.restoredSaves = {}
	Game:EachPlayer(function(w, E)
		CustomNetTables:SetNetData("player_data", "hunt_save_snapshot", nil, E)
	end)
end
function u.prototype.ApplySelectedSave(self, E, C, ab)
	if not IsValid(C) then
		return false
	end
	if self.restoredSaves == nil then
		self.restoredSaves = {}
	end
	local ag = self.restoredSaves[E]
	if (ag and ag.hero) == C and ag.matchID == Match:GetMatchID() then
		return ag.slotID == ab
	end
	local ah = self:GetSelectedSave(E, ab)
	if ah == nil or ah.data == "" then
		self:print(
			((("[HuntSaveArchive] restore skipped player=" .. tostring(E)) .. " slot=") .. tostring(ab))
				.. " save missing"
		)
		return false
	end
	local ai = json.decode(ah.data)
	local a9 = ai
	if a9 == nil or a9.hero_name ~= C:GetUnitName() then
		self:print(
			(
				(
					(
						((("[HuntSaveArchive] restore skipped player=" .. tostring(E)) .. " slot=") .. tostring(ab))
						.. " savedHero="
					) .. (a9 and a9.hero_name or "")
				) .. " currentHero="
			) .. C:GetUnitName()
		)
		return false
	end
	local aj = 0
	for w, ak in ipairs(a9.blessings or {}) do
		do
			if ak.name == "" or ak.rarity <= 0 then
				goto al
			end
			if Bless:AddBless(C, { name = ak.name, rarity = math.floor(ak.rarity) }) ~= nil then
				aj = aj + 1
			end
		end
		::al::
	end
	local am = 0
	for w, an in ipairs(a9.artifacts or {}) do
		do
			if an.item_name == "" or an.level <= 0 or KeyValues.artifact[an.item_name] == nil then
				goto ao
			end
			local L = C:AddItemByName(an.item_name, math.floor(an.level), false)
			if L ~= nil and IsValid(L) then
				am = am + 1
			end
		end
		::ao::
	end
	local ap = 0
	for w, O in ipairs(a9.ability_upgrades or {}) do
		do
			if O.name == "" or O.level <= 0 then
				goto aq
			end
			AbilityUpgrade:AddAbilityUpgrade(C, O.name, math.floor(O.level), "hunt_save_archive")
			ap = ap + 1
		end
		::aq::
	end
	local ar = 0
	for D, A in pairs(a9.attributes or {}) do
		do
			if PropertySystem:GetScopeOfProperty(D) ~= PropertyScope.UNIT or not j(A) then
				goto as
			end
			if PropertySystem:AddStaticProperty(C:entindex(), D, "hunt_save_archive_gain", A) then
				ar = ar + 1
			end
		end
		::as::
	end
	self.restoredSaves[E] = { hero = C, matchID = Match:GetMatchID(), slotID = ab }
	C:UpdateAbilityNetData()
	self:print(
		(
			(
				(
					(
						(
							(
								(
									(
										(("[HuntSaveArchive] restored player=" .. tostring(E)) .. " slot=")
										.. tostring(ab)
									) .. " blessings="
								) .. tostring(aj)
							) .. " artifacts="
						) .. tostring(am)
					) .. " upgrades="
				) .. tostring(ap)
			) .. " propertyGains="
		) .. tostring(ar)
	)
	return true
end
function u.prototype.SaveSnapshot(self, E, ab)
	local at = self.playerStates[E]
	local a9 = self:GetSnapshot(E)
	if at == nil or at.hasSaved or a9 == nil then
		return
	end
	a9.time = math.floor(Login:GetServiceTimestamp())
	at.hasSaved = true
	self:Sync(E, a9)
	CommonService:CallAction(
		"/v1/hunt/save_data",
		E,
		{ match_id = Match:GetMatchID(), slot_id = ab, data = json.encode(a9) },
		function(w, au, av)
			CommonService:CommonCallback(E, av, false)
		end,
		false
	)
end
function u.prototype.GetSnapshot(self, E)
	local aw = CustomNetTables:GetNetData("player_data", "hunt_save_snapshot", E)
	if aw == nil then
		return nil
	end
	local ax = aw.has_saved
	local a9 = m(aw, { has_saved = true })
	return a9
end
function u.prototype.Sync(self, E, a9)
	if a9 == nil then
		a9 = self:GetSnapshot(E)
	end
	local at = self.playerStates[E]
	if at == nil or a9 == nil then
		return
	end
	CustomNetTables:SetNetData("player_data", "hunt_save_snapshot", k({}, a9, { has_saved = at.hasSaved }), E)
end
u = n({ q }, u)
if HuntSaveArchive == nil then
	HuntSaveArchive = g(u)
end
return o