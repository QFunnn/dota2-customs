--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


var global = this;
/******************************************************************************
Copyright (c) Microsoft Corporation.

Permission to use, copy, modify, and/or distribute this software for any
purpose with or without fee is hereby granted.

THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES WITH
REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF MERCHANTABILITY
AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY SPECIAL, DIRECT,
INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES WHATSOEVER RESULTING FROM
LOSS OF USE, DATA OR PROFITS, WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE OR
OTHER TORTIOUS ACTION, ARISING OUT OF OR IN CONNECTION WITH THE USE OR
PERFORMANCE OF THIS SOFTWARE.
***************************************************************************** */
/* global Reflect, Promise, SuppressedError, Symbol, Iterator */


function __decorate(decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
}

function reloadlock() {
    return (c) => {
        var _a;
        let __reloadlock__ = GameUI.CustomUIConfig().__reloadlock__ = (_a = GameUI.CustomUIConfig().__reloadlock__) !== null && _a !== void 0 ? _a : {};
        if (__reloadlock__[c.name] == undefined) {
            __reloadlock__[c.name] = c;
            return c;
        }
        let C = __reloadlock__[c.name];
        for (const k of Object.getOwnPropertyNames(c)) {
            let v = c[k];
            if (C[k] == undefined || typeof (v) == 'function') {
                C[k] = v;
            }
        }
        if (c.prototype) {
            if (C.prototype == undefined) {
                C.prototype = c.prototype;
            }
            else {
                for (const k of Object.getOwnPropertyNames(c.prototype)) {
                    let v = c.prototype[k];
                    if (C.prototype[k] == undefined || typeof (v) == 'function') {
                        C.prototype[k] = v;
                    }
                }
            }
        }
        return C;
    };
}

const Command2KeyName = {
    [$.Localize("#Valve_ButtonCodeName_KP_0")]: "0",
    [$.Localize("#Valve_ButtonCodeName_KP_1")]: "1",
    [$.Localize("#Valve_ButtonCodeName_KP_2")]: "2",
    [$.Localize("#Valve_ButtonCodeName_KP_3")]: "3",
    [$.Localize("#Valve_ButtonCodeName_KP_4")]: "4",
    [$.Localize("#Valve_ButtonCodeName_KP_5")]: "5",
    [$.Localize("#Valve_ButtonCodeName_KP_6")]: "6",
    [$.Localize("#Valve_ButtonCodeName_KP_7")]: "7",
    [$.Localize("#Valve_ButtonCodeName_KP_8")]: "8",
    [$.Localize("#Valve_ButtonCodeName_KP_9")]: "9",
    [$.Localize("#Valve_ButtonCodeName_KP_DIVIDE")]: "kp_slash",
    [$.Localize("#Valve_ButtonCodeName_KP_MULTIPLY")]: "kp_multiply",
    [$.Localize("#Valve_ButtonCodeName_KP_MINUS")]: "kp_minus",
    [$.Localize("#Valve_ButtonCodeName_KP_PLUS")]: "kp_plus",
    [$.Localize("#Valve_ButtonCodeName_KP_ENTER")]: "kp_enter",
    [$.Localize("#Valve_ButtonCodeName_KP_DEL")]: "kp_del",
    [$.Localize("#Valve_ButtonCodeName_SEMICOLON")]: "semicolon",
    [$.Localize("#Valve_ButtonCodeName_ENTER")]: "enter",
    [$.Localize("#Valve_ButtonCodeName_SPACE")]: "space",
    [$.Localize("#Valve_ButtonCodeName_BACKSPACE")]: "backspace",
    [$.Localize("#Valve_ButtonCodeName_TAB")]: "tab",
    [$.Localize("#Valve_ButtonCodeName_CAPSLOCK")]: "capslock",
    [$.Localize("#Valve_ButtonCodeName_NUMLOCK")]: "numlock",
    [$.Localize("#Valve_ButtonCodeName_ESCAPE")]: "escape",
    [$.Localize("#Valve_ButtonCodeName_SCROLLLOCK")]: "scrolllock",
    [$.Localize("#Valve_ButtonCodeName_INS")]: "ins",
    [$.Localize("#Valve_ButtonCodeName_DEL")]: "del",
    [$.Localize("#Valve_ButtonCodeName_HOME")]: "home",
    [$.Localize("#Valve_ButtonCodeName_END")]: "end",
    [$.Localize("#Valve_ButtonCodeName_PGUP")]: "pgup",
    [$.Localize("#Valve_ButtonCodeName_PGDN")]: "pgdn",
    [$.Localize("#Valve_ButtonCodeName_PAUSE")]: "pause",
    [$.Localize("#Valve_ButtonCodeName_SHIFT")]: "shift",
    [$.Localize("#Valve_ButtonCodeName_RSHIFT")]: "rshift",
    [$.Localize("#Valve_ButtonCodeName_ALT")]: "alt",
    [$.Localize("#Valve_ButtonCodeName_RALT")]: "ralt",
    [$.Localize("#Valve_ButtonCodeName_CTRL")]: "ctrl",
    [$.Localize("#Valve_ButtonCodeName_RCTRL")]: "rctrl",
    [$.Localize("#Valve_ButtonCodeName_LWIN")]: "lwin",
    [$.Localize("#Valve_ButtonCodeName_RWIN")]: "rwin",
    [$.Localize("#Valve_ButtonCodeName_APP")]: "应用程序",
    [$.Localize("#Valve_ButtonCodeName_UPARROW")]: "uparrow",
    [$.Localize("#Valve_ButtonCodeName_LEFTARROW")]: "leftarrow",
    [$.Localize("#Valve_ButtonCodeName_DOWNARROW")]: "downarrow",
    [$.Localize("#Valve_ButtonCodeName_RIGHTARROW")]: "rightarrow",
    [$.Localize("#Valve_ButtonCodeName_AC_BACK")]: "应用控制 返回",
    [$.Localize("#Valve_ButtonCodeName_AC_BOOKMARKS")]: "应用控制 书签",
    [$.Localize("#Valve_ButtonCodeName_AC_FORWARD")]: "应用控制 向前",
    [$.Localize("#Valve_ButtonCodeName_AC_HOME")]: "应用控制 主页",
    [$.Localize("#Valve_ButtonCodeName_AC_REFRESH")]: "应用控制 刷新",
    [$.Localize("#Valve_ButtonCodeName_AC_SEARCH")]: "应用控制 搜索",
    [$.Localize("#Valve_ButtonCodeName_AC_STOP")]: "应用控制 停止",
    [$.Localize("#Valve_ButtonCodeName_AGAIN")]: "重做",
    [$.Localize("#Valve_ButtonCodeName_ALTERASE")]: "AltErase",
    [$.Localize("#Valve_ButtonCodeName_AMPERSAND")]: "&",
    [$.Localize("#Valve_ButtonCodeName_ASTERISK")]: "*",
    [$.Localize("#Valve_ButtonCodeName_AT")]: "@",
    [$.Localize("#Valve_ButtonCodeName_AUDIOMUTE")]: "静音",
    [$.Localize("#Valve_ButtonCodeName_AUDIONEXT")]: "下一曲",
    [$.Localize("#Valve_ButtonCodeName_AUDIOPLAY")]: "播放",
    [$.Localize("#Valve_ButtonCodeName_AUDIOPREV")]: "上一曲",
    [$.Localize("#Valve_ButtonCodeName_AUDIOSTOP")]: "停止播放",
    [$.Localize("#Valve_ButtonCodeName_BRIGHTNESSDOWN")]: "降低亮度",
    [$.Localize("#Valve_ButtonCodeName_BRIGHTNESSUP")]: "提升亮度",
    [$.Localize("#Valve_ButtonCodeName_CALCULATOR")]: "计算器",
    [$.Localize("#Valve_ButtonCodeName_CANCEL")]: "取消",
    [$.Localize("#Valve_ButtonCodeName_CARET")]: "^",
    [$.Localize("#Valve_ButtonCodeName_CLEAR")]: "清除",
    [$.Localize("#Valve_ButtonCodeName_CLEARAGAIN")]: "清除/重做",
    [$.Localize("#Valve_ButtonCodeName_COLON")]: ":",
    [$.Localize("#Valve_ButtonCodeName_COMPUTER")]: "计算机",
    [$.Localize("#Valve_ButtonCodeName_COPY")]: "复制",
    [$.Localize("#Valve_ButtonCodeName_CRSEL")]: "CrSel",
    [$.Localize("#Valve_ButtonCodeName_CURRENCYSUBUNIT")]: "货币子单位",
    [$.Localize("#Valve_ButtonCodeName_CURRENCYUNIT")]: "货币单位",
    [$.Localize("#Valve_ButtonCodeName_CUT")]: "剪切",
    [$.Localize("#Valve_ButtonCodeName_DECIMALSEPARATOR")]: ".",
    [$.Localize("#Valve_ButtonCodeName_DISPLAYSWITCH")]: "切换显示器",
    [$.Localize("#Valve_ButtonCodeName_DOLLAR")]: "$",
    [$.Localize("#Valve_ButtonCodeName_EJECT")]: "弹出",
    [$.Localize("#Valve_ButtonCodeName_EXCLAIM")]: "!",
    [$.Localize("#Valve_ButtonCodeName_EXECUTE")]: "执行",
    [$.Localize("#Valve_ButtonCodeName_EXSEL")]: "ExSel",
    [$.Localize("#Valve_ButtonCodeName_FIND")]: "查找",
    [$.Localize("#Valve_ButtonCodeName_GREATER")]: ">",
    [$.Localize("#Valve_ButtonCodeName_HASH")]: "#",
    [$.Localize("#Valve_ButtonCodeName_HELP")]: "帮助",
    [$.Localize("#Valve_ButtonCodeName_KBDILLUMDOWN")]: "减弱键盘背光",
    [$.Localize("#Valve_ButtonCodeName_KBDILLUMTOGGLE")]: "键盘背光开关",
    [$.Localize("#Valve_ButtonCodeName_KBDILLUMUP")]: "增强键盘背光",
    [$.Localize("#Valve_ButtonCodeName_KP_00")]: "小键盘 00",
    [$.Localize("#Valve_ButtonCodeName_KP_000")]: "小键盘 000",
    [$.Localize("#Valve_ButtonCodeName_KP_A")]: "小键盘 A",
    [$.Localize("#Valve_ButtonCodeName_KP_AMPERSAND")]: "小键盘 &",
    [$.Localize("#Valve_ButtonCodeName_KP_AT")]: "小键盘 @",
    [$.Localize("#Valve_ButtonCodeName_KP_B")]: "小键盘 B",
    [$.Localize("#Valve_ButtonCodeName_KP_BACKSPACE")]: "小键盘 Backspace",
    [$.Localize("#Valve_ButtonCodeName_KP_BINARY")]: "小键盘 二进制",
    [$.Localize("#Valve_ButtonCodeName_KP_C")]: "小键盘 C",
    [$.Localize("#Valve_ButtonCodeName_KP_CLEAR")]: "小键盘 清除",
    [$.Localize("#Valve_ButtonCodeName_KP_CLEARENTRY")]: "小键盘 CE",
    [$.Localize("#Valve_ButtonCodeName_KP_COLON")]: "小键盘 :",
    [$.Localize("#Valve_ButtonCodeName_KP_COMMA")]: "小键盘 ,",
    [$.Localize("#Valve_ButtonCodeName_KP_D")]: "小键盘 D",
    [$.Localize("#Valve_ButtonCodeName_KP_DBLAMPERSAND")]: "小键盘 &&",
    [$.Localize("#Valve_ButtonCodeName_KP_DBLVERTICALBAR")]: "小键盘 ||",
    [$.Localize("#Valve_ButtonCodeName_KP_DECIMAL")]: "小键盘 .",
    [$.Localize("#Valve_ButtonCodeName_KP_E")]: "小键盘 E",
    [$.Localize("#Valve_ButtonCodeName_KP_EQUALS")]: "小键盘 =",
    [$.Localize("#Valve_ButtonCodeName_KP_EQUALSAS400")]: "小键盘 =（AS/400）",
    [$.Localize("#Valve_ButtonCodeName_KP_EXCLAM")]: "小键盘 !",
    [$.Localize("#Valve_ButtonCodeName_KP_F")]: "小键盘 F",
    [$.Localize("#Valve_ButtonCodeName_KP_GREATER")]: "小键盘 >",
    [$.Localize("#Valve_ButtonCodeName_KP_HASH")]: "小键盘 #",
    [$.Localize("#Valve_ButtonCodeName_KP_HEXADECIMAL")]: "小键盘 十六进制",
    [$.Localize("#Valve_ButtonCodeName_KP_LEFTBRACE")]: "小键盘 {",
    [$.Localize("#Valve_ButtonCodeName_KP_LEFTPAREN")]: "小键盘 (",
    [$.Localize("#Valve_ButtonCodeName_KP_LESS")]: "小键盘 <",
    [$.Localize("#Valve_ButtonCodeName_KP_MEMADD")]: "小键盘 M+",
    [$.Localize("#Valve_ButtonCodeName_KP_MEMCLEAR")]: "小键盘 MC",
    [$.Localize("#Valve_ButtonCodeName_KP_MEMDIVIDE")]: "小键盘 M÷",
    [$.Localize("#Valve_ButtonCodeName_KP_MEMMULTIPLY")]: "小键盘 M×",
    [$.Localize("#Valve_ButtonCodeName_KP_MEMRECALL")]: "小键盘 MR",
    [$.Localize("#Valve_ButtonCodeName_KP_MEMSTORE")]: "小键盘 MS",
    [$.Localize("#Valve_ButtonCodeName_KP_MEMSUBTRACT")]: "小键盘 M-",
    [$.Localize("#Valve_ButtonCodeName_KP_OCTAL")]: "小键盘 八进制",
    [$.Localize("#Valve_ButtonCodeName_KP_PERCENT")]: "小键盘 %",
    [$.Localize("#Valve_ButtonCodeName_KP_PLUSMINUS")]: "小键盘 ±",
    [$.Localize("#Valve_ButtonCodeName_KP_POWER")]: "小键盘 ^",
    [$.Localize("#Valve_ButtonCodeName_KP_RIGHTBRACE")]: "小键盘 }",
    [$.Localize("#Valve_ButtonCodeName_KP_RIGHTPAREN")]: "小键盘 )",
    [$.Localize("#Valve_ButtonCodeName_KP_SPACE")]: "小键盘 空格",
    [$.Localize("#Valve_ButtonCodeName_KP_TAB")]: "小键盘 Tab",
    [$.Localize("#Valve_ButtonCodeName_KP_VERTICALBAR")]: "小键盘 |",
    [$.Localize("#Valve_ButtonCodeName_KP_XOR")]: "小键盘 XOR",
    [$.Localize("#Valve_ButtonCodeName_LEFTPAREN")]: "(",
    [$.Localize("#Valve_ButtonCodeName_MAIL")]: "邮件",
    [$.Localize("#Valve_ButtonCodeName_MEDIASELECT")]: "媒体选择",
    [$.Localize("#Valve_ButtonCodeName_MODE")]: "模式",
    [$.Localize("#Valve_ButtonCodeName_MUTE")]: "静音",
    [$.Localize("#Valve_ButtonCodeName_OPER")]: "Oper",
    [$.Localize("#Valve_ButtonCodeName_OUT")]: "Out",
    [$.Localize("#Valve_ButtonCodeName_PASTE")]: "粘贴",
    [$.Localize("#Valve_ButtonCodeName_PERCENT")]: "%",
    [$.Localize("#Valve_ButtonCodeName_PLUS")]: "+",
    [$.Localize("#Valve_ButtonCodeName_POWER")]: "电源",
    [$.Localize("#Valve_ButtonCodeName_PRINTSCREEN")]: "printscreen",
    [$.Localize("#Valve_ButtonCodeName_PRIOR")]: "Prior",
    [$.Localize("#Valve_ButtonCodeName_QUESTION")]: "?",
    [$.Localize("#Valve_ButtonCodeName_QUOTEDBL")]: "\"",
    [$.Localize("#Valve_ButtonCodeName_RETURN2")]: "回车 2",
    [$.Localize("#Valve_ButtonCodeName_RIGHTPAREN")]: ")",
    [$.Localize("#Valve_ButtonCodeName_SELECT")]: "选择",
    [$.Localize("#Valve_ButtonCodeName_SEPARATOR")]: "分隔符",
    [$.Localize("#Valve_ButtonCodeName_SLEEP")]: "休眠",
    [$.Localize("#Valve_ButtonCodeName_STOP")]: "停止",
    [$.Localize("#Valve_ButtonCodeName_SYSREQ")]: "SysReq",
    [$.Localize("#Valve_ButtonCodeName_THOUSANDSSEPARATOR")]: "千位分隔符",
    [$.Localize("#Valve_ButtonCodeName_UNDERSCORE")]: "_",
    [$.Localize("#Valve_ButtonCodeName_UNDO")]: "撤消",
    [$.Localize("#Valve_ButtonCodeName_VOLUMEDOWN")]: "降低音量",
    [$.Localize("#Valve_ButtonCodeName_VOLUMEUP")]: "提高音量",
    [$.Localize("#Valve_ButtonCodeName_WWW")]: "WWW",
    [$.Localize("#Valve_ButtonCodeName_INVERTED_EXCLAMATION_MARK")]: "¡",
    [$.Localize("#Valve_ButtonCodeName_CENT_SIGN")]: "¢",
    [$.Localize("#Valve_ButtonCodeName_POUND_SIGN")]: "£",
    [$.Localize("#Valve_ButtonCodeName_CURRENCY_SIGN")]: "¤",
    [$.Localize("#Valve_ButtonCodeName_YEN_SIGN")]: "¥",
    [$.Localize("#Valve_ButtonCodeName_BROKEN_BAR")]: "¦",
    [$.Localize("#Valve_ButtonCodeName_SECTION_SIGN")]: "§",
    [$.Localize("#Valve_ButtonCodeName_DIAERESIS")]: "¨",
    [$.Localize("#Valve_ButtonCodeName_COPYRIGHT_SIGN")]: "©",
    [$.Localize("#Valve_ButtonCodeName_FEMININE_ORDINAL_INDICATOR")]: "ª",
    [$.Localize("#Valve_ButtonCodeName_LEFT_POINTING_DOUBLE_ANGLE_QUOTATION_MARK")]: "«",
    [$.Localize("#Valve_ButtonCodeName_NOT_SIGN")]: "¬",
    [$.Localize("#Valve_ButtonCodeName_REGISTERED_SIGN")]: "®",
    [$.Localize("#Valve_ButtonCodeName_MACRON")]: "¯",
    [$.Localize("#Valve_ButtonCodeName_DEGREE_SYMBOL")]: "°",
    [$.Localize("#Valve_ButtonCodeName_PLUS_MINUS_SIGN")]: "±",
    [$.Localize("#Valve_ButtonCodeName_SUPERSCRIPT_TWO")]: "²",
    [$.Localize("#Valve_ButtonCodeName_SUPERSCRIPT_THREE")]: "³",
    [$.Localize("#Valve_ButtonCodeName_ACUTE_ACCENT")]: "´",
    [$.Localize("#Valve_ButtonCodeName_MICRO_SIGN")]: "µ",
    [$.Localize("#Valve_ButtonCodeName_PILCROW_SIGN")]: "¶",
    [$.Localize("#Valve_ButtonCodeName_MIDDLE_DOT")]: "·",
    [$.Localize("#Valve_ButtonCodeName_CEDILLA")]: "¸",
    [$.Localize("#Valve_ButtonCodeName_SUPERSCRIPT_ONE")]: "¹",
    [$.Localize("#Valve_ButtonCodeName_MASCULINE_ORDINAL_INDICATOR")]: "º",
    [$.Localize("#Valve_ButtonCodeName_RIGHT_POINTING_DOUBLE_ANGLE_QUOTATION_MARK")]: "»",
    [$.Localize("#Valve_ButtonCodeName_VULGAR_FRACTION_ONE_QUARTER")]: "¼",
    [$.Localize("#Valve_ButtonCodeName_VULGAR_FRACTION_ONE_HALF")]: "½",
    [$.Localize("#Valve_ButtonCodeName_VULGAR_FRACTION_THREE_QUARTERS")]: "¾",
    [$.Localize("#Valve_ButtonCodeName_INVERTED_QUESTION_MARK")]: "¿",
    [$.Localize("#Valve_ButtonCodeName_MULTIPLICATION_SIGN")]: "×",
    [$.Localize("#Valve_ButtonCodeName_SHARP_S")]: "ß",
    [$.Localize("#Valve_ButtonCodeName_A_WITH_GRAVE")]: "À",
    [$.Localize("#Valve_ButtonCodeName_A_WITH_ACUTE")]: "Á",
    [$.Localize("#Valve_ButtonCodeName_A_WITH_CIRCUMFLEX")]: "Â",
    [$.Localize("#Valve_ButtonCodeName_A_WITH_TILDE")]: "Ã",
    [$.Localize("#Valve_ButtonCodeName_A_WITH_DIAERESIS")]: "Ä",
    [$.Localize("#Valve_ButtonCodeName_A_WITH_RING_ABOVE")]: "Å",
    [$.Localize("#Valve_ButtonCodeName_AE")]: "Æ",
    [$.Localize("#Valve_ButtonCodeName_C_WITH_CEDILLA")]: "Ç",
    [$.Localize("#Valve_ButtonCodeName_E_WITH_GRAVE")]: "È",
    [$.Localize("#Valve_ButtonCodeName_E_WITH_ACUTE")]: "É",
    [$.Localize("#Valve_ButtonCodeName_E_WITH_CIRCUMFLEX")]: "Ê",
    [$.Localize("#Valve_ButtonCodeName_E_WITH_DIAERESIS")]: "Ë",
    [$.Localize("#Valve_ButtonCodeName_I_WITH_GRAVE")]: "Ì",
    [$.Localize("#Valve_ButtonCodeName_I_WITH_ACUTE")]: "Í",
    [$.Localize("#Valve_ButtonCodeName_I_WITH_CIRCUMFLEX")]: "Î",
    [$.Localize("#Valve_ButtonCodeName_I_WITH_DIAERESIS")]: "Ï",
    [$.Localize("#Valve_ButtonCodeName_ETH")]: "Ð",
    [$.Localize("#Valve_ButtonCodeName_N_WITH_TILDE")]: "Ñ",
    [$.Localize("#Valve_ButtonCodeName_O_WITH_GRAVE")]: "Ò",
    [$.Localize("#Valve_ButtonCodeName_O_WITH_ACUTE")]: "Ó",
    [$.Localize("#Valve_ButtonCodeName_O_WITH_CIRCUMFLEX")]: "Ô",
    [$.Localize("#Valve_ButtonCodeName_O_WITH_TILDE")]: "Õ",
    [$.Localize("#Valve_ButtonCodeName_O_WITH_DIAERESIS")]: "Ö",
    [$.Localize("#Valve_ButtonCodeName_DIVISION_SIGN")]: "÷",
    [$.Localize("#Valve_ButtonCodeName_O_WITH_STROKE")]: "Ø",
    [$.Localize("#Valve_ButtonCodeName_U_WITH_GRAVE")]: "Ù",
    [$.Localize("#Valve_ButtonCodeName_U_WITH_ACUTE")]: "Ú",
    [$.Localize("#Valve_ButtonCodeName_U_WITH_CIRCUMFLEX")]: "Û",
    [$.Localize("#Valve_ButtonCodeName_U_WITH_DIAERESIS")]: "Ü",
    [$.Localize("#Valve_ButtonCodeName_Y_WITH_ACUTE")]: "Ý",
    [$.Localize("#Valve_ButtonCodeName_THORN")]: "Þ",
    [$.Localize("#Valve_ButtonCodeName_Y_WITH_DIAERESIS")]: "Ÿ",
    [$.Localize("#Valve_ButtonCodeName_EURO_SIGN")]: "€",
    [$.Localize("#Valve_ButtonCodeName_TILDE")]: "~",
    [$.Localize("#Valve_ButtonCodeName_LEFT_CURLY_BRACKET")]: "{",
    [$.Localize("#Valve_ButtonCodeName_RIGHT_CURLY_BRACKET")]: "}",
    [$.Localize("#Valve_ButtonCodeName_VERTICAL_BAR")]: "|",
    [$.Localize("#Valve_ButtonCodeName_KEY_CYRILLIC_YU")]: "Ю",
    [$.Localize("#Valve_ButtonCodeName_KEY_CYRILLIC_E")]: "Э",
    [$.Localize("#Valve_ButtonCodeName_KEY_CYRILLIC_HARD_SIGN")]: "Ъ",
    [$.Localize("#Valve_ButtonCodeName_KEY_CYRILLIC_HA")]: "Х",
    [$.Localize("#Valve_ButtonCodeName_KEY_CYRILLIC_IO")]: "Ё",
    [$.Localize("#Valve_ButtonCodeName_KEY_CYRILLIC_ZHE")]: "Ж",
    [$.Localize("#Valve_ButtonCodeName_KEY_CYRILLIC_BE")]: "Б",
    [$.Localize("#Valve_ButtonCodeName_NONUSHASH")]: "#",
    [$.Localize("#Valve_ButtonCodeName_NONUSBACKSLASH")]: "\\",
    [$.Localize("#Valve_ButtonCodeName_MENU")]: "菜单",
    [$.Localize("#Valve_ButtonCodeName_MOUSE1")]: "mouse1",
    [$.Localize("#Valve_ButtonCodeName_MOUSE2")]: "mouse2",
    [$.Localize("#Valve_ButtonCodeName_MOUSE3")]: "mouse3",
    [$.Localize("#Valve_ButtonCodeName_MOUSE4")]: "mouse4",
    [$.Localize("#Valve_ButtonCodeName_MOUSE5")]: "mouse5",
    [$.Localize("#Valve_ButtonCodeName_MWHEELUP")]: "mwheelup",
    [$.Localize("#Valve_ButtonCodeName_MWHEELDOWN")]: "mwheeldown",
};
var tools;
(function (tools) {
    var Keybinds_1;
    let Keybinds = Keybinds_1 = class Keybinds {
        static Init(bReload) {
            tools.EventManager.Reg('ON_LOAD_XML', ({ sEnvName, bReload }) => {
                if (bReload && sEnvName != Keybinds_1.sEnvName) {
                    Keybinds_1.UnbindByEnv(sEnvName);
                    for (const sKeyName in Keybinds_1.tCallback) {
                        for (const sCommand in Keybinds_1.tCallback[sKeyName].commands) {
                            Keybinds_1._CreateCommand(sKeyName, sCommand, true);
                        }
                    }
                }
            });
            if (bReload) {
                for (const sKeyName in Keybinds_1.tCallback) {
                    for (const sCommand in Keybinds_1.tCallback[sKeyName].commands) {
                        Keybinds_1._CreateCommand(sKeyName, sCommand, true);
                    }
                }
            }
        }
        static Bind(sKeyName, type, func, bindKey = (++Keybinds_1.iBindID)) {
            let sCommand;
            if (type == 1) {
                sCommand = '+' + sKeyName;
            }
            else if (type == 2) {
                sCommand = '-' + sKeyName;
            }
            else {
                return bindKey;
            }
            if (undefined == Keybinds_1.tCallback[sKeyName] || undefined == Keybinds_1.tCallback[sKeyName].commands[sCommand]) {
                Keybinds_1._CreateCommand(sKeyName, sCommand);
            }
            Keybinds_1.tCallback[sKeyName].commands[sCommand][bindKey] = {
                func: func,
                sEnvName: this.sEnvName,
            };
            return bindKey;
        }
        static Unbind(bindKey, sKeyName) {
            if (sKeyName != undefined) {
                if (Keybinds_1.tCallback[sKeyName] != undefined) {
                    for (const sCommand in Keybinds_1.tCallback[sKeyName].commands) {
                        delete Keybinds_1.tCallback[sKeyName].commands[sCommand][bindKey];
                    }
                }
            }
            else {
                for (const sKeyName in Keybinds_1.tCallback) {
                    for (const sCommand in Keybinds_1.tCallback[sKeyName].commands) {
                        delete Keybinds_1.tCallback[sKeyName].commands[sCommand][bindKey];
                    }
                }
            }
        }
        static GetKeyNameForCommand(iCommand) {
            var _a;
            const s = Game.GetKeybindForCommand(iCommand);
            return ((_a = Command2KeyName[s]) !== null && _a !== void 0 ? _a : s);
        }
        static UnbindByEnv(sEnvName) {
            for (const sKeyName in Keybinds_1.tCallback) {
                for (const sCommand in Keybinds_1.tCallback[sKeyName].commands) {
                    for (const sBindKey in Keybinds_1.tCallback[sKeyName].commands[sCommand]) {
                        if (Keybinds_1.tCallback[sKeyName].commands[sCommand][sBindKey].sEnvName == sEnvName) {
                            delete Keybinds_1.tCallback[sKeyName].commands[sCommand][sBindKey];
                        }
                    }
                }
            }
        }
        static _Callback(sCommand) {
            const sKeyName = Keybinds_1._Key(sCommand);
            const tCommands = Keybinds_1.tCallback[sKeyName].commands[sCommand];
            for (const sBindKey in tCommands) {
                try {
                    tCommands[sBindKey].func();
                }
                catch (error) {
                    GameUI.CustomUIConfig().UploadError(error);
                }
            }
        }
        static _Key(sCommand) {
            if ('+' == sCommand[0] || '-' == sCommand[0]) {
                return sCommand.substring(1);
            }
            return sCommand;
        }
        static _CreateCommand(sKeyName, sCommand, bReload) {
            let sKeyCommonUID;
            if (Keybinds_1.tCallback[sKeyName] == undefined) {
                sKeyCommonUID = new Date().getTime().toString();
                Keybinds_1.tCallback[sKeyName] = {
                    uid: sKeyCommonUID,
                    commands: {}
                };
                Game.CreateCustomKeyBind(sKeyName, "+" + sKeyName + sKeyCommonUID);
            }
            else if (bReload) {
                sKeyCommonUID = new Date().getTime().toString();
                Keybinds_1.tCallback[sKeyName].uid = sKeyCommonUID;
                Game.CreateCustomKeyBind(sKeyName, "+" + sKeyName + sKeyCommonUID);
            }
            else {
                sKeyCommonUID = Keybinds_1.tCallback[sKeyName].uid;
            }
            if (Keybinds_1.tCallback[sKeyName].commands[sCommand] == undefined) {
                Keybinds_1.tCallback[sKeyName].commands[sCommand] = {};
            }
            Game.AddCommand(sCommand + sKeyCommonUID, () => {
                Keybinds_1._Callback(sCommand);
            }, '', 67108864);
        }
    };
    Keybinds.tCallback = {};
    Keybinds.iBindID = 0;
    Keybinds.sEnvName = $.GetContextPanel().layoutfile;
    Keybinds = Keybinds_1 = __decorate([
        reloadlock()
    ], Keybinds);
    tools.Keybinds = Keybinds;
    Keybinds.UnbindByEnv($.GetContextPanel().layoutfile);
})(tools || (tools = {}));
GameUI.CustomUIConfig().tools = tools;