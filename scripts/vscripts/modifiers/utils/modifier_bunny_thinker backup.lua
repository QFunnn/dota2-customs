--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-07 04:51:43 UTC
  ~ auto-generated — do not edit
]]


local a = "content/c4/scripts/vscripts/modifiers/utils/modifier_bunny_thinker backup.ts"
local b = getfenv()
if b then
	b.__TUI_FILEPATH = a
end
local c = require("lualib_bundle")
local d = c.__TS__Class
local e = c.__TS__ClassExtends
local f = c.__TS__ArrayIncludes
local g = c.__TS__ObjectKeys
local h = c.__TS__ObjectEntries
local i = c.__TS__ArrayForEach
local j = c.__TS__ObjectValues
local k = c.__TS__ArraySort
local l = c.__TS__Decorate
local m = c.__TS__SourceMapTraceBack
m(
	debug.getinfo(1).short_src,
	{
		["14"] = 1,
		["15"] = 1,
		["16"] = 1,
		["17"] = 3,
		["18"] = 11,
		["19"] = 3,
		["20"] = 11,
		["22"] = 11,
		["23"] = 16,
		["24"] = 19,
		["25"] = 20,
		["26"] = 21,
		["27"] = 26,
		["28"] = 27,
		["29"] = 28,
		["30"] = 29,
		["31"] = 30,
		["32"] = 3,
		["33"] = 32,
		["34"] = 33,
		["35"] = 34,
		["36"] = 36,
		["37"] = 37,
		["38"] = 38,
		["39"] = 39,
		["40"] = 40,
		["41"] = 41,
		["42"] = 42,
		["45"] = 32,
		["46"] = 49,
		["47"] = 50,
		["48"] = 49,
		["49"] = 58,
		["50"] = 60,
		["51"] = 61,
		["52"] = 62,
		["53"] = 63,
		["54"] = 64,
		["55"] = 65,
		["56"] = 66,
		["57"] = 67,
		["60"] = 70,
		["61"] = 71,
		["64"] = 71,
		["68"] = 72,
		["71"] = 72,
		["72"] = 72,
		["76"] = 73,
		["79"] = 73,
		["80"] = 73,
		["84"] = 74,
		["87"] = 74,
		["91"] = 75,
		["94"] = 75,
		["98"] = 76,
		["101"] = 76,
		["105"] = 77,
		["108"] = 77,
		["114"] = 78,
		["120"] = 82,
		["121"] = 83,
		["122"] = 83,
		["123"] = 83,
		["124"] = 83,
		["125"] = 84,
		["126"] = 84,
		["127"] = 84,
		["128"] = 84,
		["129"] = 86,
		["130"] = 87,
		["133"] = 58,
		["134"] = 127,
		["135"] = 129,
		["136"] = 129,
		["137"] = 129,
		["139"] = 129,
		["140"] = 129,
		["141"] = 129,
		["143"] = 129,
		["144"] = 127,
		["145"] = 132,
		["146"] = 133,
		["148"] = 150,
		["149"] = 151,
		["150"] = 154,
		["152"] = 132,
		["153"] = 158,
		["154"] = 159,
		["155"] = 161,
		["156"] = 162,
		["157"] = 163,
		["158"] = 164,
		["160"] = 166,
		["161"] = 167,
		["164"] = 158,
		["165"] = 171,
		["166"] = 172,
		["167"] = 173,
		["168"] = 174,
		["169"] = 174,
		["170"] = 174,
		["171"] = 174,
		["172"] = 174,
		["173"] = 174,
		["174"] = 175,
		["175"] = 176,
		["176"] = 177,
		["177"] = 177,
		["178"] = 177,
		["179"] = 177,
		["180"] = 177,
		["181"] = 178,
		["182"] = 178,
		["183"] = 178,
		["184"] = 178,
		["185"] = 178,
		["186"] = 179,
		["187"] = 180,
		["188"] = 181,
		["190"] = 183,
		["192"] = 185,
		["193"] = 186,
		["194"] = 187,
		["195"] = 188,
		["196"] = 188,
		["197"] = 189,
		["198"] = 189,
		["200"] = 174,
		["201"] = 174,
		["203"] = 196,
		["204"] = 197,
		["205"] = 201,
		["206"] = 202,
		["209"] = 171,
		["210"] = 206,
		["211"] = 207,
		["212"] = 208,
		["213"] = 209,
		["215"] = 210,
		["216"] = 210,
		["217"] = 211,
		["218"] = 210,
		["221"] = 213,
		["223"] = 206,
		["224"] = 216,
		["225"] = 217,
		["226"] = 218,
		["227"] = 218,
		["228"] = 220,
		["229"] = 220,
		["230"] = 220,
		["231"] = 218,
		["232"] = 221,
		["233"] = 221,
		["234"] = 221,
		["235"] = 221,
		["236"] = 218,
		["237"] = 222,
		["238"] = 222,
		["239"] = 222,
		["240"] = 222,
		["241"] = 222,
		["242"] = 218,
		["243"] = 223,
		["244"] = 223,
		["245"] = 223,
		["246"] = 223,
		["247"] = 223,
		["248"] = 223,
		["249"] = 218,
		["250"] = 218,
		["251"] = 225,
		["252"] = 227,
		["253"] = 228,
		["254"] = 229,
		["255"] = 231,
		["257"] = 235,
		["260"] = 238,
		["261"] = 240,
		["263"] = 243,
		["266"] = 246,
		["267"] = 216,
		["268"] = 248,
		["269"] = 249,
		["270"] = 250,
		["271"] = 251,
		["272"] = 252,
		["274"] = 254,
		["275"] = 248,
		["276"] = 256,
		["277"] = 257,
		["278"] = 258,
		["279"] = 258,
		["280"] = 258,
		["281"] = 258,
		["282"] = 258,
		["283"] = 258,
		["284"] = 259,
		["285"] = 260,
		["286"] = 261,
		["287"] = 261,
		["288"] = 261,
		["289"] = 261,
		["290"] = 261,
		["291"] = 262,
		["292"] = 262,
		["293"] = 262,
		["294"] = 262,
		["295"] = 262,
		["296"] = 263,
		["297"] = 263,
		["299"] = 258,
		["300"] = 258,
		["301"] = 256,
		["302"] = 267,
		["303"] = 268,
		["304"] = 269,
		["305"] = 270,
		["307"] = 271,
		["308"] = 271,
		["309"] = 272,
		["310"] = 271,
		["313"] = 274,
		["314"] = 267,
		["315"] = 276,
		["316"] = 276,
		["317"] = 276,
		["319"] = 277,
		["320"] = 278,
		["322"] = 281,
		["323"] = 276,
		["324"] = 283,
		["325"] = 283,
		["326"] = 283,
		["328"] = 284,
		["329"] = 285,
		["330"] = 285,
		["331"] = 285,
		["332"] = 286,
		["333"] = 287,
		["335"] = 285,
		["336"] = 285,
		["337"] = 290,
		["338"] = 290,
		["339"] = 290,
		["340"] = 291,
		["341"] = 292,
		["343"] = 290,
		["344"] = 290,
		["346"] = 296,
		["347"] = 298,
		["348"] = 301,
		["349"] = 303,
		["350"] = 304,
		["351"] = 304,
		["352"] = 304,
		["353"] = 304,
		["354"] = 304,
		["355"] = 304,
		["356"] = 304,
		["357"] = 306,
		["358"] = 307,
		["360"] = 304,
		["361"] = 304,
		["362"] = 310,
		["363"] = 310,
		["364"] = 310,
		["365"] = 311,
		["366"] = 310,
		["367"] = 310,
		["368"] = 313,
		["369"] = 313,
		["370"] = 313,
		["371"] = 314,
		["372"] = 314,
		["373"] = 314,
		["374"] = 314,
		["375"] = 314,
		["376"] = 314,
		["377"] = 314,
		["378"] = 314,
		["379"] = 314,
		["380"] = 314,
		["381"] = 314,
		["382"] = 314,
		["383"] = 314,
		["384"] = 314,
		["385"] = 326,
		["386"] = 313,
		["387"] = 313,
		["388"] = 342,
		["389"] = 283,
		["390"] = 350,
		["391"] = 351,
		["392"] = 353,
		["393"] = 354,
		["394"] = 355,
		["397"] = 358,
		["398"] = 358,
		["399"] = 358,
		["400"] = 359,
		["401"] = 360,
		["403"] = 358,
		["404"] = 358,
		["405"] = 363,
		["406"] = 369,
		["407"] = 370,
		["408"] = 371,
		["410"] = 373,
		["414"] = 350,
		["415"] = 378,
		["416"] = 379,
		["417"] = 380,
		["418"] = 380,
		["419"] = 380,
		["420"] = 381,
		["421"] = 382,
		["423"] = 380,
		["424"] = 380,
		["425"] = 385,
		["426"] = 385,
		["427"] = 385,
		["428"] = 386,
		["429"] = 387,
		["431"] = 385,
		["432"] = 385,
		["434"] = 378,
		["435"] = 11,
		["436"] = 3,
		["437"] = 3,
		["438"] = 3,
		["439"] = 3,
		["440"] = 3,
		["441"] = 3,
		["442"] = 3,
		["443"] = 3,
		["444"] = 11,
		["446"] = 11,
	}
)
local n = {}
local o = require("modifiers.eom_modifier")
local p = o.EOMModifier
local q = o.registerEOMModifier
n.modifier_bunny_thinker = d()
local r = n.modifier_bunny_thinker
r.name = "modifier_bunny_thinker"
e(r, p)
function r.prototype.____constructor(self, ...)
	p.prototype.____constructor(self, ...)
	self.d_flag = false
	self.bIDLE = true
	self.bTeleported = false
	self.bLocalBattlePos = false
	self.particles = {}
	self.idle_interval = 5
	self.POS_OFFSET_X = 570
	self.POS_OFFSET_Y = 300
	self.INTERVAL_POS_X = 100
end
function r.prototype.OnCreated(self, s)
	self:SetHasCustomTransmitterData(true)
	if IsClient() then
		self.p_bunnies = self.p_bunnies or {}
		self.bunnies = self.bunnies or {}
		self.POS_OFFSET_X = 570
		self.POS_OFFSET_Y = 300
		self.INTERVAL_POS_X = 100
		self.state = 1
		self:IDLE(true)
	else
	end
end
function r.prototype.AddCustomTransmitterData(self)
	return { state = self.state, battle_field_id = self.battle_field_id }
end
function r.prototype.HandleCustomTransmitterData(self, t)
	self.p_bunnies = self.p_bunnies or {}
	self.bunnies = self.bunnies or {}
	self.bunny_oids = self.bunny_oids or {}
	if t.state then
		self.state = t.state
		local u = { 4, 5, 7 }
		if f(u, self.state) then
			self.battle_field_id = t.battle_field_id
		end
		repeat
			local v = self.state
			local w = v == 1
			if w then
				do
					self:IDLE(true)
					return
				end
			end
			w = w or v == 2
			if w then
				do
					self.bIDLE = false
					self:PlayAction("ACT_DOTA_VICTORY", true)
					return
				end
			end
			w = w or v == 3
			if w then
				do
					self.bIDLE = false
					self:PlayAction("ACT_DOTA_DEFEAT", true)
					return
				end
			end
			w = w or v == 4
			if w then
				do
					self:BattleConfirm()
					return
				end
			end
			w = w or v == 5
			if w then
				do
					self:EndTeleport()
					return
				end
			end
			w = w or v == 6
			if w then
				do
					self:CreateBackTeleporParticle()
					return
				end
			end
			w = w or v == 7
			if w then
				do
					self:FinishBackHome()
					return
				end
			end
			do
				do
					self:IDLE(true)
					return
				end
			end
		until true
	else
		local x = self:GetParent():GetPlayerOwnerID()
		if CustomNetTables:GetTableValue("service", "player_bunny" .. tostring(x)) then
			local y = json.decode(CustomNetTables:GetTableValue("service", "player_bunny" .. tostring(x)).data)
			self.bunny_oids = y
			self:IDLE(true)
		end
	end
end
function r.prototype.GetModel(self, z)
	local A = KeyValues.CosmeticsKV[z]
	if A ~= nil then
		A = A.resource
	end
	local B = A
	if B == nil then
		B = "models/eom/hero/tunvlang_2/tunvlang_2.vmdl"
	end
	return B
end
function r.prototype.OnRefresh(self, s)
	if IsClient() then
	else
		self.state = s.state
		self.battle_field_id = s.battle_field_id
		self:SendBuffRefreshToClients()
	end
end
function r.prototype.GetEnemy(self)
	local C = CustomNetTables:GetTableValue("common", "battle_data")
	for D, E in ipairs(g(C)) do
		local F = C[E]
		if F.mainPlayer.PlayerID == self:GetParent():GetPlayerOwnerID() then
			return F.customerPlayer
		end
		if F.customerPlayer.PlayerID == self:GetParent():GetPlayerOwnerID() then
			return F.mainPlayer
		end
	end
end
function r.prototype.BattleConfirm(self)
	if self.battle_field_id and self.battle_field_id ~= self:GetParent():GetPlayerOwnerID() then
		self.particles = {}
		i(h(self.bunnies), function(D, G)
			local H
			local I = G[1]
			H = G[2]
			if IsValidEntity(H) then
				local J = ParticleManager:CreateParticle(
					"particles/econ/events/fall_2022/teleport/teleport_fall2022_end_lvl1.vpcf",
					PATTACH_CUSTOMORIGIN,
					nil
				)
				ParticleManager:SetParticleControl(J, 0, H:GetAbsOrigin())
				ParticleManager:SetParticleControl(J, 1, H:GetAbsOrigin())
				local K
				if GetLocalPlayerID() == self:GetParent():GetPlayerOwnerID() then
					K = PlayerHomePos[self.battle_field_id + 1] + Vector(-self.POS_OFFSET_X, -self.POS_OFFSET_Y, 128)
				else
					K = PlayerHomePos[self.battle_field_id + 1] + Vector(-self.POS_OFFSET_X, self.POS_OFFSET_Y, 128)
				end
				local L = ParticleManager:CreateParticle(
					"particles/econ/events/fall_2022/teleport/teleport_fall2022_end_lvl1.vpcf",
					PATTACH_CUSTOMORIGIN,
					nil
				)
				ParticleManager:SetParticleControl(L, 0, K)
				ParticleManager:SetParticleControl(L, 1, K)
				local M = self.particles
				M[#M + 1] = J
				local N = self.particles
				N[#N + 1] = L
			end
		end)
	else
		local O = self:GetEnemy()
		if O.PlayerID == GetLocalPlayerID() and O.illusion ~= 1 then
			self.bLocalBattlePos = true
			self:IDLE(true)
		end
	end
end
function r.prototype.EndTeleport(self)
	if self.battle_field_id and self.battle_field_id ~= self:GetParent():GetPlayerOwnerID() then
		self.bTeleported = true
		self:IDLE(true)
		do
			local E = 0
			while E < #self.particles do
				ParticleManager:DestroyParticle(self.particles[E + 1], true)
				E = E + 1
			end
		end
		self.particles = {}
	end
end
function r.prototype.GetPostion(self, P, Q)
	local R
	local S = {
		{ Vector(410, 420, 128) },
		{ Vector(410, 420, 128), Vector(310, 374, 128) },
		{ Vector(510, 374, 128), Vector(410, 420, 128), Vector(310, 374, 128) },
		{ Vector(510, 374, 128), Vector(410, 420, 128), Vector(310, 374, 128), Vector(210, 420, 128) },
		{ Vector(610, 420, 128), Vector(510, 374, 128), Vector(410, 420, 128), Vector(310, 374, 128), Vector(
			210,
			420,
			128
		) },
	}
	local T = S[Q]
	local U = T[P + 1]
	if self.bTeleported then
		if GetLocalPlayerID() == self:GetParent():GetPlayerOwnerID() then
			R = PlayerHomePos[self.battle_field_id + 1] + Vector(-U.x, -U.y, 128)
		else
			R = PlayerHomePos[self.battle_field_id + 1] + Vector(-U.x, U.y, 128)
		end
	else
		if self.bLocalBattlePos then
			R = PlayerHomePos[self:GetParent():GetPlayerOwnerID() + 1] + Vector(U.x, -U.y, 128)
		else
			R = PlayerHomePos[self:GetParent():GetPlayerOwnerID() + 1] + Vector(U.x, U.y, 128)
		end
	end
	return R
end
function r.prototype.GetAngle(self)
	if self.bTeleported and GetLocalPlayerID() == self:GetParent():GetPlayerOwnerID() then
		return "0 60 0"
	elseif self.bLocalBattlePos then
		return "0 120 0"
	end
	return "0 240 0"
end
function r.prototype.CreateBackTeleporParticle(self)
	self.particles = {}
	i(h(self.bunnies), function(D, G)
		local H
		local I = G[1]
		H = G[2]
		if IsValidEntity(H) then
			local V = ParticleManager:CreateParticle(
				"particles/econ/events/fall_2022/teleport/teleport_fall2022_end_lvl1.vpcf",
				PATTACH_CUSTOMORIGIN,
				nil
			)
			ParticleManager:SetParticleControl(V, 0, H:GetAbsOrigin())
			ParticleManager:SetParticleControl(V, 1, H:GetAbsOrigin())
			local W = self.particles
			W[#W + 1] = V
		end
	end)
end
function r.prototype.FinishBackHome(self)
	self.bTeleported = false
	self.bLocalBattlePos = false
	self:IDLE(true)
	do
		local E = 0
		while E < #self.particles do
			ParticleManager:DestroyParticle(self.particles[E + 1], true)
			E = E + 1
		end
	end
	self.particles = {}
end
function r.prototype.IDLE(self, X)
	if X == nil then
		X = false
	end
	if not self.bIDLE then
		self.bIDLE = true
	end
	self:PlayAction(nil, X)
end
function r.prototype.PlayAction(self, Y, X)
	if X == nil then
		X = false
	end
	if X then
		i(j(self.p_bunnies), function(D, H)
			if IsValidEntity(H) then
				H:Destroy()
			end
		end)
		i(j(self.bunnies), function(D, H)
			if IsValidEntity(H) then
				H:Destroy()
			end
		end)
	end
	self.d_flag = true
	self.bunnies = {}
	local Z = { "ACT_DOTA_CAST_ABILITY_1", "ACT_DOTA_CAST_ABILITY_2", "ACT_DOTA_CAST_ABILITY_3" }
	local _ = {}
	i(h(self.bunny_oids), function(D, G)
		local a0
		local z
		z = G[1]
		a0 = G[2]
		if a0 ~= -1 then
			_[#_ + 1] = z
		end
	end)
	k(_, function(D, a1, a2)
		return self.bunny_oids[a2] - self.bunny_oids[a1]
	end)
	i(_, function(D, z, P)
		local H = SpawnEntityFromTableSynchronous(
			"prop_dynamic_clientside",
			{
				origin = self:GetPostion(P, #_),
				model = self:GetModel(z),
				angles = self:GetAngle(),
				StartingAnim = Y or Z[RandomInt(0, 2) + 1],
				StartingAnimationLoopMode = Y == nil and "ANIM_LOOP_MODE_NOT_LOOPING" or "ANIM_LOOP_MODE_LOOPING",
				use_animgraph = "1",
				IdleAnim = "ACT_DOTA_IDLE",
				scale = "1.8",
				randomizecycle = "1",
			}
		)
		self.bunnies[z] = H
	end)
	self:StartIntervalThink(FrameTime())
end
function r.prototype.OnIntervalThink(self)
	if IsClient() then
		if not self.d_flag then
			if self.bIDLE then
				self:IDLE()
			end
		else
			i(j(self.p_bunnies), function(D, H)
				if IsValidEntity(H) then
					H:Destroy()
				end
			end)
			self.p_bunnies = self.bunnies
			self.d_flag = false
			if self.bIDLE then
				self:StartIntervalThink(8)
			else
				self:StartIntervalThink(-1)
			end
		end
	end
end
function r.prototype.OnDestroy(self)
	if IsClient() then
		i(j(self.p_bunnies), function(D, H)
			if IsValidEntity(H) then
				H:Destroy()
			end
		end)
		i(j(self.bunnies), function(D, H)
			if IsValidEntity(H) then
				H:Destroy()
			end
		end)
	end
end
r = l(
	{
		q(
			nil,
			{
				IsHidden = true,
				IsDebuff = false,
				IsPurgable = false,
				IsPurgeException = false,
				AllowIllusionDuplicate = false,
				RemoveOnDeath = true,
			}
		),
	},
	r
)
n.modifier_bunny_thinker = r
return n