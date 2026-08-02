--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_item_armor_aura", "items/d_items/book_armor", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_armor_aura_cd", "items/d_items/book_armor", LUA_MODIFIER_MOTION_NONE)

modifier_item_armor_aura_cd = class({})
function modifier_item_armor_aura_cd:IsHidden()
	return true
end
function modifier_item_armor_aura_cd:IsDebuff()
	return false
end
function modifier_item_armor_aura_cd:IsPurgable()
	return false
end
function modifier_item_armor_aura_cd:RemoveOnDeath()
	return false
end
function modifier_item_armor_aura_cd:OnCreated(kv)
	if not IsServer() then
		return
	end
	self:StartIntervalThink(FrameTime())
end
function modifier_item_armor_aura_cd:OnIntervalThink()
	self:ForceRefresh()
	self:StartIntervalThink(-1)
end

item_armor_aura = class({})

function item_armor_aura:OnSpellStart()
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
			Hero:AddNewModifier(self.caster, self, "modifier_item_armor_aura", { duration = self.duration })
		end
		self.caster:AddNewModifier(
			self.caster,
			self,
			"modifier_item_armor_aura_cd",
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
modifier_item_armor_aura = class({})

function modifier_item_armor_aura:IsHidden()
	return false
end

function modifier_item_armor_aura:GetTexture()
	return "scroll_4"
end

function modifier_item_armor_aura:IsDebuff()
	return false
end

function modifier_item_armor_aura:IsPurgable()
	return false
end

function modifier_item_armor_aura:OnCreated(kv)
	if IsServer() then
		self:StartIntervalThink(FrameTime())
	end
end

function modifier_item_armor_aura:OnIntervalThink()
	self:ForceRefresh()
	self:StartIntervalThink(-1)
end

function modifier_item_armor_aura:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
	}
	return funcs
end

function modifier_item_armor_aura:GetModifierPhysicalArmorBonus()
	local str = self:GetParent():GetStrength()
	local agi = self:GetParent():GetAgility()
	local int = self:GetParent():GetIntellect(true)
	return 5 * ((str + agi + int) / 100)
end