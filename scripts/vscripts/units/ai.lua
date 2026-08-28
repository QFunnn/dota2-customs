--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "units/ai"
local b = require("lualib_bundle")
local c = b.__TS__SourceMapTraceBack
c(
	debug.getinfo(1).short_src,
	{
		["5"] = 4,
		["6"] = 4,
		["7"] = 8,
		["8"] = 8,
		["9"] = 8,
		["10"] = 8,
		["11"] = 9,
		["13"] = 8,
		["14"] = 8,
		["15"] = 15,
		["16"] = 16,
		["17"] = 18,
		["18"] = 19,
		["19"] = 20,
		["22"] = 22,
		["23"] = 22,
		["24"] = 22,
		["25"] = 24,
		["27"] = 24,
		["28"] = 24,
		["29"] = 24,
		["31"] = 24,
		["33"] = 24,
		["34"] = 25,
		["35"] = 26,
		["36"] = 48,
		["37"] = 49,
		["38"] = 50,
		["39"] = 51,
		["40"] = 52,
		["42"] = 54,
		["46"] = 66,
		["47"] = 66,
		["48"] = 67,
		["49"] = 68,
		["50"] = 69,
		["54"] = 66,
		["58"] = 78,
		["59"] = 79,
		["60"] = 80,
		["62"] = 107,
		["64"] = 109,
		["65"] = 110,
		["66"] = 110,
		["67"] = 110,
		["68"] = 110,
		["70"] = 112,
		["71"] = 113,
		["72"] = 114,
		["73"] = 124,
		["74"] = 125,
		["75"] = 126,
		["76"] = 127,
		["77"] = 128,
		["78"] = 129,
		["79"] = 130,
		["80"] = 131,
		["83"] = 134,
		["84"] = 22,
		["85"] = 22,
		["86"] = 136,
		["88"] = 15,
		["89"] = 139,
		["90"] = 140,
		["91"] = 141,
		["92"] = 142,
		["93"] = 143,
		["94"] = 144,
		["97"] = 139,
	}
)
local d = {}
local e = require("lib.dota_ts_adapter")
local f = e.registerEntityFunction
f(nil, "Spawn", function(g, h)
	if IsServer() then
	end
end)
function d.processAI(self, i, j)
	if IsServer() then
		local k = getInterestConfig(nil)
		local l = PlayerData.playerData[i]
		if l.aiTimer > 0 then
			return
		end
		l.aiTimer = GameTimer(1, function()
			local m = l:IsBotData()
			if m then
				local n = Demo.m_bEnableAI
				if n == nil then
					n = true
				end
				m = n
			end
			if m then
				if GameState:getStateName() == "GameState_Prepare" then
					if not l.prepareReady then
						if j == "hard" or j == "hard1" or j == "hard2" then
							local o = PlayerResource:GetSelectedHeroEntity(i)
							if IsValid(o) then
								if Match:hasBonusGoldBot(i) then
									o:AddNewModifier(o, nil, "modifier_ai_luck", { maxLuck = BOT_LUCK[j] })
								else
									o:AddNewModifier(o, nil, "modifier_ai_luck", { maxLuck = BOT_LUCK[j] * 0.3 })
								end
							end
							do
								local p = 0
								while p < 20 do
									CardEffect:TryBuyCardEffect(i)
									if
										(
											PlayerData:getGold(i) >= k.Rate * math.floor(k.Max / k.Gold) + 100
											or l.health <= 10
										) and PlayerData:getGold(i) >= PlayerData:getRandomGoldCost(i)
									then
										AbilityShop:OnAbilityShop({ PlayerID = i, random = 1 })
									else
										break
									end
									p = p + 1
								end
							end
						end
						if j ~= "disconnect" then
							local q = PlayerData:getHero(i)
							q:tryToAutoSetMergeAbility()
						end
						PlayerData:OnPrepareReady({ PlayerID = i })
					end
					if IsInToolsMode() and PlayerData.playerData[i].talentPoint > 0 then
						PlayerData:OnLearnTalent({
							PlayerID = i,
							sTalentName = GetRandomElement(PlayerData.playerData[i].talentSelection[1]),
						})
					end
				elseif GameState:getStateName() == "GameState_HeroSelection" then
					GameState:getState():OnRandomHero(i, {})
				elseif GameState:getStateName() == "GameState_ConfirmNeutral" then
					l.prepareReady = true
					l:updateNetTable()
				elseif GameState:getStateName() == "GameState_ArtifactSelection" then
					local r = GameState:getState()
					r:RandomArtifact(i)
				elseif GameState:getStateName() == "GameState_SpecialSelection" then
					local r = GameState:getState()
					r:SelectRandomItem(i)
				end
			end
			return 1
		end)
		return l.aiTimer
	end
end
function d.stopProcessAI(self, i)
	if IsServer() then
		local l = PlayerData.playerData[i]
		if l.aiTimer > 0 then
			StopTimer(l.aiTimer)
			l.aiTimer = 0
		end
	end
end
return d