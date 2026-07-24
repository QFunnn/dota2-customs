--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_spectre_dispersion_custom", "abilities/spectre_dispersion_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_spectre_dispersion_custom_active", "abilities/spectre_dispersion_custom", LUA_MODIFIER_MOTION_NONE)

spectre_dispersion_custom = class({})

function spectre_dispersion_custom:GetBehavior()
	if self:GetCaster():HasShard() then
		return DOTA_ABILITY_BEHAVIOR_NO_TARGET + DOTA_ABILITY_BEHAVIOR_IMMEDIATE
	end
	return DOTA_ABILITY_BEHAVIOR_PASSIVE
end

function spectre_dispersion_custom:GetCooldown(iLevel)
	if self:GetCaster():HasShard() then
		return self:GetSpecialValueFor("activation_cooldown")
	end
	return 0
end

function spectre_dispersion_custom:GetManaCost(iLevel)
	if self:GetCaster():HasShard() then
		return self:GetSpecialValueFor("activation_manacost")
	end
	return 0
end

function spectre_dispersion_custom:OnSpellStart()
	if not IsServer() then return end
	local activation_duration = self:GetSpecialValueFor("activation_duration")
	self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_spectre_dispersion_custom_active", {duration = activation_duration})
end

function spectre_dispersion_custom:GetIntrinsicModifierName()
	return "modifier_spectre_dispersion_custom"
end

modifier_spectre_dispersion_custom = class({})

function modifier_spectre_dispersion_custom:IsHidden()
	return true
end

function modifier_spectre_dispersion_custom:IsDebuff()
	return false
end

function modifier_spectre_dispersion_custom:IsStunDebuff()
	return false
end

function modifier_spectre_dispersion_custom:IsPurgable()
	return false
end

function modifier_spectre_dispersion_custom:OnCreated( kv )
	self.parent = self:GetParent()
    self.ability = self:GetAbility()
	self.reflect = self.ability:GetSpecialValueFor( "damage_reflection_pct" )
	self.min_radius = self.ability:GetSpecialValueFor( "min_radius" )
	self.max_radius = self.ability:GetSpecialValueFor( "max_radius" )
    self.reflect = self:GetAbility():GetSpecialValueFor( "damage_reflection_pct" )
	self.delta = self.max_radius-self.min_radius
	if not IsServer() then return end
	self.dmg_list = {}
	self:StartIntervalThink(1.0)
end

function modifier_spectre_dispersion_custom:OnIntervalThink()
	if not IsServer() then return end
	for _, dmg_t in pairs(self.dmg_list) do
		if dmg_t.victim and not dmg_t.victim:IsNull() then
			ApplyDamage(dmg_t)
		end
	end
	self.dmg_list = {}
end

function modifier_spectre_dispersion_custom:OnRefresh( kv )
	self:OnCreated( kv )
end

function modifier_spectre_dispersion_custom:DeclareFunctions()
	local funcs = 
	{
		MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE,
	}
	return funcs
end

function modifier_spectre_dispersion_custom:GetModifierIncomingDamage_Percentage( params )
	if not IsServer() then return end
	if self:FlagExist( params.damage_flags, DOTA_DAMAGE_FLAG_REFLECTION ) then
		return
	end
	if self.parent:PassivesDisabled() then return 0 end
	local reflect = self.reflect
    local reflect_damage = self.reflect
	if self.parent:HasModifier("modifier_spectre_dispersion_custom_active") then
		reflect_damage = reflect_damage * 2
	end

	-- [NP3-4 / вар.A] Атакующий в ДРУГОЙ арене (глобалка кросс-арена) → отражаем одной целью
	-- В НЕГО (полный процент, без falloff по дистанции), а не по радиусу своей арены/крипам.
	do
		local attacker = params.attacker
		if attacker and not attacker:IsNull() then
			local atkArena = Players:GetUnitArena(attacker)
			local myArena = Players:GetUnitArena(self.parent)
			if atkArena and myArena and atkArena ~= myArena then
				ApplyDamage({
					attacker = self.parent,
					ability = self:GetAbility(),
					damage_flags = DOTA_DAMAGE_FLAG_HPLOSS + DOTA_DAMAGE_FLAG_REFLECTION,
					victim = attacker,
					damage = params.original_damage * reflect_damage / 100,
					damage_type = params.damage_type,
				})
				return -reflect  -- то же снижение входящего урона носителю, что и в обычной ветке
			end
		end
	end

	local enemies = FindUnitsInRadius( self.parent:GetTeamNumber(), self.parent:GetOrigin(), nil, self.max_radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 0, 0, false )
	for _,enemy in pairs(enemies) do
		local distance = (enemy:GetOrigin()-self.parent:GetOrigin()):Length2D()
		local pct = (self.max_radius-distance)/self.delta
		pct = math.min( pct, 1 )
		local dmg = params.original_damage * pct * reflect_damage/100
		local idx = enemy:entindex()

		-- Героям (вкл. иллюзии) возвращаем сразу — секундный батчинг плох для UX
		-- атакующих игроков (целая секунда «кажется ничего не отражается»,
		-- потом разом большой spike). Крипы по-прежнему батчатся через
		-- self.dmg_list, чтобы не плодить сотни ApplyDamage в массовых боях.
		if enemy:IsHero() then
			ApplyDamage({
				attacker = self.parent,
				ability = self:GetAbility(),
				damage_flags = DOTA_DAMAGE_FLAG_HPLOSS + DOTA_DAMAGE_FLAG_REFLECTION,
				victim = enemy,
				damage = dmg,
				damage_type = params.damage_type,
			})
		else
			if self.dmg_list[idx] then
				self.dmg_list[idx].damage = self.dmg_list[idx].damage + dmg
			else
				self.dmg_list[idx] = {
					attacker = self.parent,
					ability = self:GetAbility(),
					damage_flags = DOTA_DAMAGE_FLAG_HPLOSS + DOTA_DAMAGE_FLAG_REFLECTION,
					victim = enemy,
					damage = dmg,
					damage_type = params.damage_type,
				}
			end
		end
	end
	return -reflect
end

function modifier_spectre_dispersion_custom:FlagExist(a,b)--Bitwise Exist
	local p,c,d=1,0,b
	while a>0 and b>0 do
		local ra,rb=a%2,b%2
		if ra+rb>1 then c=c+p end
		a,b,p=(a-ra)/2,(b-rb)/2,p*2
	end
	return c==d
end

modifier_spectre_dispersion_custom_active = class({})
function modifier_spectre_dispersion_custom_active:IsPurgable() return false end
function modifier_spectre_dispersion_custom_active:IsPurgeException() return false end
function modifier_spectre_dispersion_custom_active:GetEffectName()
	return "particles/units/heroes/hero_spectre/spectre_dispersion_boost_effect.vpcf"
end