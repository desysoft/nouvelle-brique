<%@page import="multilangue.Translate"%>
<%@page import="dal.TActionitems"%>
<%@page import="dal.TEmployeInstitutionRole"%>
<%@page import="dal.TSecurity"%>
<%@page import="bll.actionManager.ActionManager"%>
<%@page import="dal.TActions"%>
<%@page import="toolkits.parameters.commonparameter"%>
<%@page import="dal.TEmploye"%>

<%@page import="dal.dataManager"%>
<%@page import="java.util.*"  %>
<%@page import="toolkits.web.json"  %>
<%@page import="org.json.JSONObject"  %>
<%@page import="org.json.JSONArray"  %>
<%
    dataManager OdataManager = new dataManager();
    ActionManager actionManager = new ActionManager(OdataManager);
    Translate OTranslate1 = null;
    OTranslate1 = new Translate();
    List<TActions> LstTActions = new ArrayList<TActions>();
    TEmploye OTEmploye = (TEmploye) session.getAttribute(commonparameter.AIRTIME_USER);
    String str_VALUE = "";
    if (request.getParameter("str_VALUE") != null) {
        str_VALUE = request.getParameter("str_VALUE");
        System.out.println("str_VALUE------------------->"+str_VALUE);
    }

    TSecurity tSecurity = null;
    TEmployeInstitutionRole institutionRole = null;
    for (Iterator i = OTEmploye.getTEmployeInstitutionRoleCollection().iterator(); i.hasNext();) {
        institutionRole = (TEmployeInstitutionRole) i.next();
        break;
    }
    System.out.println("institutionRole === "+institutionRole);
    System.out.println("institutionRole.getLgINSTITUTIONROLEID() === "+institutionRole.getLgINSTITUTIONROLEID());
    System.out.println("institutionRole.getLgINSTITUTIONROLEID().getLgINSTITUTIONROLEID() === "+institutionRole.getLgINSTITUTIONROLEID().getLgINSTITUTIONROLEID());
    LstTActions = actionManager.getUserAction_new(institutionRole.getLgINSTITUTIONROLEID().getLgINSTITUTIONROLEID(), str_VALUE, commonparameter.XTYPE_ACTION_BUTTON);
    System.out.println("LstTActions------------------->"+LstTActions.size());
    
%>
