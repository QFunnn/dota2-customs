--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_item_custom_rune_arcane", "items/runes/arcane.lua", LUA_MODIFIER_MOTION_NONE )

if item_custom_rune_arcane == nil then
	item_custom_rune_arcane = class({})
end

function item_custom_rune_arcane:Precache(context)
	PrecacheResource("particle", "particles/econ/items/abaddon/abaddon_alliance/abaddon_death_coil_alliance_explosion.vpcf", context)
end

function item_custom_rune_arcane:OnSpellStart()
	local RealHero = GetRealUnit(self:GetCaster())
	if RealHero and IsRealHero(RealHero) then
		local CasterPlayerID = RealHero:GetPlayerID()
		for PlayerID, PlayerInfo in pairs(Players:GetAllActivePlayers()) do
			if PlayerID ~= CasterPlayerID then
				local SecondaryUnit = PlayerInfo.secondary_unit
				if SecondaryUnit and not SecondaryUnit:IsNull() and SecondaryUnit:IsAlive() then

					local fx = ParticleManager:CreateParticle("particles/econ/items/abaddon/abaddon_alliance/abaddon_death_coil_alliance_explosion.vpcf", PATTACH_CUSTOMORIGIN_FOLLOW, SecondaryUnit)
					ParticleManager:SetParticleControlEnt(fx, 1, SecondaryUnit, PATTACH_POINT_FOLLOW, "attach_hitloc", Vector(0,0,0), true)
					ParticleManager:ReleaseParticleIndex(fx)

					ApplyDamage({
						victim = SecondaryUnit, 
						attacker = self:GetCaster(), 
						ability = self, 
						damage = 6, 
						damage_type = DAMAGE_TYPE_PURE,
						damage_flags = DOTA_DAMAGE_FLAG_NO_SPELL_AMPLIFICATION,
					})
				end
			end
		end

		EmitGlobalSound("Rune.Arcane")

		UTIL_Remove(self)
	end
end

function item_custom_rune_arcane:OnChargeCountChanged(iCharges) end