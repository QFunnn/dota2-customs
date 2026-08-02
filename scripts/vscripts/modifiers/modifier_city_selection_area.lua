--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "modifiers/modifier_city_selection_area"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = b.__TS__SourceMapTraceBack
f(
	debug.getinfo(1).short_src,
	{
		["8"] = 2,
		["9"] = 2,
		["10"] = 2,
		["11"] = 4,
		["12"] = 11,
		["13"] = 4,
		["14"] = 11,
		["16"] = 11,
		["17"] = 12,
		["18"] = 14,
		["19"] = 16,
		["20"] = 4,
		["21"] = 17,
		["22"] = 18,
		["23"] = 17,
		["24"] = 23,
		["25"] = 24,
		["26"] = 25,
		["27"] = 23,
		["28"] = 27,
		["29"] = 28,
		["30"] = 29,
		["31"] = 30,
		["32"] = 31,
		["33"] = 32,
		["34"] = 33,
		["35"] = 34,
		["37"] = 36,
		["38"] = 37,
		["39"] = 38,
		["41"] = 41,
		["42"] = 41,
		["43"] = 41,
		["44"] = 41,
		["45"] = 41,
		["46"] = 42,
		["47"] = 43,
		["48"] = 43,
		["49"] = 43,
		["50"] = 43,
		["51"] = 43,
		["53"] = 45,
		["54"] = 45,
		["55"] = 45,
		["56"] = 45,
		["57"] = 45,
		["58"] = 45,
		["59"] = 45,
		["60"] = 45,
		["62"] = 47,
		["63"] = 27,
		["64"] = 49,
		["65"] = 50,
		["67"] = 53,
		["68"] = 54,
		["69"] = 55,
		["72"] = 49,
		["73"] = 59,
		["74"] = 60,
		["75"] = 61,
		["76"] = 62,
		["77"] = 63,
		["80"] = 66,
		["81"] = 67,
		["82"] = 68,
		["83"] = 69,
		["84"] = 70,
		["86"] = 72,
		["89"] = 66,
		["91"] = 59,
		["92"] = 78,
		["93"] = 79,
		["94"] = 80,
		["95"] = 81,
		["96"] = 78,
		["97"] = 83,
		["98"] = 84,
		["99"] = 85,
		["100"] = 86,
		["101"] = 87,
		["102"] = 89,
		["103"] = 90,
		["104"] = 91,
		["105"] = 91,
		["106"] = 91,
		["107"] = 91,
		["108"] = 91,
		["111"] = 94,
		["112"] = 95,
		["113"] = 96,
		["114"] = 97,
		["119"] = 83,
		["120"] = 103,
		["121"] = 104,
		["122"] = 104,
		["123"] = 104,
		["124"] = 104,
		["125"] = 104,
		["126"] = 104,
		["127"] = 104,
		["128"] = 104,
		["129"] = 104,
		["130"] = 104,
		["131"] = 104,
		["132"] = 103,
		["133"] = 116,
		["134"] = 117,
		["135"] = 116,
		["136"] = 121,
		["137"] = 122,
		["138"] = 121,
		["139"] = 11,
		["140"] = 4,
		["141"] = 4,
		["142"] = 4,
		["143"] = 4,
		["144"] = 4,
		["145"] = 4,
		["146"] = 4,
		["147"] = 11,
		["149"] = 11,
	}
)
local g = {}
local h = require("modifiers.eom_modifier")
local i = h.EOMModifier
local j = h.registerEOMModifier
g.modifier_city_selection_area = c()
local k = g.modifier_city_selection_area
k.name = "modifier_city_selection_area"
d(k, i)
function k.prototype.____constructor(self, ...)
	i.prototype.____constructor(self, ...)
	self.radius = 250
	self.tick = 0.1
	self.uniqueKey = 0
end
function k.prototype.AddCustomTransmitterData(self)
	return { cityName = self.cityName, uniqueKey = self.uniqueKey }
end
function k.prototype.HandleCustomTransmitterData(self, l)
	self.cityName = l.cityName
	self:ClientSelectedParticle()
end
function k.prototype.OnCreated(self, m)
	if IsServer() then
		self.cityName = m and m.cityName or ""
		self:OnPlayerChangeSelection()
		local n = KeyValues.CityEffectKV[self.cityName]
		local o = ""
		if n and n.LandType then
			o = n.LandType
		end
		local p = LAND_PARTICLE_LIST[o]
		if p == nil or p == "" then
			p = "particles/gameplay/custom_city_area_selection.vpcf"
		end
		local q = ParticleManager:CreateParticle(p, PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
		if p == "particles/gameplay/custom_city_area_selection.vpcf" then
			ParticleManager:SetParticleControl(q, 1, Vector(0, self.radius, 0))
		end
		self:AddParticle(q, false, false, -1, false, false)
	end
	self:StartIntervalThink(self.tick)
end
function k.prototype.OnDestroy(self)
	if IsServer() then
	else
		if self.selectedParticle then
			ParticleManager:DestroyParticle(self.selectedParticle, false)
			ParticleManager:ReleaseParticleIndex(self.selectedParticle)
		end
	end
end
function k.prototype.OnIntervalThink(self)
	if IsServer() then
		local r = self:GetParent():GetAbsOrigin()
		local s = GameState:getState()
		if s:getStateName() ~= "GameState_CitySelection" then
			return
		end
		PlayerData:eachPlayer(function(t, u)
			local v = PlayerResource:GetSelectedHeroEntity(u.playerID)
			if IsValid(v) then
				if (r - v:GetAbsOrigin()):Length2D() < self.radius then
					s:setPlayerCitySelection(u.playerID, self.cityName)
				else
					s:setPlayerCitySelection(u.playerID, self.cityName, false)
				end
			end
		end)
	end
end
function k.prototype.OnPlayerChangeSelection(self)
	self.uniqueKey = self.uniqueKey + 1
	self:SetHasCustomTransmitterData(true)
	self:SendBuffRefreshToClients()
end
function k.prototype.ClientSelectedParticle(self)
	if IsClient() then
		local w = GetLocalPlayerID()
		local x = CustomNetTables:GetTableValue("common", "player_city_selection")
		if x and self.cityName ~= nil then
			if x[tostring(w)] == self.cityName then
				if self.selectedParticle == nil then
					self.selectedParticle = ParticleManager:CreateParticle(
						"particles/eom/events/s3_territory_fx/territory_hill_blood_enter_05.vpcf",
						PATTACH_ABSORIGIN_FOLLOW,
						self:GetParent()
					)
				end
			else
				if self.selectedParticle then
					ParticleManager:DestroyParticle(self.selectedParticle, false)
					ParticleManager:ReleaseParticleIndex(self.selectedParticle)
					self.selectedParticle = nil
				end
			end
		end
	end
end
function k.prototype.CheckState(self)
	return {
		[MODIFIER_STATE_NO_HEALTH_BAR] = true,
		[MODIFIER_STATE_INVULNERABLE] = true,
		[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
		[MODIFIER_STATE_NO_TEAM_MOVE_TO] = true,
		[MODIFIER_STATE_NO_TEAM_SELECT] = true,
		[MODIFIER_STATE_NOT_ON_MINIMAP] = true,
		[MODIFIER_STATE_OUT_OF_GAME] = true,
		[MODIFIER_STATE_UNSELECTABLE] = true,
		[MODIFIER_STATE_PROVIDES_VISION] = true,
	}
end
function k.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_PROVIDES_FOW_POSITION }
end
function k.prototype.GetModifierProvidesFOWVision(self)
	return 1
end
k = e(
	{ j(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	k
)
g.modifier_city_selection_area = k
return g