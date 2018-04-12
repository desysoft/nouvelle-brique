<%@page import="multilangue.MultilangueKeys"%>
<%@page import="multilangue.Translate"%>
<%@page import="dal.TEmploye"  %>
<%@page import="toolkits.parameters.commonparameter"  %>
<%@page import="bll.userManagement.privilege"  %>
<%@page import="dal.TPrivileges"  %>
<%@page import="java.util.List"  %>
<%@page import="toolkits.utils.logger"  %>
<%@page import="toolkits.utils.jdom"  %>
<%!    Translate OTranslate1222 = null;
%>
<%
    OTranslate1222 = new Translate();

    if (session.getAttribute(commonparameter.local).equals(commonparameter.Local_Culture_Lg_ENGLISH)) {
        OTranslate1222.setLocal_Cty(commonparameter.Local_Culture_city_ENGLISH);
        OTranslate1222.setLocal_Lg(commonparameter.Local_Culture_Lg_ENGLISH);
    } else {
        OTranslate1222.setLocal_Cty(commonparameter.Local_Culture_city_FRANCAIS);
        OTranslate1222.setLocal_Lg(commonparameter.Local_Culture_Lg_FRANCAIS);
    }

%>
<%    TEmploye OTEmploye = (TEmploye) session.getAttribute(commonparameter.AIRTIME_USER);
    List<TPrivileges> LstTPrivilege = (List<TPrivileges>) session.getAttribute(commonparameter.USER_LIST_PRIVILEGE);
%>



<%@include file="actions/add.js.jsp" %>
<%@include file="actions/edit.js.jsp" %>
<%@include file="actions/delete.js.jsp" %>
<%@include file="actions/search.js.jsp" %>
<div class="main_content">
    <script src="backadmin/modules/app.js"></script>
    <script src="backadmin/modules/ressourceshumaines/controle/motif/script/script.js"></script>
    <div class="content-header">
        
    </div>

    <div class="content-body">
        <!--div class="row toolbar-btn">
            <div class="span1">
                <button type="button" class="btn btn-block btn-sm background-color-theme-btn" id="modal_add" data-toggle="modal" href="modal_add">Ajouter</button>
            </div>
        </div-->
        <div class="row-fluid table-content-body">
            <div class="span12">
                <div class="row-fluid heading">
                    <h3 class="span4"><%=OTranslate1222.getValue(MultilangueKeys.ml_MOTIF.name())%></h3>
                    <div class="span8 toolbar-btn">
                        
                        <button type="button" class="span1 pull-right btn btn-block btn-sm background-color-theme-btn" id="modal_add" data-toggle="modal" href="modal_add">Ajouter</button>
                    </div>
                    
                </div>
                
                <table id="table-content" class="display table-content-data" width="100%" cellspacing="0">
                    <thead>
                        <tr>
                            <!--th>ID</th-->
                            <th>Libellé</th>
                            <th>Description</th>
                            <th>Action</th>
                            <!--th>Date de création</th-->
                        </tr>
                    </thead>
                    <tfoot>
                        <tr>
                            <!--th>ID</th-->
                            <th>Libellé</th>
                            <th>Description</th>
                            <th>Action</th>
                            <!--th>Date de création</th-->
                        </tr>
                    </tfoot>
                </table>
            </div>
        </div>
    </div>

</div>
<div class="content-footer">

</div>
</div>
