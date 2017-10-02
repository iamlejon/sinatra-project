setTimeout(function(){
document.getElementById('loading').style.visibility = "hidden";
},7000);

setTimeout(function(){
document.getElementById('create').style.visibility = "visible";
},7000);

$('input.pikachu').on('click', function() {
    $('input.pikachu').prop('checked', $(this).is(':checked') );

});

$('input.charmander').on('click', function() {
    $('input.charmander').prop('checked', $(this).is(':checked') );

});

$('input.staryu').on('click', function() {
    $('input.staryu').prop('checked', $(this).is(':checked') );

});

$('input.squirtle').on('click', function() {
    $('input.squirtle').prop('checked', $(this).is(':checked') );

});

$('input.bulbasaur').on('click', function() {
    $('input.bulbasaur').prop('checked', $(this).is(':checked') );

});

$('input.eevee').on('click', function() {
    $('input.eevee').prop('checked', $(this).is(':checked') );

});

$('input.abra').on('click', function() {
    $('input.abra').prop('checked', $(this).is(':checked') );

});
