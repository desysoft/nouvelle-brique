/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
url = "backadmin/modules/ressourceshumaines/controle/motif/cmp_grid.jsp";
url_transaction = "backadmin/modules/ressourceshumaines/controle/motif/cmp_transaction.jsp";
url_sousmenu_action = "backadmin/modules/menuActions.jsp";
var selected = [];
var table;
$(function () {

    loadDatatable("", "");
    addFunctionalityOnTable("");
    getActionButton();

    $('div.toolbar').on("click", "button[id='modal_add']", function (e) {
        e.preventDefault();
        $('#add-form #str_NAME').val('');
        $('#add-form #str_DESCRIPTION').val('');
        $('.modal[id="modal_add"]').modal('show');
    });


    $('table#table-content').on("click", "a.link-btn-action", function (e) {
        e.preventDefault();
        var handler = $(this).data('actionHandler');

        var id = $(this).data('actionId');
        var tr = $(this).parent().parent().parent();
        switch (handler) {
            case "editer":
                getReasonById(id);
                $('.modal[id="modal_edit"]').modal('show');
                break;
                
            case "supprimer":
                
                swal({
                    title: 'Demande de Confirmation',
                    text: "Etes-vous s\373r de vouloir supprimer cette donn\351e?'",
                    type: 'warning',
                    showCancelButton: true,
                    confirmButtonColor: '#3085d6',
                    cancelButtonColor: '#d33',
                    confirmButtonText: 'Oui',
                    cancelButtonText: 'Non',
                    confirmButtonClass: 'btn btn-success',
                    cancelButtonClass: 'btn btn-danger',
                    buttonsStyling: false,
                    closeOnConfirm: false,
                    closeOnCancel: false
                },
                        function (isConfirm) {
                            if (isConfirm) {
                                deleteReason("84101865626466668945");
                            } else {
                                swal(
                                        'Annulation',
                                        'Op\351ration annul\351e',
                                        'error'
                                        );
                            }
                        });
                        
                break;
        }
    });


    $('#add-form').submit(function (e) {
        e.preventDefault();
        var str_NAME = $('#add-form #str_NAME').val();
        var str_DESCRIPTION = $('#add-form #str_DESCRIPTION').val();
        addReason(str_NAME, str_DESCRIPTION);
    });

    $('#edit-form').submit(function (e) {
        e.preventDefault();
        var lg_REASONS_ID = $('#add-form #lg_REASONS_ID').val();
        var str_NAME = $('#add-form #str_NAME').val();
        var str_DESCRIPTION = $('#add-form #str_DESCRIPTION').val();
        editReason(lg_REASONS_ID, str_NAME, str_DESCRIPTION);
    });
});


function getReasonById(lg_REASONS_ID)
{
    //alert(lg_OFFRE_ID);
    var task = "getAllLicence";
    $.get(url + "?draw=1&lg_REASONS_ID=" + lg_REASONS_ID, function (json, textStatus)
    {
        var obj = $.parseJSON(json);
        if (obj.recordsTotal == "1")
        {

            var results = obj.data;
            if (results.length > 0)
            {
                $.each(results, function (i, value)
                {
                    $('#modal_edit #str_NAME').val(results[i].str_NAME);
                    $('#modal_edit #str_DESCRIPTION').val(results[i].str_DESCRIPTION);
                    $('#modal_edit #lg_REASONS_ID').val(results[i].DT_RowId);

                });
            }
        }
    });
}


function showFormEdit() {

}

function addReason(str_NAME, str_DESCRIPTION) {
    $.ajax({
        url: url_transaction, // La ressource cibl\351e
        type: 'POST', // Le type de la requête HTTP.
        data: 'mode=create&str_NAME=' + str_NAME + '&str_DESCRIPTION=' + str_DESCRIPTION,
        dataType: 'text',
        success: function (response) {
            //alert(response)//;return;
            var obj = $.parseJSON(response);
            //alert(obj); return;
            //var json = jQuery.parseJSON(data);
            if (obj.success == "1")
            {
                swal({
                    title: "Op\351ration r\351ussie!",
                    text: obj.msg,
                    type: "success",
                    confirmButtonText: "Ok"
                });
                $('.modal').modal('hide');
                loadDatatable("","");
            } else {
                //alert(obj[0].results);
                swal({
                    title: "Echec de l'op\351raion",
                    text: obj.msg,
                    type: "error",
                    confirmButtonText: "Ok"
                });
                $('.modal').modal('hide');
            }
        }
    });
}


function editReason(lg_REASONS_ID, str_NAME, str_DESCRIPTION) {
    $.ajax({
        url: url_transaction, // La ressource cibl\351e
        type: 'POST', // Le type de la requête HTTP.
        data: 'mode=update&lg_REASONS_ID=' + lg_REASONS_ID + '&str_NAME=' + str_NAME + '&str_DESCRIPTION=' + str_DESCRIPTION,
        dataType: 'text',
        success: function (response) {
            //alert(response)//;return;
            var obj = $.parseJSON(response);
            //alert(obj); return;
            //var json = jQuery.parseJSON(data);
            if (obj.success == "1")
            {
                swal({
                    title: "Op\351ration r\351ussie!",
                    text: obj.msg,
                    type: "success",
                    confirmButtonText: "Ok"
                });
                $('.modal').modal('hide');
                loadDatatable("","");
            } else {
                //alert(obj[0].results);
                swal({
                    title: "Echec de l'op\351raion",
                    text: obj.msg,
                    type: "error",
                    confirmButtonText: "Ok"
                });
                $('.modal').modal('hide');
            }
        }
    });
}

function deleteReason(lg_REASONS_ID) {
    $.ajax({
        url: url_transaction, // La ressource cibl\351e
        type: 'POST', // Le type de la requête HTTP.
        data: 'mode=delete&lg_REASONS_ID=' + lg_REASONS_ID,
        dataType: 'text',
        success: function (response) {
            //alert(response)//;return;
            var obj = $.parseJSON(response);
            if (obj.success == "1")
            {
                swal({
                    title: "Op\351ration r\351ussie!",
                    text: obj.msg,
                    type: "success",
                    confirmButtonText: "Ok"
                });
                $('.modal').modal('hide');
                loadDatatable("","");
            } else {
                //alert(obj[0].results);
                swal({
                    title: "Echec de l'op\351raion",
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
    var str_VALUE = sessionStorage.getItem("menuIndex");
//    alert(str_VALUE);
    table = $('#table-content').DataTable({
        "language": {
            "lengthMenu": "Afficher _MENU_ enregistrements",
            "zeroRecords": "Aucune ligne trouv\351e",
            //"info": "Page _PAGE_ sur _PAGES_",
            "info": "Affichage des enregistrements _START_ &agrave; _END_ sur _TOTAL_ enregistrements",
            "infoEmpty": "Aucun enregistrement trouv\351",
            "infoFiltered": "(filtr&eacute; de _MAX_ enregistrements au total)",
            "emptyTable": "Aucune donn\351e disponible dans le tableau",
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
        "pageLength": default_nb_pagination_size,

        //"ajax": "backadmin/modules/ressourceshumaines/controle/motif/cmp_grid.jsp",
        "ajax": {
            "url": url + "?search_value=" + search_value + "&lg_REASONS_ID=" + lg_REASONS_ID + "&str_VALUE=" + str_VALUE,
            "type": "POST",
            "data": function (d) {
                //d.length = default_nb_pagination_size;
                // d.custom = $('#myInput').val();
                // etc
            },
            dataFilter: function (data) {
                var json = jQuery.parseJSON(data);
                json.recordsTotal = json.recordsTotal;
                json.recordsFiltered = json.recordsFiltered;
                json.draw = json.draw;
                json.data = json.data;
                return JSON.stringify(json); // return JSON string
            }
            //"type": "GET"
        },
        "dom": '<"toolbar">frtip',

        "columns": [
            {"data": "index"},
            {"data": "str_NAME"},
            {"data": "str_DESCRIPTION"},
            {"data": "str_BUTTON"},
        ], "rowCallback": function (row, data) {
            if ($.inArray(data.DT_RowId, selected) !== -1) {
                $(row).addClass('selected');
            }
        }
    });


}