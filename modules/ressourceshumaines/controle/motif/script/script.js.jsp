
<%@page import="dal.TEmploye"  %>
<%@page import="toolkits.parameters.commonparameter"  %>
<%@page import="bll.userManagement.privilege"  %>
<%@page import="dal.TPrivileges"  %>
<%@page import="java.util.List"  %>
<%@page import="toolkits.utils.logger"  %>
<%@page import="toolkits.utils.jdom"  %>
<%@page import="multilangue.*"  %>
<%!    Translate OTranslate1 = null;
%>
<%
    OTranslate1 = new Translate();

    if (session.getAttribute(commonparameter.local).equals(commonparameter.Local_Culture_Lg_ENGLISH)) {
        OTranslate1.setLocal_Cty(commonparameter.Local_Culture_city_ENGLISH);
        OTranslate1.setLocal_Lg(commonparameter.Local_Culture_Lg_ENGLISH);
    } else {
        OTranslate1.setLocal_Cty(commonparameter.Local_Culture_city_FRANCAIS);
        OTranslate1.setLocal_Lg(commonparameter.Local_Culture_Lg_FRANCAIS);
    }

%>
<script type="text/javascript">
    
</script>