function mOvr(src,clrOver) 
{ 
    if (!src.contains(event.fromElement)) 
	{
		src.bgColor = clrOver;
	}
}

function mOut(src,clrIn) 
{
	if (!src.contains(event.toElement))
	{
		src.style.cursor = 'default'; src.bgColor = clrIn;
	}
}

if (document.all)    {n=0;ie=1;fShow="visible";fHide="hidden";}
if (document.layers) {n=1;ie=0;fShow="show";   fHide="hide";}

topY = 0;rightX = 0;bottomY = 0;leftX = 0;
lastMenu = null;
var mstyle;

function MenuStyle()
{
	this.bgColor     = "#ffffff";
	this.menuFont;
	this.menuFontIE  = "9pt";
	this.menuFontNS  = "9pt";

	this.clsMenuItemIE = "class=clsMenuItemIE";
	this.clsMenuItemNS = "class=clsMenuItemNS";

	this.mainMenuWidth = "100%";

	this.mainMenuBorder = 0;
	this.subMenuBorder  = 0;
	this.menuDelta = 1;

	this.subMenueWidth = 100;

	this.bMenuStatic = 0;

	this.TranslateStyle = TranslateStyle;
}

function TranslateStyle()
{
	if (n)  this.menuFont = this.menuFontNS;
	if (ie) this.menuFont = this.menuFontIE;
}


function Menu(ms)
{
	ms.TranslateStyle();
	mstyle = ms;

	this.addItem    = addItem;
	this.addSubItem = addSubItem;
	this.showMenu   = showMenu;
	this.displaySubMenu = displaySubMenu;


	HTMLstr = "";
	HTMLstr += "<!-- MENU PANE DECLARATION BEGINS -->\n";
	HTMLstr += "\n";

	HTMLstr += "<!-- MAIN MENU STARTS -->\n";
	HTMLstr += "<!-- MAIN_MENU -->\n";
	HTMLstr += "<!-- MAIN MENU ENDS -->\n";
	HTMLstr += "\n";
	HTMLstr += "<!-- SUB MENU STARTS -->\n";
	HTMLstr += "<!-- SUB_MENU -->\n";
	HTMLstr += "<!-- SUB MENU ENDS -->\n";
	HTMLstr += "\n";

	HTMLstr += "<!-- MENU PANE DECALARATION ENDS -->\n";
}

function addItem(idItem, text, hint, location, altLocation)
{
	var Lookup = "<!-- ITEM "+idItem+" -->";
	if (HTMLstr.indexOf(Lookup) != -1)
	{
		alert(idParent + " already exist");
		return;
	}
	var MENUitem = "";
	MENUitem += "\n<!-- ITEM "+idItem+" -->\n";
	if (ie)
	{
		MENUitem += "<a id='"+idItem+"'"+mstyle.clsMenuItemIE+" ";
		if (hint != null)
			MENUitem += "title=\""+hint+"\" ";
		if (location != null)
		{
			MENUitem += "href='"+location+"' ";
			MENUitem += "onmouseover=\"hideAll();\" ";
		}
		else
		{
			MENUitem += "href='#' ";
			MENUitem += "onmouseover=\"hideAll();displaySubMenu('"+idItem+"');this.style.cursor = 'hand';\" ";
			MENUitem += "onclick=\"return false;\" "
		}
		MENUitem += ">"+text+"</a>\n";
	}
	MENUitem += "<!-- END OF ITEM "+idItem+" -->\n\n";
	MENUitem += "<!-- MAIN_MENU -->\n";

	HTMLstr = HTMLstr.replace("<!-- MAIN_MENU -->\n", MENUitem);
}

function addSubItem(idParent, text, hint, location, frame)
{
	var MENUitem = "";
	Lookup = "<!-- ITEM "+idParent+" -->";
	if (HTMLstr.indexOf(Lookup) == -1)
	{
		alert(idParent + " not found");
		return;
	}
	Lookup = "<!-- NEXT ITEM OF SUB MENU "+ idParent +" -->";
	if (HTMLstr.indexOf(Lookup) == -1)
	{
		if (ie)
		{
			MENUitem += "\n";
			MENUitem += "<div id='"+idParent+"submenu' style='position:absolute; visibility: hidden; width: "+mstyle.subMenuWidth+"; font: "+mstyle.menuFont+"; top: -300;'>\n";
			MENUitem += "<table border='"+mstyle.subMenuBorder+"' bgcolor='"+mstyle.bgColor+"' width="+mstyle.subMenuWidth+">\n";
			MENUitem += "<!-- NEXT ITEM OF SUB MENU "+ idParent +" -->\n";
			MENUitem += "</table>\n";
			MENUitem += "</div>\n";
			MENUitem += "\n";
		}
		MENUitem += "<!-- SUB_MENU -->\n";
		HTMLstr = HTMLstr.replace("<!-- SUB_MENU -->\n", MENUitem);
	}

	if (location !=null)
	{
	  	MENUitem = "<tr><td class='menuLink' height='20'><a "+mstyle.clsMenuItemIE+" href='"+location+"'";
	  	if (hint!=null)  MENUitem += " title=\""+hint+"\"";
	  	if (frame!=null) MENUitem += " target='"+frame+"'";
	  	MENUitem += ">"+text+"</a></td></tr>\n";
	}
	else
	{
	  	MENUitem = "<tr><td height=1 bgcolor=#DDDDDD></td></tr>\n";
	}

	MENUitem += Lookup;
	HTMLstr = HTMLstr.replace(Lookup, MENUitem);
}

function showMenu()
{
	document.writeln(HTMLstr);
	//alert(HTMLstr);
	if (mstyle.bMenuStatic > 0) UpdateIt();
}

////////////////////////////////////////////////////////////////////////////
// Private declaration
function displaySubMenu(idMainMenu)
{
	var menu;
	var submenu;
	if (n)
	{
		submenu = document.layers[idMainMenu+"submenu"];
		smp = document.layers["SmartMenu"].document.layers["SmartMenuPane"];

		submenu.left = smp.document.layers[idMainMenu].pageX;
		submenu.top  = document.layers["SmartMenu"].pageY+smp.clip.height+3;
		submenu.visibility = fShow;

		leftX  = submenu.left;
		rightX = leftX + submenu.clip.width;

		topY    = document.layers["SmartMenu"].pageY;
		bottomY = topY+document.layers["SmartMenu"].clip.height+submenu.clip.height;
	} else if (ie) {
		menu = eval(idMainMenu);
		submenu = eval(idMainMenu+"submenu.style");
		smp = document.all["SmartMenu"];

		submenu.left = calculateSumOffset(menu, 'offsetLeft');
		submenu.top = calculateSumOffset(document.all["SmartMenu"], 'offsetTop')+smp.offsetHeight+mstyle.menuDelta;
		submenu.visibility = fShow;

		leftX  = document.all[idMainMenu+"submenu"].style.posLeft;
		rightX = leftX + document.all[idMainMenu+"submenu"].offsetWidth;

		topY    = document.all["SmartMenu"].offsetTop;
		bottomY = topY+document.all["SmartMenu"].offsetHeight+
				document.all[idMainMenu+"submenu"].offsetHeight;
	}
	lastMenu = submenu;
}

function hideAll()
{
	if (lastMenu != null) {lastMenu.visibility = fHide;lastMenu.left = 0;}
}

function calculateSumOffset(idItem, offsetName)
{
	var totalOffset = 0;
	var item = eval('idItem');
	do
	{
		totalOffset += eval('item.'+offsetName);
		item = eval('item.offsetParent');
	} while (item != null);
	return totalOffset;
}

function updateIt(e)
{
	if (ie)
	{
		var x = window.event.clientX;
		var y = window.event.clientY+document.body.scrollTop;

		if (x > rightX || x < leftX) hideAll();
		else if (y < topY || y > bottomY+58) hideAll();
	}
	if (n)
	{
		var x = e.pageX;
		var y = e.pageY;

		if (x > rightX || x < leftX) hideAll();
		else if (y > bottomY || y < topY) hideAll();
	}
}

function UpdateIt()
{
  if (ie) document.all["SmartMenu"].style.top = document.body.scrollTop;
  if (n)  document.layers["SmartMenu"].top    = top.pageYOffset;
  setTimeout("UpdateIt()", 200);
}


if (document.all)
{
	//document.body.onclick=hideAll;
	//document.body.onscroll=hideAll;
	document.body.onmousemove=updateIt;
}
if (document.layers)
{
	document.onmousedown=hideAll;
	window.captureEvents(Event.MOUSEMOVE);
	window.onmousemove=updateIt;
}