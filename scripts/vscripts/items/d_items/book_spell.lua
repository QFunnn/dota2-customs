--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-05 05:42:45 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_item_spell_aura", "items/d_items/book_spell", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_spell_aura_cd", "items/d_items/book_spell", LUA_MODIFIER_MOTION_NONE)

modifier_item_spell_aura_cd = class({})
function modifier_item_spell_aura_cd:IsHidden()
	return true
end
function modifier_item_spell_aura_cd:IsDebuff()
	return false
end
function modifier_item_spell_aura_cd:IsPurgable()
	return false
end
function modifier_item_spell_aura_cd:RemoveOnDeath()
	return false
end
function modifier_item_spell_aura_cd:OnCreated(kv)
	if not IsServer() then
		return
	end
	self:StartIntervalThink(FrameTime())
end
function modifier_item_spell_aura_cd:OnIntervalThink()
	self:ForceRefresh()
	self:StartIntervalThink(-1)
end

item_spell_aura = class({})

function item_spell_aura:OnSpellStart()
	if IsServer() then
		self.caster = self:GetCaster()
		self.radius = self:GetSpecialValueFor("radius")
		self.duration = self:GetSpecialValueFor("duration")
		local Heroes = FindUnitsInRadius(
			self:GetCaster():GetTeamNumber(),
			self:GetCaster():GetOrigin(),
			self:GetCaster(),
			self.radius,
			DOTA_UNIT_TARGET_TEAM_FRIENDLY,
			DOTA_UNIT_TARGET_HERO,
			DOTA_UNIT_TARGET_FLAG_NOT_ILLUSIONS,
			0,
			false
		)
		for _, Hero in pairs(Heroes) do
			Hero:AddNewModifier(self.caster, self, "modifier_item_spell_aura", { duration = self.duration })
		end
		self.caster:AddNewModifier(
			self.caster,
			self,
			"modifier_item_spell_aura_cd",
			{ duration = self:GetCooldown(self:GetLevel()) * self.caster:GetCooldownReduction() }
		)
		self.caster:EmitSound("Item.TomeOfKnowledge")
		self:SpendCharge(1)
		local new_charges = self:GetCurrentCharges()
		if new_charges <= 0 then
			UTIL_Remove(self)
		end
	end
end

----------------------------------------------------------------------------------------------------------------------------------------------------------------------
modifier_item_spell_aura = class({})

function modifier_item_spell_aura:IsHidden()
	return false
end

function modifier_item_spell_aura:GetTexture()
	return "spell_buff"
end

function modifier_item_spell_aura:IsDebuff()
	return false
end

function modifier_item_spell_aura:IsPurgable()
	return false
end

function modifier_item_spell_aura:OnCreated(kv)
	if IsServer() then
		self:StartIntervalThink(FrameTime())
	end
end

function modifier_item_spell_aura:OnIntervalThink()
	self:ForceRefresh()
	self:StartIntervalThink(-1)
end

function modifier_item_spell_aura:DeclareFunctions()
	local funcs = {
		MODIFIER_EVENT_ON_TAKEDAMAGE,
	}
	return funcs
end

function modifier_item_spell_aura:OnTakeDamage(keys)
	if
		keys.attacker == self:GetParent()
		and keys.unit ~= keys.attacker
		and not keys.unit:IsBuilding()
		and not keys.unit:IsOther()
	then
		if
			self:GetParent():FindAllModifiersByName(self:GetName())[1] == self
			and keys.damage_category == 0
			and keys.inflictor
			and bit.band(keys.damage_flags, DOTA_DAMAGE_FLAG_NO_SPELL_LIFESTEAL)
				~= DOTA_DAMAGE_FLAG_NO_SPELL_LIFESTEAL
		then
			local lifesteal = keys.original_damage * 5 / 100
			if lifesteal > 1 then
				self.lifesteal_pfx = ParticleManager:CreateParticle(
					"particles/items3_fx/octarine_core_lifesteal.vpcf",
					PATTACH_ABSORIGIN_FOLLOW,
					keys.attacker
				)
				ParticleManager:SetParticleControl(self.lifesteal_pfx, 0, keys.attacker:GetAbsOrigin())
				ParticleManager:ReleaseParticleIndex(self.lifesteal_pfx)

				keys.attacker:Heal(lifesteal, self)
			end
		end
	end
end