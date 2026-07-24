--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


var dotaHud = $.GetContextPanel().GetParent().GetParent().GetParent().FindChildTraverse("AbilitiesAndStatBranch");
$.GetContextPanel().SetParent(dotaHud.FindChildrenWithClassTraverse("LeftRightFlow")[0]);

var dotaH = $.GetContextPanel().GetParent().GetParent().GetParent().GetParent().GetParent().GetParent()
var dota_neutral_shop_window = dotaH.FindChildTraverse("GridNeutralsCategory")
dota_neutral_shop_window.style.overflow = "squish scroll";


dotaHud.FindChildrenWithClassTraverse("LeftRightFlow")[0].MoveChildBefore($.GetContextPanel(),dotaHud.FindChildTraverse("StatBranch"))


Hack()


//rating1()

//rating()

//penalty()

function penalty()
{
	let avg_limit = 2.8
	let k = 0.06
	let c = 1.1
	let n = 4
	let min = 4

	let matches = 10
	let avg_place = 2
	let result = -1

	if (matches <= min || avg_place > avg_limit)
	{
		result = 0
	}else
	{
		let effectiveMatches = matches - n
		let thresh = avg_limit - c*Math.exp(-k*effectiveMatches)
	
		$.Msg(thresh,' ',  avg_place)

		if (avg_place < thresh)
		{
			result = 1
		}else
		{
			result = 0
		}
	}
	$.Msg(result)
}

function rating()
{

let ratings_places = [0, 40, 30, 10, -10, -30, -40]
let players = [0, 0,1200,1000,1800,1200,1300]
let player = 1

let place = 1
let self_rating = players[player]

let r_summ = 0

for (var i = 0; i <= 6; i++)
{
	r_summ = r_summ + players[i]
}

let avg = r_summ/6

let diff = self_rating - avg
let coef = 1


if ( Math.abs(diff) > 300)
{
  if (diff < 0)
  {
  	diff = Math.max( -650, diff )
  	diff = diff + 300
  }else
  {
  	diff = Math.min( 650, diff )
  	diff = diff - 300
  }

	if (place > 3)
  {
    coef = 1 + diff / 300 / 1.7
  }else
  {
    coef = 1 - diff / 300 / 1.7
  }
}

let r = Math.trunc( ratings_places[place] * coef )


$.Msg(self_rating,' ',Math.floor(avg),' ', diff,' ',coef, ' ---- ',r)

}



function median(values){
  values = [...values].sort(function(a,b){
    return a-b;
  })

  var half = Math.floor(values.length / 2)
  
  if (values.length % 2)
    return values[half]
  
  return (values[half - 1] + values[half]) / 2
}

function rating1()
{
	let players_rating = [1500,2000,2000,1250,750,1750]
	let self_id = 1
	let avg = (players_rating[0] + players_rating[1] + players_rating[2] + players_rating[3] + players_rating[4] + players_rating[5])/6

	let places = [-40,-30,-10,10,30,40]
	let p = 5

	$.Msg(players_rating[self_id],' ',median(players_rating),' ', places[p]*Math.min(Math.max(median(players_rating)/players_rating[self_id],0.25),2))
}


//\ma()
function ma()
{

let h = []

h[1] = 0
h[2] = 0

let n = 0
let n2 = 0

let timer = 20
let timer2 = 20



$.Msg('--------------------------------')

for (var i = 1; i < 30; i++)
{


	if (i > 1)
	{
		timer = 70
		timer2 = 70
	}

	if (i >= 6)
	{
		timer = 120
		timer2 = 120
	}	

	if (i >= 14)
	{
		timer = 180

	}
	if (i >= 13)
	{
		timer2 = 180
	}

	if (i >= 21)
	{
		timer = 180
		timer2 = 180
	}

	n = n + timer
	n2 = n2 + timer2

	let min1 = Math.floor(n/60)
	let sec1 = n - min1 * 60

	let min2 = Math.floor(n2/60)
	let sec2 = n2 - min2 * 60

	let ivent = "0"
	let wave_ivent = "0"

	if ((i == 5) || (i == 22))
	{
		wave_ivent = "boss"
	}

	if ((i == 18) || (i == 20))
	{
		wave_ivent = "siege"
	}

	if ((i >= 13) && (i % 2 != 0))
	{
		wave_ivent = "duel"
	}


	if ((i >= 5) && (i < 13))
	{
		ivent = "patrol 1"
	}

	if (i >= 13)
	{
		ivent = "patrol 2"
	}

	if ((i >= 12) && (i % 3 == 0))
	{
		ivent = "torment"
	}


	$.Msg(i,' ',min1,':',sec1,' --- ',min2,':',sec2,'   ',i,'   | ',wave_ivent,' + ',ivent,' | ')
}



}

//ma_3()
function ma_3()
{


let health1 = 3950

let health_up1 = 1.14

let health2 = 3300

let health_up2 = 1.12



$.Msg('--------------------------------')

for (var i = 8; i < 30; i++)
{
	if (i >= 10)
	{
		health_up1 = 1.10
		health_up2 = 1.09
	}	

	health1 = health1*health_up1
	health2 = health2*health_up2

	if (i % 3 == 0 && i >= 12)
		$.Msg(i,' ', Math.floor(health1), ' ', Math.floor(health2))
}



}


















function Hack()
{
	var parentHUDElements = $.GetContextPanel().GetParent().GetParent().GetParent().GetParent().GetParent().GetParent().GetParent().FindChild("HUDElements");
	var check_local = parentHUDElements.FindChildTraverse("center_block");
	var Button = dotaHud.FindChildrenWithClassTraverse("LeftRightFlow")[0].FindChildrenWithClassTraverse("MainUpgrades")[0]
 
    if (check_local.BHasClass("NonHero")) {
        Button.visible = false;
      
    } else {
    	  Button.visible = true;
    }
    $.Schedule(0.03, Hack)
}