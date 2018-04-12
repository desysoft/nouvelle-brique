<%@page import="toolkits.utils.logger"%>
<%@page import="dal.TModuleMenu"%>
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
<%@page import=" org.json.JSONObject"  %>
<%@page import="org.json.JSONArray"  %>
<%@page import="dal.TMenu"  %>
<%@page import="dal.TSousMenu"  %>



<%!   Translate OTranslate = new Translate();
    dataManager OdataManager = new dataManager();
    String strLASTNAME = "%%", strFIRSTNAME = "%%", strLOGIN = "%%", lg_ROLE_ID = "", lg_USER_ID = "";
    date key = new date();
    privilege Oprivilege = new privilege();
    json Ojson = new json();
    List<TMenu> lstTMenu = new ArrayList<TMenu>();
%>
<%
            new toolkits.utils.logger().OCategory.info("mod :"+session.getAttribute("MOD"));

            TEmploye OTEmploye = (TEmploye) session.getAttribute(commonparameter.AIRTIME_USER);
            new toolkits.utils.logger().OCategory.info("User : "+OTEmploye.getStrFIRSTNAME() + " " + OTEmploye.getStrLASTNAME());
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
            new logger().OCategory.info("**********************************"+session.getAttribute("MOD").toString());
            lstTMenu = Oprivilege.getMenubyModule(session.getAttribute("MOD").toString());
            new logger().OCategory.info("taille liste menu "+lstTMenu.size());
            JSONArray arrayObj = new JSONArray();
            JSONObject jsonMain = new JSONObject();
            jsonMain.put("total", lstTMenu.size());
            jsonMain.put("code_statut", "1");
            JSONArray array_menu = new JSONArray();
            
            for (int i = 0; i < lstTMenu.size(); i++) {

                OdataManager.getEm().refresh(lstTMenu.get(i));

                if (Oprivilege.isAvalaible(lstTMenu.get(i).getPKey())) {
                    System.out.println("isAvalaible ====  "+i);
                    List<TSousMenu> lstTSousMenu = new ArrayList<TSousMenu>();
                    lstTSousMenu = OdataManager.getEm().createQuery("SELECT t FROM TSousMenu t WHERE t.lgMENUID.lgMENUID = ?1  AND t.strStatus LIKE ?2 ORDER BY t.intPRIORITY ").setParameter(1, lstTMenu.get(i).getLgMENUID()).setParameter(2, commonparameter.statut_enable).getResultList();
                     new logger().OCategory.info("taille liste lstTSousMenu "+lstTSousMenu.size());
                    JSONObject json = new JSONObject();
                    json.put("text", OTranslate.getValue(lstTMenu.get(i).getStrDESCRIPTION()));
                    json.put("expanded", "true");
                    JSONArray arrayObj_sub = new JSONArray();
                    for (int j = 0; j < lstTSousMenu.size(); j++) {

                        TSousMenu OTSousMenu = lstTSousMenu.get(j);
                        OdataManager.getEm().refresh(OTSousMenu);
                        JSONObject json_sub = new JSONObject();
                       
                        

                        if (Oprivilege.isAvalaible(lstTSousMenu.get(j).getPKey())) {

                            json_sub.put("text", OTranslate.getValue(OTSousMenu.getStrDESCRIPTION()));
                            json_sub.put("id", OTSousMenu.getStrVALUE());//leaf:true
                            json_sub.put("leaf", "true");
                            json_sub.put("href", OTSousMenu.getStrURL());
                            arrayObj_sub.put(json_sub);
                        }
                        json.put("children", arrayObj_sub);
                    }
                    array_menu.put(json);
                }
                jsonMain.put("results", array_menu);
            }
            arrayObj.put(jsonMain);
%>
<%= arrayObj.toString()%>
