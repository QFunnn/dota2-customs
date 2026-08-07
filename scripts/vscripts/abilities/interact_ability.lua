--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-07 04:51:43 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/interact_ability"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__Delete
local f = b.__TS__SourceMapTraceBack
f(
	debug.getinfo(1).short_src,
	{
		["8"] = 1,
		["9"] = 1,
		["10"] = 1,
		["11"] = 3,
		["12"] = 3,
		["13"] = 3,
		["14"] = 3,
		["15"] = 4,
		["16"] = 5,
		["17"] = 6,
		["18"] = 7,
		["20"] = 9,
		["22"] = 4,
		["23"] = 12,
		["24"] = 13,
		["25"] = 14,
		["27"] = 12,
		["28"] = 17,
		["29"] = 18,
		["30"] = 19,
		["31"] = 19,
		["32"] = 19,
		["33"] = 20,
		["34"] = 21,
		["35"] = 22,
		["36"] = 23,
		["37"] = 24,
		["38"] = 25,
		["39"] = 26,
		["40"] = 27,
		["42"] = 29,
		["45"] = 19,
		["46"] = 19,
		["48"] = 17,
		["49"] = 35,
		["50"] = 36,
		["51"] = 37,
		["52"] = 38,
		["53"] = 38,
		["54"] = 38,
		["55"] = 38,
		["57"] = 40,
		["58"] = 35,
		["59"] = 42,
		["60"] = 43,
		["63"] = 44,
		["64"] = 45,
		["65"] = 46,
		["66"] = 47,
		["67"] = 48,
		["68"] = 49,
		["69"] = 50,
		["70"] = 51,
		["71"] = 52,
		["72"] = 53,
		["73"] = 54,
		["74"] = 55,
		["75"] = 56,
		["76"] = 57,
		["77"] = 58,
		["80"] = 42,
		["81"] = 84,
		["82"] = 85,
		["83"] = 86,
		["84"] = 88,
		["86"] = 90,
		["88"] = 93,
		["89"] = 95,
		["90"] = 97,
		["91"] = 99,
		["92"] = 100,
		["93"] = 101,
		["94"] = 102,
		["95"] = 103,
		["98"] = 106,
		["100"] = 109,
		["101"] = 110,
		["102"] = 111,
		["103"] = 112,
		["104"] = 113,
		["106"] = 115,
		["107"] = 116,
		["108"] = 117,
		["109"] = 118,
		["110"] = 119,
		["111"] = 120,
		["112"] = 121,
		["113"] = 122,
		["115"] = 124,
		["116"] = 125,
		["120"] = 129,
		["121"] = 130,
		["122"] = 131,
		["123"] = 132,
		["124"] = 133,
		["126"] = 135,
		["127"] = 136,
		["129"] = 138,
		["130"] = 139,
		["132"] = 141,
		["133"] = 142,
		["135"] = 144,
		["136"] = 145,
		["137"] = 146,
		["139"] = 148,
		["140"] = 149,
		["142"] = 110,
		["143"] = 152,
		["144"] = 153,
		["145"] = 154,
		["146"] = 155,
		["147"] = 156,
		["148"] = 157,
		["150"] = 153,
		["151"] = 160,
		["152"] = 161,
		["153"] = 162,
		["154"] = 163,
		["156"] = 165,
		["157"] = 166,
		["159"] = 161,
		["160"] = 169,
		["161"] = 170,
		["162"] = 171,
		["163"] = 172,
		["164"] = 173,
		["166"] = 175,
		["167"] = 176,
		["170"] = 171,
		["172"] = 84,
		["173"] = 186,
		["174"] = 186,
		["175"] = 186,
		["176"] = 186,
		["177"] = 187,
		["178"] = 188,
		["179"] = 189,
		["180"] = 190,
		["181"] = 191,
		["182"] = 192,
		["185"] = 187,
		["186"] = 196,
		["187"] = 197,
		["188"] = 198,
		["189"] = 199,
		["190"] = 200,
		["192"] = 196,
		["193"] = 203,
		["194"] = 204,
		["196"] = 203,
		["197"] = 208,
		["198"] = 209,
		["199"] = 211,
		["201"] = 213,
		["203"] = 216,
		["204"] = 218,
		["205"] = 220,
		["206"] = 222,
		["207"] = 223,
		["208"] = 224,
		["209"] = 225,
		["210"] = 226,
		["212"] = 228,
		["213"] = 229,
		["215"] = 223,
		["216"] = 232,
		["217"] = 233,
		["218"] = 234,
		["219"] = 235,
		["221"] = 237,
		["222"] = 238,
		["224"] = 233,
		["225"] = 208,
	}
)
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseAbility
local j = h.toDotaClassInstance
g.InteractAbility = c()
local k = g.InteractAbility
k.name = "InteractAbility"
d(k, i)
function k.prototype.GetAbilityTextureName(self)
	if self.ActiveTextureName and self.InactiveTextureName then
		if self:GetToggleState() then
			return self.ActiveTextureName
		end
		return self.InactiveTextureName
	end
end
function k.prototype.OnSpellStart(self)
	if not self.DisableToggle then
		self:ToggleAbility()
	end
end
function k.prototype.Spawn(self)
	if not self.DisableToggle and IsServer() then
		self:GameTimer(0.1, function()
			local l = self:GetCaster():GetPlayerOwnerID()
			local m = PlayerData:getplayerData(l)
			if m then
				local n = self:GetToggleState()
				local o = m:GetInteractiveAbilityState()
				if n ~= o then
					self:GetCaster():ForcePlayActivityOnce(ACT_DOTA_TELEPORT_END)
					self:CastAbility()
				else
					self:OnToggle(true)
				end
			end
		end)
	end
end
function k.prototype.CustomToggleEnable(self)
	local p = GameState:isCeaseFireState()
	if not p then
		ErrorMessage(self:GetCaster():GetPlayerOwnerID(), "error_disabled_battling")
	end
	return p
end
function k.prototype.OnToggle(self, q)
	if q then
		return
	end
	if self.talent_ability1 and self.talent_ability2 and self.ult_ability1 and self.ult_ability2 then
		if IsServer() then
			local r = self:GetCaster()
			local s = self:GetToggleState()
			local t = r:FindAbilityByName(self.talent_ability2)
			t:setEnableState(s)
			local u = r:FindAbilityByName(self.ult_ability2)
			u:setEnableState(s)
			local v = r:FindAbilityByName(self.talent_ability1)
			v:setEnableState(not s)
			local w = r:FindAbilityByName(self.ult_ability1)
			w:setEnableState(not s)
			r:RemoveGesture(ACT_DOTA_SPAWN)
			r:SwapAbilities(self.talent_ability2, self.talent_ability1, s, not s)
			r:SwapAbilities(self.ult_ability2, self.ult_ability1, s, not s)
		end
	end
end
g.registerInteractAbility = function(x, y)
	return function(x, z)
		local A = y and y.name
		if A ~= nil then
			z.name = A
		else
			A = z.name
		end
		local B = _G
		B[A] = {}
		j(nil, B[A], z)
		local C = false
		local D = z.____super
		while D do
			if not C and D == g.InteractAbility then
				C = true
				break
			end
			D = D.____super
		end
		local E = B[A].Spawn
		B[A].Spawn = function(self)
			local r
			if self.GetCaster ~= nil then
				r = self:GetCaster()
			end
			if r and r.__pendingAbilityLevels then
				local F = self:GetAbilityName()
				local G = r.__pendingAbilityLevels
				local H = G[F]
				if H and #H > 0 then
					local I = table.remove(H, 1)
					if #H == 0 then
						e(G, F)
					end
					if I and I > 0 and self:GetLevel() ~= I then
						self:SetLevel(I)
					end
				end
			end
			self.ActiveTextureName = y.ActiveTextureName
			self.InactiveTextureName = y.InactiveTextureName
			self.DisableToggle = y.DisableToggle
			if y.talent_ability1 then
				self.talent_ability1 = y.talent_ability1
			end
			if y.talent_ability2 then
				self.talent_ability2 = y.talent_ability2
			end
			if y.ult_ability1 then
				self.ult_ability1 = y.ult_ability1
			end
			if y.ult_ability2 then
				self.ult_ability2 = y.ult_ability2
			end
			self:____constructor()
			if C and E ~= g.InteractAbility.prototype.Spawn then
				g.InteractAbility.prototype.Spawn(self)
			end
			if E then
				E(self)
			end
		end
		local J = B[A].OnSpellStart
		B[A].OnSpellStart = function(self)
			if J then
				J(self)
			elseif C and E ~= g.InteractAbility.prototype.OnSpellStart then
				g.InteractAbility.prototype.OnSpellStart(self)
			end
		end
		local K = B[A].OnToggle
		B[A].OnToggle = function(self, q)
			if K and K ~= g.InteractAbility.prototype.OnToggle then
				K(self)
			end
			if C then
				g.InteractAbility.prototype.OnToggle(self, q)
			end
		end
		if IsServer() then
			local L = B[A].CustomToggleEnable
			B[A].CustomToggleEnable = function(self)
				if L then
					return L(self)
				else
					if C and L ~= g.InteractAbility.prototype.CustomToggleEnable then
						return g.InteractAbility.prototype.CustomToggleEnable(self)
					end
				end
			end
		end
	end
end
g.InteractBaseAbility = c()
local M = g.InteractBaseAbility
M.name = "InteractBaseAbility"
d(M, i)
function M.prototype.Spawn(self)
	if IsServer() then
		self.enable_state = not self:IsHidden()
		local n = self:GetToggleState()
		if self.enable_state ~= n then
			self:ToggleAbility()
		end
	end
end
function M.prototype.setEnableState(self, s)
	self.enable_state = s
	local n = self:GetToggleState()
	if self.enable_state ~= n then
		self:ToggleAbility()
	end
end
function M.prototype.OnToggle(self)
	if IsServer() then
	end
end
g.registerInteractBaseAbility = function(x, A)
	return function(x, z)
		if A ~= nil then
			z.name = A
		else
			A = z.name
		end
		local B = _G
		B[A] = {}
		j(nil, B[A], z)
		local E = B[A].Spawn
		B[A].Spawn = function(self)
			self:____constructor()
			if E ~= g.InteractBaseAbility.prototype.Spawn then
				g.InteractBaseAbility.prototype.Spawn(self)
			end
			if E then
				E(self)
			end
		end
		local K = B[A].OnToggle
		B[A].OnToggle = function(self)
			if K then
				K(self)
			end
			if K ~= g.InteractBaseAbility.prototype.OnToggle then
				return g.InteractBaseAbility.prototype.OnToggle(self)
			end
		end
	end
end
return g