--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


'use strict'; const require = GameUI.__require;

var libs = require('./libs.js');
var solid_utils = require('./solid_utils.js');

const INTELLIGENCE_CARDS = [{
  rarity: 1,
  className: "Rarity_3",
  amount: 20,
  title: "#HuntIntelligence_Rare"
}, {
  rarity: 2,
  className: "Rarity_4",
  amount: 50,
  title: "#HuntIntelligence_Epic"
}, {
  rarity: 3,
  className: "Rarity_5",
  amount: 100,
  title: "#HuntIntelligence_Legendary"
}];
const INTELLIGENCE_CURRENT = 105;
const INTELLIGENCE_LIMIT = 300;
const HuntIntelligenceHud = () => {
  const intelligence = solid_utils.createNetDataSignal("hunt_boss", "intelligence");
  const [dismissed, setDismissed] = libs.createSignal(false);
  const [displayedProgress, setDisplayedProgress] = libs.createSignal(0);
  const selectedRarity = libs.createMemo(() => intelligence()?.rarity ?? 0);
  const selectedCard = libs.createMemo(() => INTELLIGENCE_CARDS[selectedRarity() - 1] ?? INTELLIGENCE_CARDS[0]);
  const visible = libs.createMemo(() => selectedRarity() > 0 && !dismissed());
  let dismissSchedule;
  let progressStartSchedule;
  let progressTickSchedule;
  let netUpdateCount = 0;
  let rootMountCount = 0;
  const cancelSchedules = () => {
    if (dismissSchedule !== undefined) $.CancelScheduled(dismissSchedule);
    if (progressStartSchedule !== undefined) $.CancelScheduled(progressStartSchedule);
    if (progressTickSchedule !== undefined) $.CancelScheduled(progressTickSchedule);
    dismissSchedule = undefined;
    progressStartSchedule = undefined;
    progressTickSchedule = undefined;
  };
  libs.createEffect(() => {
    const data = intelligence();
    netUpdateCount++;
    console.log(`[HuntIntelligence] net update=${netUpdateCount} rarity=${data?.rarity ?? "undefined"}`);
    if (data === undefined) {
      cancelSchedules();
      return;
    }
    cancelSchedules();
    setDismissed(false);
    setDisplayedProgress(0);
    progressStartSchedule = $.Schedule(1.05, () => {
      progressStartSchedule = undefined;
      let step = 0;
      const tick = () => {
        step++;
        setDisplayedProgress(Math.min(INTELLIGENCE_CURRENT, Math.floor(INTELLIGENCE_CURRENT * step / 14)));
        if (step < 14) progressTickSchedule = $.Schedule(0.05, tick);
      };
      tick();
    });
    dismissSchedule = $.Schedule(5, () => {
      dismissSchedule = undefined;
      console.log("[HuntIntelligence] auto dismiss");
      setDismissed(true);
    });
  });
  libs.createEffect(() => {
    console.log(`[HuntIntelligence] visible=${visible()}`);
  });
  libs.onCleanup(() => {
    cancelSchedules();
  });
  const HuntIntelligenceDisplay = () => {
    const mountIndex = ++rootMountCount;
    libs.onMount(() => {
      console.log(`[HuntIntelligence] root mounted=${mountIndex} rarity=${selectedRarity()}`);
    });
    libs.onCleanup(() => {
      console.log(`[HuntIntelligence] root unmounted=${mountIndex}`);
    });
    return (() => {
      const _el$ = libs.createElement("Panel", {
          id: "HuntIntelligenceRoot",
          hittest: false
        }, null),
        _el$2 = libs.createElement("Panel", {
          id: "HuntIntelligenceContent",
          hittest: false
        }, _el$),
        _el$3 = libs.createElement("Panel", {
          id: "CardMain",
          hittest: false
        }, _el$2);
        libs.createElement("Panel", {
          id: "RarityBG",
          hittest: false
        }, _el$3);
        const _el$5 = libs.createElement("Panel", {
          id: "HuntIntelligenceCardText",
          hittest: false
        }, _el$3),
        _el$6 = libs.createElement("Label", {
          "class": "HuntIntelligenceCardRarity",
          get text() {
            return GetLocalization(selectedCard().title);
          }
        }, _el$5),
        _el$7 = libs.createElement("Label", {
          "class": "HuntIntelligenceCardAmount",
          get text() {
            return LocalizeWithVars("#HuntIntelligence_Amount", {
              amount: selectedCard().amount
            });
          }
        }, _el$5),
        _el$8 = libs.createElement("Label", {
          "class": "HuntIntelligenceCardState",
          get text() {
            return GetLocalization("#HuntIntelligence_Obtained");
          }
        }, _el$5),
        _el$9 = libs.createElement("Panel", {
          id: "HuntIntelligenceProgress"
        }, _el$2),
        _el$0 = libs.createElement("Panel", {
          id: "HuntIntelligenceProgressTrack"
        }, _el$9),
        _el$1 = libs.createElement("Panel", {
          id: "HuntIntelligenceProgressFill",
          get style() {
            return {
              width: `${displayedProgress() / INTELLIGENCE_LIMIT * 100}%`
            };
          }
        }, _el$0),
        _el$10 = libs.createElement("Label", {
          id: "HuntIntelligenceProgressValue",
          get text() {
            return `${displayedProgress()} / ${INTELLIGENCE_LIMIT}`;
          }
        }, _el$9);
      libs.effect(_p$ => {
        const _v$ = {
            [selectedCard().className]: true
          },
          _v$2 = GetLocalization(selectedCard().title),
          _v$3 = LocalizeWithVars("#HuntIntelligence_Amount", {
            amount: selectedCard().amount
          }),
          _v$4 = GetLocalization("#HuntIntelligence_Obtained"),
          _v$5 = {
            width: `${displayedProgress() / INTELLIGENCE_LIMIT * 100}%`
          },
          _v$6 = `${displayedProgress()} / ${INTELLIGENCE_LIMIT}`;
        _v$ !== _p$._v$ && (_p$._v$ = libs.setProp(_el$3, "classList", _v$, _p$._v$));
        _v$2 !== _p$._v$2 && (_p$._v$2 = libs.setProp(_el$6, "text", _v$2, _p$._v$2));
        _v$3 !== _p$._v$3 && (_p$._v$3 = libs.setProp(_el$7, "text", _v$3, _p$._v$3));
        _v$4 !== _p$._v$4 && (_p$._v$4 = libs.setProp(_el$8, "text", _v$4, _p$._v$4));
        _v$5 !== _p$._v$5 && (_p$._v$5 = libs.setProp(_el$1, "style", _v$5, _p$._v$5));
        _v$6 !== _p$._v$6 && (_p$._v$6 = libs.setProp(_el$10, "text", _v$6, _p$._v$6));
        return _p$;
      }, {
        _v$: undefined,
        _v$2: undefined,
        _v$3: undefined,
        _v$4: undefined,
        _v$5: undefined,
        _v$6: undefined
      });
      return _el$;
    })();
  };
  return libs.createComponent(libs.Show, {
    get when() {
      return visible();
    },
    get children() {
      return libs.createComponent(HuntIntelligenceDisplay, {});
    }
  });
};
libs.render(() => libs.createComponent(HuntIntelligenceHud, {}), $.GetContextPanel());