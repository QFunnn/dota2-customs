--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-07 04:51:43 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/greevil_egg/greevil_egg_base"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__SourceMapTraceBack
d(
	debug.getinfo(1).short_src,
	{
		["7"] = 3,
		["8"] = 3,
		["9"] = 3,
		["10"] = 23,
		["11"] = 15,
		["12"] = 18,
		["13"] = 24,
		["14"] = 25,
		["15"] = 26,
		["16"] = 27,
		["17"] = 28,
		["18"] = 29,
		["19"] = 29,
		["20"] = 29,
		["21"] = 30,
		["22"] = 29,
		["23"] = 29,
		["24"] = 32,
		["25"] = 32,
		["26"] = 32,
		["27"] = 33,
		["28"] = 32,
		["29"] = 32,
		["30"] = 23,
		["31"] = 47,
		["32"] = 48,
		["33"] = 49,
		["34"] = 52,
		["35"] = 52,
		["36"] = 52,
		["37"] = 52,
		["38"] = 47,
		["39"] = 55,
		["40"] = 56,
		["41"] = 55,
		["42"] = 58,
		["43"] = 60,
		["44"] = 58,
		["45"] = 63,
		["46"] = 64,
		["49"] = 67,
		["52"] = 70,
		["53"] = 71,
		["55"] = 73,
		["56"] = 74,
		["58"] = 76,
		["59"] = 77,
		["60"] = 78,
		["61"] = 79,
		["62"] = 80,
		["63"] = 81,
		["64"] = 87,
		["65"] = 88,
		["66"] = 90,
		["67"] = 90,
		["68"] = 90,
		["69"] = 90,
		["71"] = 87,
		["72"] = 87,
		["73"] = 87,
		["74"] = 87,
		["75"] = 87,
		["76"] = 87,
		["77"] = 87,
		["78"] = 87,
		["79"] = 87,
		["80"] = 93,
		["81"] = 94,
		["82"] = 94,
		["83"] = 94,
		["84"] = 94,
		["85"] = 94,
		["86"] = 94,
		["87"] = 94,
		["88"] = 94,
		["89"] = 94,
		["90"] = 95,
		["91"] = 63,
		["92"] = 98,
		["93"] = 99,
		["94"] = 100,
		["95"] = 101,
		["96"] = 102,
		["97"] = 102,
		["98"] = 102,
		["99"] = 102,
		["100"] = 102,
		["101"] = 103,
		["103"] = 105,
		["104"] = 106,
		["106"] = 108,
		["107"] = 109,
		["108"] = 98,
		["109"] = 111,
		["110"] = 111,
		["111"] = 114,
		["112"] = 115,
		["113"] = 116,
		["115"] = 118,
		["116"] = 119,
		["118"] = 121,
		["119"] = 122,
		["121"] = 114,
		["122"] = 127,
		["123"] = 128,
		["124"] = 129,
		["125"] = 130,
		["126"] = 131,
		["127"] = 132,
		["128"] = 133,
		["129"] = 133,
		["130"] = 133,
		["131"] = 134,
		["132"] = 133,
		["133"] = 133,
		["135"] = 137,
		["137"] = 127,
		["138"] = 142,
		["139"] = 143,
		["140"] = 144,
		["141"] = 145,
		["142"] = 146,
		["144"] = 148,
		["147"] = 142,
		["148"] = 154,
		["149"] = 155,
		["150"] = 156,
		["151"] = 157,
		["152"] = 158,
		["153"] = 158,
		["154"] = 158,
		["155"] = 158,
		["156"] = 158,
		["157"] = 159,
		["159"] = 161,
		["160"] = 162,
		["162"] = 165,
		["163"] = 166,
		["164"] = 166,
		["166"] = 154,
		["167"] = 170,
		["168"] = 170,
		["169"] = 174,
		["170"] = 175,
		["171"] = 175,
		["173"] = 175,
		["175"] = 175,
		["176"] = 175,
		["177"] = 175,
		["179"] = 175,
		["180"] = 174,
		["181"] = 177,
		["182"] = 178,
		["183"] = 177,
		["184"] = 5,
		["185"] = 7,
		["186"] = 8,
	}
)
local e = {}
e.GreevilEggBase = c()
local f = e.GreevilEggBase
f.name = "GreevilEggBase"
function f.prototype.____constructor(self, g, h)
	self.modifierEventIDList = {}
	self.round_start = 0
	self._name = h
	self._position = PlayerData:getPlayerHomeHeroPosition(g) + Vector(-192, 192, 0)
	self._playerID = g
	self.kv = KeyValues.GreevilEggKv[h]
	self._stage = GreevilStage.EGG
	self:ModifierEvent(EOMModifierEvents.MODIFIER_EVENT_ON_ROUND_CHANGE, function(i, j)
		self:OnRoundChange(j.round_number)
	end)
	self:ModifierEvent(EOMModifierEvents.MODIFIER_EVENT_ON_CONFIRM_BATTLE, function()
		self:OnConfirmBattle()
	end)
end
function f.prototype.OnRoundChange(self, k)
	self:createEggEnt(true)
	self:OnRoundGain(k)
	PlayerData:modifyGreevilEnergy(self:getPlayerID(), 10)
end
function f.prototype.OnConfirmBattle(self)
	self:removeEggEnt()
end
function f.prototype.ModifierEvent(self, j, l)
	self.modifierEventIDList[j] = ModifierEvent(j, l, self)
end
function f.prototype.createEggEnt(self, m)
	if self._stage ~= GreevilStage.EGG then
		return
	end
	if not m and not GameState:isCeaseFireState() then
		return
	end
	if IsValid(self.egg_ent) then
		UTIL_Remove(self.egg_ent)
	end
	if IsValid(self.plate_ent) then
		UTIL_Remove(self.plate_ent)
	end
	local n = GetGroundPosition(self._position, nil)
	n.z = n.z + e.GreevilEggBase.height_offset
	local o = PlayerResource:GetSelectedHeroEntity(self._playerID)
	local p = ParticleManager:CreateParticle(
		"particles/econ/events/seasonal_reward_line_fall_2025/blink_dagger_start_fallrewardline_2025.vpcf",
		PATTACH_CUSTOMORIGIN,
		o
	)
	ParticleManager:SetParticleControl(p, 0, n)
	self.plate_ent = SpawnEntityFromTableSynchronous(
		"prop_dynamic",
		{ model = self.kv.PlatformModel, rendercolor = self.kv.PlatformRGBA, origin = n, ModelScale = 0.4 }
	)
	local q = SpawnEntityFromTableSynchronous
	local r = self.kv.Model
	local s = tostring
	local t = self.kv.Skin
	if t == nil then
		t = ""
	end
	self.egg_ent =
		q("prop_dynamic", { model = r, ModelScale = 0.4, skin = s(t), origin = n + e.GreevilEggBase.egg_offset })
	local u = ParticleManager:CreateParticle(
		"particles/econ/events/seasonal_reward_line_fall_2025/blink_dagger_end_fallrewardline_2025_sparkles_outer.vpcf",
		PATTACH_CUSTOMORIGIN,
		o
	)
	ParticleManager:SetParticleControlEnt(u, 0, self.egg_ent, PATTACH_ABSORIGIN_FOLLOW, nil, Vector(0, 0, 0), true)
	self.round_start = GameRules:GetGameTime() + e.GreevilEggBase.hatch_delay
end
function f.prototype.removeEggEnt(self)
	if IsValid(self.plate_ent) then
		local o = PlayerResource:GetSelectedHeroEntity(self._playerID)
		local p = ParticleManager:CreateParticle(
			"particles/econ/events/seasonal_reward_line_fall_2025/blink_dagger_start_fallrewardline_2025.vpcf",
			PATTACH_CUSTOMORIGIN,
			o
		)
		ParticleManager:SetParticleControl(p, 0, self.plate_ent:GetAbsOrigin())
		UTIL_Remove(self.plate_ent)
	end
	if IsValid(self.egg_ent) then
		UTIL_Remove(self.egg_ent)
	end
	self.egg_ent = nil
	self.plate_ent = nil
end
function f.prototype.spawn(self) end
function f.prototype.dispose(self)
	for v, w in pairs(self.modifierEventIDList) do
		RemoveModifierEvent(v, w)
	end
	if IsValid(self.egg_ent) then
		UTIL_Remove(self.egg_ent)
	end
	if IsValid(self.plate_ent) then
		UTIL_Remove(self.plate_ent)
	end
end
function f.prototype.hatch(self)
	local x = Greevil:getPlayerGreevil(self._playerID)
	x._state = GreevilStage.GREEVIL
	if GameState:isCeaseFireState() then
		local y = GameRules:GetGameTime()
		local z = math.max(0, self.round_start - y)
		TimerManager:GameTimer(z, function()
			self:OnHatched()
		end)
	else
		Greevil:fixGreevilLevel(self._playerID, true)
	end
end
function f.prototype.switchStage(self, A)
	if A ~= self._stage then
		self._stage = A
		if A == GreevilStage.GREEVIL then
			self:hatch()
		else
			self:createEggEnt()
		end
	end
end
function f.prototype.OnHatched(self)
	if IsValid(self.plate_ent) then
		local o = PlayerResource:GetSelectedHeroEntity(self._playerID)
		local p = ParticleManager:CreateParticle(
			"particles/econ/events/seasonal_reward_line_fall_2025/blink_dagger_start_fallrewardline_2025.vpcf",
			PATTACH_CUSTOMORIGIN,
			o
		)
		ParticleManager:SetParticleControl(p, 0, self.plate_ent:GetAbsOrigin())
		UTIL_Remove(self.plate_ent)
	end
	if IsValid(self.egg_ent) then
		UTIL_Remove(self.egg_ent)
	end
	local x = Greevil:getPlayerGreevil(self._playerID)
	if x ~= nil then
		x:createHomeGreevil(true)
	end
end
function f.prototype.OnRoundGain(self, k) end
function f.prototype.getSpecialValueFor(self, B)
	local C = self.kv
	local D = C and C.AbilityValues
	if D ~= nil then
		D = D[B]
	end
	local E = D
	if E == nil then
		E = 0
	end
	return E
end
function f.prototype.getPlayerID(self)
	return self._playerID
end
f.hatch_delay = 1
f.egg_offset = Vector(0, 0, 111)
f.height_offset = 0
return e