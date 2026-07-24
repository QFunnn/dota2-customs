--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_item_custom_rune_shield", "items/runes/shield.lua", LUA_MODIFIER_MOTION_NONE )

if item_custom_rune_shield == nil then
	item_custom_rune_shield = class({})
end

function item_custom_rune_shield:Precache(context)
	PrecacheResource("particle", "particles/units/heroes/hero_abaddon/abaddon_aphotic_shield.vpcf", context)
	PrecacheResource("particle", "particles/units/heroes/hero_abaddon/abaddon_aphotic_shield_hit.vpcf", context)
end

function item_custom_rune_shield:OnSpellStart()
	self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_item_custom_rune_shield", {duration=10})

	EmitGlobalSound("Rune.Shield")

	UTIL_Remove(self)
end

modifier_item_custom_rune_shield = class({
    IsHidden                = function(self) return false end,
    IsPurgable              = function(self) return false end,
    IsPurgeException        = function(self) return false end,
    IsDebuff                = function(self) return false end,

	DeclareFunctions        = function(self)
        return {
            MODIFIER_PROPERTY_INCOMING_DAMAGE_CONSTANT
        }
    end,

	OnCreated				= function(self)
		self.barrier_max = 10

		if IsServer() then 
			self:SetStackCount(self.barrier_max)

			local fx = ParticleManager:CreateParticle("particles/units/heroes/hero_abaddon/abaddon_aphotic_shield.vpcf", PATTACH_CUSTOMORIGIN_FOLLOW, self:GetParent())
			ParticleManager:SetParticleControlEnt(fx, 0, self:GetParent(), PATTACH_POINT_FOLLOW, "attach_hitloc", Vector(0,0,0), true)
			ParticleManager:SetParticleControl(fx, 1, Vector(100, 0, 0))
			self:AddParticle(fx, false, false, -1, false, false)

			EmitSoundOn("Minigames.ShieldRune.Cast", self:GetParent())
 
			-- self.HealthBar = SpawnEntityFromTableSynchronous("point_clientui_world_panel", {
			-- 	dialog_layout_name = "file://{resources}/layout/custom_game/custom_shieldbar.xml",
			-- 	parentname = self:GetParent():GetName(),
			-- 	targetname = "Unit_HealthBar_"..self:GetParent():entindex(),
			-- 	width = 125,
			-- 	height = 20,
			-- 	panel_dpi = 32,
			-- 	orientation = 3,
			-- 	vertical_align = 1,
			-- 	useLocalOffset = 1,
			-- 	horizontal_align = 1,
			-- 	["local.origin"] = "0 0 215",
			-- })
		end
	end,

	OnDestroy				= function(self)
		if not IsServer() then return end

		-- if self.HealthBar and not self.HealthBar:IsNull() then
		-- 	UTIL_Remove(self.HealthBar)
		-- 	self.HealthBar = nil
		-- end

		-- KeyValues:RemoveEntityData(self:GetParent():entindex())

		EmitSoundOn("Minigames.ShieldRune.End", self:GetParent())
	end,

    GetModifierIncomingDamageConstant           = function(self, event) 
		if IsClient() then
			if event.report_max then
				return self.barrier_max
			else
				return self:GetStackCount()
			end
		end

		local fx = ParticleManager:CreateParticle("particles/units/heroes/hero_abaddon/abaddon_aphotic_shield_hit.vpcf", PATTACH_CUSTOMORIGIN_FOLLOW, self:GetParent())
		ParticleManager:SetParticleControlEnt(fx, 0, self:GetParent(), PATTACH_POINT_FOLLOW, "attach_hitloc", Vector(0,0,0), true)
		ParticleManager:SetParticleControl(fx, 1, Vector(100, 0, 0))
		ParticleManager:ReleaseParticleIndex(fx)

		EmitSoundOn("Minigames.ShieldRune.Damage", self:GetParent())

		if event.original_damage >= self:GetStackCount() then
			self:Destroy()
			return self:GetStackCount() * (-1)
		else
			self:SetStackCount(self:GetStackCount() - event.original_damage)
			return event.original_damage * (-1)
		end
	end,

    GetStatusEffectName			= function(self) return "particles/status_fx/status_effect_shield_rune.vpcf" end,
})
function item_custom_rune_shield:OnChargeCountChanged(iCharges) end