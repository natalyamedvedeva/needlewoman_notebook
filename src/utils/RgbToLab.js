/**
* Returns c converted to xyzcolor.
* @param {rgbcolor} c should have fields R,G,B
* @return {xyzcolor} c converted to xyzcolor
*/

function rgbToXyz(c)
{
  // Based on http://www.easyrgb.com/index.php?X=MATH&H=02
  var R = ( c.R / 255 );
  var G = ( c.G / 255 );
  var B = ( c.B / 255 );

  if ( R > 0.04045 ) R = Math.pow(( ( R + 0.055 ) / 1.055 ),2.4);
  else               R = R / 12.92;
  if ( G > 0.04045 ) G = Math.pow(( ( G + 0.055 ) / 1.055 ),2.4);
  else               G = G / 12.92;
  if ( B > 0.04045 ) B = Math.pow(( ( B + 0.055 ) / 1.055 ), 2.4);
  else               B = B / 12.92;

  R *= 100;
  G *= 100;
  B *= 100;

  // Observer. = 2°, Illuminant = D65
  var X = R * 0.4124 + G * 0.3576 + B * 0.1805;
  var Y = R * 0.2126 + G * 0.7152 + B * 0.0722;
  var Z = R * 0.0193 + G * 0.1192 + B * 0.9505;
  return {'X' : X, 'Y' : Y, 'Z' : Z};
}

/**
* Returns c converted to labcolor.
* @param {xyzcolor} c should have fields X,Y,Z
* @return {labcolor} c converted to labcolor
*/
function xyzToLab(c)
{
  // Based on http://www.easyrgb.com/index.php?X=MATH&H=07
  var refY = 100.000;
  var refZ = 108.883;
  var refX = 95.047; // Observer= 2°, Illuminant= D65
  var Y = c.Y / refY;
  var Z = c.Z / refZ;
  var X = c.X / refX;
  if ( X > 0.008856 ) X = Math.pow(X, 1/3);
  else                X = ( 7.787 * X ) + ( 16 / 116 );
  if ( Y > 0.008856 ) Y = Math.pow(Y, 1/3);
  else                Y = ( 7.787 * Y ) + ( 16 / 116 );
  if ( Z > 0.008856 ) Z = Math.pow(Z, 1/3);
  else                Z = ( 7.787 * Z ) + ( 16 / 116 );
  var L = ( 116 * Y ) - 16;
  var a = 500 * ( X - Y );
  var b = 200 * ( Y - Z );
  return {'L' : L , 'a' : a, 'b' : b};
}

function hexStringToRgb(str) {
    var rStr = str.substring(1, 3);
    var gStr = str.substring(3, 5);
    var bStr = str.substring(5, 7);
    return {'R' : parseInt(rStr, 16), 'G' : parseInt(gStr, 16), 'B' : parseInt(bStr, 16)};
}

function rgbToLab(strColor) {
    return xyzToLab(rgbToXyz(hexStringToRgb(strColor)));
}

function isSimilar(c1, c2) {
    return (Math.pow(c1.L - c2.L, 2) + Math.pow(c1.a - c2.a, 2) + Math.pow(c1.b - c2.b, 2)) < 5.29;
}

function findSimilar(id, colors) {
    let color;
    colors.forEach(item => {
                       if (item.id === id) {
                            color = item;
                            return;
                       };
                   });
    let result = [];
    colors.forEach(item => {
                       if (isSimilar(item, color))
                            result.push({id: item.id});
                   });
    return result;
}

WorkerScript.onMessage = function(message) {
    var result = [];
    message.forEach(item => {
                     var lab = rgbToLab(item.rgb);
                     result.push({id: item.id, L: lab.L, a: lab.a, b: lab.b});
                 });
    WorkerScript.sendMessage({ reply: result });
}
