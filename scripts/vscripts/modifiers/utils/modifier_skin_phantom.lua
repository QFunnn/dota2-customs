--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "modifiers/utils/modifier_skin_phantom"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__ArrayFilter
local f = b.__TS__ArraySort
local g = b.__TS__ArrayIncludes
local h = b.__TS__ArrayIndexOf
local i = b.__TS__ObjectKeys
local j = b.__TS__DecorateLegacy
local k = b.__TS__SourceMapTraceBack
k(
	debug.getinfo(1).short_src,
	{
		["13"] = 1,
		["14"] = 1,
		["15"] = 1,
		["16"] = 3,
		["17"] = 3,
		["18"] = 3,
		["19"] = 3,
		["20"] = 3,
		["21"] = 3,
		["22"] = 3,
		["23"] = 3,
		["24"] = 3,
		["25"] = 13,
		["26"] = 22,
		["27"] = 13,
		["28"] = 22,
		["30"] = 22,
		["31"] = 23,
		["32"] = 24,
		["33"] = 13,
		["34"] = 29,
		["35"] = 30,
		["36"] = 31,
		["37"] = 32,
		["38"] = 33,
		["41"] = 36,
		["42"] = 37,
		["43"] = 38,
		["45"] = 40,
		["47"] = 42,
		["48"] = 43,
		["51"] = 46,
		["52"] = 46,
		["54"] = 47,
		["55"] = 48,
		["56"] = 49,
		["58"] = 29,
		["59"] = 52,
		["60"] = 53,
		["61"] = 54,
		["62"] = 55,
		["64"] = 52,
		["65"] = 58,
		["66"] = 59,
		["67"] = 60,
		["68"] = 61,
		["69"] = 62,
		["70"] = 63,
		["73"] = 66,
		["74"] = 67,
		["76"] = 69,
		["77"] = 70,
		["78"] = 71,
		["81"] = 58,
		["82"] = 75,
		["83"] = 76,
		["84"] = 77,
		["85"] = 78,
		["86"] = 79,
		["87"] = 80,
		["88"] = 81,
		["89"] = 82,
		["90"] = 82,
		["91"] = 82,
		["92"] = 82,
		["93"] = 82,
		["94"] = 82,
		["95"] = 82,
		["97"] = 83,
		["98"] = 83,
		["99"] = 84,
		["100"] = 85,
		["101"] = 86,
		["102"] = 87,
		["103"] = 88,
		["104"] = 89,
		["105"] = 90,
		["106"] = 91,
		["107"] = 92,
		["108"] = 93,
		["111"] = 96,
		["112"] = 97,
		["113"] = 98,
		["114"] = 99,
		["115"] = 100,
		["116"] = 101,
		["118"] = 103,
		["121"] = 106,
		["122"] = 107,
		["123"] = 108,
		["124"] = 109,
		["125"] = 109,
		["126"] = 109,
		["127"] = 109,
		["128"] = 109,
		["129"] = 109,
		["130"] = 110,
		["131"] = 111,
		["132"] = 112,
		["133"] = 113,
		["134"] = 114,
		["135"] = 115,
		["136"] = 116,
		["137"] = 117,
		["138"] = 118,
		["140"] = 121,
		["141"] = 122,
		["142"] = 123,
		["143"] = 124,
		["144"] = 125,
		["145"] = 126,
		["146"] = 127,
		["147"] = 128,
		["148"] = 129,
		["150"] = 131,
		["151"] = 132,
		["152"] = 133,
		["153"] = 134,
		["155"] = 136,
		["156"] = 137,
		["158"] = 139,
		["160"] = 141,
		["163"] = 144,
		["164"] = 109,
		["165"] = 109,
		["166"] = 146,
		["167"] = 147,
		["168"] = 148,
		["169"] = 149,
		["170"] = 150,
		["171"] = 151,
		["172"] = 152,
		["173"] = 153,
		["175"] = 155,
		["177"] = 157,
		["178"] = 158,
		["179"] = 159,
		["180"] = 160,
		["181"] = 161,
		["182"] = 162,
		["184"] = 164,
		["185"] = 165,
		["186"] = 166,
		["187"] = 167,
		["188"] = 168,
		["189"] = 169,
		["190"] = 170,
		["191"] = 171,
		["193"] = 173,
		["194"] = 174,
		["195"] = 175,
		["196"] = 176,
		["197"] = 177,
		["198"] = 178,
		["199"] = 179,
		["200"] = 180,
		["201"] = 180,
		["202"] = 180,
		["203"] = 180,
		["204"] = 180,
		["206"] = 182,
		["207"] = 182,
		["208"] = 182,
		["209"] = 182,
		["210"] = 182,
		["211"] = 182,
		["212"] = 182,
		["213"] = 182,
		["214"] = 182,
		["219"] = 187,
		["220"] = 188,
		["221"] = 188,
		["222"] = 188,
		["223"] = 188,
		["224"] = 188,
		["225"] = 188,
		["226"] = 188,
		["227"] = 188,
		["233"] = 83,
		["236"] = 199,
		["237"] = 200,
		["238"] = 201,
		["240"] = 75,
		["241"] = 204,
		["242"] = 205,
		["243"] = 204,
		["244"] = 210,
		["245"] = 211,
		["246"] = 212,
		["248"] = 214,
		["249"] = 210,
		["250"] = 216,
		["251"] = 217,
		["252"] = 217,
		["253"] = 217,
		["254"] = 217,
		["255"] = 218,
		["256"] = 219,
		["258"] = 221,
		["259"] = 221,
		["260"] = 221,
		["261"] = 221,
		["262"] = 216,
		["263"] = 223,
		["264"] = 224,
		["265"] = 225,
		["267"] = 223,
		["268"] = 22,
		["269"] = 13,
		["270"] = 13,
		["271"] = 13,
		["272"] = 13,
		["273"] = 13,
		["274"] = 13,
		["275"] = 13,
		["276"] = 13,
		["277"] = 13,
		["278"] = 22,
		["280"] = 22,
	}
)
local l = {}
local m = require("modifiers.eom_modifier")
local n = m.EOMModifier
local o = m.registerEOMModifier
local p = {
	absorigin = PATTACH_ABSORIGIN,
	absorigin_follow = PATTACH_ABSORIGIN_FOLLOW,
	customorigin = PATTACH_CUSTOMORIGIN,
	customorigin_follow = PATTACH_CUSTOMORIGIN_FOLLOW,
	point_follow = PATTACH_POINT_FOLLOW,
	renderorigin_follow = PATTACH_RENDERORIGIN_FOLLOW,
	rootbone_follow = PATTACH_ROOTBONE_FOLLOW,
}
l.modifier_skin_phantom = c()
local q = l.modifier_skin_phantom
q.name = "modifier_skin_phantom"
d(q, n)
function q.prototype.____constructor(self, ...)
	n.prototype.____constructor(self, ...)
	self.tWearables = {}
	self.tActivities = {}
end
function q.prototype.OnCreated(self, r)
	if IsServer() then
		local s = r.unitName
		if not KeyValues.CommonUnitsKv[s] then
			self:Destroy()
			return
		end
		if r.id and KeyValues.CosmeticsKV[r.id] then
			self.tKV = KeyValues.CosmeticsKV[r.id]
			self.tKV.Model = self.tKV.resource
		else
			self.tKV = KeyValues.CommonUnitsKv[s]
		end
		if not self.tKV then
			self:Destroy()
			return
		end
		if not self.tKV.Model then
			self.tKV.Model = KeyValues.CommonUnitsKv[s].Model
		end
		self.originModel = KeyValues.CommonUnitsKv[s].Model
		self.originProjectile = KeyValues.CommonUnitsKv[s].ProjectileModel
		self:Wearable()
	end
end
function q.prototype.OnRefresh(self, r)
	if IsServer() then
		self:OnDestroy()
		self:OnCreated(r)
	end
end
function q.prototype.OnDestroy(self)
	if IsServer() then
		local t = self:GetParent()
		for u, v in ipairs(self.tWearables) do
			if IsValid(v) then
				v:SetModel("models/development/invisiblebox.vmdl")
			end
		end
		for u, w in ipairs(self.tActivities) do
			t:RemoveActivityModifier(w)
		end
		if self.originModel then
			t:SetOriginalModel(self.originModel)
			t:ManageModelChanges()
		end
	end
end
function q.prototype.Wearable(self)
	if IsServer() then
		local x = self:GetParent()
		local y = self:GetCaster()
		self.tWearables = {}
		self.tActivities = {}
		local z = 9
		local A = f(
			e(x:GetChildren(), function(u, B)
				return B:GetClassname() == "dota_item_wearable"
			end),
			function(u, C, D)
				return C:entindex() - D:entindex()
			end
		)
		do
			local E = 1
			while E <= 10 do
				local F = tostring(self.tKV["wearable" .. tostring(E)])
				local G = tonumber(self.tKV[("wearable" .. tostring(E)) .. "style"]) or 0
				local H = KeyValues.ItemsGame[F]
				if H ~= nil then
					local I
					local J
					if type(H.visuals) == "table" then
						J = tonumber(H.visuals.skin)
						if type(H.visuals.styles) == "table" and type(H.visuals.styles[tostring(G)]) == "table" then
							J = tonumber(H.visuals.styles[tostring(G)].skin) or 0
						end
					end
					if H.model_player ~= nil then
						I = A[E]
						if IsValid(I) then
							I:SetModel(H.model_player)
							if J ~= nil then
								I:SetSkin(J)
							end
							table.insert(self.tWearables, I)
						end
					end
					if type(H.visuals) == "table" then
						local K = false
						local L = {}
						local M = f(
							e(i(H.visuals), function(u, N)
								return string.sub(N, 1, 14) == "asset_modifier"
							end),
							function(u, C, D)
								local O = 0
								local P = #C
								local Q = string.sub(C, 1, P)
								local R = tonumber(string.sub(C, P, -1))
								while type(R) == "number" do
									O = R
									P = P - 1
									R = tonumber(string.sub(C, P, -1))
									Q = string.sub(C, 1, P)
								end
								local S = 0
								local T = #D
								local U = string.sub(D, 1, T)
								local V = tonumber(string.sub(D, T, -1))
								while type(V) == "number" do
									S = V
									T = T - 1
									V = tonumber(string.sub(D, T, -1))
									U = string.sub(D, 1, T)
								end
								if T == P then
									if U ~= Q then
										if not g(L, Q) then
											L[#L + 1] = Q
										end
										if not g(L, U) then
											L[#L + 1] = U
										end
										return h(L, U) - h(L, Q)
									else
										return O - S
									end
								end
								return P - T
							end
						)
						for u, W in ipairs(M) do
							local N = H.visuals[W]
							if N.type == "additional_wearable" then
								local X = A[z + 1]
								if IsValid(X) then
									K = true
									X:SetModel(N.asset)
									table.insert(self.tWearables, X)
								end
								z = z - 1
							end
							if N.style == nil or N.style == G then
								if N.type == "activity" and N.asset == "ALL" then
									local Y = tostring(N.modifier)
									if TableFindKey(self.tActivities, Y) == nil then
										x:AddActivityModifier(Y)
										table.insert(self.tActivities, Y)
									end
								elseif N.type == "particle_create" then
									local Z
									local _
									local a0 = I
									if N.system == nil then
										_ = Wearable:getReplaceParticle(y, N.modifier)
										a0 = not K and I ~= nil and I or x
										Z = ParticleManager:CreateParticle(_, PATTACH_INVALID, a0)
									else
										_ = Wearable:getReplaceParticle(y, N.system)
										a0 = (N.attach_entity == "this" or N.attach_entity == "self") and I ~= nil and I
											or x
										Z = ParticleManager:CreateParticle(_, p[N.attach_type] or -1, a0)
										if type(N.control_points) == "table" then
											for a1 in pairs(N.control_points) do
												local a2 = N.control_points[a1]
												if a2.attach_type == "worldorigin" then
													ParticleManager:SetParticleControl(
														Z,
														a2.control_point_index,
														StringToVector(a2.position)
													)
												else
													ParticleManager:SetParticleControlEnt(
														Z,
														a2.control_point_index,
														a0,
														p[a2.attach_type] or -1,
														a2.attachment,
														a0:GetAbsOrigin(),
														false
													)
												end
											end
										end
									end
									K = false
									self:AddParticle(Z, true, false, -1, false, false)
								end
							end
						end
					end
				end
				E = E + 1
			end
		end
		x:SetOriginalModel(self.tKV.Model)
		x:SetSkin(tonumber(self.tKV.Skin) or 0)
		x:ManageModelChanges()
	end
end
function q.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_PROJECTILE_NAME, MODIFIER_PROPERTY_TRANSLATE_ATTACK_SOUND }
end
function q.prototype.GetModifierModelChange(self)
	if self.tKV.Model then
		return self.tKV.Model
	end
	return self.originModel
end
function q.prototype.GetModifierProjectileName(self)
	local a3 = GetModifierProperty(self:GetCaster(), EOMModifierFunction.EOM_MODIFIER_PROPERTY_PROJECTILE_NAME)
	if a3 and a3 ~= "" then
		return a3
	end
	return Wearable:getReplaceParticle(self:GetCaster(), self.originProjectile)
end
function q.prototype.GetAttackSound(self)
	if self.tKV.SoundSet then
		return tostring(self.tKV.SoundSet) .. ".Attack"
	end
end
q = j(
	{
		o(
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
	q
)
l.modifier_skin_phantom = q
return l