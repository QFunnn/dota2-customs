--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


var global = this;
var Diy;
(function (Diy) {
    class DiyAbility {
        constructor(iEntID, iAbltID) {
            this.__iEntID = iEntID;
            this.__iAbltID = iAbltID;
        }
        GetDiyAbilityCustomAttributes() {
            var _a;
            return (_a = GameUI.CustomUIConfig().tools.runlua(`
                local tAttributes = {}
                local hUnit = EntIndexToHScript(${this.__iEntID})
                if IsValid(hUnit) then
                    local hAblt = EntIndexToHScript(${this.__iAbltID})
                    if hAblt and hAblt.DDeclareFunctions then
                        for typeFun, v in pairs(hAblt:DDeclareFunctions()) do
                            if type(typeFun) == "table" then
                                local hAttribute = typeFun
                                tAttributes[hAttribute.name] = hAttribute:GetByKey(hUnit, hAblt)
                            end
                        end
                    end
                end
                return tAttributes
            `)) !== null && _a !== void 0 ? _a : {};
        }
        GetAbilityName() {
            return Abilities.GetAbilityName(this.__iAbltID);
        }
        GetAbilityTextureName() {
            return Abilities.GetAbilityTextureName(this.__iAbltID);
        }
        GetAssociatedPrimaryAbilities() {
            return Abilities.GetAssociatedPrimaryAbilities(this.__iAbltID);
        }
        GetAssociatedSecondaryAbilities() {
            return Abilities.GetAssociatedSecondaryAbilities(this.__iAbltID);
        }
        GetHotkeyOverride() {
            return Abilities.GetHotkeyOverride(this.__iAbltID);
        }
        GetIntrinsicModifierName() {
            return Abilities.GetIntrinsicModifierName(this.__iAbltID);
        }
        GetSharedCooldownName() {
            return Abilities.GetSharedCooldownName(this.__iAbltID);
        }
        AbilityReady() {
            return Abilities.AbilityReady(this.__iAbltID);
        }
        CanAbilityBeUpgraded() {
            return Abilities.CanAbilityBeUpgraded(this.__iAbltID);
        }
        CanBeExecuted() {
            return Abilities.CanBeExecuted(this.__iAbltID);
        }
        GetAbilityDamage() {
            return Abilities.GetAbilityDamage(this.__iAbltID);
        }
        GetAbilityDamageType() {
            return Abilities.GetAbilityDamageType(this.__iAbltID);
        }
        GetAbilityTargetFlags() {
            return Abilities.GetAbilityTargetFlags(this.__iAbltID);
        }
        GetAbilityTargetTeam() {
            return Abilities.GetAbilityTargetTeam(this.__iAbltID);
        }
        GetAbilityTargetType() {
            return Abilities.GetAbilityTargetType(this.__iAbltID);
        }
        GetAbilityType() {
            return Abilities.GetAbilityType(this.__iAbltID);
        }
        GetBehavior() {
            return Abilities.GetBehavior(this.__iAbltID);
        }
        GetCastRange() {
            return Abilities.GetCastRange(this.__iAbltID);
        }
        GetChannelledManaCostPerSecond() {
            return Abilities.GetChannelledManaCostPerSecond(this.__iAbltID);
        }
        GetCurrentCharges() {
            return Abilities.GetCurrentCharges(this.__iAbltID);
        }
        GetEffectiveLevel() {
            return Abilities.GetEffectiveLevel(this.__iAbltID);
        }
        GetHeroLevelRequiredToUpgrade() {
            return Abilities.GetHeroLevelRequiredToUpgrade(this.__iAbltID);
        }
        GetLevel() {
            return Abilities.GetLevel(this.__iAbltID);
        }
        GetManaCost() {
            return Abilities.GetManaCost(this.__iAbltID);
        }
        GetMaxLevel() {
            return Abilities.GetMaxLevel(this.__iAbltID);
        }
        AttemptToUpgrade() {
            return Abilities.AttemptToUpgrade(this.__iAbltID);
        }
        CanLearn() {
            return Abilities.CanLearn(this.__iAbltID);
        }
        GetAutoCastState() {
            return Abilities.GetAutoCastState(this.__iAbltID);
        }
        GetToggleState() {
            return Abilities.GetToggleState(this.__iAbltID);
        }
        HasScepterUpgradeTooltip() {
            return Abilities.HasScepterUpgradeTooltip(this.__iAbltID);
        }
        IsActivated() {
            return Abilities.IsActivated(this.__iAbltID);
        }
        IsActivatedChanging() {
            return Abilities.IsActivatedChanging(this.__iAbltID);
        }
        IsAttributeBonus() {
            return Abilities.IsAttributeBonus(this.__iAbltID);
        }
        IsAutocast() {
            return Abilities.IsAutocast(this.__iAbltID);
        }
        IsCooldownReady() {
            return Abilities.IsCooldownReady(this.__iAbltID);
        }
        IsDisplayedAbility() {
            return Abilities.IsDisplayedAbility(this.__iAbltID);
        }
        IsHidden() {
            return Abilities.IsHidden(this.__iAbltID);
        }
        IsHiddenWhenStolen() {
            return Abilities.IsHiddenWhenStolen(this.__iAbltID);
        }
        IsInAbilityPhase() {
            return Abilities.IsInAbilityPhase(this.__iAbltID);
        }
        IsItem() {
            return Abilities.IsItem(this.__iAbltID);
        }
        IsMarkedAsDirty() {
            return Abilities.IsMarkedAsDirty(this.__iAbltID);
        }
        IsMuted() {
            return Abilities.IsMuted(this.__iAbltID);
        }
        IsOnCastbar() {
            return Abilities.IsOnCastbar(this.__iAbltID);
        }
        IsOnLearnbar() {
            return Abilities.IsOnLearnbar(this.__iAbltID);
        }
        IsOwnersGoldEnough() {
            return Abilities.IsOwnersGoldEnough(this.__iAbltID);
        }
        IsOwnersGoldEnoughForUpgrade() {
            return Abilities.IsOwnersGoldEnoughForUpgrade(this.__iAbltID);
        }
        IsOwnersManaEnough() {
            return Abilities.IsOwnersManaEnough(this.__iAbltID);
        }
        IsPassive() {
            return Abilities.IsPassive(this.__iAbltID);
        }
        IsRecipe() {
            return Abilities.IsRecipe(this.__iAbltID);
        }
        IsSharedWithTeammates() {
            return Abilities.IsSharedWithTeammates(this.__iAbltID);
        }
        IsStealable() {
            return Abilities.IsStealable(this.__iAbltID);
        }
        IsStolen() {
            return Abilities.IsStolen(this.__iAbltID);
        }
        IsToggle() {
            return Abilities.IsToggle(this.__iAbltID);
        }
        GetAOERadius() {
            return Abilities.GetAOERadius(this.__iAbltID);
        }
        GetBackswingTime() {
            return Abilities.GetBackswingTime(this.__iAbltID);
        }
        GetCastPoint() {
            return Abilities.GetCastPoint(this.__iAbltID);
        }
        GetChannelStartTime() {
            return Abilities.GetChannelStartTime(this.__iAbltID);
        }
        GetChannelTime() {
            return Abilities.GetChannelTime(this.__iAbltID);
        }
        GetCooldown() {
            return Abilities.GetCooldown(this.__iAbltID);
        }
        GetCooldownLength() {
            return Abilities.GetCooldownLength(this.__iAbltID);
        }
        GetCooldownTime() {
            return Abilities.GetCooldownTime(this.__iAbltID);
        }
        GetCooldownTimeRemaining() {
            return Abilities.GetCooldownTimeRemaining(this.__iAbltID);
        }
        GetDuration() {
            return Abilities.GetDuration(this.__iAbltID);
        }
        GetUpgradeBlend() {
            return Abilities.GetUpgradeBlend(this.__iAbltID);
        }
        GetLocalPlayerActiveAbility() {
            return Abilities.GetLocalPlayerActiveAbility();
        }
        GetCaster() {
            return this.__iEntID;
        }
        GetCustomValueFor(pszAbilityVarName) {
            return Abilities.GetCustomValueFor(this.__iAbltID, pszAbilityVarName);
        }
        GetLevelSpecialValueFor(szName, nLevel) {
            return Abilities.GetLevelSpecialValueFor(this.__iAbltID, szName, nLevel);
        }
        GetSpecialValueFor(szName) {
            return Abilities.GetSpecialValueFor(this.__iAbltID, szName);
        }
        IsCosmetic(nTargetEntityIndex) {
            return Abilities.IsCosmetic(this.__iAbltID, nTargetEntityIndex);
        }
        ExecuteAbility(nCasterEntIndex, bIsQuickCast) {
            return Abilities.ExecuteAbility(this.__iAbltID, nCasterEntIndex, bIsQuickCast);
        }
        CreateDoubleTapCastOrder(nCasterEntIndex) {
            return Abilities.CreateDoubleTapCastOrder(this.__iAbltID, nCasterEntIndex);
        }
        PingAbility() {
            return Abilities.PingAbility(this.__iAbltID);
        }
        GetKeybind() {
            return Abilities.GetKeybind(this.__iAbltID);
        }
        GetAbilitySlot(iAbltID) {
            return Abilities.GetAbilitySlot(iAbltID);
        }
        GetCooldownModified(iAbltID) {
            return Abilities.GetCooldownModified(iAbltID);
        }
        GetManaCostModified(iAbltID) {
            return Abilities.GetManaCostModified(iAbltID);
        }
    }
    Diy.DiyAbility = DiyAbility;
    class DiyModifier {
        constructor(iEntID, params) {
            this.__iParentEntID = iEntID;
            if (params.buff_id != undefined) {
                this.__iBuffID = params.buff_id;
            }
            else if (params.creation_time != undefined && params.name != undefined) {
                const creation_time = params.creation_time.toFixed(2);
                for (let i = Entities.GetNumBuffs(iEntID) - 1; i >= 0; --i) {
                    const iBuffID = Entities.GetBuff(iEntID, i);
                    if (Buffs.GetName(iEntID, iBuffID) == params.name && Buffs.GetCreationTime(iEntID, iBuffID).toFixed(2) == creation_time) {
                        this.__iBuffID = iBuffID;
                        break;
                    }
                }
            }
        }
        GetBuffID() { return this.__iBuffID; }
        GetName() { return Buffs.GetName(this.__iParentEntID, this.__iBuffID); }
        GetAbility() { return Buffs.GetAbility(this.__iParentEntID, this.__iBuffID); }
        GetParent() { return Buffs.GetParent(this.__iParentEntID, this.__iBuffID); }
        GetCaster() { return Buffs.GetCaster(this.__iParentEntID, this.__iBuffID); }
        GetTexture() { return Buffs.GetTexture(this.__iParentEntID, this.__iBuffID); }
        GetAttributes() { return this.__call('GetAttributes'); }
        GetPriority() { return this.__call('GetPriority'); }
        GetAuraDuration() { return this.__call('GetAuraDuration'); }
        GetAuraEntityReject() { return this.__call('GetAuraEntityReject'); }
        GetAuraRadius() { return this.__call('GetAuraRadius'); }
        GetAuraSearchFlags() { return this.__call('GetAuraSearchFlags'); }
        GetAuraSearchTeam() { return this.__call('GetAuraSearchTeam'); }
        GetAuraSearchType() { return this.__call('GetAuraSearchType'); }
        GetModifierAura() { return this.__call('GetModifierAura'); }
        IsAura() { return this.__call('IsAura'); }
        IsAuraActiveOnDeath() { return this.__call('IsAuraActiveOnDeath'); }
        GetEffectAttachType() { return this.__call('GetEffectAttachType'); }
        GetEffectName() { return this.__call('GetEffectName'); }
        GetHeroEffectName() { return this.__call('GetHeroEffectName'); }
        GetStatusEffectName() { return this.__call('GetStatusEffectName'); }
        HeroEffectPriority() { return this.__call('HeroEffectPriority'); }
        StatusEffectPriority() { return this.__call('StatusEffectPriority'); }
        GetCreationTime() { return Buffs.GetCreationTime(this.__iParentEntID, this.__iBuffID); }
        GetDieTime() { return Buffs.GetDieTime(this.__iParentEntID, this.__iBuffID); }
        GetDuration() { return Buffs.GetDuration(this.__iParentEntID, this.__iBuffID); }
        GetElapsedTime() { return Buffs.GetElapsedTime(this.__iParentEntID, this.__iBuffID); }
        GetLastAppliedTime() { return this.__call('GetLastAppliedTime'); }
        GetRemainingTime() { return Buffs.GetRemainingTime(this.__iParentEntID, this.__iBuffID); }
        GetClass() { return Buffs.GetClass(this.__iParentEntID, this.__iBuffID); }
        GetSerialNumber() { return this.__call('GetSerialNumber'); }
        GetStackCount() { return Buffs.GetStackCount(this.__iParentEntID, this.__iBuffID); }
        CheckState() { return this.__call('CheckState'); }
        HasFunction(iFunction) { return this.__call('HasFunction', iFunction); }
        IsHidden() { return Buffs.IsHidden(this.__iParentEntID, this.__iBuffID); }
        IsDebuff() { return Buffs.IsDebuff(this.__iParentEntID, this.__iBuffID); }
        IsStunDebuff() { return this.__call('IsStunDebuff'); }
        IsPurgable() { return this.__call('IsPurgable'); }
        IsPurgeException() { return this.__call('IsPurgeException'); }
        IsPermanent() { return this.__call('IsPermanent'); }
        AllowIllusionDuplicate() { return this.__call('AllowIllusionDuplicate'); }
        RemoveOnDeath() { return this.__call('RemoveOnDeath'); }
        OnTooltip() { return this.__call('OnTooltip'); }
        OnTooltip2() { return this.__call('OnTooltip2'); }
        GetCustomAttributes() {
            var _a;
            return (_a = GameUI.CustomUIConfig().tools.runlua(`
            local tAttributes = {}
            local hUnit = EntIndexToHScript(${this.__iParentEntID})
            if IsValid(hUnit) then
                local hBuff = hUnit:FindModifierByJsBuff('${this.GetName()}', ${this.GetCreationTime()})
                if hBuff and hBuff.DDeclareFunctions then
                    for typeFun, v in pairs(hBuff:DDeclareFunctions()) do
                        if type(typeFun) == "table" then
                            local hAttribute = typeFun
                            tAttributes[hAttribute.name] = hAttribute:GetByKey(hUnit, hBuff)
                        end
                    end
                end
            end
            return tAttributes
            `)) !== null && _a !== void 0 ? _a : {};
        }
        __call(sFunc, ...args) {
            let sParams = args.map(v => {
                if (typeof v == 'boolean') {
                    return v;
                }
                else if (typeof v == 'string') {
                    return "'" + v + "'";
                }
                else if (typeof v == 'number') {
                    if (Number.isNaN(v)) {
                        return '0/0';
                    }
                    return v;
                }
                return 'nil';
            }).join(',');
            return GameUI.CustomUIConfig().tools.runlua(`
            local hUnit = EntIndexToHScript(${this.__iParentEntID})
            if IsValid(hUnit) then
                local hBuff = hUnit:FindModifierByJsBuff('${this.GetName()}', ${this.GetCreationTime()})
                if hBuff then
                    return hBuff:${sFunc}(${sParams})
                end
            end
            `);
        }
    }
    Diy.DiyModifier = DiyModifier;
})(Diy || (Diy = {}));

var _a, _b, _c;
class Attribute {
    constructor(hParent, hMath) {
        this.hParent = hParent;
        this.hMath = hMath;
    }
    Get(iEntID, key, ...args) {
        return GameUI.CustomUIConfig().tools.AttributeGet(iEntID, this.name, key, ...args);
    }
    Data(iEntID) {
        const tData = [];
        for (const { k, v } of GameUI.CustomUIConfig().tools.AttributeData(iEntID, this.name)) {
            if (k.type == 'key') {
                const get_key = k.name;
                tData.push({
                    k: k.name,
                    v: v.is_dynamic ? () => this.Get(iEntID, get_key) : v.val
                });
            }
            else {
                let get_key;
                let key = k.name;
                if (k.type == 'ability') {
                    get_key = GameUI.CustomUIConfig().tools.EntIndexToHScript(k.ability_entid);
                    key = new Diy.DiyAbility(iEntID, k.ability_entid);
                }
                else if (k.type == 'buff') {
                    const h = key = new Diy.DiyModifier(iEntID, { 'name': k.name, 'creation_time': k.buff_creation_time });
                    get_key = GameUI.CustomUIConfig().tools.BuffToModifier(iEntID, h.GetBuffID());
                }
                else if (k.type == 'polymer') {
                    get_key = GameUI.CustomUIConfig().tools.PolymerIDToDiyPolymer(iEntID, k.polymer_id);
                }
                else {
                    const object_address = k.object_address;
                    tData.push({
                        k: key,
                        v: v.is_dynamic
                            ? () => GameUI.CustomUIConfig().tools.runlua(`
                            local hUnit = EntIndexToHScript(${iEntID})
                            if IsValid(hUnit) then
                                local hAttribute = AttributeSysteam.ID2Attribute[${this.name}]
                                local _ = hAttribute:Data(hUnit)
                                if _ then
                                    for ____, t in ipairs(_) do
                                        for k, v in pairs(t) do
                                            if type(k) == "table" and tostring(k) == "${object_address}" then
                                                return hAttribute:GetByKey(hUnit, k)
                                            end
                                        end
                                    end
                                end
                            end`)
                            : v.val
                    });
                    continue;
                }
                tData.push({
                    k: key,
                    v: v.is_dynamic ? () => this.Get(iEntID, get_key) : v.val
                });
            }
        }
        return tData;
    }
}
var MathAlgorithm;
(function (MathAlgorithm) {
    class Base {
        static count(x, y) { }
        static reverse_count(x, y) { }
    }
    MathAlgorithm.Base = Base;
    class Add extends Base {
        static count(x, y) { return x + y; }
        static reverse_count(x, y) { return x - y; }
    }
    Add.base = 0;
    MathAlgorithm.Add = Add;
    class PctAdd extends Base {
        static count(x, y) { return x + y; }
        static reverse_count(x, y) { return x - y; }
    }
    PctAdd.base = 100;
    MathAlgorithm.PctAdd = PctAdd;
    class Add_Min0 extends Base {
        static count(x, y) {
            if (y != y)
                return x;
            return x + y;
        }
        static reverse_count(x, y) {
            if (y != y)
                return x;
            return x - y;
        }
    }
    Add_Min0.base = 0;
    Add_Min0.post_process = function (v) { return Math.max(v, 0); };
    MathAlgorithm.Add_Min0 = Add_Min0;
    class PctAdd_Min0 extends Base {
        static count(x, y) { return x + y; }
        static reverse_count(x, y) { return x - y; }
    }
    PctAdd_Min0.base = 100;
    PctAdd_Min0.post_process = function (v) { return Math.max(v, 0); };
    MathAlgorithm.PctAdd_Min0 = PctAdd_Min0;
    class PctMul extends Base {
        static count(x, y) {
            if (y <= -100)
                return 0;
            return x * (100 + y) * 0.01;
        }
        static reverse_count(x, y) {
            if (y <= -100)
                return NaN;
            return x / (100 + y) * 100;
        }
    }
    PctMul.base = 100;
    MathAlgorithm.PctMul = PctMul;
    class PctInvMul extends Base {
        static count(x, y) {
            if (y >= 100)
                return 100;
            return 100 - (100 - x) * (100 - y) * 0.01;
        }
        static reverse_count(x, y) {
            if (y >= 100)
                return NaN;
            return 100 - (100 - x) / (100 - y) * 100;
        }
    }
    PctInvMul.base = 0;
    MathAlgorithm.PctInvMul = PctInvMul;
})(MathAlgorithm || (MathAlgorithm = {}));
class LevelAttribute extends Attribute {
    constructor(hParent) {
        super(hParent, undefined);
    }
    Get(iEntID, key, ...args) {
        return GameUI.CustomUIConfig().tools.AttributeGet(iEntID, this.name, key, ...args);
    }
    Data(iEntID) {
        return super.Data(iEntID);
    }
}
var DotaAttribute;
(function (DotaAttribute) {
    DotaAttribute.Main = new class Main extends Attribute {
        constructor() {
            super(...arguments);
            this.BASE = new Attribute(this, MathAlgorithm.Add);
            this.BONUS = new Attribute(this, MathAlgorithm.Add);
            this.PCT = new Attribute(this, MathAlgorithm.Add);
            this.AMP = new Attribute(this, MathAlgorithm.Add);
            this.AMP_1 = new Attribute(this, MathAlgorithm.Add);
            this.AMP_2 = new Attribute(this, MathAlgorithm.Add);
            this.AMP_3 = new Attribute(this, MathAlgorithm.Add);
            this.AMP_4 = new Attribute(this, MathAlgorithm.Add);
            this.UNIQUE = new Attribute(this, MathAlgorithm.Add);
        }
    }();
    DotaAttribute.Secondary = new class Secondary extends Attribute {
        constructor() {
            super(...arguments);
            this.BASE = new Attribute(this, MathAlgorithm.Add);
            this.BONUS = new Attribute(this, MathAlgorithm.Add);
            this.PCT = new Attribute(this, MathAlgorithm.Add);
            this.AMP = new Attribute(this, MathAlgorithm.Add);
            this.AMP_1 = new Attribute(this, MathAlgorithm.Add);
            this.AMP_2 = new Attribute(this, MathAlgorithm.Add);
            this.AMP_3 = new Attribute(this, MathAlgorithm.Add);
            this.AMP_4 = new Attribute(this, MathAlgorithm.Add);
            this.UNIQUE = new Attribute(this, MathAlgorithm.Add);
        }
    }();
    DotaAttribute.AllStats = new class AllStats extends Attribute {
        constructor() {
            super(...arguments);
            this.BASE = new Attribute(this, MathAlgorithm.Add);
            this.BONUS = new Attribute(this, MathAlgorithm.Add);
            this.PCT = new Attribute(this, MathAlgorithm.Add);
            this.AMP = new Attribute(this, MathAlgorithm.Add);
            this.AMP_1 = new Attribute(this, MathAlgorithm.Add);
            this.AMP_2 = new Attribute(this, MathAlgorithm.Add);
            this.AMP_3 = new Attribute(this, MathAlgorithm.Add);
            this.AMP_4 = new Attribute(this, MathAlgorithm.Add);
            this.UNIQUE = new Attribute(this, MathAlgorithm.Add);
        }
    }();
    DotaAttribute.Strength = new class Strength extends Attribute {
        constructor() {
            super(...arguments);
            this.BASE = new Attribute(this, MathAlgorithm.Add);
            this.BONUS = new Attribute(this, MathAlgorithm.Add);
            this.PCT = new Attribute(this, MathAlgorithm.Add);
            this.AMP = new Attribute(this, MathAlgorithm.Add);
            this.AMP_1 = new Attribute(this, MathAlgorithm.Add);
            this.AMP_2 = new Attribute(this, MathAlgorithm.Add);
            this.AMP_3 = new Attribute(this, MathAlgorithm.Add);
            this.AMP_4 = new Attribute(this, MathAlgorithm.Add);
            this.UNIQUE = new Attribute(this, MathAlgorithm.Add);
        }
    }();
    DotaAttribute.Agility = new class Agility extends Attribute {
        constructor() {
            super(...arguments);
            this.BASE = new Attribute(this, MathAlgorithm.Add);
            this.BONUS = new Attribute(this, MathAlgorithm.Add);
            this.PCT = new Attribute(this, MathAlgorithm.Add);
            this.AMP = new Attribute(this, MathAlgorithm.Add);
            this.AMP_1 = new Attribute(this, MathAlgorithm.Add);
            this.AMP_2 = new Attribute(this, MathAlgorithm.Add);
            this.AMP_3 = new Attribute(this, MathAlgorithm.Add);
            this.AMP_4 = new Attribute(this, MathAlgorithm.Add);
            this.UNIQUE = new Attribute(this, MathAlgorithm.Add);
        }
    }();
    DotaAttribute.Intellect = new class Intellect extends Attribute {
        constructor() {
            super(...arguments);
            this.BASE = new Attribute(this, MathAlgorithm.Add);
            this.BONUS = new Attribute(this, MathAlgorithm.Add);
            this.PCT = new Attribute(this, MathAlgorithm.Add);
            this.AMP = new Attribute(this, MathAlgorithm.Add);
            this.AMP_1 = new Attribute(this, MathAlgorithm.Add);
            this.AMP_2 = new Attribute(this, MathAlgorithm.Add);
            this.AMP_3 = new Attribute(this, MathAlgorithm.Add);
            this.AMP_4 = new Attribute(this, MathAlgorithm.Add);
            this.UNIQUE = new Attribute(this, MathAlgorithm.Add);
        }
    }();
    DotaAttribute.Attributes2Class = {
        [Attributes.DOTA_ATTRIBUTE_STRENGTH]: DotaAttribute.Strength,
        [Attributes.DOTA_ATTRIBUTE_AGILITY]: DotaAttribute.Agility,
        [Attributes.DOTA_ATTRIBUTE_INTELLECT]: DotaAttribute.Intellect,
    };
    DotaAttribute.Atk = new class Atk extends Attribute {
        constructor() {
            super(...arguments);
            this.BASE = new Attribute(this, MathAlgorithm.Add);
            this.BONUS = new Attribute(this, MathAlgorithm.Add);
            this.PCT = new Attribute(this, MathAlgorithm.Add);
            this.AMP = new Attribute(this, MathAlgorithm.Add);
            this.AMP_1 = new Attribute(this, MathAlgorithm.Add);
            this.AMP_2 = new Attribute(this, MathAlgorithm.Add);
            this.AMP_3 = new Attribute(this, MathAlgorithm.Add);
            this.AMP_4 = new Attribute(this, MathAlgorithm.Add);
            this.UNIQUE = new Attribute(this, MathAlgorithm.Add);
        }
    }();
    DotaAttribute.PhyFixDmg = new class PhyFixDmg extends Attribute {
        constructor() {
            super(...arguments);
            this.BASE = new Attribute(this, MathAlgorithm.Add);
            this.BONUS = new Attribute(this, MathAlgorithm.Add);
            this.PCT = new Attribute(this, MathAlgorithm.Add);
            this.AMP = new Attribute(this, MathAlgorithm.Add);
            this.AMP_1 = new Attribute(this, MathAlgorithm.Add);
            this.AMP_2 = new Attribute(this, MathAlgorithm.Add);
            this.AMP_3 = new Attribute(this, MathAlgorithm.Add);
            this.AMP_4 = new Attribute(this, MathAlgorithm.Add);
            this.UNIQUE = new Attribute(this, MathAlgorithm.Add);
        }
    }();
    DotaAttribute.MgcFixDmg = new class MgcFixDmg extends Attribute {
        constructor() {
            super(...arguments);
            this.BASE = new Attribute(this, MathAlgorithm.Add);
            this.BONUS = new Attribute(this, MathAlgorithm.Add);
            this.PCT = new Attribute(this, MathAlgorithm.Add);
            this.AMP = new Attribute(this, MathAlgorithm.Add);
            this.AMP_1 = new Attribute(this, MathAlgorithm.Add);
            this.AMP_2 = new Attribute(this, MathAlgorithm.Add);
            this.AMP_3 = new Attribute(this, MathAlgorithm.Add);
            this.AMP_4 = new Attribute(this, MathAlgorithm.Add);
            this.UNIQUE = new Attribute(this, MathAlgorithm.Add);
        }
    }();
    DotaAttribute.AtkPure = new class AtkPure extends Attribute {
        constructor() {
            super(...arguments);
            this.BASE = new Attribute(this, MathAlgorithm.Add);
            this.BONUS = new Attribute(this, MathAlgorithm.Add);
            this.PCT = new Attribute(this, MathAlgorithm.Add);
            this.AMP = new Attribute(this, MathAlgorithm.Add);
            this.AMP_1 = new Attribute(this, MathAlgorithm.Add);
            this.AMP_2 = new Attribute(this, MathAlgorithm.Add);
            this.AMP_3 = new Attribute(this, MathAlgorithm.Add);
            this.AMP_4 = new Attribute(this, MathAlgorithm.Add);
            this.UNIQUE = new Attribute(this, MathAlgorithm.Add);
        }
    }();
    DotaAttribute.HpLimit = new class HpLimit extends Attribute {
        constructor() {
            super(...arguments);
            this.BASE = new Attribute(this, MathAlgorithm.Add);
            this.BONUS = new Attribute(this, MathAlgorithm.Add);
            this.PCT = new Attribute(this, MathAlgorithm.Add);
            this.AMP = new Attribute(this, MathAlgorithm.Add);
            this.AMP_1 = new Attribute(this, MathAlgorithm.Add);
            this.AMP_2 = new Attribute(this, MathAlgorithm.Add);
            this.AMP_3 = new Attribute(this, MathAlgorithm.Add);
            this.AMP_4 = new Attribute(this, MathAlgorithm.Add);
            this.UNIQUE = new Attribute(this, MathAlgorithm.Add);
        }
    }();
    DotaAttribute.HpRegen = new class HpRegen extends Attribute {
        constructor() {
            super(...arguments);
            this.BASE = new Attribute(this, MathAlgorithm.Add);
            this.BONUS = new Attribute(this, MathAlgorithm.Add);
            this.PCT = new Attribute(this, MathAlgorithm.Add);
            this.AMP = new Attribute(this, MathAlgorithm.Add);
            this.UNIQUE = new Attribute(this, MathAlgorithm.Add);
            this.HP_PCT = new Attribute(this, MathAlgorithm.Add);
            this.OVERRIDE = new LevelAttribute(this);
        }
    }();
    DotaAttribute.MpLimit = new class MpLimit extends Attribute {
        constructor() {
            super(...arguments);
            this.BASE = new Attribute(this, MathAlgorithm.Add);
            this.BONUS = new Attribute(this, MathAlgorithm.Add);
            this.PCT = new Attribute(this, MathAlgorithm.Add);
            this.AMP = new Attribute(this, MathAlgorithm.Add);
            this.UNIQUE = new Attribute(this, MathAlgorithm.Add);
            this.OVERRIDE = new LevelAttribute(this);
        }
    }();
    DotaAttribute.MpRegen = new class MpRegen extends Attribute {
        constructor() {
            super(...arguments);
            this.BASE = new Attribute(this, MathAlgorithm.Add);
            this.BONUS = new Attribute(this, MathAlgorithm.Add);
            this.PCT = new Attribute(this, MathAlgorithm.Add);
            this.AMP = new Attribute(this, MathAlgorithm.Add);
            this.UNIQUE = new Attribute(this, MathAlgorithm.Add);
            this.MP_PCT = new Attribute(this, MathAlgorithm.Add);
            this.OVERRIDE = new LevelAttribute(this);
        }
    }();
    DotaAttribute.Armor = new class Armor extends Attribute {
        constructor() {
            super(...arguments);
            this.BASE = new Attribute(this, MathAlgorithm.Add);
            this.BONUS = new Attribute(this, MathAlgorithm.Add);
            this.PCT = new Attribute(this, MathAlgorithm.Add);
            this.AMP = new Attribute(this, MathAlgorithm.Add);
            this.AMP_1 = new Attribute(this, MathAlgorithm.Add);
            this.AMP_2 = new Attribute(this, MathAlgorithm.Add);
            this.AMP_3 = new Attribute(this, MathAlgorithm.Add);
            this.AMP_4 = new Attribute(this, MathAlgorithm.Add);
            this.UNIQUE = new Attribute(this, MathAlgorithm.Add);
            this.OVERRIDE = new LevelAttribute(this);
        }
    }();
    DotaAttribute.AtkSpd = new class AtkSpd extends Attribute {
        constructor() {
            super(...arguments);
            this.BASE = new Attribute(this, MathAlgorithm.Add);
            this.BONUS = new Attribute(this, MathAlgorithm.Add);
            this.PCT = new Attribute(this, MathAlgorithm.Add);
            this.TOTAL = new Attribute(this, MathAlgorithm.Add);
            this.LIMIT_MAX = new LevelAttribute(this);
            this.OVERRIDE = new LevelAttribute(this);
        }
    }();
    DotaAttribute.AtkTime = new class AtkTime extends Attribute {
        constructor() {
            super(...arguments);
            this.BASE = new Attribute(this, MathAlgorithm.Add);
            this.LIMIT_MIN = new LevelAttribute(this);
            this.OVERRIDE = new LevelAttribute(this);
        }
    }();
    DotaAttribute.MoveSpd = new class MoveSpd extends Attribute {
        constructor() {
            super(...arguments);
            this.BASE = new Attribute(this, MathAlgorithm.Add);
            this.BONUS = new Attribute(this, MathAlgorithm.Add);
            this.PCT = new Attribute(this, MathAlgorithm.Add);
            this.LIMIT_MAX = new LevelAttribute(this);
            this.LIMIT_MIN = new LevelAttribute(this);
            this.OVERRIDE = new LevelAttribute(this);
        }
    }();
    DotaAttribute.AtkRange = new class AtkRange extends Attribute {
        constructor() {
            super(...arguments);
            this.BASE = new Attribute(this, MathAlgorithm.Add);
            this.BONUS = new Attribute(this, MathAlgorithm.Add);
            this.PCT = new Attribute(this, MathAlgorithm.Add);
            this.OVERRIDE = new LevelAttribute(this);
        }
    }();
    DotaAttribute.PrjctSpd = new class PrjctSpd extends Attribute {
        constructor() {
            super(...arguments);
            this.BASE = new Attribute(this, MathAlgorithm.Add);
            this.BONUS = new Attribute(this, MathAlgorithm.Add);
            this.PCT = new Attribute(this, MathAlgorithm.Add);
        }
    }();
    DotaAttribute.CastRange = new class CastRange extends Attribute {
        constructor() {
            super(...arguments);
            this.BASE = new Attribute(this, MathAlgorithm.Add);
            this.BONUS = new Attribute(this, MathAlgorithm.Add);
            this.PCT = new Attribute(this, MathAlgorithm.Add);
        }
    }();
    DotaAttribute.Cooldown = new class Cooldown extends Attribute {
        constructor() {
            super(...arguments);
            this.BASE = new Attribute(this, MathAlgorithm.Add);
            this.BONUS = new Attribute(this, MathAlgorithm.Add);
            this.PCT = new Attribute(this, MathAlgorithm.Add);
            this.LIMIT_MAX = new LevelAttribute(this);
        }
    }();
    DotaAttribute.StaResist = new Attribute(undefined, MathAlgorithm.PctInvMul);
    DotaAttribute.DebuffAmp = new Attribute(undefined, MathAlgorithm.PctInvMul);
    DotaAttribute.Hit = new Attribute(undefined, MathAlgorithm.Add);
    DotaAttribute.Evasion = new Attribute(undefined, MathAlgorithm.Add);
    DotaAttribute.Heal = new Attribute(undefined, MathAlgorithm.Add);
    DotaAttribute.Vision = new class Vision extends Attribute {
        constructor() {
            super(...arguments);
            this.DAY = new class DAY extends Attribute {
                constructor() {
                    super(...arguments);
                    this.BASE = new Attribute(this, MathAlgorithm.Add);
                    this.PCT = new Attribute(this, MathAlgorithm.Add);
                    this.OVERRIDE = new LevelAttribute(this);
                }
            }(this);
            this.NIGHT = new class NIGHT extends Attribute {
                constructor() {
                    super(...arguments);
                    this.BASE = new Attribute(this, MathAlgorithm.Add);
                    this.PCT = new Attribute(this, MathAlgorithm.Add);
                    this.OVERRIDE = new LevelAttribute(this);
                }
            }(this);
        }
    }();
    DotaAttribute.ModelScale = new class ModelScale extends Attribute {
        constructor() {
            super(...arguments);
            this.BASE = new Attribute(this, MathAlgorithm.Add);
            this.PCT = new Attribute(this, MathAlgorithm.PctAdd_Min0);
        }
    }();
    DotaAttribute.Model = new LevelAttribute();
    DotaAttribute.Prjct = new LevelAttribute();
    DotaAttribute.AtkAnimPoint = new Attribute();
    DotaAttribute.HpMin = new LevelAttribute();
})(DotaAttribute || (DotaAttribute = {}));
const AttributeCfg = {
    Main: DotaAttribute.Main,
    Secondary: DotaAttribute.Secondary,
    AllStats: DotaAttribute.AllStats,
    Strength: DotaAttribute.Strength,
    Agility: DotaAttribute.Agility,
    Intellect: DotaAttribute.Intellect,
    Atk: DotaAttribute.Atk,
    PhyFixDmg: DotaAttribute.PhyFixDmg,
    MgcFixDmg: DotaAttribute.MgcFixDmg,
    AtkPure: DotaAttribute.AtkPure,
    HpLimit: DotaAttribute.HpLimit,
    HpRegen: DotaAttribute.HpRegen,
    MpLimit: DotaAttribute.MpLimit,
    MpRegen: DotaAttribute.MpRegen,
    Armor: DotaAttribute.Armor,
    AtkSpd: DotaAttribute.AtkSpd,
    AtkTime: DotaAttribute.AtkTime,
    MoveSpd: DotaAttribute.MoveSpd,
    AtkRange: DotaAttribute.AtkRange,
    PrjctSpd: DotaAttribute.PrjctSpd,
    CastRange: DotaAttribute.CastRange,
    Cooldown: DotaAttribute.Cooldown,
    StaResist: DotaAttribute.StaResist,
    DebuffAmp: DotaAttribute.DebuffAmp,
    Hit: DotaAttribute.Hit,
    Evasion: DotaAttribute.Evasion,
    Heal: DotaAttribute.Heal,
    Vision: DotaAttribute.Vision,
    ModelScale: DotaAttribute.ModelScale,
    Model: DotaAttribute.Model,
    Prjct: DotaAttribute.Prjct,
    AtkAnimPoint: DotaAttribute.AtkAnimPoint,
    HpMin: DotaAttribute.HpMin,
    ArmorPenetrate: new class ArmorPenetrate extends Attribute {
        constructor() {
            super(...arguments);
            this.BASE = new Attribute(this, MathAlgorithm.Add);
            this.BONUS = new Attribute(this, MathAlgorithm.Add);
            this.PCT = new Attribute(this, MathAlgorithm.Add);
            this.AMP = new Attribute(this, MathAlgorithm.Add);
            this.UNIQUE = new Attribute(this, MathAlgorithm.Add);
        }
    }(undefined, MathAlgorithm.Add),
    ArmorIgnore: new class ArmorIgnore extends Attribute {
        constructor() {
            super(...arguments);
            this.BASE = new Attribute(this, MathAlgorithm.Add);
            this.LIMIT_MAX = new LevelAttribute(this);
        }
    }(undefined, MathAlgorithm.Add),
    PhyCritChance: new class PhyCritChance extends Attribute {
        constructor() {
            super(...arguments);
            this.BASE = new Attribute(this, MathAlgorithm.Add);
            this.UNIQUE = new Attribute(this, MathAlgorithm.Add);
            this.LIMIT_MAX = new LevelAttribute(this);
        }
    }(undefined, MathAlgorithm.Add),
    MgcCritChance: new class MgcCritChance extends Attribute {
        constructor() {
            super(...arguments);
            this.BASE = new Attribute(this, MathAlgorithm.Add);
            this.UNIQUE = new Attribute(this, MathAlgorithm.Add);
            this.LIMIT_MAX = new LevelAttribute(this);
        }
    }(undefined, MathAlgorithm.Add),
    PureCritChance: new class PureCritChance extends Attribute {
        constructor() {
            super(...arguments);
            this.BASE = new Attribute(this, MathAlgorithm.Add);
            this.UNIQUE = new Attribute(this, MathAlgorithm.Add);
            this.LIMIT_MAX = new LevelAttribute(this);
        }
    }(undefined, MathAlgorithm.Add),
    PhyCritDmg: new class PhyCritDmg extends Attribute {
        constructor() {
            super(...arguments);
            this.BASE = new Attribute(this, MathAlgorithm.Add);
            this.AMP = new Attribute(this, MathAlgorithm.Add);
            this.AMP_1 = new Attribute(this, MathAlgorithm.Add);
            this.UNIQUE = new Attribute(this, MathAlgorithm.Add);
        }
    }(undefined, MathAlgorithm.Add),
    MgcCritDmg: new class MgcCritDmg extends Attribute {
        constructor() {
            super(...arguments);
            this.BASE = new Attribute(this, MathAlgorithm.Add);
            this.AMP = new Attribute(this, MathAlgorithm.Add);
            this.AMP_1 = new Attribute(this, MathAlgorithm.Add);
            this.UNIQUE = new Attribute(this, MathAlgorithm.Add);
        }
    }(undefined, MathAlgorithm.Add),
    PureCritDmg: new class PureCritDmg extends Attribute {
        constructor() {
            super(...arguments);
            this.BASE = new Attribute(this, MathAlgorithm.Add);
            this.AMP = new Attribute(this, MathAlgorithm.Add);
            this.AMP_1 = new Attribute(this, MathAlgorithm.Add);
            this.UNIQUE = new Attribute(this, MathAlgorithm.Add);
        }
    }(undefined, MathAlgorithm.Add),
    MultCount: new Attribute(undefined, MathAlgorithm.Add),
    MultDmg: new Attribute(undefined, MathAlgorithm.Add),
    BounceCount: new Attribute(undefined, MathAlgorithm.Add),
    BounceDmg: new Attribute(undefined, MathAlgorithm.Add),
    CleaveCount: new Attribute(undefined, MathAlgorithm.Add),
    CleaveDmg: new Attribute(undefined, MathAlgorithm.Add),
    StrGain: new class StrGain extends Attribute {
        constructor() {
            super(...arguments);
            this.BASE = new Attribute(this, MathAlgorithm.Add);
            this.BONUS = new Attribute(this, MathAlgorithm.Add);
            this.PCT = new Attribute(this, MathAlgorithm.Add);
            this.AMP = new Attribute(this, MathAlgorithm.Add);
            this.AMP_3 = new Attribute(this, MathAlgorithm.Add);
        }
    }(undefined),
    AgiGain: new class AgiGain extends Attribute {
        constructor() {
            super(...arguments);
            this.BASE = new Attribute(this, MathAlgorithm.Add);
            this.BONUS = new Attribute(this, MathAlgorithm.Add);
            this.PCT = new Attribute(this, MathAlgorithm.Add);
            this.AMP = new Attribute(this, MathAlgorithm.Add);
            this.AMP_3 = new Attribute(this, MathAlgorithm.Add);
        }
    }(undefined),
    IntGain: new class IntGain extends Attribute {
        constructor() {
            super(...arguments);
            this.BASE = new Attribute(this, MathAlgorithm.Add);
            this.BONUS = new Attribute(this, MathAlgorithm.Add);
            this.PCT = new Attribute(this, MathAlgorithm.Add);
            this.AMP = new Attribute(this, MathAlgorithm.Add);
            this.AMP_3 = new Attribute(this, MathAlgorithm.Add);
        }
    }(undefined),
    AtkGain: new class AtkGain extends Attribute {
        constructor() {
            super(...arguments);
            this.BASE = new Attribute(this, MathAlgorithm.Add);
            this.BONUS = new Attribute(this, MathAlgorithm.Add);
            this.PCT = new Attribute(this, MathAlgorithm.Add);
            this.AMP = new Attribute(this, MathAlgorithm.Add);
            this.AMP_3 = new Attribute(this, MathAlgorithm.Add);
        }
    }(undefined),
    AtkPureGain: new class AtkPureGain extends Attribute {
        constructor() {
            super(...arguments);
            this.BASE = new Attribute(this, MathAlgorithm.Add);
            this.BONUS = new Attribute(this, MathAlgorithm.Add);
            this.PCT = new Attribute(this, MathAlgorithm.Add);
            this.AMP = new Attribute(this, MathAlgorithm.Add);
            this.AMP_3 = new Attribute(this, MathAlgorithm.Add);
        }
    }(undefined),
    HpGain: new class HpGain extends Attribute {
        constructor() {
            super(...arguments);
            this.BASE = new Attribute(this, MathAlgorithm.Add);
            this.BONUS = new Attribute(this, MathAlgorithm.Add);
            this.PCT = new Attribute(this, MathAlgorithm.Add);
            this.AMP = new Attribute(this, MathAlgorithm.Add);
            this.AMP_3 = new Attribute(this, MathAlgorithm.Add);
        }
    }(undefined),
    PhyFixedGain: new class PhyFixedGain extends Attribute {
        constructor() {
            super(...arguments);
            this.BASE = new Attribute(this, MathAlgorithm.Add);
            this.BONUS = new Attribute(this, MathAlgorithm.Add);
            this.PCT = new Attribute(this, MathAlgorithm.Add);
            this.AMP = new Attribute(this, MathAlgorithm.Add);
            this.AMP_3 = new Attribute(this, MathAlgorithm.Add);
        }
    }(undefined),
    MgcFixedGain: new class MgcFixedGain extends Attribute {
        constructor() {
            super(...arguments);
            this.BASE = new Attribute(this, MathAlgorithm.Add);
            this.BONUS = new Attribute(this, MathAlgorithm.Add);
            this.PCT = new Attribute(this, MathAlgorithm.Add);
            this.AMP = new Attribute(this, MathAlgorithm.Add);
            this.AMP_3 = new Attribute(this, MathAlgorithm.Add);
        }
    }(undefined),
    CreepDmg: new class CreepDmg extends Attribute {
        constructor() {
            super(...arguments);
            this.BASE = new Attribute(this, MathAlgorithm.Add);
            this.AMP = new Attribute(this, MathAlgorithm.Add);
            this.AMP_1 = new Attribute(this, MathAlgorithm.Add);
            this.UNIQUE = new Attribute(this, MathAlgorithm.Add);
        }
    }(undefined),
    EliteDmg: new class EliteDmg extends Attribute {
        constructor() {
            super(...arguments);
            this.BASE = new Attribute(this, MathAlgorithm.Add);
            this.AMP = new Attribute(this, MathAlgorithm.Add);
            this.AMP_1 = new Attribute(this, MathAlgorithm.Add);
            this.UNIQUE = new Attribute(this, MathAlgorithm.Add);
        }
    }(undefined),
    ChallengeDmg: new class ChallengeDmg extends Attribute {
        constructor() {
            super(...arguments);
            this.BASE = new Attribute(this, MathAlgorithm.Add);
            this.AMP = new Attribute(this, MathAlgorithm.Add);
            this.AMP_1 = new Attribute(this, MathAlgorithm.Add);
            this.UNIQUE = new Attribute(this, MathAlgorithm.Add);
        }
    }(undefined),
    BossDmg: new class BossDmg extends Attribute {
        constructor() {
            super(...arguments);
            this.BASE = new Attribute(this, MathAlgorithm.Add);
            this.AMP = new Attribute(this, MathAlgorithm.Add);
            this.AMP_1 = new Attribute(this, MathAlgorithm.Add);
            this.UNIQUE = new Attribute(this, MathAlgorithm.Add);
        }
    }(undefined),
    ArchiveDmg: new class ArchiveDmg extends Attribute {
        constructor() {
            super(...arguments);
            this.BASE = new Attribute(this, MathAlgorithm.Add);
            this.AMP = new Attribute(this, MathAlgorithm.Add);
            this.AMP_1 = new Attribute(this, MathAlgorithm.Add);
            this.UNIQUE = new Attribute(this, MathAlgorithm.Add);
        }
    }(undefined),
    AtkDmg: new class AtkDmg extends Attribute {
        constructor() {
            super(...arguments);
            this.BASE = new Attribute(this, MathAlgorithm.Add);
            this.AMP = new Attribute(this, MathAlgorithm.Add);
            this.AMP_1 = new Attribute(this, MathAlgorithm.Add);
            this.UNIQUE = new Attribute(this, MathAlgorithm.Add);
        }
    }(undefined),
    AbltDmg: new class AbltDmg extends Attribute {
        constructor() {
            super(...arguments);
            this.BASE = new Attribute(this, MathAlgorithm.Add);
            this.AMP = new Attribute(this, MathAlgorithm.Add);
            this.AMP_1 = new Attribute(this, MathAlgorithm.Add);
            this.UNIQUE = new Attribute(this, MathAlgorithm.Add);
        }
    }(undefined),
    PhyDmg: new class PhyDmg extends Attribute {
        constructor() {
            super(...arguments);
            this.BASE = new Attribute(this, MathAlgorithm.Add);
            this.AMP = new Attribute(this, MathAlgorithm.Add);
            this.AMP_1 = new Attribute(this, MathAlgorithm.Add);
            this.UNIQUE = new Attribute(this, MathAlgorithm.Add);
        }
    }(undefined),
    MgcDmg: new class MgcDmg extends Attribute {
        constructor() {
            super(...arguments);
            this.BASE = new Attribute(this, MathAlgorithm.Add);
            this.AMP = new Attribute(this, MathAlgorithm.Add);
            this.AMP_1 = new Attribute(this, MathAlgorithm.Add);
            this.UNIQUE = new Attribute(this, MathAlgorithm.Add);
        }
    }(undefined),
    PureDmg: new class PureDmg extends Attribute {
        constructor() {
            super(...arguments);
            this.BASE = new Attribute(this, MathAlgorithm.Add);
            this.AMP = new Attribute(this, MathAlgorithm.Add);
            this.AMP_1 = new Attribute(this, MathAlgorithm.Add);
            this.UNIQUE = new Attribute(this, MathAlgorithm.Add);
        }
    }(undefined),
    AllDmg: new class AllDmg extends Attribute {
        constructor() {
            super(...arguments);
            this.BASE = new Attribute(this, MathAlgorithm.Add);
            this.AMP = new Attribute(this, MathAlgorithm.Add);
            this.AMP_1 = new Attribute(this, MathAlgorithm.Add);
            this.UNIQUE = new Attribute(this, MathAlgorithm.Add);
        }
    }(undefined),
    DmgFinal: new class DmgFinal extends Attribute {
        constructor() {
            super(...arguments);
            this.BASE = new Attribute(this, MathAlgorithm.Add);
            this.AMP_1 = new Attribute(this, MathAlgorithm.Add);
            this.UNIQUE = new Attribute(this, MathAlgorithm.Add);
        }
    }(undefined),
    DmgReduce: new class DmgReduce extends Attribute {
        constructor() {
            super(...arguments);
            this.BASE = new Attribute(this, MathAlgorithm.Add);
            this.UNIQUE = new Attribute(this, MathAlgorithm.Add);
        }
    }(undefined),
    GoldPct: new Attribute(undefined, MathAlgorithm.Add),
    WoodPct: new Attribute(undefined, MathAlgorithm.Add),
    KillPct: new Attribute(undefined, MathAlgorithm.Add),
    ExpPct: new Attribute(undefined, MathAlgorithm.Add),
    PerSecAllStats: new Attribute(undefined, MathAlgorithm.Add),
    PerSecStr: new Attribute(undefined, MathAlgorithm.Add),
    PerSecAgi: new Attribute(undefined, MathAlgorithm.Add),
    PerSecInt: new Attribute(undefined, MathAlgorithm.Add),
    PerSecHp: new Attribute(undefined, MathAlgorithm.Add),
    PerSecAtk: new Attribute(undefined, MathAlgorithm.Add),
    PerSecAtkPure: new Attribute(undefined, MathAlgorithm.Add),
    PerSecPhyFixDmg: new Attribute(undefined, MathAlgorithm.Add),
    PerSecMgcFixDmg: new Attribute(undefined, MathAlgorithm.Add),
    PerSecGold: new Attribute(undefined, MathAlgorithm.Add),
    PerSecWood: new Attribute(undefined, MathAlgorithm.Add),
    PerSecKill: new Attribute(undefined, MathAlgorithm.Add),
    PerSecExp: new Attribute(undefined, MathAlgorithm.Add),
    KillAllStats: new Attribute(undefined, MathAlgorithm.Add),
    KillStr: new Attribute(undefined, MathAlgorithm.Add),
    KillAgi: new Attribute(undefined, MathAlgorithm.Add),
    KillInt: new Attribute(undefined, MathAlgorithm.Add),
    KillHp: new Attribute(undefined, MathAlgorithm.Add),
    KillAtk: new Attribute(undefined, MathAlgorithm.Add),
    KillAtkPure: new Attribute(undefined, MathAlgorithm.Add),
    KillPhyFixDmg: new Attribute(undefined, MathAlgorithm.Add),
    KillMgcFixDmg: new Attribute(undefined, MathAlgorithm.Add),
    KillGold: new Attribute(undefined, MathAlgorithm.Add),
    KillWood: new Attribute(undefined, MathAlgorithm.Add),
    KillKill: new Attribute(undefined, MathAlgorithm.Add),
    KillExp: new Attribute(undefined, MathAlgorithm.Add),
    KillRegenHp: new Attribute(undefined, MathAlgorithm.Add),
    KillGoldPct: new Attribute(undefined, MathAlgorithm.Add),
    KillWoodPct: new Attribute(undefined, MathAlgorithm.Add),
    KillKillPct: new Attribute(undefined, MathAlgorithm.Add),
    KillExpPct: new Attribute(undefined, MathAlgorithm.Add),
    RespawnChance: new Attribute(undefined, MathAlgorithm.Add),
    RespawnTime: new class RespawnTime extends Attribute {
        constructor() {
            super(...arguments);
            this.BASE = new Attribute(this, MathAlgorithm.Add);
            this.PCT = new Attribute(this, MathAlgorithm.Add);
            this.OVERRIDE = new LevelAttribute(this);
        }
    }(undefined, MathAlgorithm.Add),
    SummonDoubleChance: new Attribute(undefined, MathAlgorithm.Add),
    SummonDuration: new Attribute(undefined, MathAlgorithm.Add),
    SummonDmg: new Attribute(undefined, MathAlgorithm.Add),
    HolyDmg: new class HolyDmg extends Attribute {
        constructor() {
            super(...arguments);
            this.BASE = new Attribute(this, MathAlgorithm.Add);
            this.AMP = new Attribute(this, MathAlgorithm.Add);
            this.AMP_1 = new Attribute(this, MathAlgorithm.Add);
            this.AMP2 = new Attribute(this, MathAlgorithm.Add);
            this.UNIQUE = new Attribute(this, MathAlgorithm.Add);
        }
    }(undefined, MathAlgorithm.Add),
    NatureDmg: new class NatureDmg extends Attribute {
        constructor() {
            super(...arguments);
            this.BASE = new Attribute(this, MathAlgorithm.Add);
            this.AMP = new Attribute(this, MathAlgorithm.Add);
            this.AMP_1 = new Attribute(this, MathAlgorithm.Add);
            this.AMP2 = new Attribute(this, MathAlgorithm.Add);
            this.UNIQUE = new Attribute(this, MathAlgorithm.Add);
        }
    }(undefined, MathAlgorithm.Add),
    FrostDmg: new class FrostDmg extends Attribute {
        constructor() {
            super(...arguments);
            this.BASE = new Attribute(this, MathAlgorithm.Add);
            this.AMP = new Attribute(this, MathAlgorithm.Add);
            this.AMP_1 = new Attribute(this, MathAlgorithm.Add);
            this.AMP2 = new Attribute(this, MathAlgorithm.Add);
            this.UNIQUE = new Attribute(this, MathAlgorithm.Add);
        }
    }(undefined, MathAlgorithm.Add),
    FireDmg: new class FireDmg extends Attribute {
        constructor() {
            super(...arguments);
            this.BASE = new Attribute(this, MathAlgorithm.Add);
            this.AMP = new Attribute(this, MathAlgorithm.Add);
            this.AMP_1 = new Attribute(this, MathAlgorithm.Add);
            this.AMP2 = new Attribute(this, MathAlgorithm.Add);
            this.UNIQUE = new Attribute(this, MathAlgorithm.Add);
        }
    }(undefined, MathAlgorithm.Add),
    PhysicalDmg: new class PhysicalDmg extends Attribute {
        constructor() {
            super(...arguments);
            this.BASE = new Attribute(this, MathAlgorithm.Add);
            this.AMP = new Attribute(this, MathAlgorithm.Add);
            this.AMP_1 = new Attribute(this, MathAlgorithm.Add);
            this.AMP2 = new Attribute(this, MathAlgorithm.Add);
            this.UNIQUE = new Attribute(this, MathAlgorithm.Add);
        }
    }(undefined, MathAlgorithm.Add),
    ShadowDmg: new class ShadowDmg extends Attribute {
        constructor() {
            super(...arguments);
            this.BASE = new Attribute(this, MathAlgorithm.Add);
            this.AMP = new Attribute(this, MathAlgorithm.Add);
            this.AMP_1 = new Attribute(this, MathAlgorithm.Add);
            this.AMP2 = new Attribute(this, MathAlgorithm.Add);
            this.UNIQUE = new Attribute(this, MathAlgorithm.Add);
        }
    }(undefined, MathAlgorithm.Add),
    AllFlagDmg: new Attribute(undefined, MathAlgorithm.Add),
    HolyPenetrate: new Attribute(undefined, MathAlgorithm.Add),
    NaturePenetrate: new Attribute(undefined, MathAlgorithm.Add),
    FrostPenetrate: new Attribute(undefined, MathAlgorithm.Add),
    FirePenetrate: new Attribute(undefined, MathAlgorithm.Add),
    PhysicalPenetrate: new Attribute(undefined, MathAlgorithm.Add),
    ShadowPenetrate: new Attribute(undefined, MathAlgorithm.Add),
    HolyResist: new Attribute(undefined, MathAlgorithm.Add),
    NatureResist: new Attribute(undefined, MathAlgorithm.Add),
    FrostResist: new Attribute(undefined, MathAlgorithm.Add),
    FireResist: new Attribute(undefined, MathAlgorithm.Add),
    PhysicalResist: new Attribute(undefined, MathAlgorithm.Add),
    ShadowResist: new Attribute(undefined, MathAlgorithm.Add),
    InitGood: new Attribute(undefined, MathAlgorithm.Add),
    InitWood: new Attribute(undefined, MathAlgorithm.Add),
    InitKill: new Attribute(undefined, MathAlgorithm.Add),
    GainDoubleChance: new class GainDoubleChance extends Attribute {
        constructor() {
            super(...arguments);
            this.BASE = new Attribute(this, MathAlgorithm.Add);
            this.LIMIT_MAX = new LevelAttribute(this);
        }
    }(undefined, MathAlgorithm.Add),
    DoubleCastChance: new class DoubleCastChance extends Attribute {
        constructor() {
            super(...arguments);
            this.BASE = new Attribute(this, MathAlgorithm.Add);
            this.UNIQUE = new Attribute(this, MathAlgorithm.Add);
            this.LIMIT_MAX = new LevelAttribute(this);
        }
    }(undefined, MathAlgorithm.Add),
    AtkPureChance: new Attribute(undefined, MathAlgorithm.Add),
    MgcPureChance: new Attribute(undefined, MathAlgorithm.Add),
    AtkCleaveChance: new class AtkCleaveChance extends Attribute {
        constructor() {
            super(...arguments);
            this.BASE = new Attribute(this, MathAlgorithm.Add);
            this.LIMIT_MAX = new LevelAttribute(this);
        }
    }(undefined, MathAlgorithm.Add),
    AtkCleaveRadius: new Attribute(undefined, MathAlgorithm.Add),
    AtkCleaveDmg: new Attribute(undefined, MathAlgorithm.Add),
    PureCleaveChance: new class PureCleaveChance extends Attribute {
        constructor() {
            super(...arguments);
            this.BASE = new Attribute(this, MathAlgorithm.Add);
            this.LIMIT_MAX = new LevelAttribute(this);
        }
    }(undefined, MathAlgorithm.Add),
    PureCleaveRadius: new Attribute(undefined, MathAlgorithm.Add),
    PureCleaveDmg: new Attribute(undefined, MathAlgorithm.Add),
    AtkBadDmgChance: new class AtkBadDmgChance extends Attribute {
        constructor() {
            super(...arguments);
            this.BASE = new Attribute(this, MathAlgorithm.Add);
            this.LIMIT_MAX = new LevelAttribute(this);
        }
    }(undefined, MathAlgorithm.Add),
    AtkBadDmg: new Attribute(undefined, MathAlgorithm.Add),
    AtkBadDuration: new Attribute(undefined, MathAlgorithm.Add),
    BadEffect: new Attribute(undefined, MathAlgorithm.Add),
    CardEffect: new Attribute(undefined, MathAlgorithm.Add),
    FatalBlow: new Attribute(undefined, MathAlgorithm.Add),
    PenetrateCount: new Attribute(undefined, MathAlgorithm.Add),
    BurnDmg: new Attribute(undefined, MathAlgorithm.Add),
    IceDmg: new Attribute(undefined, MathAlgorithm.Add),
    GoldChallengeCount: new Attribute(undefined, MathAlgorithm.Add),
    WoodChallengeCount: new Attribute(undefined, MathAlgorithm.Add),
    ExpChallengeCount: new Attribute(undefined, MathAlgorithm.Add),
    ChallengeDuration: new Attribute(undefined, MathAlgorithm.Add),
    ShiftDistance: new Attribute(undefined, MathAlgorithm.Add),
    SpawnRatePct: new Attribute(undefined, MathAlgorithm.Add),
    VertRefreshSR: new Attribute(undefined, MathAlgorithm.Add),
    VertRefreshSSR: new Attribute(undefined, MathAlgorithm.Add),
    BottleMaxStack: new Attribute(undefined, MathAlgorithm.Add),
    BlockDmg: new Attribute(undefined, MathAlgorithm.Add),
    GameShopDiscount: new Attribute(undefined, MathAlgorithm.Add),
    PerSecGameShopExp: new Attribute(undefined, MathAlgorithm.Add),
    BaseAtkDmg: new Attribute(undefined, MathAlgorithm.Add),
    ShadowArrowCount: new Attribute(undefined, MathAlgorithm.Add),
    ShadowArrowDmg: new Attribute(undefined, MathAlgorithm.Add),
    ShadowArrowCooldown: new Attribute(undefined, MathAlgorithm.Add),
    ShadowArrowAoeDmg: new Attribute(undefined, MathAlgorithm.Add),
    ShadowArrowAoeRadius: new Attribute(undefined, MathAlgorithm.Add),
    ShadowSecondaryArrowCount: new Attribute(undefined, MathAlgorithm.Add),
    ShadowSecondaryArrowDmg: new Attribute(undefined, MathAlgorithm.Add),
    GameShopRefreshCostReduce: new Attribute(undefined, MathAlgorithm.Add),
    WeaponStatsPct: new Attribute(undefined, MathAlgorithm.Add),
    BlazingArrowHitDmg: new Attribute(undefined, MathAlgorithm.Add),
    BlazingArrowBoomDmg: new Attribute(undefined, MathAlgorithm.Add),
    BlazingArrowDmg: new Attribute(undefined, MathAlgorithm.Add),
    BlazingArrowAoeRadius: new Attribute(undefined, MathAlgorithm.Add),
    BlazingArrowCooldown: new Attribute(undefined, MathAlgorithm.Add),
    BlazingArrowPenetrateCount: new Attribute(undefined, MathAlgorithm.Add),
    IceArrowDmg: new Attribute(undefined, MathAlgorithm.Add),
    IceArrowCount: new Attribute(undefined, MathAlgorithm.Add),
    IceArrowCleaveCount: new Attribute(undefined, MathAlgorithm.Add),
    IceArrowProjectSpd: new Attribute(undefined, MathAlgorithm.Add),
    SmallIceArrowDmg: new Attribute(undefined, MathAlgorithm.Add),
    SkyThunderDmg: new Attribute(undefined, MathAlgorithm.Add),
    MagneticStormDmg: new Attribute(undefined, MathAlgorithm.Add),
    MagneticStormRadius: new Attribute(undefined, MathAlgorithm.Add),
    EMFieldDmg: new Attribute(undefined, MathAlgorithm.Add),
    BlitzballDmg: new Attribute(undefined, MathAlgorithm.Add),
    SwordDmg: new Attribute(undefined, MathAlgorithm.Add),
    SwordProjectSpd: new Attribute(undefined, MathAlgorithm.Add),
    SwordScale: new Attribute(undefined, MathAlgorithm.Add),
    SwordCooldown: new Attribute(undefined, MathAlgorithm.Add),
    ArcaneLaserDmg: new Attribute(undefined, MathAlgorithm.Add),
    ArcaneLaserKeepTime: new Attribute(undefined, MathAlgorithm.Add),
    ArcaneLaserCooldown: new Attribute(undefined, MathAlgorithm.Add),
    ArcaneLaserRadius: new Attribute(undefined, MathAlgorithm.Add),
    ArcaneRayDmg: new Attribute(undefined, MathAlgorithm.Add),
    ArcaneRayKeepTime: new Attribute(undefined, MathAlgorithm.Add),
    ArcaneRayCount: new Attribute(undefined, MathAlgorithm.Add),
    FrostNovaDmg: new Attribute(undefined, MathAlgorithm.Add),
    FrostNovaRadius: new Attribute(undefined, MathAlgorithm.Add),
    FrostNovaCount: new Attribute(undefined, MathAlgorithm.Add),
    FrostNovaCooldown: new Attribute(undefined, MathAlgorithm.Add),
    IceArrowCooldown: new Attribute(undefined, MathAlgorithm.Add),
    LightningChainDmg: new Attribute(undefined, MathAlgorithm.Add),
    LightningChainCount: new Attribute(undefined, MathAlgorithm.Add),
    LonBlastingRadius: new Attribute(undefined, MathAlgorithm.Add),
    LonBlastingDmg: new Attribute(undefined, MathAlgorithm.Add),
    LightningChainCooldown: new Attribute(undefined, MathAlgorithm.Add),
    SkyThunderCooldown: new Attribute(undefined, MathAlgorithm.Add),
    EarthQuakeDmg: new Attribute(undefined, MathAlgorithm.Add),
    EarthQuakeRadius: new Attribute(undefined, MathAlgorithm.Add),
    EmbersDmg: new Attribute(undefined, MathAlgorithm.Add),
    TornadoDmg: new Attribute(undefined, MathAlgorithm.Add),
    TornadoKeepTime: new Attribute(undefined, MathAlgorithm.Add),
    TornadoRadius: new Attribute(undefined, MathAlgorithm.Add),
    TornadoMoveSpd: new Attribute(undefined, MathAlgorithm.Add),
    DianCiWangDmg: new Attribute(undefined, MathAlgorithm.Add),
    DianCiWangRadius: new Attribute(undefined, MathAlgorithm.Add),
    DianCiWangCooldown: new Attribute(undefined, MathAlgorithm.Add),
    MeteoriteDmg: new Attribute(undefined, MathAlgorithm.Add),
    MeteoriteCooldown: new Attribute(undefined, MathAlgorithm.Add),
    MeteoriteRadius: new Attribute(undefined, MathAlgorithm.Add),
    MeteoriteCount: new Attribute(undefined, MathAlgorithm.Add),
    MeteoriteFragmentsCount: new Attribute(undefined, MathAlgorithm.Add),
    FireBallDmg: new Attribute(undefined, MathAlgorithm.Add),
    FireBallKeepTime: new Attribute(undefined, MathAlgorithm.Add),
    FireBallRadius: new Attribute(undefined, MathAlgorithm.Add),
    FireBallMoveSpd: new Attribute(undefined, MathAlgorithm.Add),
    FireBallCount: new Attribute(undefined, MathAlgorithm.Add),
    BurntFrostDmg: new Attribute(undefined, MathAlgorithm.Add),
    HurricaneDmg: new Attribute(undefined, MathAlgorithm.Add),
    SmallHurricaneCount: new Attribute(undefined, MathAlgorithm.Add),
    VacuumDmg: new Attribute(undefined, MathAlgorithm.Add),
    GameShopRefreshInterval: new Attribute(undefined, MathAlgorithm.Add),
    HolyAbilitySpellRadius: new Attribute(undefined, MathAlgorithm.Add),
    NatureAbilitySpellRadius: new Attribute(undefined, MathAlgorithm.Add),
    FrostAbilitySpellRadius: new Attribute(undefined, MathAlgorithm.Add),
    FireAbilitySpellRadius: new Attribute(undefined, MathAlgorithm.Add),
    PhysicalAbilitySpellRadius: new Attribute(undefined, MathAlgorithm.Add),
    ShadowAbilitySpellRadius: new Attribute(undefined, MathAlgorithm.Add),
    HolyAbilityCooldown: new Attribute(undefined, MathAlgorithm.Add),
    NatureAbilityCooldown: new Attribute(undefined, MathAlgorithm.Add),
    FrostAbilityCooldown: new Attribute(undefined, MathAlgorithm.Add),
    FireAbilityCooldown: new Attribute(undefined, MathAlgorithm.Add),
    PhysicalAbilityCooldown: new Attribute(undefined, MathAlgorithm.Add),
    ShadowAbilityCooldown: new Attribute(undefined, MathAlgorithm.Add),
    HolyReduceResistPct: new Attribute(undefined, MathAlgorithm.Add),
    NatureReduceResistPct: new Attribute(undefined, MathAlgorithm.Add),
    FrostReduceResistPct: new Attribute(undefined, MathAlgorithm.Add),
    FireReduceResistPct: new Attribute(undefined, MathAlgorithm.Add),
    PhysicalReduceResistPct: new Attribute(undefined, MathAlgorithm.Add),
    ShadowReduceResistPct: new Attribute(undefined, MathAlgorithm.Add),
    MiningSpd: new Attribute(undefined, MathAlgorithm.Add),
    GameShopCostReduce: new Attribute(undefined, MathAlgorithm.Add),
    ShadowArrowPenetrateCount: new Attribute(undefined, MathAlgorithm.Add),
    IceArrowPenetrateCount: new Attribute(undefined, MathAlgorithm.Add),
    HurricanePenetrateCount: new Attribute(undefined, MathAlgorithm.Add),
    ThunderDmgFactor: new Attribute(undefined, MathAlgorithm.Add),
    ArcaneRayCooldown: new Attribute(undefined, MathAlgorithm.Add),
    LightningBounceCount: new Attribute(undefined, MathAlgorithm.Add),
    EarthquakeCooldown: new Attribute(undefined, MathAlgorithm.Add),
    TornadoCooldown: new Attribute(undefined, MathAlgorithm.Add),
    HurricaneCooldown: new Attribute(undefined, MathAlgorithm.Add),
    FireballDuration: new Attribute(undefined, MathAlgorithm.Add),
    FireballCooldown: new Attribute(undefined, MathAlgorithm.Add),
    ArcaneRayRange: new Attribute(undefined, MathAlgorithm.Add),
    FinalDamageCalculation: new Attribute(undefined, MathAlgorithm.Add),
    FinalDamageCalculation1: new Attribute(undefined, MathAlgorithm.Add),
    FinalHpRegen: new Attribute(undefined, MathAlgorithm.Add),
    DmgAmp: new Attribute(undefined, MathAlgorithm.Add),
    FinalAllDmg: new Attribute(undefined, MathAlgorithm.Add),
    FinalPhyDmg: new Attribute(undefined, MathAlgorithm.Add),
    FinalMagDmg: new Attribute(undefined, MathAlgorithm.Add),
    ArcaneLaserCount: new Attribute(undefined, MathAlgorithm.Add),
    DianCiWangFixRadius: new Attribute(undefined, MathAlgorithm.Add),
    HolyRairty: new Attribute(undefined, MathAlgorithm.Add),
    HolyAbilityLevel: new Attribute(undefined, MathAlgorithm.Add),
    NatureAbilityLevel: new Attribute(undefined, MathAlgorithm.Add),
    FrostAbilityLevel: new Attribute(undefined, MathAlgorithm.Add),
    FireAbilityLevel: new Attribute(undefined, MathAlgorithm.Add),
    PhysicalAbilityLevel: new Attribute(undefined, MathAlgorithm.Add),
    ShadowAbilityLevel: new Attribute(undefined, MathAlgorithm.Add),
};
function setname(t, sNameParent) {
    for (const k in t) {
        if (k != 'hParent' && t[k] instanceof Attribute) {
            if (sNameParent) {
                t[k].name = sNameParent + '.' + k;
            }
            else {
                t[k].name = k;
            }
            setname(t[k], t[k].name);
        }
    }
}
setname(AttributeCfg);
{
    Entities['_GetHealth'] = (_a = Entities['_GetHealth']) !== null && _a !== void 0 ? _a : Entities.GetHealth;
    Entities.GetHealth = function (iEntID) {
        var _a, _b, _c;
        if ((_c = (_b = (_a = GameUI.CustomUIConfig()) === null || _a === void 0 ? void 0 : _a.tools) === null || _b === void 0 ? void 0 : _b.AttributeKind) === null || _c === void 0 ? void 0 : _c.HpLimit) {
            return Entities['_GetHealth'](iEntID) / Entities['_GetMaxHealth'](iEntID) * GameUI.CustomUIConfig().tools.AttributeKind.HpLimit.Get(iEntID);
        }
        return Entities['_GetHealth'](iEntID);
    };
    Entities['_GetMaxHealth'] = (_b = Entities['_GetMaxHealth']) !== null && _b !== void 0 ? _b : Entities.GetMaxHealth;
    Entities.GetMaxHealth = function (iEntID) {
        var _a, _b, _c;
        if ((_c = (_b = (_a = GameUI.CustomUIConfig()) === null || _a === void 0 ? void 0 : _a.tools) === null || _b === void 0 ? void 0 : _b.AttributeKind) === null || _c === void 0 ? void 0 : _c.HpLimit) {
            let f = GameUI.CustomUIConfig().tools.AttributeKind.HpLimit.Get(iEntID);
            if (typeof f == 'number')
                return f;
            return 0;
        }
        return Entities['_GetMaxHealth'](iEntID);
    };
    Entities['_GetHealthPercent'] = (_c = Entities['_GetHealthPercent']) !== null && _c !== void 0 ? _c : Entities.GetHealthPercent;
    Entities.GetHealthPercent = function (iEntID) {
        return Math.floor(Entities['_GetHealth'](iEntID) / Entities['_GetMaxHealth'](iEntID) * 100);
    };
}

var tools;
(function (tools) {
    tools.AttributeKind = AttributeCfg;
    class AttributeSystem {
        static Init(bReload) {
            GameEvents.Subscribe('attribute_update_client_player', (event) => {
                for (const entid in event.data) {
                    const data = event.data[entid];
                    GameEvents.SendEventClientSide('attribute_update_client', {
                        entid: Number(entid),
                        json: JSON.stringify(data),
                    });
                }
            });
        }
    }
    tools.AttributeSystem = AttributeSystem;
})(tools || (tools = {}));
GameUI.CustomUIConfig().tools = tools;