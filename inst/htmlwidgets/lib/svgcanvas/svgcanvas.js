// extract bits and pieces from NY Times svg_crowbar
//   https://github.com/NYTimes/svg-crowbar
window.svg_crowbar = function(svg){
  var prefix = {
    xmlns: "http://www.w3.org/2000/xmlns/",
    xlink: "http://www.w3.org/1999/xlink",
    svg: "http://www.w3.org/2000/svg"
  };

  var emptySvg = window.document.createElementNS(prefix.svg, 'svg');
  window.document.body.appendChild(emptySvg);
  var emptySvgDeclarationComputed = getComputedStyle(emptySvg);

  svg.setAttribute("version", "1.1");

  // removing attributes so they aren't doubled up
  svg.removeAttribute("xmlns");
  svg.removeAttribute("xlink");

  // These are needed for the svg
  if (!svg.hasAttributeNS(prefix.xmlns, "xmlns")) {
    svg.setAttributeNS(prefix.xmlns, "xmlns", prefix.svg);
  }

  if (!svg.hasAttributeNS(prefix.xmlns, "xmlns:xlink")) {
    svg.setAttributeNS(prefix.xmlns, "xmlns:xlink", prefix.xlink);
  }

  emptySvg.innerHTML = svg.innerHTML;

  setInlineStyles(emptySvg, emptySvgDeclarationComputed);

  window.document.body.removeChild(emptySvg);

  return emptySvg;


  function setInlineStyles(svg, emptySvgDeclarationComputed) {

    function explicitlySetStyle (element) {
      var cSSStyleDeclarationComputed = getComputedStyle(element);
      var i, len, key, value;
      var computedStyleStr = "";
      for (i=0, len=cSSStyleDeclarationComputed.length; i<len; i++) {
        key=cSSStyleDeclarationComputed[i];
        value=cSSStyleDeclarationComputed.getPropertyValue(key);
        if (value!==emptySvgDeclarationComputed.getPropertyValue(key)) {
          computedStyleStr+=key+":"+value+";";
        }
      }
      element.setAttribute('style', computedStyleStr);
    }
    function traverse(obj){
      var tree = [];
      tree.push(obj);
      visit(obj);
      function visit(node) {
        if (node && node.hasChildNodes()) {
          var child = node.firstChild;
          while (child) {
            if (child.nodeType === 1 && child.nodeName != 'SCRIPT'){
              tree.push(child);
              visit(child);
            }
            child = child.nextSibling;
          }
        }
      }
      return tree;
    }
    // hardcode computed css styles inside svg
    var allElements = traverse(svg);
    var i = allElements.length;
    while (i--){
      explicitlySetStyle(allElements[i]);
    }
  }

}

// our function to export as png
window.pngify = function( svg ){
  var cvs = document.createElement("canvas")
  cvs.width = svg.getBoundingClientRect().width
  cvs.height = svg.getBoundingClientRect().height

  //check for percentage height and width
  //  if so explicitly set height and width on svg as attributes
  if(svg.style.width) {
    svg.style.width = null
    svg.style.height = null
    svg.setAttribute("width",cvs.width)
    svg.setAttribute("height", cvs.height)
  }

  svg = svg_crowbar( svg );

  var ctx = cvs.getContext("2d")

  var datUrl

  try {
    ctx.drawSvg( svg.outerHTML, 0, 0 )
    //datUrl = cvs.toDataURL()
    //downloadFile( datUrl )
    return cvs;
  } catch(e) {
    console.log(["failed with error", e].join(' '));
  }

}