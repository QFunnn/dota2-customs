--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-07 04:51:43 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/maps/map_class"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__StringStartsWith
local e = b.__TS__New
local f = b.__TS__ArrayForEach
local g = b.__TS__SourceMapTraceBack
g(
	debug.getinfo(1).short_src,
	{
		["10"] = 4,
		["11"] = 4,
		["12"] = 4,
		["13"] = 27,
		["14"] = 28,
		["15"] = 29,
		["16"] = 30,
		["17"] = 31,
		["18"] = 32,
		["19"] = 33,
		["20"] = 34,
		["21"] = 35,
		["22"] = 36,
		["23"] = 37,
		["25"] = 39,
		["26"] = 40,
		["27"] = 41,
		["28"] = 42,
		["29"] = 43,
		["30"] = 44,
		["31"] = 45,
		["33"] = 47,
		["37"] = 51,
		["38"] = 52,
		["39"] = 53,
		["41"] = 55,
		["42"] = 56,
		["43"] = 56,
		["44"] = 56,
		["45"] = 56,
		["46"] = 56,
		["48"] = 61,
		["49"] = 62,
		["50"] = 62,
		["51"] = 62,
		["52"] = 62,
		["53"] = 62,
		["54"] = 66,
		["55"] = 66,
		["56"] = 66,
		["57"] = 66,
		["58"] = 66,
		["59"] = 66,
		["60"] = 66,
		["62"] = 27,
		["63"] = 69,
		["64"] = 70,
		["65"] = 71,
		["66"] = 72,
		["67"] = 72,
		["68"] = 73,
		["69"] = 72,
		["70"] = 74,
		["71"] = 72,
		["72"] = 72,
		["73"] = 76,
		["74"] = 77,
		["75"] = 78,
		["76"] = 79,
		["78"] = 69,
		["79"] = 85,
		["80"] = 86,
		["81"] = 87,
		["82"] = 88,
		["84"] = 90,
		["85"] = 91,
		["87"] = 85,
		["88"] = 94,
		["89"] = 95,
		["91"] = 97,
		["92"] = 98,
		["93"] = 99,
		["95"] = 94,
		["96"] = 102,
		["97"] = 103,
		["98"] = 104,
		["99"] = 105,
		["100"] = 106,
		["101"] = 107,
		["102"] = 108,
		["103"] = 109,
		["106"] = 102,
		["107"] = 113,
		["108"] = 114,
		["111"] = 117,
		["112"] = 118,
		["113"] = 119,
		["114"] = 120,
		["115"] = 121,
		["117"] = 113,
		["118"] = 127,
		["119"] = 128,
		["120"] = 129,
		["123"] = 132,
		["124"] = 133,
		["125"] = 134,
		["126"] = 135,
		["127"] = 136,
		["128"] = 137,
		["131"] = 140,
		["132"] = 140,
		["133"] = 140,
		["134"] = 141,
		["135"] = 142,
		["136"] = 143,
		["137"] = 140,
		["138"] = 140,
		["139"] = 145,
		["140"] = 145,
		["141"] = 145,
		["142"] = 146,
		["143"] = 147,
		["145"] = 149,
		["146"] = 150,
		["147"] = 151,
		["149"] = 153,
		["150"] = 154,
		["151"] = 155,
		["152"] = 155,
		["153"] = 155,
		["154"] = 155,
		["155"] = 155,
		["156"] = 155,
		["157"] = 155,
		["158"] = 155,
		["159"] = 155,
		["162"] = 163,
		["163"] = 164,
		["164"] = 164,
		["165"] = 164,
		["166"] = 164,
		["167"] = 164,
		["168"] = 164,
		["169"] = 164,
		["170"] = 164,
		["171"] = 164,
		["173"] = 171,
		["174"] = 172,
		["175"] = 173,
		["178"] = 145,
		["179"] = 145,
		["181"] = 178,
		["182"] = 179,
		["183"] = 180,
		["184"] = 180,
		["185"] = 180,
		["186"] = 180,
		["187"] = 180,
		["188"] = 180,
		["189"] = 180,
		["190"] = 180,
		["191"] = 180,
		["194"] = 188,
		["195"] = 189,
		["196"] = 189,
		["197"] = 189,
		["198"] = 189,
		["199"] = 189,
		["200"] = 189,
		["201"] = 189,
		["202"] = 189,
		["203"] = 189,
		["205"] = 196,
		["206"] = 197,
		["207"] = 198,
		["211"] = 202,
		["212"] = 127,
		["213"] = 205,
		["214"] = 206,
		["215"] = 206,
		["216"] = 206,
		["217"] = 207,
		["218"] = 206,
		["219"] = 206,
		["220"] = 209,
		["221"] = 210,
		["222"] = 211,
		["224"] = 213,
		["225"] = 214,
		["227"] = 216,
		["228"] = 217,
		["230"] = 205,
	}
)
local h = {}
h.MapClass = c()
local i = h.MapClass
i.name = "MapClass"
function i.prototype.____constructor(self, j, k, l)
	self.eventIDs = {}
	self.playerID = j
	self.BFSwitching = false
	self.mapName = k
	self.position = l
	self:initMapBaseInstance()
	for m, n in pairs(KeyValues.CosmeticsKV) do
		if n.resource == k and d(m, "530") then
			if n.extra_resource then
				self.victoryParticleName = n.extra_resource
			end
			self.BFModelPath = n.map_model
			self.BFModelSkinDefault = n.map_skin_default and tostring(n.map_skin_default) or nil
			self.BFModelSkinPlus = n.map_skin_plus and tostring(n.map_skin_plus) or nil
			self.BFModelSkinSwitchPTCL = n.map_skin_switch
			self.BFAmbientPlusPath = n.map_ambient_plus
			if self.BFModelPath == "models/eom/props/base_0016_map/base_0016_1.vmdl" then
				self.BFModelAngle = "0 270 0"
			else
				self.BFModelAngle = "0 0 0"
			end
		end
	end
	self.BFState = 0
	if self.BFModelPath then
		self:SwtichMapSkin(0, true)
	end
	if self.victoryParticleName ~= nil then
		local o = self.eventIDs
		o[#o + 1] = {
			id = ModifierEvent(EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_END, self.OnBattleEnd, self),
			event = EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_END,
		}
	end
	if self.BFModelSkinPlus ~= nil then
		local p = self.eventIDs
		p[#p + 1] = {
			id = ModifierEvent(EOMModifierEvents.MODIFIER_EVENT_ON_HERO_LEVEL_UP, self.OnHeroLevelUp, self),
			event = EOMModifierEvents.MODIFIER_EVENT_ON_HERO_LEVEL_UP,
		}
		self.UIEventID = CustomUIEvent("teleport_player_area", function(self, ...)
			return self:OnTeleportPlayerArea(...)
		end, self)
	end
end
function i.prototype.initMapBaseInstance(self)
	local q
	local r = "abilities/maps/" .. self.mapName
	xpcall(function()
		q = require(r)
	end, function(s) end)
	if q and q[self.mapName] then
		q = q[self.mapName]
		self._mapBase = e(q, self.playerID, self.mapName, self.position)
		self._mapBase:spawn()
	end
end
function i.prototype.OnTeleportPlayerArea(self, t)
	if self.BFSwitchScreenID then
		ParticleManager:DestroyParticle(self.BFSwitchScreenID, true)
		self.BFSwitchScreenID = nil
	end
	if t.PlayerID == self.playerID then
		self:checkSwitchState()
	end
end
function i.prototype.OnBattleEnd(self, u)
	if u.illusionPlayerID ~= self.playerID and u.winPlayerID == self.playerID then
		local m = ParticleManager:CreateParticle(self.victoryParticleName, PATTACH_CUSTOMORIGIN, nil)
		ParticleManager:SetParticleControl(m, 0, self.position)
		ParticleManager:ReleaseParticleIndex(m)
	end
end
function i.prototype.OnHeroLevelUp(self, v)
	if v.player_id == self.playerID then
		if v.lvl >= 15 then
			self.BFNextState = 1
			self:checkSwitchState()
		elseif v.lvl < 15 then
			self.BFNextState = 0
			self:checkSwitchState()
		end
	end
end
function i.prototype.checkSwitchState(self)
	if self.BFNextState == nil then
		return
	end
	local j = self.playerID
	local w = PlayerData:getplayerData(self.playerID)
	if w and not w.viewIllusion and j == w.viewPlayerID then
		self:SwtichMapSkin(self.BFNextState)
		self.BFNextState = nil
	end
end
function i.prototype.SwtichMapSkin(self, x, y)
	if not y then
		if self.BFState ~= nil and self.BFState == x then
			return
		end
		self.BFSwitching = true
		if self.BFModelSkinSwitchPTCL then
			local z = PlayerResource:GetSelectedHeroEntity(self.playerID)
			local A = PlayerResource:GetPlayer(self.playerID)
			if IsValid(z) and A then
				self.BFSwitchScreenID =
					ParticleManager:CreateParticleForPlayer(self.BFModelSkinSwitchPTCL, PATTACH_MAIN_VIEW, z, A)
			end
		end
		GameTimer(0.8, function()
			self.BFSwitching = false
			self.BFSwitchScreenID = nil
			self:checkSwitchState()
		end)
		GameTimer(0.5, function()
			if IsValid(self.BFModel) then
				self.BFModel:RemoveSelf()
			end
			if self.BFPlusPTCLID ~= nil then
				ParticleManager:DestroyParticle(self.BFPlusPTCLID, true)
				self.BFPlusPTCLID = nil
			end
			if x == 0 then
				if self.BFModelPath then
					self.BFModel = SpawnEntityFromTableSynchronous(
						"prop_dynamic",
						{
							origin = GetGroundPosition(self.position, nil),
							model = self.BFModelPath,
							skin = self.BFModelSkinDefault,
							angles = self.BFModelAngle,
						}
					)
				end
			else
				if self.BFModelPath then
					self.BFModel = SpawnEntityFromTableSynchronous(
						"prop_dynamic",
						{
							origin = GetGroundPosition(self.position, nil),
							model = self.BFModelPath,
							skin = self.BFModelSkinPlus,
							angles = self.BFModelAngle,
						}
					)
				end
				if self.BFAmbientPlusPath then
					self.BFPlusPTCLID =
						ParticleManager:CreateParticle(self.BFAmbientPlusPath, PATTACH_CUSTOMORIGIN, nil)
					ParticleManager:SetParticleControl(self.BFPlusPTCLID, 0, self.position)
				end
			end
		end)
	else
		if x == 0 then
			if self.BFModelPath then
				self.BFModel = SpawnEntityFromTableSynchronous(
					"prop_dynamic",
					{
						origin = GetGroundPosition(self.position, nil),
						model = self.BFModelPath,
						skin = self.BFModelSkinDefault,
						angles = self.BFModelAngle,
					}
				)
			end
		else
			if self.BFModelPath then
				self.BFModel = SpawnEntityFromTableSynchronous(
					"prop_dynamic",
					{
						origin = GetGroundPosition(self.position, nil),
						model = self.BFModelPath,
						skin = self.BFModelSkinPlus,
						angles = self.BFModelAngle,
					}
				)
			end
			if self.BFAmbientPlusPath then
				self.BFPlusPTCLID = ParticleManager:CreateParticle(self.BFAmbientPlusPath, PATTACH_CUSTOMORIGIN, nil)
				ParticleManager:SetParticleControl(self.BFPlusPTCLID, 0, self.position)
			end
		end
	end
	self.BFState = x
end
function i.prototype.dispose(self)
	f(self.eventIDs, function(B, n)
		RemoveModifierEvent(n.event, n.id)
	end)
	if self.BFPlusPTCLID ~= nil then
		ParticleManager:DestroyParticle(self.BFPlusPTCLID, true)
		self.BFPlusPTCLID = nil
	end
	if self.UIEventID then
		CustomGameEventManager:UnregisterListener(self.UIEventID)
	end
	if self._mapBase then
		self._mapBase:_dispose()
	end
end
return h