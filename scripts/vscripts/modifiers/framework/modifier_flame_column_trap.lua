--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "modifiers/framework/modifier_flame_column_trap"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = b.__TS__SourceMapTraceBack
f(
	debug.getinfo(1).short_src,
	{
		["8"] = 1,
		["9"] = 1,
		["10"] = 1,
		["11"] = 3,
		["12"] = 4,
		["13"] = 5,
		["14"] = 6,
		["15"] = 7,
		["16"] = 8,
		["17"] = 9,
		["18"] = 10,
		["19"] = 11,
		["20"] = 18,
		["21"] = 18,
		["22"] = 26,
		["24"] = 26,
		["25"] = 27,
		["26"] = 28,
		["27"] = 29,
		["28"] = 30,
		["29"] = 31,
		["30"] = 32,
		["31"] = 18,
		["32"] = 36,
		["33"] = 37,
		["34"] = 38,
		["35"] = 39,
		["37"] = 36,
		["38"] = 43,
		["39"] = 44,
		["40"] = 45,
		["41"] = 46,
		["44"] = 49,
		["45"] = 50,
		["48"] = 53,
		["51"] = 57,
		["52"] = 43,
		["53"] = 60,
		["54"] = 61,
		["55"] = 62,
		["56"] = 63,
		["58"] = 64,
		["59"] = 64,
		["60"] = 65,
		["61"] = 66,
		["62"] = 67,
		["63"] = 68,
		["65"] = 64,
		["68"] = 71,
		["69"] = 72,
		["70"] = 73,
		["72"] = 60,
		["73"] = 77,
		["74"] = 78,
		["75"] = 79,
		["76"] = 80,
		["77"] = 81,
		["78"] = 82,
		["79"] = 82,
		["80"] = 82,
		["81"] = 83,
		["82"] = 84,
		["85"] = 87,
		["86"] = 82,
		["87"] = 82,
		["88"] = 77,
		["89"] = 91,
		["90"] = 92,
		["91"] = 93,
		["92"] = 94,
		["95"] = 97,
		["96"] = 98,
		["97"] = 99,
		["98"] = 101,
		["99"] = 102,
		["100"] = 102,
		["101"] = 102,
		["102"] = 102,
		["103"] = 102,
		["104"] = 102,
		["105"] = 102,
		["106"] = 102,
		["107"] = 102,
		["108"] = 103,
		["109"] = 104,
		["110"] = 104,
		["111"] = 105,
		["112"] = 106,
		["113"] = 107,
		["114"] = 107,
		["115"] = 107,
		["116"] = 108,
		["117"] = 109,
		["118"] = 110,
		["121"] = 113,
		["122"] = 114,
		["123"] = 115,
		["126"] = 118,
		["127"] = 119,
		["128"] = 120,
		["129"] = 121,
		["132"] = 125,
		["133"] = 126,
		["134"] = 107,
		["135"] = 107,
		["136"] = 91,
		["137"] = 130,
		["138"] = 131,
		["139"] = 132,
		["140"] = 133,
		["141"] = 134,
		["142"] = 130,
		["143"] = 137,
		["144"] = 138,
		["145"] = 139,
		["147"] = 141,
		["148"] = 137,
		["149"] = 144,
		["150"] = 145,
		["151"] = 146,
		["153"] = 148,
		["155"] = 150,
		["156"] = 151,
		["157"] = 152,
		["158"] = 153,
		["161"] = 144,
		["162"] = 158,
		["163"] = 159,
		["164"] = 160,
		["166"] = 162,
		["167"] = 158,
		["168"] = 165,
		["169"] = 166,
		["170"] = 165,
		["171"] = 169,
		["172"] = 170,
		["174"] = 171,
		["175"] = 171,
		["176"] = 172,
		["177"] = 173,
		["178"] = 174,
		["180"] = 171,
		["183"] = 177,
		["184"] = 169,
		["185"] = 180,
		["186"] = 181,
		["187"] = 182,
		["188"] = 183,
		["189"] = 183,
		["190"] = 183,
		["191"] = 183,
		["192"] = 183,
		["193"] = 183,
		["194"] = 183,
		["195"] = 183,
		["196"] = 183,
		["197"] = 183,
		["198"] = 183,
		["199"] = 180,
		["200"] = 196,
		["201"] = 197,
		["202"] = 198,
		["204"] = 199,
		["205"] = 199,
		["206"] = 200,
		["207"] = 201,
		["208"] = 202,
		["210"] = 199,
		["213"] = 205,
		["214"] = 206,
		["216"] = 208,
		["217"] = 196,
		["218"] = 211,
		["219"] = 212,
		["220"] = 213,
		["222"] = 215,
		["223"] = 211,
		["224"] = 218,
		["225"] = 219,
		["226"] = 220,
		["227"] = 221,
		["228"] = 221,
		["229"] = 221,
		["230"] = 221,
		["231"] = 221,
		["232"] = 221,
		["233"] = 221,
		["234"] = 221,
		["235"] = 221,
		["236"] = 221,
		["237"] = 221,
		["238"] = 218,
		["239"] = 234,
		["240"] = 235,
		["241"] = 236,
		["242"] = 237,
		["245"] = 240,
		["246"] = 242,
		["247"] = 243,
		["248"] = 243,
		["249"] = 243,
		["250"] = 243,
		["251"] = 243,
		["252"] = 243,
		["253"] = 243,
		["254"] = 243,
		["255"] = 243,
		["256"] = 244,
		["257"] = 244,
		["258"] = 244,
		["259"] = 244,
		["260"] = 244,
		["261"] = 245,
		["262"] = 234,
		["263"] = 248,
		["264"] = 249,
		["265"] = 250,
		["266"] = 251,
		["268"] = 253,
		["269"] = 248,
		["270"] = 256,
		["271"] = 257,
		["272"] = 258,
		["273"] = 259,
		["274"] = 260,
		["276"] = 261,
		["277"] = 261,
		["278"] = 262,
		["279"] = 263,
		["280"] = 264,
		["281"] = 265,
		["282"] = 265,
		["283"] = 265,
		["284"] = 265,
		["285"] = 265,
		["286"] = 265,
		["287"] = 265,
		["289"] = 261,
		["292"] = 256,
		["293"] = 270,
		["294"] = 271,
		["295"] = 272,
		["296"] = 272,
		["297"] = 272,
		["298"] = 271,
		["299"] = 273,
		["300"] = 273,
		["301"] = 273,
		["302"] = 271,
		["303"] = 274,
		["304"] = 274,
		["305"] = 274,
		["306"] = 271,
		["307"] = 275,
		["308"] = 275,
		["309"] = 275,
		["310"] = 271,
		["311"] = 271,
		["312"] = 270,
		["313"] = 279,
		["314"] = 280,
		["315"] = 281,
		["316"] = 282,
		["318"] = 284,
		["319"] = 279,
		["320"] = 287,
		["321"] = 288,
		["322"] = 289,
		["325"] = 292,
		["326"] = 293,
		["327"] = 294,
		["329"] = 295,
		["330"] = 295,
		["332"] = 296,
		["333"] = 297,
		["334"] = 297,
		["336"] = 298,
		["337"] = 298,
		["338"] = 298,
		["339"] = 298,
		["340"] = 298,
		["341"] = 298,
		["342"] = 298,
		["343"] = 298,
		["344"] = 298,
		["345"] = 299,
		["346"] = 300,
		["349"] = 295,
		["352"] = 287,
		["353"] = 304,
		["354"] = 305,
		["356"] = 306,
		["357"] = 306,
		["359"] = 307,
		["360"] = 308,
		["361"] = 308,
		["363"] = 309,
		["364"] = 310,
		["365"] = 311,
		["367"] = 313,
		["370"] = 306,
		["373"] = 304,
		["374"] = 317,
		["375"] = 318,
		["376"] = 319,
		["378"] = 320,
		["379"] = 320,
		["381"] = 321,
		["382"] = 322,
		["383"] = 322,
		["385"] = 323,
		["386"] = 324,
		["390"] = 320,
		["393"] = 327,
		["394"] = 317,
		["395"] = 26,
		["396"] = 18,
		["397"] = 18,
		["398"] = 18,
		["399"] = 18,
		["400"] = 18,
		["401"] = 18,
		["402"] = 18,
		["403"] = 18,
		["404"] = 26,
	}
)
local g = {}
local h = require("modifiers.eom_modifier.eom_modifier")
local i = h.EOMModifier
local j = h.registerEOMModifier
local k = 0.5
local l = 1.5
local m = 3
local n = 1
local o = 0.2
local p = 350
local q = 90
local r = 0.04
local s = 0.5
local t = c()
t.name = "modifier_flame_column_trap"
d(t, i)
function t.prototype.____constructor(self, ...)
	i.prototype.____constructor(self, ...)
	self.activeDirections = {}
	self.flameParticleIDs = {}
	self.directionThinkers = {}
	self.nextTriggerTimes = {}
	self.isDestroyed = false
	self.flameSoundCount = 0
end
function t.prototype.OnCreated(self)
	if IsServer() then
		self:CreateDirectionThinkers()
		self:StartIntervalThink(k)
	end
end
function t.prototype.OnIntervalThink(self)
	local u = self:GetParent()
	if not IsValid(u) or not u:IsAlive() then
		self:StartIntervalThink(-1)
		return
	end
	local v = self:GetTriggerDirection()
	if v == nil then
		return
	end
	if self.triggerFunc ~= nil and not self:triggerFunc() then
		return
	end
	self:StartDirectionAttack(v.index, v.direction)
end
function t.prototype.OnDestroy(self)
	if IsServer() then
		self.isDestroyed = true
		self:StartIntervalThink(-1)
		do
			local w = 0
			while w < #self.flameParticleIDs do
				local x = self.flameParticleIDs[w + 1]
				if x ~= nil then
					ParticleManager:DestroyParticle(x, true)
					ParticleManager:ReleaseParticleIndex(x)
				end
				w = w + 1
			end
		end
		self.flameParticleIDs = {}
		self:StopFlameSound(true)
		self:DestroyDirectionThinkers()
	end
end
function t.prototype.StartDirectionAttack(self, y, z)
	local u = self:GetParent()
	local A = self:NormalizeDirection(z)
	self.activeDirections[y] = true
	self:CreateWarning(A)
	u:GameTimer(l, function()
		if self:IsStopped(u) then
			self.activeDirections[y] = false
			return
		end
		self:StartFlame(y, A)
	end)
end
function t.prototype.StartFlame(self, y, z)
	local B = self.directionThinkers[y]
	if not IsValid(B) then
		self.activeDirections[y] = false
		return
	end
	local A = self:NormalizeDirection(z)
	local C = B:GetAbsOrigin()
	local u = self:GetParent()
	local x = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_shredder/shredder_flame_thrower.vpcf",
		PATTACH_ABSORIGIN_FOLLOW,
		B
	)
	ParticleManager:SetParticleControlEnt(x, 0, B, PATTACH_ABSORIGIN_FOLLOW, nil, C, true)
	ParticleManager:SetParticleControl(x, 1, C + A * p)
	local D = self.flameParticleIDs
	D[#D + 1] = x
	self:StartFlameSound(u)
	local E = GameRules:GetGameTime()
	u:GameTimer(0, function()
		if self:IsStopped(u) then
			self:DestroyFlameParticle(x, true)
			self.activeDirections[y] = false
			return
		end
		if not IsValid(u) or not u:IsAlive() then
			self:DestroyFlameParticle(x, true)
			self.activeDirections[y] = false
			return
		end
		if GameRules:GetGameTime() - E >= n then
			self:DestroyFlameParticle(x, false)
			self.activeDirections[y] = false
			self:StartDirectionCooldown(y)
			return
		end
		self:DamageTargets(A)
		return o
	end)
end
function t.prototype.DestroyFlameParticle(self, x, F)
	ArrayRemove(self.flameParticleIDs, x)
	ParticleManager:DestroyParticle(x, F)
	ParticleManager:ReleaseParticleIndex(x)
	self:StopFlameSound(false)
end
function t.prototype.StartFlameSound(self, u)
	if self.flameSoundCount <= 0 then
		u:EmitSound("Hero_Batrider.Firefly.loop")
	end
	self.flameSoundCount = self.flameSoundCount + 1
end
function t.prototype.StopFlameSound(self, G)
	if G then
		self.flameSoundCount = 0
	else
		self.flameSoundCount = math.max(0, self.flameSoundCount - 1)
	end
	if self.flameSoundCount <= 0 then
		local u = self:GetParent()
		if IsValid(u) then
			u:StopSound("Hero_Batrider.Firefly.loop")
		end
	end
end
function t.prototype.IsStopped(self, u)
	if self.isDestroyed or not IsValid(self) or not IsValid(u) or not u:IsAlive() then
		return true
	end
	return not u:HasModifier("modifier_flame_column_trap")
end
function t.prototype.StartDirectionCooldown(self, y)
	self.nextTriggerTimes[y] = GameRules:GetGameTime() + m
end
function t.prototype.HasTarget(self, z)
	local H = self:FindTriggerTargets(z)
	do
		local w = 0
		while w < #H do
			local I = H[w + 1]
			if IsValid(I) and I ~= self:GetParent() then
				return true
			end
			w = w + 1
		end
	end
	return false
end
function t.prototype.FindTriggerTargets(self, z)
	local u = self:GetParent()
	local A = self:NormalizeDirection(z)
	return FindUnitsInSector(
		self:GetTrapTeamNumber(),
		u:GetAbsOrigin(),
		p,
		A,
		q,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_ANY_ORDER
	)
end
function t.prototype.GetTriggerDirection(self)
	local J = {}
	local K = self:GetDirections()
	do
		local w = 0
		while w < #K do
			local L = K[w + 1]
			if L ~= nil and self:CanTriggerDirection(L) and self:HasTarget(L.direction) then
				J[#J + 1] = L
			end
			w = w + 1
		end
	end
	if #J <= 0 then
		return nil
	end
	return J[RandomInt(0, #J - 1) + 1]
end
function t.prototype.CanTriggerDirection(self, L)
	if self.activeDirections[L.index] == true then
		return false
	end
	return GameRules:GetGameTime() >= (self.nextTriggerTimes[L.index] or 0)
end
function t.prototype.FindTargets(self, z)
	local u = self:GetParent()
	local A = self:NormalizeDirection(z)
	return FindUnitsInSector(
		self:GetTrapTeamNumber(),
		u:GetAbsOrigin(),
		p,
		A,
		q,
		DOTA_UNIT_TARGET_TEAM_BOTH,
		DOTA_UNIT_TARGET_HEROES_AND_CREEPS,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_ANY_ORDER
	)
end
function t.prototype.CreateWarning(self, z)
	local A = self:NormalizeDirection(z)
	local B = self:GetDirectionThinker(A)
	if not IsValid(B) then
		return
	end
	local C = B:GetAbsOrigin()
	local x = ParticleManager:CreateParticle("particles/warning/sector.vpcf", PATTACH_ABSORIGIN_FOLLOW, B)
	ParticleManager:SetParticleControlEnt(x, 0, B, PATTACH_ABSORIGIN_FOLLOW, nil, C, true)
	ParticleManager:SetParticleControl(x, 1, Vector(p, q, l))
	ParticleManager:ReleaseParticleIndex(x)
end
function t.prototype.GetTrapTeamNumber(self)
	local M = self:GetCaster()
	if IsValid(M) then
		return M:GetTeamNumber()
	end
	return self:GetParent():GetTeamNumber()
end
function t.prototype.DamageTargets(self, z)
	local u = self:GetParent()
	local M = self:GetCaster()
	local N = IsValid(M) and M or u
	local H = self:FindTargets(z)
	do
		local w = 0
		while w < #H do
			local I = H[w + 1]
			if IsValid(I) and I ~= u then
				local O = (self.damageFunc ~= nil and self:damageFunc(I) * o / n or I:GetMaxHealth() * r) * s
				N:DealDamage(I, nil, O, nil, EOM_DAMAGE_FLAGS.TRAP)
			end
			w = w + 1
		end
	end
end
function t.prototype.GetDirections(self)
	return {
		{ index = 0, direction = Vector(0, 1, 0) },
		{ index = 1, direction = Vector(0, -1, 0) },
		{ index = 2, direction = Vector(-1, 0, 0) },
		{ index = 3, direction = Vector(1, 0, 0) },
	}
end
function t.prototype.NormalizeDirection(self, z)
	local A = Vector(z.x, z.y, 0)
	if A:Length2D() <= 0 then
		return Vector(1, 0, 0)
	end
	return A:Normalized()
end
function t.prototype.CreateDirectionThinkers(self)
	local u = self:GetParent()
	if not IsValid(u) then
		return
	end
	local P = u:GetAbsOrigin()
	local Q = Vector(P.x, P.y, 300)
	local K = self:GetDirections()
	do
		local w = 0
		while w < #K do
			do
				local L = K[w + 1]
				if L == nil then
					goto R
				end
				local B = CreateModifierThinker(u, nil, "modifier_custom_thinker", {}, Q, u:GetTeamNumber(), false)
				B:SetForwardVector(self:NormalizeDirection(L.direction))
				self.directionThinkers[L.index] = B
			end
			::R::
			w = w + 1
		end
	end
end
function t.prototype.DestroyDirectionThinkers(self)
	local K = self:GetDirections()
	do
		local w = 0
		while w < #K do
			do
				local L = K[w + 1]
				if L == nil then
					goto S
				end
				local B = self.directionThinkers[L.index]
				if IsValid(B) then
					B:RemoveSelf()
				end
				self.directionThinkers[L.index] = nil
			end
			::S::
			w = w + 1
		end
	end
end
function t.prototype.GetDirectionThinker(self, z)
	local K = self:GetDirections()
	local A = self:NormalizeDirection(z)
	do
		local w = 0
		while w < #K do
			do
				local L = K[w + 1]
				if L == nil then
					goto T
				end
				if self:NormalizeDirection(L.direction):Dot(A) > 0.99 then
					return self.directionThinkers[L.index]
				end
			end
			::T::
			w = w + 1
		end
	end
	return nil
end
t = e(
	{
		j(
			a,
			{
				IsHidden = true,
				IsDebuff = false,
				IsPurgable = false,
				IsPurgeException = false,
				IsStunDebuff = false,
				AllowIllusionDuplicate = false,
			}
		),
	},
	t
)
return g