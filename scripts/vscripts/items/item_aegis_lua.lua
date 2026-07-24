--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


item_aegis_lua = class({})
function item_aegis_lua:OnChargeCountChanged(iCharges) end
LinkLuaModifier( "modifier_item_aegis_lua", "items/item_aegis_lua", LUA_MODIFIER_MOTION_NONE )

--自动使用
function item_aegis_lua:GetIntrinsicModifierName()
  return "modifier_item_aegis_lua"
end

modifier_item_aegis_lua = class({})

function modifier_item_aegis_lua:IsHidden()
	return true
end

function modifier_item_aegis_lua:OnCreated()
	if IsServer() then

		Timers:CreateTimer(0.1, function()
			if self and not self:IsNull() then
					local hCaster = self:GetParent()
					local hPlayer =  hCaster:GetPlayerOwner()
					if hCaster and hCaster:IsRealHero() and not hCaster:IsTempestDouble() and not hCaster:HasModifier("modifier_arc_warden_tempest_double_lua") then 

						HeroBuilder:UpdatePlayerLifesCount(hCaster:GetPlayerOwnerID(), 1, "add")
						 
					    self:GetAbility():SpendCharge(0)
					    EmitSoundOn("DOTA_Item.Refresher.Activate", hCaster)
					    local nParticle = ParticleManager:CreateParticle("particles/items_fx/aegis_respawn_timer.vpcf", PATTACH_ABSORIGIN_FOLLOW, hCaster)
						ParticleManager:ReleaseParticleIndex( nParticle );
						Util:RecordConsumableItem(hCaster:GetPlayerOwnerID(),"item_aegis_lua")
						self:Destroy()
					end
			end
		end)
	end
end
