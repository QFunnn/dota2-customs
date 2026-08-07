--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-07 04:51:43 UTC
  ~ auto-generated — do not edit
]]


local a = "modifiers/utils/modifier_skin"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__StringSplit
local f = b.__TS__ObjectValues
local g = b.__TS__ArrayFilter
local h = b.__TS__ArraySort
local i = b.__TS__ArrayIncludes
local j = b.__TS__ArrayIndexOf
local k = b.__TS__ObjectKeys
local l = b.__TS__ArrayForEach
local m = b.__TS__DecorateLegacy
local n = b.__TS__SourceMapTraceBack
n(
	debug.getinfo(1).short_src,
	{
		["16"] = 1,
		["17"] = 1,
		["18"] = 1,
		["19"] = 3,
		["20"] = 3,
		["21"] = 3,
		["22"] = 3,
		["23"] = 3,
		["24"] = 3,
		["25"] = 3,
		["26"] = 3,
		["27"] = 3,
		["28"] = 13,
		["29"] = 22,
		["30"] = 13,
		["31"] = 22,
		["33"] = 22,
		["34"] = 23,
		["35"] = 24,
		["36"] = 13,
		["37"] = 50,
		["38"] = 51,
		["39"] = 52,
		["40"] = 53,
		["41"] = 54,
		["42"] = 55,
		["43"] = 56,
		["44"] = 57,
		["45"] = 58,
		["46"] = 59,
		["47"] = 59,
		["49"] = 60,
		["51"] = 61,
		["52"] = 61,
		["54"] = 62,
		["55"] = 63,
		["56"] = 64,
		["58"] = 66,
		["59"] = 67,
		["60"] = 67,
		["61"] = 67,
		["62"] = 67,
		["63"] = 67,
		["64"] = 68,
		["65"] = 69,
		["66"] = 70,
		["67"] = 71,
		["68"] = 72,
		["69"] = 73,
		["70"] = 74,
		["72"] = 76,
		["73"] = 77,
		["75"] = 79,
		["76"] = 80,
		["78"] = 50,
		["79"] = 83,
		["80"] = 84,
		["81"] = 85,
		["82"] = 86,
		["84"] = 83,
		["85"] = 89,
		["86"] = 90,
		["87"] = 91,
		["88"] = 92,
		["89"] = 93,
		["90"] = 94,
		["91"] = 95,
		["94"] = 98,
		["95"] = 99,
		["97"] = 101,
		["98"] = 102,
		["99"] = 103,
		["101"] = 105,
		["102"] = 106,
		["103"] = 107,
		["106"] = 110,
		["107"] = 111,
		["108"] = 112,
		["109"] = 113,
		["110"] = 113,
		["111"] = 113,
		["112"] = 113,
		["113"] = 113,
		["115"] = 115,
		["116"] = 116,
		["117"] = 117,
		["118"] = 117,
		["119"] = 117,
		["120"] = 117,
		["121"] = 117,
		["123"] = 119,
		["124"] = 120,
		["125"] = 120,
		["126"] = 120,
		["127"] = 120,
		["130"] = 89,
		["131"] = 126,
		["132"] = 127,
		["133"] = 127,
		["134"] = 127,
		["135"] = 127,
		["136"] = 127,
		["137"] = 127,
		["138"] = 127,
		["139"] = 126,
		["140"] = 135,
		["141"] = 136,
		["142"] = 137,
		["143"] = 138,
		["144"] = 139,
		["145"] = 140,
		["147"] = 142,
		["148"] = 143,
		["149"] = 144,
		["150"] = 145,
		["151"] = 146,
		["152"] = 147,
		["153"] = 148,
		["154"] = 148,
		["155"] = 148,
		["156"] = 148,
		["157"] = 148,
		["160"] = 151,
		["161"] = 152,
		["163"] = 154,
		["165"] = 156,
		["166"] = 157,
		["167"] = 157,
		["168"] = 157,
		["169"] = 157,
		["170"] = 157,
		["171"] = 157,
		["173"] = 159,
		["175"] = 161,
		["176"] = 162,
		["177"] = 162,
		["178"] = 162,
		["179"] = 162,
		["180"] = 162,
		["182"] = 135,
		["183"] = 165,
		["184"] = 166,
		["185"] = 167,
		["186"] = 168,
		["187"] = 169,
		["188"] = 170,
		["189"] = 171,
		["190"] = 172,
		["191"] = 173,
		["192"] = 174,
		["193"] = 175,
		["194"] = 176,
		["195"] = 177,
		["196"] = 177,
		["197"] = 177,
		["198"] = 177,
		["199"] = 177,
		["200"] = 177,
		["201"] = 177,
		["203"] = 179,
		["204"] = 179,
		["205"] = 180,
		["206"] = 181,
		["207"] = 182,
		["208"] = 183,
		["211"] = 186,
		["213"] = 188,
		["214"] = 189,
		["215"] = 190,
		["216"] = 191,
		["217"] = 192,
		["218"] = 193,
		["219"] = 194,
		["220"] = 195,
		["221"] = 196,
		["224"] = 199,
		["225"] = 200,
		["226"] = 201,
		["227"] = 202,
		["228"] = 203,
		["229"] = 204,
		["231"] = 206,
		["234"] = 209,
		["235"] = 210,
		["236"] = 211,
		["237"] = 212,
		["238"] = 212,
		["239"] = 212,
		["240"] = 212,
		["241"] = 212,
		["242"] = 212,
		["243"] = 213,
		["244"] = 214,
		["245"] = 215,
		["246"] = 216,
		["247"] = 217,
		["248"] = 218,
		["249"] = 219,
		["250"] = 220,
		["251"] = 221,
		["253"] = 224,
		["254"] = 225,
		["255"] = 226,
		["256"] = 227,
		["257"] = 228,
		["258"] = 229,
		["259"] = 230,
		["260"] = 231,
		["261"] = 232,
		["263"] = 234,
		["264"] = 235,
		["265"] = 236,
		["266"] = 237,
		["268"] = 239,
		["269"] = 240,
		["271"] = 242,
		["273"] = 244,
		["276"] = 247,
		["277"] = 212,
		["278"] = 212,
		["279"] = 249,
		["280"] = 250,
		["281"] = 251,
		["282"] = 252,
		["283"] = 253,
		["284"] = 254,
		["285"] = 255,
		["286"] = 256,
		["288"] = 258,
		["290"] = 260,
		["291"] = 261,
		["292"] = 262,
		["293"] = 263,
		["294"] = 264,
		["295"] = 265,
		["297"] = 267,
		["298"] = 268,
		["299"] = 269,
		["300"] = 270,
		["301"] = 271,
		["302"] = 272,
		["303"] = 273,
		["305"] = 278,
		["306"] = 279,
		["307"] = 280,
		["308"] = 284,
		["309"] = 285,
		["310"] = 286,
		["311"] = 287,
		["312"] = 288,
		["314"] = 290,
		["315"] = 291,
		["317"] = 296,
		["322"] = 305,
		["324"] = 307,
		["325"] = 308,
		["326"] = 309,
		["332"] = 179,
		["335"] = 316,
		["337"] = 165,
		["338"] = 319,
		["339"] = 320,
		["340"] = 321,
		["341"] = 322,
		["342"] = 323,
		["343"] = 323,
		["344"] = 323,
		["345"] = 324,
		["346"] = 323,
		["347"] = 323,
		["350"] = 328,
		["352"] = 319,
		["353"] = 331,
		["354"] = 332,
		["355"] = 333,
		["356"] = 334,
		["357"] = 336,
		["358"] = 336,
		["359"] = 336,
		["360"] = 336,
		["361"] = 336,
		["362"] = 336,
		["363"] = 336,
		["364"] = 337,
		["365"] = 338,
		["366"] = 339,
		["367"] = 340,
		["368"] = 340,
		["369"] = 340,
		["370"] = 340,
		["371"] = 340,
		["372"] = 341,
		["373"] = 342,
		["374"] = 342,
		["375"] = 342,
		["376"] = 342,
		["377"] = 342,
		["378"] = 342,
		["379"] = 342,
		["380"] = 342,
		["381"] = 342,
		["385"] = 346,
		["386"] = 347,
		["387"] = 348,
		["388"] = 349,
		["390"] = 351,
		["391"] = 351,
		["393"] = 354,
		["394"] = 354,
		["395"] = 354,
		["396"] = 354,
		["397"] = 354,
		["398"] = 354,
		["399"] = 354,
		["400"] = 354,
		["405"] = 331,
		["406"] = 360,
		["407"] = 361,
		["408"] = 360,
		["409"] = 366,
		["410"] = 367,
		["411"] = 367,
		["412"] = 367,
		["413"] = 367,
		["414"] = 368,
		["415"] = 369,
		["416"] = 369,
		["417"] = 369,
		["418"] = 369,
		["420"] = 371,
		["421"] = 371,
		["422"] = 371,
		["423"] = 371,
		["424"] = 366,
		["425"] = 373,
		["426"] = 374,
		["427"] = 375,
		["429"] = 373,
		["430"] = 22,
		["431"] = 13,
		["432"] = 13,
		["433"] = 13,
		["434"] = 13,
		["435"] = 13,
		["436"] = 13,
		["437"] = 13,
		["438"] = 13,
		["439"] = 13,
		["440"] = 22,
		["442"] = 22,
	}
)
local o = {}
local p = require("modifiers.eom_modifier")
local q = p.EOMModifier
local r = p.registerEOMModifier
local s = {
	absorigin = PATTACH_ABSORIGIN,
	absorigin_follow = PATTACH_ABSORIGIN_FOLLOW,
	customorigin = PATTACH_CUSTOMORIGIN,
	customorigin_follow = PATTACH_CUSTOMORIGIN_FOLLOW,
	point_follow = PATTACH_POINT_FOLLOW,
	renderorigin_follow = PATTACH_RENDERORIGIN_FOLLOW,
	rootbone_follow = PATTACH_ROOTBONE_FOLLOW,
}
o.modifier_skin = c()
local t = o.modifier_skin
t.name = "modifier_skin"
d(t, q)
function t.prototype.____constructor(self, ...)
	q.prototype.____constructor(self, ...)
	self.tWearables = {}
	self.tActivities = {}
end
function t.prototype.OnCreated(self, u)
	self:SetHasCustomTransmitterData(true)
	if IsServer() then
		self.modifierWearableIDList = nil
		self.modifierModel = nil
		local v = self:GetParent()
		self.tParticleReplace = {}
		self.tKV = shallowcopy(KeyValues.CosmeticsKV[u.id])
		local w = v:GetUnitName()
		if not self.tKV then
			self.tKV = KeyValues.CommonUnitsKv[w]
		else
			self.tKV.Model = self.tKV.resource
		end
		if not self.tKV.Model then
			self.tKV.Model = KeyValues.CommonUnitsKv[w].Model
		end
		self.wearableID = u.id
		if self.wearableID then
			v:AddNewModifier(v, nil, "modifier_" .. self.wearableID, {})
		end
		self.originProjectile = KeyValues.CommonUnitsKv[w].ProjectileModel
		Wearable:registerWearableID(v:GetPlayerOwnerID(), w, u.id)
		self.unitModel = KeyValues.CommonUnitsKv[w].Model
		self.originModel = self.tKV.Model
		local x = EOM_GetModifierChangeModel(v)
		local y = GetChangeWearableIdList(v)
		if y ~= nil and type(y) == "string" and y ~= "" then
			self.modifierWearableIDList = e(y, ",")
			KeyValues:AddWearableToItemsGame(self.modifierWearableIDList)
		end
		if x ~= nil and x ~= "" then
			self.modifierModel = x
		end
		self:Wearable()
		self:SendBuffRefreshToClients()
	end
end
function t.prototype.OnRefresh(self, u)
	if IsServer() then
		self:OnDestroy(true)
		self:OnCreated(u)
	end
end
function t.prototype.OnDestroy(self, z)
	if IsServer() then
		local v = self:GetParent()
		self:DestroyWearableAmbient()
		for A, B in ipairs(self.tWearables) do
			if IsValid(B) then
				B:SetModel("models/development/invisiblebox.vmdl")
			end
		end
		for A, C in ipairs(self.tActivities) do
			v:RemoveActivityModifier(C)
		end
		if not z then
			v:SetOriginalModel(self.unitModel)
			v:ManageModelChanges()
		end
		Wearable:unregisterParticleModifier(v)
		if self.wearableID then
			v:RemoveModifierByName("modifier_" .. self.wearableID)
		end
	else
		local D = false
		if self.modifierModel then
			D = true
			Wearable:unregisterUnitPortraitModifier(self:GetParent():GetPlayerOwnerID(), self.originModel, true)
		end
		if self.modifierWearableIDList then
			D = true
			Wearable:unregisterUnitWearablesModifier(self:GetParent():GetPlayerOwnerID(), self.originModel, true)
		end
		if D then
			Client:SendLocalConsoleMessage("refresh_hero_portrait", { player_id = self:GetParent():GetPlayerOwnerID() })
		end
	end
end
function t.prototype.AddCustomTransmitterData(self)
	return {
		originModel = self.originModel,
		modifierModel = self.modifierModel,
		modifierWearableIDList = self.modifierWearableIDList,
		wearable = self.wearableID,
		tParticleReplace = self.tParticleReplace,
	}
end
function t.prototype.HandleCustomTransmitterData(self, E)
	self.tParticleReplace = E.tParticleReplace
	self.wearableID = E.wearable
	local D = false
	if self.modifierModel ~= E.modifierModel or self.modifierWearableIDList ~= E.modifierWearableIDList then
		D = true
	end
	self.modifierModel = E.modifierModel
	self.modifierWearableIDList = E.modifierWearableIDList
	self.originModel = E.originModel
	local F = self:GetParent():GetPlayerOwnerID()
	if self.tParticleReplace then
		for G in pairs(self.tParticleReplace) do
			Wearable:registerParticleModifier(self:GetParent(), G, self.tParticleReplace[G])
		end
	end
	if self.modifierModel then
		Wearable:registerUnitPortraitModifier(F, self.originModel, self.modifierModel, true)
	else
		Wearable:unregisterUnitPortraitModifier(F, self.originModel, true)
	end
	if self.modifierWearableIDList then
		Wearable:registerUnitWearablesModifier(F, self.originModel, f(self.modifierWearableIDList), true)
	else
		Wearable:unregisterUnitWearablesModifier(F, self.originModel, true)
	end
	if self.wearableID then
		Wearable:registerWearableID(F, self:GetParent():GetUnitName(), self.wearableID)
	end
end
function t.prototype.Wearable(self)
	local H = self:GetParent()
	if IsServer() then
		self.tWearables = {}
		self.tActivities = {}
		self.tAmbientParticleConfig = {}
		self:DestroyWearableAmbient()
		local I = self.modifierModel and self.modifierModel or self.originModel
		H:SetOriginalModel(I)
		H:SetSkin(tonumber(self.tKV.Skin) or 0)
		H:ManageModelChanges()
		local J = 9
		local K = h(
			g(H:GetChildren(), function(A, L)
				return L:GetClassname() == "dota_item_wearable"
			end),
			function(A, M, N)
				return M:entindex() - N:entindex()
			end
		)
		do
			local O = 1
			while O <= 10 do
				local P
				if self.modifierWearableIDList ~= nil then
					if #self.modifierWearableIDList >= O then
						P = self.modifierWearableIDList[O]
					end
				else
					P = tostring(self.tKV["wearable" .. tostring(O)])
				end
				local Q = tonumber(self.tKV[("wearable" .. tostring(O)) .. "style"]) or 0
				local R = KeyValues.ItemsGame[P]
				if R ~= nil then
					local S
					local T
					if type(R.visuals) == "table" then
						T = tonumber(R.visuals.skin)
						if type(R.visuals.styles) == "table" and type(R.visuals.styles[tostring(Q)]) == "table" then
							T = tonumber(R.visuals.styles[tostring(Q)].skin) or 0
						end
					end
					if R.model_player ~= nil then
						S = K[O]
						if IsValid(S) then
							S:SetModel(R.model_player)
							if T ~= nil then
								S:SetSkin(T)
							end
							table.insert(self.tWearables, S)
						end
					end
					if type(R.visuals) == "table" then
						local U = false
						local V = {}
						local W = h(
							g(k(R.visuals), function(A, X)
								return string.sub(X, 1, 14) == "asset_modifier"
							end),
							function(A, M, N)
								local Y = 0
								local Z = #M
								local _ = string.sub(M, 1, Z)
								local a0 = tonumber(string.sub(M, Z, -1))
								while type(a0) == "number" do
									Y = a0
									Z = Z - 1
									a0 = tonumber(string.sub(M, Z, -1))
									_ = string.sub(M, 1, Z)
								end
								local a1 = 0
								local a2 = #N
								local a3 = string.sub(N, 1, a2)
								local a4 = tonumber(string.sub(N, a2, -1))
								while type(a4) == "number" do
									a1 = a4
									a2 = a2 - 1
									a4 = tonumber(string.sub(N, a2, -1))
									a3 = string.sub(N, 1, a2)
								end
								if a2 == Z then
									if a3 ~= _ then
										if not i(V, _) then
											V[#V + 1] = _
										end
										if not i(V, a3) then
											V[#V + 1] = a3
										end
										return j(V, a3) - j(V, _)
									else
										return Y - a1
									end
								end
								return Z - a2
							end
						)
						for A, a5 in ipairs(W) do
							local X = R.visuals[a5]
							if X.type == "additional_wearable" then
								local a6 = K[J + 1]
								if IsValid(a6) then
									U = true
									a6:SetModel(X.asset)
									table.insert(self.tWearables, a6)
								end
								J = J - 1
							end
							if X.style == nil or X.style == Q then
								if X.type == "activity" and X.asset == "ALL" then
									local a7 = tostring(X.modifier)
									if TableFindKey(self.tActivities, a7) == nil then
										H:AddActivityModifier(a7)
										table.insert(self.tActivities, a7)
									end
								elseif X.type == "particle_create" then
									local a8
									local a9 = S
									if X.system == nil then
										a8 = Wearable:getReplaceParticle(H, X.modifier)
										a9 = not U and S ~= nil and S or H
										self.tAmbientParticleConfig[a8] = { ent = a9, create_type = PATTACH_INVALID }
									else
										a8 = Wearable:getReplaceParticle(H, X.system)
										a9 = (X.attach_entity == "this" or X.attach_entity == "self") and S ~= nil and S
											or H
										self.tAmbientParticleConfig[a8] = { ent = a9, create_type = s[X.attach_type]
											or -1 }
										if type(X.control_points) == "table" then
											for aa in pairs(X.control_points) do
												local ab = X.control_points[aa]
												if self.tAmbientParticleConfig[a8].extra_config == nil then
													self.tAmbientParticleConfig[a8].extra_config = {}
												end
												if ab.attach_type == "worldorigin" then
													self.tAmbientParticleConfig[a8].extra_config[ab.control_point_index] =
														{ set_type = "vec", vec = ab.position }
												else
													self.tAmbientParticleConfig[a8].extra_config[ab.control_point_index] =
														{
															set_type = "ent",
															ent_attach_type = s[ab.attach_type] or -1,
															ent_attach_name = ab.attachment,
														}
												end
											end
										end
									end
									U = false
								end
								if X.type == "particle" or X.type == "hero_model_change" then
									Wearable:registerParticleModifier(H, X.asset, X.modifier)
									self.tParticleReplace[X.asset] = X.modifier
								end
							end
						end
					end
				end
				O = O + 1
			end
		end
		self:CreateWearableAmbient()
	end
end
function t.prototype.DestroyWearableAmbient(self)
	if IsServer() then
		if self.tAmbientParticleList then
			for a5, X in pairs(self.tAmbientParticleList) do
				l(X, function(A, ac)
					ParticleManager:DestroyParticle(ac, true)
				end)
			end
		end
		self.tAmbientParticleList = {}
	end
end
function t.prototype.CreateWearableAmbient(self)
	if IsServer() then
		if self.tAmbientParticleConfig then
			for G, E in pairs(self.tAmbientParticleConfig) do
				local ad = ParticleManager:CreateParticle(G, E.create_type, E.ent, nil, true)
				if E.extra_config then
					for ae, X in pairs(E.extra_config) do
						if X.set_type == "vec" and X.vec then
							ParticleManager:SetParticleControl(ad, ae, StringToVector(X.vec))
						elseif X.set_type == "ent" then
							ParticleManager:SetParticleControlEnt(
								ad,
								ae,
								E.ent,
								X.ent_attach_type,
								X.ent_attach_name,
								E.ent:GetAbsOrigin(),
								false
							)
						end
					end
				end
				if IsValid(E.ent) then
					local af = E.ent:entindex()
					if self.tAmbientParticleList[af] == nil then
						self.tAmbientParticleList[af] = {}
					end
					local ag = self.tAmbientParticleList[af]
					ag[#ag + 1] = ad
				else
					self:AddParticle(ad, true, false, -1, false, false)
				end
			end
		end
	end
end
function t.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_PROJECTILE_NAME, MODIFIER_PROPERTY_TRANSLATE_ATTACK_SOUND }
end
function t.prototype.GetModifierProjectileName(self)
	local ah = GetModifierProperty(self:GetParent(), EOMModifierFunction.EOM_MODIFIER_PROPERTY_PROJECTILE_NAME)
	if ah and ah ~= "" then
		return Wearable:getReplaceParticle(self:GetParent(), ah)
	end
	return Wearable:getReplaceParticle(self:GetParent(), self.originProjectile)
end
function t.prototype.GetAttackSound(self)
	if self.tKV.SoundSet then
		return tostring(self.tKV.SoundSet) .. ".Attack"
	end
end
t = m(
	{
		r(
			a,
			{
				IsHidden = true,
				IsDebuff = false,
				IsPurgable = false,
				IsPurgeException = false,
				RemoveOnDeath = false,
				AllowIllusionDuplicate = false,
				GetPriority = MODIFIER_PRIORITY_LOW,
			}
		),
	},
	t
)
o.modifier_skin = t
return o