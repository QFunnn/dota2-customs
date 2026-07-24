--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


if Halloween == nil then Halloween = class({}) end

function Halloween:Init()
   Halloween.damageCount={}
   for nPlayerID = 0, DOTA_MAX_TEAM_PLAYERS-1 do    
       Halloween.damageCount[nPlayerID] = 0
   end
end



function Halloween:SettleDamageBonus()
   
   local dataList= {}
   for nPlayerID = 0, DOTA_MAX_TEAM_PLAYERS-1 do
   	   local data = {}
       if Halloween.damageCount[nPlayerID]>0 then
       	  data.flDamage = Halloween.damageCount[nPlayerID]
          data.nPlayerID = nPlayerID
          table.insert(dataList, data)
       end
   end
   if #dataList>=1 then
   table.sort(dataList, function(a, b) return a.flDamage > b.flDamage end)

   local nAliveTeamNumber = 0 
	 for _,bAlive in pairs(GameMode.vAliveTeam) do
	   if bAlive then
	     nAliveTeamNumber = nAliveTeamNumber+1
	   end
	 end

	 local flReducePerRank = 0
	 if nAliveTeamNumber >= 1 then
		 flReducePerRank = 1 / nAliveTeamNumber
	 end
     
     local nRank=0
     for _,data in ipairs(dataList) do
     	    nRank = nRank+1
        --1.5倍过关奖励   	    
		    local nBonusGold = math.ceil(GameMode.currentRound.flBonus*1.5* (1-(nRank-1) *flReducePerRank))
		    --发奖励
		    local hHero = PlayerResource:GetSelectedHeroEntity(data.nPlayerID)
		    SendOverheadEventMessage(hHero, OVERHEAD_ALERT_GOLD, hHero, nBonusGold, nil)
        PlayerResource:ModifyGold(data.nPlayerID,nBonusGold, true, DOTA_ModifyGold_GameTick)
        --弹幕
		    local vBulletData = {}
	        vBulletData.type = "settle_pumpkin_king"
	        vBulletData.gold_value =tostring(nBonusGold)
	        vBulletData.playerId = data.nPlayerID
	        vBulletData.damage = Halloween.damageCount[data.nPlayerID]
	        Barrage:FireBullet(vBulletData)
     end
   end

   for nPlayerID = 0, DOTA_MAX_TEAM_PLAYERS-1 do    
       Halloween.damageCount[nPlayerID] = 0
   end
end


function Halloween:SpawnPumpkinKing()
   local mapCenter = Entities:FindByName(nil, "map_center")
   --出生点位于地图中央
   local hUnit = CreateUnitByName("npc_dota_pumpkin_king", Vector(0,0,mapCenter:GetAbsOrigin().z), true, nil, nil, DOTA_TEAM_NEUTRALS)

   local nParticleIndex = ParticleManager:CreateParticle("effect/crown_s2/2_shield.vpcf",PATTACH_OVERHEAD_FOLLOW,hUnit)
   ParticleManager:SetParticleControlEnt(nParticleIndex,0,hUnit,PATTACH_OVERHEAD_FOLLOW,"follow_origin",hUnit:GetAbsOrigin()+Vector(0,0,500),true)
   
end