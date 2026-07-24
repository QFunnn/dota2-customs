--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


"use strict";
let ability_kv = {};
const OP_ADD = 0;
const OP_MULT = 1;
const OP_PERCENTAGE = 2;
const OP_SET = 3;
const DAMAGE_TYPE_CLASS = {
    DAMAGE_TYPE_MAGICAL: "DamageTypeMagical",
    DAMAGE_TYPE_PURE: "DamageTypePure",
    DAMAGE_TYPE_PHYSICAL: "DamageTypePhysical",
};
function SetKVDefinition(kv) {
    // $.Msg("ABILITY KV EVENT RESPONSE");
    ability_kv = kv;
}
function GetAbilityKV(ability_name) {
    return ability_kv[ability_name];
}
function ParseBonusValue(value) {
    let operator = OP_ADD;
    let num_value = value;
    if (typeof value === "string") {
        num_value = num_value.trim();
        if (num_value.endsWith("%")) {
            operator = OP_PERCENTAGE;
            num_value = parseFloat(num_value.substring(0, num_value.length - 1));
        }
        else if (num_value.startsWith("x")) {
            operator = OP_MULT;
            num_value = parseFloat(num_value.substring(1));
        }
        else if (num_value.startsWith("=")) {
            operator = OP_SET;
            num_value = parseFloat(num_value.substring(1));
        }
        else
            num_value = parseFloat(value);
    }
    return [operator, num_value];
}
function GetValueForLevel(values, level) {
    var _a, _b;
    if (typeof values === "number")
        return values;
    if (typeof values === "string") {
        const n = parseFloat(values);
        return isNaN(n) ? 0 : n;
    }
    if (Array.isArray(values)) {
        if (values.length === 0)
            return 0;
        const idx = Math.min(level, values.length) - 1;
        const v = values[idx];
        const n = Number(v);
        return isNaN(n) ? 0 : n;
    }
    if (values && typeof values === "object") {
        const exact = (_a = values[level]) !== null && _a !== void 0 ? _a : values[String(level)];
        if (exact != null) {
            const n = Number(exact);
            return isNaN(n) ? 0 : n;
        }
        // берём максимальный доступный уровень
        const keys = Object.keys(values)
            .map((k) => parseInt(k, 10))
            .filter((k) => !isNaN(k))
            .sort((a, b) => a - b);
        if (keys.length === 0)
            return 0;
        const maxKey = keys[keys.length - 1];
        const v = (_b = values[maxKey]) !== null && _b !== void 0 ? _b : values[String(maxKey)];
        const n = Number(v);
        return isNaN(n) ? 0 : n;
    }
    return 0;
}
function GetAbilityValues(ability_name) {
    const kv = GetAbilityKV(ability_name);
    if (!kv || !kv.AbilityValues)
        return [];
    return kv.AbilityValues;
}
function GetAbilityBonusValue(ability_name, special_value, bonus_name, level) {
    const values = GetAbilityValues(ability_name);
    const special_value_data = values[special_value];
    const is_object = Object.prototype.toString.call(special_value_data) == "[object Object]";
    if (is_object && special_value_data[bonus_name]) {
        const [operator, value] = ParseBonusValue(GetValueForLevel(special_value_data[bonus_name], level));
        return Math.abs(value);
    }
    return 0;
}
function GetAbilityValue(ability_name, special_value, level, active_bonus) {
    var _a;
    special_value = special_value.toLowerCase();
    let value = 0;
    const kv = GetAbilityKV(ability_name);
    if (!kv || !kv.AbilityValues || !kv.AbilityValues[special_value])
        return 0;
    const special_value_data = kv.AbilityValues[special_value];
    const is_object = Object.prototype.toString.call(special_value_data) == "[object Object]";
    if (is_object) {
        // 👉 главное изменение: если нет .value — используем сам объект
        const baseField = (_a = special_value_data.value) !== null && _a !== void 0 ? _a : special_value_data;
        value += GetValueForLevel(baseField, level);
        let total_bonus = 0;
        let mult = 1;
        let perc = 1;
        if (active_bonus) {
            for (const bonus_name of active_bonus) {
                const bonus_data = special_value_data[bonus_name];
                if (!bonus_data)
                    continue;
                const [operator, bonus] = ParseBonusValue(GetValueForLevel(bonus_data, level));
                if (operator === OP_ADD)
                    total_bonus += bonus;
                else if (operator === OP_PERCENTAGE)
                    perc += bonus * 0.01;
                else if (operator === OP_MULT)
                    mult *= bonus;
                else if (operator === OP_SET)
                    value = bonus;
            }
        }
        value += total_bonus;
        value *= mult;
        value *= perc;
    }
    else {
        value = GetValueForLevel(special_value_data, level);
    }
    return Math.abs(value);
}
function TryShrink(arr) {
    const last = arr[arr.length - 1];
    for (let i = arr.length - 2; i >= 0; i--) {
        if (last == arr[i]) {
            arr.pop();
        }
    }
    if (arr.length == 1 && arr[0] == 0)
        return;
    return arr;
}
function WrapHTMLClass(text, class_name) {
    return `<span class="${class_name}">${text}</span>`;
}
function PrintSpecialValueBonus(ability_name, ability, special_value, bonus_name, inline, is_percentage) {
    special_value = special_value.toLowerCase();
    const kv = GetAbilityKV(ability_name);
    if (!kv || !kv.AbilityValues)
        return;
    const max_level = kv.MaxLevel || 4;
    let values = [];
    for (let level = 1; level <= max_level; level++) {
        values[level - 1] = GetAbilityBonusValue(ability_name, special_value, bonus_name, level);
    }
    return FormatValuesString(values, ability_name, ability, special_value, inline, is_percentage);
}
function PrintSpecialValue(ability_name, ability, special_value, active_bonus, inline, is_percentage) {
    special_value = special_value.toLowerCase();
    const kv = GetAbilityKV(ability_name);
    if (!kv || !kv.AbilityValues)
        return;
    if (!kv.AbilityValues[special_value]) {
        const only_bonus = special_value.startsWith("bonus_");
        if (only_bonus && active_bonus[0]) {
            return PrintSpecialValueBonus(ability_name, ability, special_value.substring(6), active_bonus[0], inline, is_percentage);
        }
    }
    // Weird case when Valve add "shard_" prefix to special values
    if (!kv.AbilityValues[special_value] && special_value.startsWith("shard_")) {
        special_value = special_value.substring(6);
        if (!kv.AbilityValues[special_value])
            return;
    }
    const max_level = kv.MaxLevel || 4;
    let values = [];
    for (let level = 1; level <= max_level; level++) {
        values[level - 1] = GetAbilityValue(ability_name, special_value, level, active_bonus);
    }
    return FormatValuesString(values, ability_name, ability, special_value, inline, is_percentage);
}
function FormatValuesString(values, ability_name, ability, special_value, inline, is_percentage) {
    const kv = GetAbilityKV(ability_name);
    if (!kv || !kv.AbilityValues)
        return;
    const current_level = Abilities.GetLevel(ability);
    const max_level = kv.MaxLevel || 4;
    values = TryShrink(values);
    if (!values)
        return;
    values = values.map((value, i) => {
        value = parseFloat(value.toFixed(2));
        if (is_percentage)
            value = value + "%";
        // Highlight current level value
        if (i == current_level - 1 ||
            (values.length == 1 && !inline) ||
            (i == values.length - 1 && values.length < current_level))
            value = WrapHTMLClass(value, "GameplayVariable");
        return value;
    });
    let classes = ["GameplayValues"];
    return WrapHTMLClass(values.join(" / "), classes.join(" "));
}
function PrintSpecialValueLine(ability_name, ability, special_value, active_bonus) {
    special_value = special_value.toLowerCase();
    const token = `dota_tooltip_ability_${ability_name}_${special_value}`;
    let text = $.Localize(token);
    const is_percentage = text.startsWith("%");
    if (is_percentage)
        text = text.substring(1);
    const values_string = PrintSpecialValue(ability_name, ability, special_value, active_bonus, true, is_percentage);
    if (!values_string)
        return;
    if (token.toLowerCase() != text.toLowerCase() && text != "") {
        return `${text} ${values_string}`;
    }
}
function ReplaceAbilityValues(string, ability_name, ability, active_bonus) {
    return string
        .replace(/%(\w+)%+/g, (match, value_name) => {
        return (PrintSpecialValue(ability_name, ability, value_name, active_bonus, false, match.endsWith("%%")) || match);
    })
        .replace(/%%/g, "%");
}
function IsPassiveByName(name) {
    const kv = GetAbilityKV(name);
    if (!kv)
        return false;
    return !!kv.IsPassive;
}
function GetLinkedAbilities(name, b_filter_loc = false) {
    const kv = GetAbilityKV(name);
    if (!kv)
        return [];
    let result = kv.linked_abilities || [];
    if (b_filter_loc) {
        result = result.filter((ability_name) => {
            const loc_token = `DOTA_Tooltip_ability_${ability_name}`;
            const loc_name = $.Localize(loc_token);
            return loc_token != loc_name && loc_name != "";
        });
    }
    return result;
}
function GetAbilityID(ability_name) {
    const kv = GetAbilityKV(ability_name);
    if (!kv)
        return -1;
    return kv.ID || -1;
}
Abilities.GetAbilityKV = GetAbilityKV;
// Abilities.PrintSpecialValue = PrintSpecialValue;
Abilities.PrintSpecialValueLine = PrintSpecialValueLine;
Abilities.GetAbilityValue = GetAbilityValue;
Abilities.GetAbilityValues = GetAbilityValues;
Abilities.ReplaceAbilityValues = ReplaceAbilityValues;
Abilities.IsPassiveByName = IsPassiveByName;
Abilities.GetLinkedAbilities = GetLinkedAbilities;
Abilities.GetAbilityID = GetAbilityID;
let _ability_kv_response_sent = false;
function GetAbilitiesKVResponse() {
    if (_ability_kv_response_sent)
        return;
    _ability_kv_response_sent = true;
    const get_kv_response = () => {
        const _player_id = Game.GetLocalPlayerID();
        if (Players.IsSpectator(_player_id) || _player_id > -1) {
            const delay = Players.IsSpectator(_player_id) ? 5 : 0;
            $.Schedule(delay, () => {
                GameEvents.SendCustomGameEventToServer("get_abilities_items_kv", {});
                // $.Msg("ABILITY KV EVENT SENDED");
            });
        }
        else
            $.Schedule(0.3, get_kv_response);
    };
    get_kv_response();
}
(function () {
    GameEvents.Subscribe("set_abilities_items_kv", SetKVDefinition);
    GetAbilitiesKVResponse();
})();