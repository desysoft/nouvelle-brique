<%@page import="dal.TEmploye"%>
<%@page import="dal.TReasons"%>
<%@page import="toolkits.parameters.commonparameter"  %>
<%@page import="bll.userManagement.privilege"  %>
<%@page import="dal.TPrivileges"  %>
<%@page import="java.util.List"  %>
<%@page import="toolkits.utils.logger"  %>
<%@page import="toolkits.utils.jdom"  %>
<%@page import="multilangue.*"  %>
<%!    Translate OTranslate7 = null;
%>
<%
    OTranslate7 = new Translate();
//sd

    if (session.getAttribute(commonparameter.local).equals(commonparameter.Local_Culture_Lg_ENGLISH)) {
        OTranslate7.setLocal_Cty(commonparameter.Local_Culture_city_ENGLISH);
        OTranslate7.setLocal_Lg(commonparameter.Local_Culture_Lg_ENGLISH);
    } else {
        OTranslate7.setLocal_Cty(commonparameter.Local_Culture_city_FRANCAIS);
        OTranslate7.setLocal_Lg(commonparameter.Local_Culture_Lg_FRANCAIS);
    }
%>

<div class="modal form-windows fade" id="modal_add" role="dialog">
    <div class="modal-dialog ">

        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">&times;</button>
                <h4 class="modal-title">Ajouter</h4>
            </div> 
            <div class="modal-body">
                <form class="form" role="form" id="add-form">
                    <div class="box-body">
                        <div class="form-group">
                            <label for="str_NAME" class="span3 control-label">Libellé</label>
                            <div class="span5">
                                <input class="span5 form-control" id="str_NAME" name="str_NAME" placeholder="Libellé..." type="text">
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="str_DESCRIPTION" class="span3 control-label">Description</label>
                            <div class="span5">
                                <textarea class="span5 form-control" rows="3" placeholder="Description" id="str_DESCRIPTION" name="str_DESCRIPTION"></textarea>
                            </div>
                        </div>
                    </div>
                    <div class="box-footer">
                        <div class="form-group">
                            <input id="lg_REASONS_ID" name="lg_REASONS_ID" type="hidden">
                            <button type="submit" class="btn btn-warning pull-right" style="margin-left: 3px;">Enregistrer</button>
                            <button type="reset" class="btn btn-default pull-right" data-dismiss="modal">Annuler</button>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">

            </div>

        </div>

    </div>
</div>