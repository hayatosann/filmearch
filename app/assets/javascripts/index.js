var elem = document.getElementById('range');
var target = document.getElementById('value');
var rangeValue = function (elem, target) {
  return function(evt){
    target.innerHTML = elem.value;
  }
}
// elem.addEventListener('input', rangeValue(elem, target));
