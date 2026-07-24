--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_lina_flame_cloak_custom", "abilities/lina_flame_cloak_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_infinite_form_mana_drain", "modifiers/modifier_infinite_form_mana_drain", LUA_MODIFIER_MOTION_NONE)

lina_flame_cloak_custom = class({})

function lina_flame_cloak_custom:OnSpellStart()
    if not IsServer() then return end
    self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_lina_flame_cloak", {duration = self:GetSpecialValueFor("flame_cloak_duration")})
end

function lina_flame_cloak_custom:GetManaCost(level)
	if self:GetCaster():HasScepter() then 
        if IsClient() then return 15 end
		return 0
	end
	return self.BaseClass.GetManaCost(self,level)
end

function lina_flame_cloak_custom:GetCooldown(iLevel)
	if self:GetCaster():HasScepter() then
		return 0
	end
	return self.BaseClass.GetCooldown(self, iLevel) 
end

function lina_flame_cloak_custom:GetBehavior()
  	if self:GetCaster():HasScepter() then
    	return DOTA_ABILITY_BEHAVIOR_NO_TARGET + DOTA_ABILITY_BEHAVIOR_TOGGLE + DOTA_ABILITY_BEHAVIOR_IMMEDIATE
   	end
 	return DOTA_ABILITY_BEHAVIOR_NO_TARGET + DOTA_ABILITY_BEHAVIOR_IMMEDIATE 
end

function lina_flame_cloak_custom:OnToggle() 
	if not IsServer() then return end
	
	local modifier_lina_flame_cloak = self:GetCaster():FindModifierByName("modifier_lina_flame_cloak")

	if not self:GetToggleState() then
		if modifier_lina_flame_cloak then
			modifier_lina_flame_cloak:Destroy()
		end
	else
		self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_lina_flame_cloak", {})
		self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_lina_flame_cloak_custom", {})
		self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_infinite_form_mana_drain", {}) -- [MF-16] общий дрейн 3%/сек
	end

	self:EndCooldown()
	self:StartCooldown(1) 
end

modifier_lina_flame_cloak_custom = class({})

function modifier_lina_flame_cloak_custom:IsHidden() return true end
function modifier_lina_flame_cloak_custom:IsPurgable() return false end
function modifier_lina_flame_cloak_custom:IsPurgeException() return false end

-- [A61] Flame Cloak (аганим-форма) даёт полёт (через связанный modifier_lina_flame_cloak, он
-- движковый/не определён в репо — править нельзя). Этот _custom-маркер висит на герое всю форму,
-- поэтому NO_UNIT_COLLISION вешаем сюда: убирает коллизию героя → летающий не запирает наземного
-- врага (как фикс DK/остальных форм), независимо от того, что именно даёт полёт.
function modifier_lina_flame_cloak_custom:CheckState()
	local parent = self:GetParent()
	if not parent or parent:IsNull() then return end
	return
	{
		[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
	}
end

function modifier_lina_flame_cloak_custom:OnCreated()
	if not IsServer() then return end
    self.caster = self:GetCaster()
	self:StartIntervalThink(0.5)
end

function modifier_lina_flame_cloak_custom:OnIntervalThink()
	if not IsServer() then return end
	-- [MF-16] Трату маны вынесли в общий modifier_infinite_form_mana_drain (навешивается в OnToggle).
	-- Здесь остаётся только очистка формы.
	if not self.caster:HasModifier("modifier_lina_flame_cloak") then
		self:Destroy()
        return
	end
    if not self.caster:HasScepter() then
        self.caster:RemoveModifierByName("modifier_lina_flame_cloak")
        return
    end
end