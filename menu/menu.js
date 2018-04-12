/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

var url = "backadmin/menu/cmp_tree_menu.jsp";
$(function () {

    //alert('menu');
    buildMenu();
    $('.link-sub-menu').hover({
        //$(this).addClass('color-theme');
    });



});


function buildMenu()
{
    //alert('buildMenu')
    var task = "getAllMenu";
    $.get(url + "?task=" + task, function (json, textStatus) {
        var cpt = 0;
        //var obj = $.parseJSON(json);
        var obj = JSON.parse(json);
        $('#side_accordion').empty();
        if (obj[0].code_statut == "1")
        {
            var results = obj[0].results;
            if (obj[0].results.length > 0)
            {

                $.each(results, function (i, value)
                {
                    //partie de contruction du menu
                    var div_accordeon_group = $('<div class="accordion-group"></div>');
                    var div_accordeon_handing = $('<div class="accordion-heading"></div>');
                    var link_title_menu = $('<a href="#collapse' + i + '" data-parent="#side_accordion" data-toggle="collapse" class="accordion-toggle"></a>');
                    link_title_menu.addClass('link-title-menu');
                    var li_icon = $('<i class="icon-th" style=""></i>');
                    var string_menu = results[i].text;
                    link_title_menu.append(li_icon).append(' ').append(string_menu);
                    //link_title_menu.append(link_title_menu);


                    div_accordeon_handing.append(link_title_menu);
                    //alert(div_accordeon_handing.html())
                    //debut partie de contruction des sous-menus
                    var div_accordion_body = $('<div class="accordion-body collapse div-menu" id="collapse' + i + '"></div>');
                    var div_accordion_inner = $('<div class="accordion-inner"></div>');
                    var ul_nav_list = $('<ul class="nav nav-list"></ul>');
                    var data_sub_menu = results[i].children;
                    $.each(data_sub_menu, function (j, value)
                    {
                        var link_sub_menu = $('<a class="sub-menu-hover" href="javascript:void(0)" data-key-value="' + data_sub_menu[j].id + '"></a>');
                        link_sub_menu.attr('id', data_sub_menu[j].text);
                        link_sub_menu.addClass('link-sub-menu');
                        link_sub_menu.text(data_sub_menu[j].text);
                        var li_sub_menu = $('<li class="li-sub-menu"></li>');
                        li_sub_menu.append(link_sub_menu)
                        li_sub_menu.append(li_sub_menu);
                        ul_nav_list.append(li_sub_menu);
                    });

                    div_accordion_inner.append(ul_nav_list);


                    //fin partie de contruction des sous-menus

                    div_accordion_body.append(div_accordion_inner);

                    //ajout du titre du menu
                    div_accordeon_group.append(div_accordeon_handing);

                    //ajout des sous-menus
                    div_accordeon_group.append(div_accordion_body);

                    $('#side_accordion').append(div_accordeon_group);
                });
            }
        }
    });
}