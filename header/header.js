/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
//var url = "backadmin/header/getallmodule.jsp";
$(function () {
    buildDropdownmenu();
    
    //setUserBloc();
});


function buildDropdownmenu() {
    var task = "getAllModule";
    var url = "backadmin/header/getallmodule.jsp"
    $.get(url + "?task=" + task, function (json, textStatus) {
        var cpt = 0;
        //var obj = $.parseJSON(json);
        var obj = JSON.parse(json);
        $('#mobile-nav').empty();
        if (obj[0].code_statut == "1")
        {
            var results = obj[0].results;
            if (obj[0].results.length > 0)
            {
                var li_menu_bar = $('<li class="dropdown"></li>');
                var li_content = $('<i class="icon-list-alt icon-white"></i>');
                var class_caret = $('<b class="caret"></b>');
                var link_title = $('<a data-toggle="dropdown" class="dropdown-toggle" href="#"></a>');
                link_title.append(li_content).append(' ').append('Modules').append(class_caret);

                li_menu_bar.append(link_title);
                var ul_content_module=$('<ul class="dropdown-menu">');
                $.each(results, function (i, value)
                {
                    var link_module = $('<a class="link-module-dropdown"></a>')
                    link_module.attr("href",results[i].link);
                    link_module.text(results[i].value);
                    var li_module_dropdown = $('<li></li>');
                    li_module_dropdown.append(link_module);
                    ul_content_module.append(li_module_dropdown);
                    li_menu_bar.append(ul_content_module)
                });
                $('#mobile-nav').append(li_menu_bar);
            }
        }
    });
}