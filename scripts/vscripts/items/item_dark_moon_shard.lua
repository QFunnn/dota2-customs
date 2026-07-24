--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_item_dark_moon_shard", "items/item_dark_moon_shard", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_item_dark_moon_shard_passive", "items/item_dark_moon_shard", LUA_MODIFIER_MOTION_NONE )


item_dark_moon_shard = class({})
function item_dark_moon_shard:OnChargeCountChanged(iCharges) end

function item_dark_moon_shard:GetIntrinsicModifierName()
   return "modifier_item_dark_moon_shard_passive"
end

function item_dark_moon_shard:OnSpellStart()
	if IsServer() then
		local hCaster = self:GetCaster()
		local hPlayer =  hCaster:GetPlayerOwner()
		if hCaster and ((hCaster:IsRealHero() and not hCaster:IsTempestDouble() and not hCaster:HasModifier("modifier_arc_warden_tempest_double_lua")) or (string.find(hCaster:GetUnitName(),"npc_dota_lone_druid_bear") == 1) ) then 
			if hCaster:HasModifier("modifier_item_dark_moon_shard") then
				return
			end
			-- [NP-14] Поглощение Dark Moon Shard во время ульты Алхимика (Chemical Rage)
			-- РАЗРЕШЕНО: бонус скорости атаки даёт пассивный интринзик от наличия
			-- предмета и не зависит от рейджа, поэтому прежний запрет
			-- (#can_not_cast_during_rage) убран.
			if hCaster:HasModifier("modifier_snapfire_lil_shredder_buff") then
				if hPlayer then
					SendErrorToPlayer(hPlayer:GetPlayerID(), "#can_not_cast_during_lil")
				end
				return
			end
			hCaster:AddNewModifier(hCaster, self, "modifier_item_dark_moon_shard", {})
			self:SpendCharge(0)
			EmitSoundOn("Item.MoonShard.Consume", hCaster)
			Util:RecordConsumableItem(hCaster:GetPlayerOwnerID(),"item_dark_moon_shard")
		end
      	if hCaster and string.find(hCaster:GetUnitName(),"npc_dota_lone_druid_bear") == 1 then 
			local nPlayerID=hCaster:GetPlayerOwnerID()
			if nPlayerID then
				local hHero = PlayerResource:GetSelectedHeroEntity(nPlayerID)
				if hHero then
				hHero.bUsedBearDarkMoon = true
				end
			end
      	end
	end
end

modifier_item_dark_moon_shard_passive = class({})
function modifier_item_dark_moon_shard_passive:IsPurgable() return false end
function modifier_item_dark_moon_shard_passive:IsPurgeException() return false end
function modifier_item_dark_moon_shard_passive:IsHidden() return true end
function modifier_item_dark_moon_shard_passive:RemoveOnDeath() return false end
function modifier_item_dark_moon_shard_passive:GetAttributes() return MODIFIER_ATTRIBUTE_MULTIPLE end
function modifier_item_dark_moon_shard_passive:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT
    }
end

function modifier_item_dark_moon_shard_passive:GetModifierAttackSpeedBonus_Constant()
    if self:GetAbility() then return self:GetAbility():GetSpecialValueFor("passive_attack_speed") end
end

modifier_item_dark_moon_shard = class({})

function modifier_item_dark_moon_shard:IsHidden()
	return true
end

function modifier_item_dark_moon_shard:GetTexture()
	return "item_dark_moon_shard"
end

function modifier_item_dark_moon_shard:IsPermanent()
	return true
end

function modifier_item_dark_moon_shard:IsPurgable()
	return false
end