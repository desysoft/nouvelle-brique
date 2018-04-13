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
    List<TActions> LstTActions = actionManager.getUserAction(institutionRole.getLgINSTITUTIONROLEID().getLgINSTITUTIONROLEID(), str_VALUE);

    System.out.println("LstTActions------------------->"+LstTActions.size());
     
    JSONArray jSONArray = new JSONArray();
    if (LstTActions.size() > 0) {

        for (int i = 0; i < LstTActions.size(); i++) {
            if(!LstTActions.get(i).getStrNAME().equals(commonparameter.privilege_read)){
                JSONObject json = new JSONObject();
            String str_NAME = "", str_DESCRIPTION = "", str_TOOLTIP = "", str_HANDLER = "", str_ANCHO = "", str_ICON = "", str_width = "", str_heigth = "";
            if (LstTActions.get(i).getStrHeigth() != null) {
                str_heigth = LstTActions.get(i).getStrHeigth() + "";
            }
            if (LstTActions.get(i).getStrWidth() != null) {
                str_width = LstTActions.get(i).getStrWidth() + "";
            }
            if (LstTActions.get(i).getStrTOOLTIP() != null) {
                str_TOOLTIP = LstTActions.get(i).getStrTOOLTIP();
            }
            if (LstTActions.get(i).getStrANCHO() != null) {
                str_ANCHO = LstTActions.get(i).getStrANCHO();
            }
            if (LstTActions.get(i).getStrHANDLER() != null) {
                str_HANDLER = LstTActions.get(i).getStrHANDLER();
            }
            if (LstTActions.get(i).getStrDESCRIPTION() != null) {
                str_DESCRIPTION = LstTActions.get(i).getStrDESCRIPTION();
            }
            if (LstTActions.get(i).getStrNAME() != null) {
                str_NAME = LstTActions.get(i).getStrNAME();
            }
            if (LstTActions.get(i).getStrICON() != null) {
                str_ICON = LstTActions.get(i).getStrICON();
            }
            if ("menu".equals(LstTActions.get(i).getStrXTYPE())) {
                JSONArray items = new JSONArray();
                  String str_NAME_item = "", str_DESCRIPTION_item  = "", str_TOOLTIP_item  = "", str_HANDLER_item  = "",  str_ANCHO_item  = "", str_ICON_item  = "", str_width_item  = "", str_heigth_item  = "";
                for (Iterator j = LstTActions.get(i).getTActionitemsCollection().iterator(); j.hasNext();) {
                    TActionitems actionitems = (TActionitems) j.next();
                    JSONObject itemobj = new JSONObject();
                    if (actionitems.getStrHeigth() != null) {
                        str_heigth_item = actionitems.getStrHeigth() + "";
                    }
                    if (actionitems.getStrWidth() != null) {
                        str_width_item = actionitems.getStrWidth() + "";
                    }
                    if (actionitems.getStrTOOLTIP() != null) {
                        str_TOOLTIP_item = actionitems.getStrTOOLTIP();
                    }
                    if (actionitems.getStrANCHO() != null) {
                        str_ANCHO_item = actionitems.getStrANCHO();
                    }
                    if (actionitems.getStrHANDLER() != null) {
                        str_HANDLER_item = actionitems.getStrHANDLER();
                    }
                    if (actionitems.getStrDESCRIPTION() != null) {
                        str_DESCRIPTION_item = actionitems.getStrDESCRIPTION();
                    }
                    if (actionitems.getStrNAME() != null) {
                        str_NAME_item = actionitems.getStrNAME();
                    }
                    if (actionitems.getStrICON() != null) {
                        str_ICON_item = actionitems.getStrICON();
                    }
                    itemobj.put("lg_ACTIONS_ID", actionitems.getLgACTIONSID().getLgACTIONSID());
                    itemobj.put("str_XTYPE", actionitems.getStrXTYPE());
                    itemobj.put("str_TEXT", OTranslate1.getValue(actionitems.getStrTEXT()));
                    itemobj.put("str_DESCRIPTION", actionitems.getStrDESCRIPTION());
                    itemobj.put("str_NAME", str_NAME_item);
                    itemobj.put("str_HANDLER", str_HANDLER_item);
                    itemobj.put("str_TOOLTIP", str_TOOLTIP_item);
                    itemobj.put("str_ANCHO", str_ANCHO_item);
                    itemobj.put("str_ICON", str_ICON_item);
                    itemobj.put("str_width", str_width_item);
                    itemobj.put("str_heigth", str_heigth_item );
                    itemobj.put("str_ID", actionitems.getStrID());
                    items.put(itemobj);
                    json.put("items",items );
                }

            }
            json.put("lg_ACTIONS_ID", LstTActions.get(i).getLgACTIONSID());
            json.put("str_XTYPE", LstTActions.get(i).getStrXTYPE());
            json.put("str_TEXT", OTranslate1.getValue(LstTActions.get(i).getStrTEXT()));
            json.put("str_DESCRIPTION", str_DESCRIPTION);
            json.put("str_NAME", str_NAME);
            json.put("str_HANDLER", str_HANDLER);
            json.put("str_TOOLTIP", OTranslate1.getValue(str_TOOLTIP));
            json.put("str_ANCHO", str_ANCHO);
            json.put("str_ICON", str_ICON);
            json.put("str_width", str_width);
            json.put("str_heigth", str_heigth);
            json.put("str_ID", LstTActions.get(i).getStrID());

            jSONArray.put(json);
            }
            
        }
    }


%>
<%= jSONArray%>