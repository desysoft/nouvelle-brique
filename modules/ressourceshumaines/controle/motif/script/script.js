/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
url = "backadmin/modules/ressourceshumaines/controle/motif/cmp_grid.jsp";
url_transaction = "backadmin/modules/ressourceshumaines/controle/motif/cmp_transaction.jsp";
url_sousmenu_action = "backadmin/modules/menuActions.jsp";
$(function () {
    loadDatatable("", "");
    var stringBtn = getActionButton();
    //alert(stringBtn);
    $("div.toolbar").html('<button type="button" class="span1 btn btn-block btn-sm background-color-theme-btn" id="modal_add" data-toggle="modal" href="modal_add">Ajouter</button>'+stringBtn);
    
    $('.btn[id="modal_add"]').click(function () {
        $('#add-form #str_NAME').val('');
        $('#add-form #str_DESCRIPTION').val('');
        $('.modal[id="modal_add"]').modal('show');
    });

    $('#add-form').submit(function (e) {
        e.preventDefault();
        var str_NAME = $('#add-form #str_NAME').val();
        var str_DESCRIPTION = $('#add-form #str_DESCRIPTION').val();
        addReason(str_NAME, str_DESCRIPTION);
    });


});

function addReason(str_NAME, str_DESCRIPTION) {
    $.ajax({
        url: url_transaction, // La ressource ciblée
        type: 'POST', // Le type de la requête HTTP.
        data: 'mode=create&str_NAME=' + str_NAME + '&str_DESCRIPTION=' + str_DESCRIPTION ,
        dataType: 'text',
        success: function (response) {
            //alert(response)//;return;
            var obj = $.parseJSON(response);
            //alert(obj); return;
            //var json = jQuery.parseJSON(data);
            if (obj.success == "1")
            {
                swal({
                    title: "Opération réussie!",
                    text: obj.msg,
                    type: "success",
                    confirmButtonText: "Ok"
                });
                $('.modal').modal('hide');
                //datatable.destroy();
                //getAllOffre("", "", "");
                //swal("Opération réussie!", obj[0].results, "success");
            } else {
                //alert(obj[0].results);
                swal({
                    title: "Echec de l'opéraion",
                    text: obj.msg,
                    type: "error",
                    confirmButtonText: "Ok"
                });
                $('.modal').modal('hide');
            }
        }
    });
}


function loadDatatable(search_value, lg_REASONS_ID) {
    //$("#table-content tbody").empty();
    //alert('loadDatatable')
    $('#table-content').DataTable({
        "language": {
            "lengthMenu": "Afficher _MENU_ enregistrements",
            "zeroRecords": "Aucune ligne trouvée",
            //"info": "Page _PAGE_ sur _PAGES_",
            "info": "Affichage des enregistrements _START_ &agrave; _END_ sur _TOTAL_ enregistrements",
            "infoEmpty": "Aucun enregistrement trouvé",
            "infoFiltered": "(filtr&eacute; de _MAX_ enregistrements au total)",
            "emptyTable": "Aucune donnée disponible dans le tableau",
            "search": "Recherche",
            "zeroRecords": "Aucun enregistrement &agrave; afficher",
            "paginate": {
                "first": "Premier",
                "last": "Dernier",
                "next": "Suivant",
                "previous": "Precedent"
            }
        },
        "ordering": false,
        "processing": true,
        "serverSide": true,
        fixedHeader: {
            header: true,
            footer: true
        },

        //"ajax": "backadmin/modules/ressourceshumaines/controle/motif/cmp_grid.jsp",
        "ajax": {
            "url": url + "?search_value=" + search_value + "&lg_REASONS_ID=" + lg_REASONS_ID,
            "type": "POST",
            dataFilter: function (data) {
                var json = jQuery.parseJSON(data);
                json.recordsTotal = json.recordsTotal;
                json.recordsFiltered = json.recordsFiltered;
                json.draw = json.draw;
                json.data = json.data;
                return JSON.stringify(json); // return JSON string
            }
            //"type": "GET"
        },"dom": '<"toolbar">frtip',
        "columns": [
            //{"data": "lg_REASONS_ID"},
            {"data": "str_NAME"},
            {"data": "str_DESCRIPTION"}/*,
             {"data": "str_STATUT"}*/
        ],"columnDefs": [ {
            "targets": -1,
            "data": null,
            "defaultContent": "<button>Click!</button>"
        } ]


    });
    
    
}

function loadDatatable_hold(search_value, lg_REASONS_ID) {
//$("#table-content tbody").empty();
//alert('loadDatatable')
    $('#table-content').DataTable({
        "processing": true,
        "serverSide": true,
        //"ajax": "backadmin/modules/ressourceshumaines/controle/motif/cmp_grid.jsp",
        "ajax": $.fn.dataTable.pipeline({
            "url": "backadmin/modules/ressourceshumaines/controle/motif/cmp_grid.jsp?search_value=" + search_value + "&lg_REASONS_ID=" + lg_REASONS_ID,
            pages: 5 // number of pages to cache
        }),
        "columns": [
            //{"data": "lg_REASONS_ID"},
            {"data": "str_NAME"},
            {"data": "str_DESCRIPTION"}/*,
             {"data": "str_STATUT"}*/
        ]


    });
}