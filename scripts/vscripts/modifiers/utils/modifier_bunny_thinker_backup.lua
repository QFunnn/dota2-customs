--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "modifiers/utils/modifier_bunny_thinker_backup"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__ArrayIncludes
local f = b.__TS__ObjectKeys
local g = b.__TS__ObjectEntries
local h = b.__TS__ArrayForEach
local i = b.__TS__ObjectValues
local j = b.__TS__ArraySort
local k = b.__TS__DecorateLegacy
local l = b.__TS__SourceMapTraceBack
l(
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
local m = {}
local n = require("modifiers.eom_modifier")
local o = n.EOMModifier
local p = n.registerEOMModifier
m.modifier_bunny_thinker = c()
local q = m.modifier_bunny_thinker
q.name = "modifier_bunny_thinker"
d(q, o)
function q.prototype.____constructor(self, ...)
	o.prototype.____constructor(self, ...)
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
function q.prototype.OnCreated(self, r)
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
function q.prototype.AddCustomTransmitterData(self)
	return { state = self.state, battle_field_id = self.battle_field_id }
end
function q.prototype.HandleCustomTransmitterData(self, s)
	self.p_bunnies = self.p_bunnies or {}
	self.bunnies = self.bunnies or {}
	self.bunny_oids = self.bunny_oids or {}
	if s.state then
		self.state = s.state
		local t = { 4, 5, 7 }
		if e(t, self.state) then
			self.battle_field_id = s.battle_field_id
		end
		repeat
			local u = self.state
			local v = u == 1
			if v then
				do
					self:IDLE(true)
					return
				end
			end
			v = v or u == 2
			if v then
				do
					self.bIDLE = false
					self:PlayAction("ACT_DOTA_VICTORY", true)
					return
				end
			end
			v = v or u == 3
			if v then
				do
					self.bIDLE = false
					self:PlayAction("ACT_DOTA_DEFEAT", true)
					return
				end
			end
			v = v or u == 4
			if v then
				do
					self:BattleConfirm()
					return
				end
			end
			v = v or u == 5
			if v then
				do
					self:EndTeleport()
					return
				end
			end
			v = v or u == 6
			if v then
				do
					self:CreateBackTeleporParticle()
					return
				end
			end
			v = v or u == 7
			if v then
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
		local w = self:GetParent():GetPlayerOwnerID()
		if CustomNetTables:GetTableValue("service", "player_bunny" .. tostring(w)) then
			local x = json.decode(CustomNetTables:GetTableValue("service", "player_bunny" .. tostring(w)).data)
			self.bunny_oids = x
			self:IDLE(true)
		end
	end
end
function q.prototype.GetModel(self, y)
	local z = KeyValues.CosmeticsKV[y]
	if z ~= nil then
		z = z.resource
	end
	local A = z
	if A == nil then
		A = "models/eom/hero/tunvlang_2/tunvlang_2.vmdl"
	end
	return A
end
function q.prototype.OnRefresh(self, r)
	if IsClient() then
	else
		self.state = r.state
		self.battle_field_id = r.battle_field_id
		self:SendBuffRefreshToClients()
	end
end
function q.prototype.GetEnemy(self)
	local B = CustomNetTables:GetTableValue("common", "battle_data")
	for C, D in ipairs(f(B)) do
		local E = B[D]
		if E.mainPlayer.PlayerID == self:GetParent():GetPlayerOwnerID() then
			return E.customerPlayer
		end
		if E.customerPlayer.PlayerID == self:GetParent():GetPlayerOwnerID() then
			return E.mainPlayer
		end
	end
end
function q.prototype.BattleConfirm(self)
	if self.battle_field_id and self.battle_field_id ~= self:GetParent():GetPlayerOwnerID() then
		self.particles = {}
		h(g(self.bunnies), function(C, F)
			local G
			local H = F[1]
			G = F[2]
			if IsValidEntity(G) then
				local I = ParticleManager:CreateParticle(
					"particles/econ/events/fall_2022/teleport/teleport_fall2022_end_lvl1.vpcf",
					PATTACH_CUSTOMORIGIN,
					nil
				)
				ParticleManager:SetParticleControl(I, 0, G:GetAbsOrigin())
				ParticleManager:SetParticleControl(I, 1, G:GetAbsOrigin())
				local J
				if GetLocalPlayerID() == self:GetParent():GetPlayerOwnerID() then
					J = PlayerHomePos[self.battle_field_id + 1] + Vector(-self.POS_OFFSET_X, -self.POS_OFFSET_Y, 128)
				else
					J = PlayerHomePos[self.battle_field_id + 1] + Vector(-self.POS_OFFSET_X, self.POS_OFFSET_Y, 128)
				end
				local K = ParticleManager:CreateParticle(
					"particles/econ/events/fall_2022/teleport/teleport_fall2022_end_lvl1.vpcf",
					PATTACH_CUSTOMORIGIN,
					nil
				)
				ParticleManager:SetParticleControl(K, 0, J)
				ParticleManager:SetParticleControl(K, 1, J)
				local L = self.particles
				L[#L + 1] = I
				local M = self.particles
				M[#M + 1] = K
			end
		end)
	else
		local N = self:GetEnemy()
		if N.PlayerID == GetLocalPlayerID() and N.illusion ~= 1 then
			self.bLocalBattlePos = true
			self:IDLE(true)
		end
	end
end
function q.prototype.EndTeleport(self)
	if self.battle_field_id and self.battle_field_id ~= self:GetParent():GetPlayerOwnerID() then
		self.bTeleported = true
		self:IDLE(true)
		do
			local D = 0
			while D < #self.particles do
				ParticleManager:DestroyParticle(self.particles[D + 1], true)
				D = D + 1
			end
		end
		self.particles = {}
	end
end
function q.prototype.GetPostion(self, O, P)
	local Q
	local R = {
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
	local S = R[P]
	local T = S[O + 1]
	if self.bTeleported then
		if GetLocalPlayerID() == self:GetParent():GetPlayerOwnerID() then
			Q = PlayerHomePos[self.battle_field_id + 1] + Vector(-T.x, -T.y, 128)
		else
			Q = PlayerHomePos[self.battle_field_id + 1] + Vector(-T.x, T.y, 128)
		end
	else
		if self.bLocalBattlePos then
			Q = PlayerHomePos[self:GetParent():GetPlayerOwnerID() + 1] + Vector(T.x, -T.y, 128)
		else
			Q = PlayerHomePos[self:GetParent():GetPlayerOwnerID() + 1] + Vector(T.x, T.y, 128)
		end
	end
	return Q
end
function q.prototype.GetAngle(self)
	if self.bTeleported and GetLocalPlayerID() == self:GetParent():GetPlayerOwnerID() then
		return "0 60 0"
	elseif self.bLocalBattlePos then
		return "0 120 0"
	end
	return "0 240 0"
end
function q.prototype.CreateBackTeleporParticle(self)
	self.particles = {}
	h(g(self.bunnies), function(C, F)
		local G
		local H = F[1]
		G = F[2]
		if IsValidEntity(G) then
			local U = ParticleManager:CreateParticle(
				"particles/econ/events/fall_2022/teleport/teleport_fall2022_end_lvl1.vpcf",
				PATTACH_CUSTOMORIGIN,
				nil
			)
			ParticleManager:SetParticleControl(U, 0, G:GetAbsOrigin())
			ParticleManager:SetParticleControl(U, 1, G:GetAbsOrigin())
			local V = self.particles
			V[#V + 1] = U
		end
	end)
end
function q.prototype.FinishBackHome(self)
	self.bTeleported = false
	self.bLocalBattlePos = false
	self:IDLE(true)
	do
		local D = 0
		while D < #self.particles do
			ParticleManager:DestroyParticle(self.particles[D + 1], true)
			D = D + 1
		end
	end
	self.particles = {}
end
function q.prototype.IDLE(self, W)
	if W == nil then
		W = false
	end
	if not self.bIDLE then
		self.bIDLE = true
	end
	self:PlayAction(nil, W)
end
function q.prototype.PlayAction(self, X, W)
	if W == nil then
		W = false
	end
	if W then
		h(i(self.p_bunnies), function(C, G)
			if IsValidEntity(G) then
				G:Destroy()
			end
		end)
		h(i(self.bunnies), function(C, G)
			if IsValidEntity(G) then
				G:Destroy()
			end
		end)
	end
	self.d_flag = true
	self.bunnies = {}
	local Y = { "ACT_DOTA_CAST_ABILITY_1", "ACT_DOTA_CAST_ABILITY_2", "ACT_DOTA_CAST_ABILITY_3" }
	local Z = {}
	h(g(self.bunny_oids), function(C, F)
		local _
		local y
		y = F[1]
		_ = F[2]
		if _ ~= -1 then
			Z[#Z + 1] = y
		end
	end)
	j(Z, function(C, a0, a1)
		return self.bunny_oids[a1] - self.bunny_oids[a0]
	end)
	h(Z, function(C, y, O)
		local G = SpawnEntityFromTableSynchronous(
			"prop_dynamic_clientside",
			{
				origin = self:GetPostion(O, #Z),
				model = self:GetModel(y),
				angles = self:GetAngle(),
				StartingAnim = X or Y[RandomInt(0, 2) + 1],
				StartingAnimationLoopMode = X == nil and "ANIM_LOOP_MODE_NOT_LOOPING" or "ANIM_LOOP_MODE_LOOPING",
				use_animgraph = "1",
				IdleAnim = "ACT_DOTA_IDLE",
				scale = "1.8",
				randomizecycle = "1",
			}
		)
		self.bunnies[y] = G
	end)
	self:StartIntervalThink(FrameTime())
end
function q.prototype.OnIntervalThink(self)
	if IsClient() then
		if not self.d_flag then
			if self.bIDLE then
				self:IDLE()
			end
		else
			h(i(self.p_bunnies), function(C, G)
				if IsValidEntity(G) then
					G:Destroy()
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
function q.prototype.OnDestroy(self)
	if IsClient() then
		h(i(self.p_bunnies), function(C, G)
			if IsValidEntity(G) then
				G:Destroy()
			end
		end)
		h(i(self.bunnies), function(C, G)
			if IsValidEntity(G) then
				G:Destroy()
			end
		end)
	end
end
q = k(
	{
		p(
			a,
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
	q
)
m.modifier_bunny_thinker = q
return m