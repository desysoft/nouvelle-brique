<%@page import="toolkits.utils.logger"%>
<%@page import="bll.security.Module"%>
<%@page import="dal.dataManager"  %>
<%@page import="dal.TEmploye"  %>
<%@page import="dal.TRole"  %>


<%@page import="bll.userManagement.privilege"  %>
<%@page import="java.util.*"  %>
<%@page import="multilangue.Translate"  %>
<%@page import="toolkits.utils.date"  %>
<%@page import="bll.userManagement.privilege"  %>
<%@page import="toolkits.parameters.commonparameter"  %>
<%@page import="toolkits.web.json"  %>
<%@page import="org.json.JSONObject"  %>
<%@page import="org.json.JSONArray"  %>
<%@page import="dal.TModule"  %>
<%@page import="dal.TSousMenu"  %>
<%@page import="toolkits.utils.jdom"  %>


<%
    TEmploye OTEmploye = (TEmploye) session.getAttribute(commonparameter.AIRTIME_USER);
    if (OTEmploye == null) {
        response.sendRedirect("login");
    }
%>
<%!   Translate OTranslate = new Translate();
    dataManager OdataManager = new dataManager();
    String strLASTNAME = "%%", strFIRSTNAME = "%%", strLOGIN = "%%", lg_ROLE_ID = "", lg_USER_ID = "";
    date key = new date();
    privilege Oprivilege = new privilege();
    json Ojson = new json();
    List<TModule> lstTModule_temp = new ArrayList<TModule>();
    List<TModule> lstTModule = new ArrayList<TModule>();
    Module OModule;

%>
<%
    new toolkits.utils.logger().OCategory.info("mod :" + session.getAttribute("MOD"));

    new toolkits.utils.logger().OCategory.info("User : " + OTEmploye.getStrFIRSTNAME() + " " + OTEmploye.getStrLASTNAME());
    if (session.getAttribute(commonparameter.local).equals(commonparameter.Local_Culture_Lg_ENGLISH)) {
        OTranslate.setLocal_Cty(commonparameter.Local_Culture_city_ENGLISH);
        OTranslate.setLocal_Lg(commonparameter.Local_Culture_Lg_ENGLISH);
    } else {
        OTranslate.setLocal_Cty(commonparameter.Local_Culture_city_FRANCAIS);
        OTranslate.setLocal_Lg(commonparameter.Local_Culture_Lg_FRANCAIS);
    }

    OdataManager.initEntityManager();
    Oprivilege.LoadDataManger(OdataManager);
    Oprivilege.LoadMultilange(OTranslate);
    Oprivilege.setoTEmploye(OTEmploye);
    new logger().OCategory.info("**********************************" + session.getAttribute("MOD").toString());
%>            
<%
    if (session.getAttribute(commonparameter.local) != null) {
        if (session.getAttribute(commonparameter.local).equals(commonparameter.Local_Culture_Lg_ENGLISH)) {
            OTranslate.setLocal_Cty(commonparameter.Local_Culture_city_ENGLISH);
            OTranslate.setLocal_Lg(commonparameter.Local_Culture_Lg_ENGLISH);
        } else {
            OTranslate.setLocal_Cty(commonparameter.Local_Culture_city_FRANCAIS);
            OTranslate.setLocal_Lg(commonparameter.Local_Culture_Lg_FRANCAIS);

        }
    }

    OdataManager.initEntityManager();
    Oprivilege.LoadDataManger(OdataManager);
    Oprivilege.LoadMultilange(OTranslate);
    Oprivilege.setoTEmploye(OTEmploye);
    OModule = new Module(OdataManager);

    lstTModule_temp = OModule.getAllModule();
    new toolkits.utils.logger().OCategory.info(" Liste module  ===== " + lstTModule_temp.size());
    lstTModule.clear();
    new toolkits.utils.logger().OCategory.info(" Liste module after clear ===== " + lstTModule_temp.size());
    for (int i = 0; i < lstTModule_temp.size(); i++) {
        try {
            OdataManager.getEm().refresh(lstTModule_temp.get(i));
        } catch (Exception e) {
        }
        if (Oprivilege.isAvalaible(lstTModule_temp.get(i).getPKey())) {

            lstTModule.add(lstTModule_temp.get(i));

        }
    }

    new logger().OCategory.info("Liste de module ===== " + lstTModule.size());
%> 
<%
    JSONArray arrayObj = new JSONArray();
    JSONObject jsonMain = new JSONObject();
    jsonMain.put("total", lstTModule.size());
    if (lstTModule.size() > 0) {
        jsonMain.put("code_statut", "1");
    } else {
        jsonMain.put("code_statut", "0");
    }
    JSONArray array_results = new JSONArray();
    for (int i = 0; i < lstTModule.size(); i++) {
        JSONObject oJSONObject = new JSONObject();
        oJSONObject.put("link", lstTModule.get(i).getStrURL());
        oJSONObject.put("icone", lstTModule.get(i).getStrIcone());
        oJSONObject.put("priority", lstTModule.get(i).getIntPRIORITY());
        oJSONObject.put("value", lstTModule.get(i).getStrVALUE());
        array_results.put(oJSONObject);
    }
    jsonMain.put("results", array_results);
    arrayObj.put(jsonMain);
%>
<%= arrayObj.toString()%>
