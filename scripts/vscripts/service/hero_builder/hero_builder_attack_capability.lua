--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


-- Модификаторы, меняющие тип атаки: по ним восстанавливаем исходный AttackCapability
HeroBuilderService.attackCapabilityModifiers = {
	["modifier_troll_warlord_berserkers_rage"] = true,
	["modifier_lone_druid_true_form"] = true,
	["modifier_terrorblade_metamorphosis"] = true,
	["modifier_dragon_knight_dragon_form"] = true,
	["modifier_dragon_knight_elder_dragon_form_lua_form"] = true,
}

-- Отслеживать событие внутри фильтра модификаторов
---@param hero CDOTA_BaseNPC_Hero
function HeroBuilderService:RegisterAttackCapabilityChanged(hero)
	if not hero or hero:IsTempestDouble() or hero:HasModifier("modifier_arc_warden_tempest_double_lua") then
		return
	end
	HeroBuilderService.attackCapabilityChanged[hero:GetEntityIndex()] = hero
end

---@param hero CDOTA_BaseNPC_Hero
local function HasAttackCapabilityModifiers(hero)
	for _, modifier in ipairs(hero:FindAllModifiers()) do
		if HeroBuilderService.attackCapabilityModifiers[modifier:GetName()] then
			return true
		end
	end
	return false
end

-- Периодическое задание, исправляющее исходный тип атаки героя
function HeroBuilderService:FixAttackCapability()
	for _, hero in pairs(HeroBuilderService.attackCapabilityChanged) do
		if hero and hero.originalAttackCapability and not HasAttackCapabilityModifiers(hero) then
			hero:SetAttackCapability(hero.originalAttackCapability)
		end
	end
end