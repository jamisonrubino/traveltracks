// function validateHhMm(inputField) {
//     var isValid = /^([0-1]?[0-9]|2[0-4]):([0-5][0-9])(:[0-5][0-9])?$/.test(inputField.val());
//     if (isValid) {
//         inputField.css("background", "#bfa");
//     } else {
//         inputField.css("background", "#fba");
//     }
// }
// var timeInput = $("#time_input");
// $(document).on("change", timeInput, validateHhMm(timeInput));

$(document).ready(function() {
    $("input#pool_genre").change(addHideGenres);
    $("input#pool_top_tracks").change(addHideGenres);
});

function addHideGenres() {
    if ($("input:radio[name=pool]#pool_genre").is(":checked")) {
        $("#genre-seeds").removeClass("hide");
    }
    if ($("input:radio[name=pool]#pool_top_tracks").is(":checked")) {
        $("#genre-seeds").addClass("hide");
    }
}

var genreNum = "two";
function addGenre() {
    $("#genre-seeds").append("<div class=\"genre\"><%= label_tag \"genre_seed_" + genreNum + "\", \"Music Genre\" %>");
    
    if (genreNum === "two") {   
        genreNum = "three";
    } else if (genreNum ==="three") {
        $("#add_genre").addClass("hide");
    }
}