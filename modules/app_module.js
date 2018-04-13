/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
var LG = '*******';
var MODE = '***45';
var label_text = '*****';
var label_text_param_1 = "*****";
var label_text_param_2 = "*****";
var label_text_param_3 = "*****";
var lg_USER_ID = "*****";

var nb_pagination_size = 20;
var default_nb_pagination_size_add_reference = 1000;
var nb_pagination_size_add_reference = 1000;
var default_nb_pagination_size = 20;

var str_Number = "50";
var str_Mobile_Phone = "99397034";
var dt_debut_paris_Date = "2009/10/1";
var int_debut_heure = "00:00";
var dt_fin_paris_Date = "2010/10/5";
var int_fin_heure = "00:00";
var actionclicked = "";
var url_get_content = "backadmin/modules/app_module.jsp";

$(function () {

    $("#side_accordion").on("click", "a.link-sub-menu", function (e) {
        e.preventDefault();
        //alert('dsfjqs');
        var key = $(this).data('keyValue');
        var result = doworkTreeflow(key);
        sessionStorage.setItem("menuIndex", getActionClicked());
        $("#contentwrapper").effect("clip", "50000000", function () {
            //$('#contentwrapper').empty();
        });

        $('#contentwrapper').addClass('loader');
        var url = url_get_content + "?key=" + key + "&result=" + result;
        $.ajax(url).done(function (html, status, jqxhr) {
            $('#contentwrapper').html(html);
            $('#contentwrapper').removeClass('loader');
            $("#contentwrapper").effect("slide", "slow");
        });
    });

});

function doworkTreeflow(Okey) {
    var result = Okey;
    // var red = 1;
    actionclicked = Okey;
    switch (Okey) {
        case "Motifs":
            result = 'ressourceshumaines/controle/motif/cmp_grid.html.jsp?search_value=ALL';
            break;
        default:
            result = '';
    }
    return result;
}

function getActionClicked() {
    return actionclicked;
}

function getActionButton() {
    var str_VALUE = sessionStorage.getItem("menuIndex");
    string_button = '';
    $.ajax({
        url: url_sousmenu_action, // La ressource ciblée
        type: 'POST', // Le type de la requête HTTP.
        data: 'str_VALUE=' + str_VALUE,
        dataType: 'text',
        success: function (response) {
            //alert(response)//;return;
            var obj = $.parseJSON(response);
            //alert(obj.length);
            if (obj.length > 0)
            {
                $.each(obj, function (i, value)//
                {
                    var btnLink = '<a data-action-btn="'+obj[i].str_NAME+'" class="brand" href="#"><i class="'+obj[i].str_ICON+'"></i><b class="caret"></b></a>';
                    string_button+=btnLink;                   
                });
            }
        }
    });
    //alert(string_button);
    return string_button;
}