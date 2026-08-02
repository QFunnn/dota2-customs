--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "mechanics/wearable"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = b.__TS__New
local g = b.__TS__SourceMapTraceBack
g(
	debug.getinfo(1).short_src,
	{
		["9"] = 1,
		["10"] = 1,
		["12"] = 4,
		["13"] = 4,
		["14"] = 5,
		["15"] = 55,
		["16"] = 56,
		["17"] = 57,
		["18"] = 58,
		["19"] = 59,
		["20"] = 60,
		["21"] = 61,
		["22"] = 62,
		["23"] = 63,
		["24"] = 64,
		["26"] = 55,
		["27"] = 68,
		["28"] = 69,
		["29"] = 68,
		["30"] = 72,
		["31"] = 73,
		["32"] = 72,
		["33"] = 76,
		["34"] = 77,
		["35"] = 78,
		["36"] = 79,
		["38"] = 81,
		["39"] = 76,
		["40"] = 84,
		["41"] = 85,
		["42"] = 86,
		["43"] = 87,
		["44"] = 88,
		["47"] = 91,
		["49"] = 84,
		["50"] = 96,
		["51"] = 97,
		["52"] = 98,
		["53"] = 99,
		["55"] = 101,
		["57"] = 96,
		["58"] = 105,
		["59"] = 106,
		["60"] = 107,
		["61"] = 108,
		["63"] = 110,
		["64"] = 105,
		["65"] = 113,
		["66"] = 114,
		["67"] = 115,
		["68"] = 116,
		["69"] = 117,
		["72"] = 120,
		["74"] = 113,
		["75"] = 124,
		["76"] = 125,
		["77"] = 126,
		["78"] = 127,
		["80"] = 129,
		["82"] = 124,
		["83"] = 133,
		["84"] = 134,
		["85"] = 135,
		["86"] = 136,
		["88"] = 138,
		["89"] = 133,
		["90"] = 141,
		["91"] = 142,
		["92"] = 143,
		["93"] = 144,
		["94"] = 145,
		["97"] = 148,
		["99"] = 141,
		["100"] = 152,
		["101"] = 153,
		["102"] = 154,
		["103"] = 155,
		["105"] = 157,
		["107"] = 152,
		["108"] = 161,
		["109"] = 162,
		["110"] = 161,
		["111"] = 165,
		["112"] = 166,
		["113"] = 165,
		["114"] = 169,
		["115"] = 180,
		["116"] = 180,
		["117"] = 169,
		["118"] = 183,
		["119"] = 184,
		["120"] = 185,
		["122"] = 187,
		["123"] = 183,
		["124"] = 190,
		["125"] = 191,
		["126"] = 192,
		["128"] = 190,
		["129"] = 196,
		["130"] = 197,
		["131"] = 198,
		["132"] = 198,
		["134"] = 200,
		["135"] = 200,
		["137"] = 196,
		["138"] = 204,
		["139"] = 205,
		["140"] = 206,
		["142"] = 208,
		["143"] = 204,
		["144"] = 211,
		["145"] = 212,
		["146"] = 213,
		["148"] = 211,
		["149"] = 217,
		["150"] = 218,
		["151"] = 219,
		["152"] = 219,
		["154"] = 221,
		["155"] = 221,
		["157"] = 217,
		["158"] = 225,
		["159"] = 226,
		["160"] = 227,
		["162"] = 229,
		["163"] = 230,
		["164"] = 231,
		["166"] = 225,
		["167"] = 235,
		["168"] = 236,
		["169"] = 237,
		["170"] = 238,
		["171"] = 239,
		["174"] = 235,
		["175"] = 244,
		["176"] = 245,
		["177"] = 246,
		["179"] = 248,
		["180"] = 249,
		["181"] = 250,
		["183"] = 244,
		["184"] = 254,
		["185"] = 255,
		["186"] = 256,
		["187"] = 257,
		["188"] = 258,
		["191"] = 254,
		["192"] = 263,
		["193"] = 264,
		["194"] = 265,
		["196"] = 267,
		["197"] = 268,
		["198"] = 269,
		["200"] = 263,
		["201"] = 273,
		["202"] = 274,
		["203"] = 275,
		["204"] = 276,
		["205"] = 277,
		["208"] = 273,
		["209"] = 282,
		["210"] = 283,
		["211"] = 284,
		["212"] = 284,
		["214"] = 286,
		["215"] = 286,
		["217"] = 282,
		["218"] = 290,
		["219"] = 291,
		["220"] = 292,
		["221"] = 292,
		["223"] = 294,
		["224"] = 294,
		["226"] = 290,
		["227"] = 298,
		["228"] = 299,
		["229"] = 300,
		["230"] = 300,
		["232"] = 302,
		["233"] = 302,
		["235"] = 298,
		["236"] = 4,
		["237"] = 310,
		["238"] = 311,
	}
)
local h = {}
local i = require("lib.tstl-utils")
local j = i.reloadable
local k = c()
k.name = "CWearable"
d(k, CModule)
function k.prototype.init(self, l)
	if not l then
		self.particleModifier = {}
		self.soundModifier = {}
		self.unitModelModifier = {}
		self.unitPortraitModifier = {}
		self.unitWearablesModifier = {}
		self.unitPortraitSkinModifier = {}
		self.wearableID = {}
		self.modelWearableID = {}
	end
end
function k.prototype.equipWearable(self, m, n)
	m:AddNewModifier(m, nil, "modifier_skin", { id = n })
end
function k.prototype.unequipWearable(self, m)
	m:RemoveModifierByName("modifier_skin")
end
function k.prototype.registerParticleModifier(self, m, o, p)
	local q = m:entindex()
	if self.particleModifier[q] == nil then
		self.particleModifier[q] = {}
	end
	self.particleModifier[q][o] = p
end
function k.prototype.unregisterParticleModifier(self, m, o)
	local q = m:entindex()
	if o then
		if self.particleModifier[q] and self.particleModifier[q][o] then
			self.particleModifier[q][o] = nil
		end
	else
		self.particleModifier[q] = nil
	end
end
function k.prototype.getReplaceParticle(self, m, o)
	local q = m:entindex()
	if self.particleModifier[q] == nil then
		return o
	else
		return self.particleModifier[q][o] or o
	end
end
function k.prototype.registerUnitModelModifier(self, m, o, p)
	local q = m:entindex()
	if self.unitModelModifier[q] == nil then
		self.unitModelModifier[q] = {}
	end
	self.unitModelModifier[q][o] = p
end
function k.prototype.unregisterUnitModelModifier(self, m, o)
	local q = m:entindex()
	if o then
		if self.unitModelModifier[q] and self.unitModelModifier[q][o] then
			self.unitModelModifier[q][o] = nil
		end
	else
		self.unitModelModifier[q] = nil
	end
end
function k.prototype.getReplaceUnitModel(self, m, o)
	local q = m:entindex()
	if self.unitModelModifier[q] == nil then
		return o
	else
		return self.unitModelModifier[q][o] or o
	end
end
function k.prototype.registerSoundModifier(self, m, o, p)
	local q = m:entindex()
	if self.soundModifier[q] == nil then
		self.soundModifier[q] = {}
	end
	self.soundModifier[q][o] = p
end
function k.prototype.unregisterSoundModifier(self, m, o)
	local q = m:entindex()
	if o then
		if self.soundModifier[q] and self.soundModifier[q][o] then
			self.soundModifier[q][o] = nil
		end
	else
		self.soundModifier[q] = nil
	end
end
function k.prototype.getReplaceSound(self, m, o)
	local q = m and m:entindex()
	if not q or self.soundModifier[q] == nil then
		return o
	else
		return self.soundModifier[q][o] or o
	end
end
function k.prototype.serviceEquipWearable(self, r, n)
	SaveData(self, r, n)
end
function k.prototype.serviceUnequipWearable(self, r)
	SaveData(self, r, nil)
end
function k.prototype.serviceGetEquipWearable(self, r, s)
	local t = self.wearableID[r]
	return t and t[s]
end
function k.prototype.registerWearableID(self, r, u, n)
	if self.wearableID[r] == nil then
		self.wearableID[r] = {}
	end
	self.wearableID[r][u] = n
end
function k.prototype.unregisterWearableID(self, r, u)
	if self.wearableID[r] and self.wearableID[r][u] then
		self.wearableID[r][u] = nil
	end
end
function k.prototype.getWearableID(self, u, r)
	if r then
		local v = self.wearableID[r]
		return v and v[u]
	else
		local w = self.wearableID[GetLocalPlayerID()]
		return w and w[u]
	end
end
function k.prototype.registerUnitModelWearableID(self, r, x, n)
	if self.modelWearableID[r] == nil then
		self.modelWearableID[r] = {}
	end
	self.modelWearableID[r][x] = n
end
function k.prototype.unregisterUnitModelWearableID(self, r, x)
	if self.modelWearableID[r] and self.modelWearableID[r][x] then
		self.modelWearableID[r][x] = nil
	end
end
function k.prototype.getUnitModelWearableID(self, x, r)
	if r then
		local y = self.modelWearableID[r]
		return y and y[x]
	else
		local z = self.modelWearableID[GetLocalPlayerID()]
		return z and z[x]
	end
end
function k.prototype.registerUnitWearablesModifier(self, r, A, B, C)
	if self.unitWearablesModifier[r] == nil then
		self.unitWearablesModifier[r] = {}
	end
	self.unitWearablesModifier[r][A] = B
	if C then
		Client:SendLocalConsoleMessage("refresh_hero_portrait", { player_id = r })
	end
end
function k.prototype.unregisterUnitWearablesModifier(self, r, A, C)
	if self.unitWearablesModifier[r] and self.unitWearablesModifier[r][A] then
		self.unitWearablesModifier[r][A] = nil
		if C then
			Client:SendLocalConsoleMessage("refresh_hero_portrait", { player_id = r })
		end
	end
end
function k.prototype.registerUnitPortraitModifier(self, r, A, p, C)
	if self.unitPortraitModifier[r] == nil then
		self.unitPortraitModifier[r] = {}
	end
	self.unitPortraitModifier[r][A] = p
	if C then
		Client:SendLocalConsoleMessage("refresh_hero_portrait", { player_id = r })
	end
end
function k.prototype.unregisterUnitPortraitModifier(self, r, A, C)
	if self.unitPortraitModifier[r] and self.unitPortraitModifier[r][A] then
		self.unitPortraitModifier[r][A] = nil
		if C then
			Client:SendLocalConsoleMessage("refresh_hero_portrait", { player_id = r })
		end
	end
end
function k.prototype.registerUnitPortraitSkinModifier(self, r, A, D, C)
	if self.unitPortraitSkinModifier[r] == nil then
		self.unitPortraitSkinModifier[r] = {}
	end
	self.unitPortraitSkinModifier[r][A] = D
	if C then
		Client:SendLocalConsoleMessage("refresh_hero_portrait", { player_id = r })
	end
end
function k.prototype.unregisterUnitPortraitSkinModifier(self, r, A, C)
	if self.unitPortraitSkinModifier[r] and self.unitPortraitSkinModifier[r][A] then
		self.unitPortraitSkinModifier[r][A] = nil
		if C then
			Client:SendLocalConsoleMessage("refresh_hero_portrait", { player_id = r })
		end
	end
end
function k.prototype.getUnitPortraitReplaceModel(self, A, r)
	if r then
		local E = self.unitPortraitModifier[r]
		return E and E[A]
	else
		local F = self.unitPortraitModifier[GetLocalPlayerID()]
		return F and F[A]
	end
end
function k.prototype.getUnitWearablesModifier(self, A, r)
	if r then
		local G = self.unitWearablesModifier[r]
		return G and G[A]
	else
		local H = self.unitWearablesModifier[GetLocalPlayerID()]
		return H and H[A]
	end
end
function k.prototype.getUnitPortraitReplaceSkin(self, A, r)
	if r then
		local I = self.unitPortraitSkinModifier[r]
		return I and I[A]
	else
		local J = self.unitPortraitSkinModifier[GetLocalPlayerID()]
		return J and J[A]
	end
end
k = e({ j }, k)
if _G.Wearable == nil then
	_G.Wearable = f(k)
end
return h