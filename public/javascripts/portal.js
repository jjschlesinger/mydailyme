// Copyright (c) 2006 Nicolas Schmitt (nicolas.schmitt@gmail.com)
// 
// Permission is hereby granted, free of charge, to any person obtaining
// a copy of this software and associated documentation files (the
// "Software"), to deal in the Software without restriction, including
// without limitation the rights to use, copy, modify, merge, publish,
// distribute, sublicense, and/or sell copies of the Software, and to
// permit persons to whom the Software is furnished to do so, subject to
// the following conditions:
// 
// The above copyright notice and this permission notice shall be
// included in all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
// EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
// MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
// NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
// LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
// OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
// WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.


Sortable.onEmptyHover = function(element, dropon) {
    var d = Sortable.options(dropon);
    if(element.parentNode!=dropon) {
        var oldParentNode = element.parentNode;
        dropon.appendChild(element);
        Sortable.options(oldParentNode).onChange(element);
        d.onChange(element);
    }
    Droppables.activate(d);
}

/*function initportal() {
    try {
        Sortable.create('leftcontent', {tag:'div', handle:'meTitle', hoverclass:'dragover', dropOnEmpty:true, constraint:false, containment:["leftcontent", "centercontent", "rightcontent"]});
        Sortable.create('centercontent', {tag:'div', handle:'meTitle', hoverclass:'dragover', dropOnEmpty:true, constraint:false, containment:["leftcontent", "centercontent", "rightcontent"]});
        Sortable.create('rightcontent', {tag:'div', handle:'meTitle', hoverclass:'dragover', dropOnEmpty:true, constraint:false, containment:["leftcontent", "centercontent", "rightcontent"]});
    } catch (e) {
        alert(e);
    }
}

Event.observe(window, "load", initportal, false);
*/

function show_hide(id)
{
    var tmp = document.getElementById(id).style.display;
    if(tmp == 'none')
    {
        document.getElementById(id).style.display = 'block';
        document.getElementById("img" + id).src = '/images/min.png';
    }
    else
    {
        document.getElementById(id).style.display = 'none';
        document.getElementById("img" + id).src = '/images/max.png';
    }
}

function resize(which, max) {
  var elem = document.getElementById(which);
  if (elem == undefined || elem == null) return false;
  if (max == undefined) max = 100;
  if (elem.width > elem.height) {
    if (elem.width > max) elem.width = max;
  } else {
    if (elem.height > max) elem.height = max;
  }
}
