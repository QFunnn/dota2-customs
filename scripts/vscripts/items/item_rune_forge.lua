--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


item_rune_forge = class({})
function item_rune_forge:OnChargeCountChanged(iCharges) end


function item_rune_forge:OnSpellStart()
	if IsServer() then
		local hCaster = self:GetCaster()
		if hCaster and hCaster:GetTeamNumber() then

            if hCaster:HasModifier("modifier_hero_refreshing") then
                self:EndCooldown()
                self:StartCooldown(1.0)
                return
            end

			hCaster:EmitSound("Hero_ArcWarden.RuneForge.Cast")

			local nRandomRange = RandomInt(100, 200)
			local vRandomPos=hCaster:GetAbsOrigin()+RandomVector(nRandomRange)

            local nRetryTime = 1
            while (not GridNav:CanFindPath(hCaster:GetAbsOrigin(), vRandomPos )) and nRetryTime<20  do
            	nRetryTime = nRetryTime + 1
                nRandomRange = RandomInt(50, 950)
			    vRandomPos=hCaster:GetAbsOrigin()+RandomVector(nRandomRange)
            end

            local runes = 
            {
                DOTA_RUNE_DOUBLEDAMAGE,
                DOTA_RUNE_HASTE,
                DOTA_RUNE_ILLUSION,
                DOTA_RUNE_INVISIBILITY,
                DOTA_RUNE_REGENERATION,
                DOTA_RUNE_ARCANE,
                DOTA_RUNE_SHIELD,
            }

			CreateRune(vRandomPos, runes[RandomInt(1, #runes)])

			self:SpendCharge(0)
            
            if hCaster and hCaster:GetPlayerOwnerID() then 
			   Util:RecordConsumableItem(hCaster:GetPlayerOwnerID(),"item_rune_forge")
			end
		end
	end
end
