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
var toolbarBtn = [];

$(function () {
//    alert(toolbarBtn.length);
    $("#side_accordion").on("click", "a.link-sub-menu", function (e) {
        e.preventDefault();
        //alert('dsfjqs');
        var key = $(this).data('keyValue');
        var result = doworkTreeflow(key);
        //alert("actionclicked ==== "+actionclicked);
        sessionStorage.setItem("menuIndex", getActionClicked());
        $("#contentwrapper").effect("clip", "50000000", function () {
            //$('#contentwrapper').empty();
        });

        $('#contentwrapper').addClass('loader');
//        var url = url_get_content + "?key=" + key + "&result=" + result;
        var url = url_get_content + "?result=" + result;
        //alert("url === "+url)
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
    //alert(result+" Taille === "+result.length);
    return result;
}

function getActionClicked() {
    return actionclicked;
}

function getToolbarBtn() {
    return toolbarBtn;
}

function getActionButton() {
    var str_VALUE = sessionStorage.getItem("menuIndex");
    var myToolbarBtn  =  getToolbarBtn();
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
                $.each(obj, function (i, value)//<i class='" + LstTActions.get(i).getStrICON() + "'></i>
                {
                    //alert(obj[i].str_TEXT)
                    var btnLink = '<button type="button" class="btn span1 btn-block btn-sm background-color-theme-btn" id="modal_add" data-toggle="modal" href="modal_add"><i class="' + obj[i].str_ICON + ' icon-white"></i> ' + obj[i].str_TEXT + '</button>'
                    $("div.toolbar").append(btnLink);
                   /* var index = $.inArray(btnLink, myToolbarBtn);
                    if (index === -1) {
                        myToolbarBtn.push(btnLink);
                    }*//* else {
                        myToolbarBtn.splice(index, 1);
                        myToolbarBtn.push(btnLink);
                    }*/
                });
            }
        }
    });
}


function addFunctionalityOnTable() {
    $('#table-content tbody').on('click', 'tr', function () {
        var id = this.id;
        //alert(id);
        var index = $.inArray(id, selected);
        if (index === -1) {
            selected.push(id);
        } else {
            selected.splice(index, 1);
        }
        icon = $(this).find('td span i.icon');
        //icon = $(this).has('td span a i');
        icon.toggleClass('icon-white');
        $(this).toggleClass('selected');
        
    });
}