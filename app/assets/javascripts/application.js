//------------------------------------------------------------------------------------------------

function element(blockId) {
  return document.getElementById(blockId);
}

function hasClass(ele, cls) {
  return ele.className.match(new RegExp('(\\s|^)' + cls + '(\\s|$)'));
}
function addClass(ele, cls) {
  if (!this.hasClass(ele, cls)) ele.className += " " + cls;
}
function removeClass(ele, cls) {
  if (hasClass(ele, cls)) {
    var reg = new RegExp('(\\s|^)' + cls + '(\\s|$)');
    ele.className = ele.className.replace(reg, ' ');
  }
}

//------------------------------------------------------------------------------------------------

function showElement(blockId) {
  var block = element(blockId);
  var currently_hidden = hasClass(block,'noshow');
  if (currently_hidden) {
    removeClass(block,'noshow')
  }
}

function hideElement(blockId) {
  var block = element(blockId);
  var currently_hidden = hasClass(block,'noshow');
  if (!currently_hidden) {
    addClass(block,'noshow')
  }
}

function flipElement(blockId) {
  var block = element(blockId);
  var currently_hidden = hasClass(block,'noshow');
  if (currently_hidden) {
    removeClass(block,'noshow')
  } else {
    addClass(block,'noshow')
  }
}

function flipBlock(blockId) {
  var block   = element(blockId);
  var block_t = element(blockId+'_t');
  var currently_hidden = hasClass(block,'noshow');
  if (currently_hidden) {
    removeClass(block,'noshow')
    if (block_t) {removeClass(block_t,'closed')}
  } else {
    addClass(block,'noshow')
    if (block_t) {addClass(block_t,'closed')}
  }
}
//------------------------------------------------------------------------------------------------
//------------------------------------------------------------------------------------------------

function goTo(curId,arr) {
  for (x in arr) {
    var cId = arr[x];
    var block = element(cId);
    var block_a = element(cId+'_a');
    if (block != null && block_a != null) {
      removeClass(block_a,'here');
    addClass(block,'noshow');
    }
  }
  var block = element(curId);
  var block_a = element(curId+'_a');
  var block_aa = element(curId+'_aa');
  addClass(block_a,'here');
  removeClass(block,'noshow');
}

//------------------------------------------------------------------------------------------------

var tabs_array = ['tab_00','tab_01','tab_02','tab_03','tab_04','tab_05','tab_06','tab_07','tab_08','tab_09','tab_10','tab_11','tab_12']
function changeTab(curId) {
  for (x in tabs_array) {
    var cId = tabs_array[x];
    var block = element(cId);
    var block_a = element(cId+'_a');
    var block_aa = element(cId+'_aa');
    if (block != null && block_a != null) {
      removeClass(block_a,'here');
	    if (block_aa != null) {removeClass(block_aa,'here');} // secondary tabs
    addClass(block,'noshow');
    }
  }
  var block = element(curId);
  var block_a = element(curId+'_a');
  var block_aa = element(curId+'_aa');
  addClass(block_a,'here');
  if (block_aa != null) {addClass(block_aa,'here');} // secondary tabs
  removeClass(block,'noshow');
}

//------------------------------------------------------------------------------------------------

var menus_array = ['menu_00','menu_01','menu_02','menu_03','menu_04','menu_05','menu_06','menu_07','menu_08','menu_09','menu_10','menu_11','menu_12']
function changeMenu(curId) {
  for (x in menus_array) {
    var cId = menus_array[x];
    var block = element(cId);
    var block_h = element(cId+'_h');
    if (block != null && block_h != null) {
      removeClass(block_h,'here');
    addClass(block,'noshow');
    }
  }
  var block = element(curId);
  var block_h = element(curId+'_h');
  addClass(block_h,'here');
  removeClass(block,'noshow');
}

//------------------------------------------------------------------------------------------------
