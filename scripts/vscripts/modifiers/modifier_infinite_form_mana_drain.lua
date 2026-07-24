--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


-- [MF-16] Общий модификатор убыли маны для бесконечных (аганим-toggle) форм.
-- Навешивается ДОПОЛНИТЕЛЬНО на героя при входе в форму (в OnToggle каждой формы),
-- вместо того чтобы вшивать трату маны в каждую форму отдельно.
--   • тратит 2% от МАКС. маны в секунду (think 0.5с → 1% за тик);
--   • при нехватке маны — выключает форму (ToggleAbility) и снимается;
--   • самоочищается: если способность-владелец больше не в toggle-состоянии
--     (форму выключили вручную), снимается на ближайшем тике (трату при этом НЕ списывает).
-- Способность-владелец берётся из source ability (AddNewModifier(caster, ability, ...)).
modifier_infinite_form_mana_drain = class({})

function modifier_infinite_form_mana_drain:IsHidden() return true end
function modifier_infinite_form_mana_drain:IsPurgable() return false end
function modifier_infinite_form_mana_drain:IsPurgeException() return false end

-- MULTIPLE: у героя может быть НЕСКОЛЬКО форм одновременно. Без этого модификатор — синглтон,
-- вторая форма лишь рефрешит первый экземпляр (привязанный к первой способности), и при
-- выключении первой формы дрейн умирает, хотя вторая ещё активна. С MULTIPLE у каждой формы
-- свой экземпляр, привязанный к своей способности → независимая трата (по 2% на форму).
function modifier_infinite_form_mana_drain:GetAttributes()
	return MODIFIER_ATTRIBUTE_MULTIPLE
end

function modifier_infinite_form_mana_drain:OnCreated(kv)
	if not IsServer() then return end
	self.parent = self:GetParent()
	-- external=1 → жизненным циклом рулит внешний вотчер (напр. Arctic Burn — ванильная форма
	-- без своего OnToggle-хука): не самоуничтожаемся по GetToggleState и форму не выключаем.
	self.external = (kv and kv.external == 1)
	self:StartIntervalThink(0.5)
end

function modifier_infinite_form_mana_drain:OnIntervalThink()
	if not IsServer() then return end
	local ab = self:GetAbility()
	if not ab or ab:IsNull() then self:Destroy() return end

	-- Внешний режим (Arctic Burn): не завязываемся на GetToggleState (у ванильной формы он не
	-- переключаемый в привычном смысле). Просто тратим ману при наличии; снятием и выключением
	-- формы при нуле маны занимается вотчер modifier_arctic_burn_no_collision.
	if self.external then
		local drain = self.parent:GetMaxMana() * 0.02 * 0.5
		if self.parent:GetMana() >= drain then
			self.parent:SpendMana(drain, ab)
		end
		return
	end

	-- Обычная toggle-форма: выключили вручную (toggle off) → снимаем дрейн (без списания).
	if ab.GetToggleState and not ab:GetToggleState() then
		self:Destroy()
		return
	end
	-- 2% от МАКС. маны в секунду; think 0.5с → 1% за тик.
	local drain = self.parent:GetMaxMana() * 0.02 * 0.5
	if self.parent:GetMana() < drain then
		if ab.GetToggleState and ab:GetToggleState() then ab:ToggleAbility() end -- выключит форму (OnToggle off)
		self:Destroy()
		return
	end
	self.parent:SpendMana(drain, ab)
end