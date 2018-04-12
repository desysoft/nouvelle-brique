
<%@page import="dal.TLocality"%>
<%@page import="bll.disciplinarymanagement.Reasonmanagement"%>
<%@page import="bll.providermanager.ProviderManager"%>
<%@page import="dal.TProvider"%>
<%@page import="bll.paperManager.TypePaperManager"%>
<%@page import="dal.TProvider"%>

<%@page import="dal.dataManager"  %>
<%@page import="dal.TRole"  %>
<%@page import="java.util.*"  %>
<%@page import="multilangue.Translate"  %>
<%@page import="toolkits.utils.date"  %>
<%@page import="toolkits.parameters.commonparameter"  %>
<%@page import="toolkits.web.json"  %>
<%@page import="org.json.JSONObject"  %>
<%@page import="org.json.JSONArray"  %>
<%@page import="dal.TEmploye"  %>
<%@page import="toolkits.utils.jdom"  %>
<%@page import="toolkits.utils.logger"  %>
<%@page import="java.text.SimpleDateFormat"  %>




<%! Translate oTranslate = new Translate();
    dataManager OdataManager = new dataManager();

    json Ojson = new json();

    String search_value = "";

%>

<%
    int DATA_PER_PAGE = jdom.int_size_pagination, count = 0, pages_curr = 0;
    new logger().OCategory.info("dans ws data");
    TEmploye OTEmploye = (TEmploye) session.getAttribute(commonparameter.AIRTIME_USER);
    List<TLocality> lsTLocality = new ArrayList<TLocality>();
    List<TLocality> lsTLocality_for_page = new ArrayList<TLocality>();
    Reasonmanagement OReasonmanagement;
    String column[] = {"strNAME","strDESCRIPTION"};
    
%>


<%    String action = request.getParameter("action");
    int pageAsInt = 0;

    try {
        if ((action != null) && action.equals("filltable")) {
        } else {

            String p = request.getParameter("start");
            System.out.println("start === " + p);

            if (p != null) {
                int int_page = new Integer(p).intValue();
                int_page = (int_page / DATA_PER_PAGE) + 1;
                p = new Integer(int_page).toString();

                // Strip quotation marks
                StringBuffer buffer = new StringBuffer();
                for (int index = 0; index < p.length(); index++) {
                    char c = p.charAt(index);
                    if (c != '\\') {
                        buffer.append(c);
                    }
                }
                p = buffer.toString();
                Integer intTemp = new Integer(p);

                pageAsInt = intTemp.intValue();

            } else {
                pageAsInt = 1;
            }

        }
    } catch (Exception E) {
    }


%>

<%    /*List<String> parameterNames = new ArrayList<String>(request.getParameterMap().keySet());
    for(String elemrequest : parameterNames){
        System.out.println("elemrequest === "+elemrequest);
    }*/
    OReasonmanagement = new Reasonmanagement(OdataManager);

    String lg_REASONS_ID = "", draw = "", search = "", start = "", limit = "", orderBy = "", order = "";

    if (request.getParameter("search[value]") != null) {
        search_value = request.getParameter("search[value]");
    }
    if (request.getParameter("draw") != null) {
        draw = request.getParameter("draw");
    }

    if (request.getParameter("search") != null) {
        search = request.getParameter("search");
    }
    if (search_value.equals("") || search_value == null) {
        search_value = "";
    } else {
        search_value = search_value;
    }
    if (request.getParameter("order[0][column]") != null) {
        //orderBy = column[Integer.parseInt(request.getParameter("draw"))];
        orderBy = "ORDER BY t."+column[Integer.parseInt(request.getParameter("order[0][column]"))];
    }
    if (request.getParameter("lg_REASONS_ID") != null) {
        lg_REASONS_ID = request.getParameter("lg_REASONS_ID");
        new logger().OCategory.info(lg_REASONS_ID);
    }

    if (request.getParameter("start") != null) {
        start = request.getParameter("start");
    }
    if (start.equals("")) {
        start = "0";
    }

    if (request.getParameter("length") != null) {
        limit = request.getParameter("length");
    }
    if (limit.equals("")) {
        limit = "10";
    }
    int limited = Integer.parseInt(start) + Integer.parseInt(limit);
     System.out.println("limited ===== "+limited);
    //lsTLocality = OReasonmanagement.getAllLocality(lg_REASONS_ID, search_value);

   //lsTLocality = OReasonmanagement.getAllLocality(lg_REASONS_ID, search_value, start, limit, orderBy, order);
   String jpql = "SELECT t FROM TLocality t WHERE (t.strNAME LIKE ?1 OR t.strDESCRIPTION LIKE ?2 ) AND t.strSTATUT = ?3 AND t.lgLOCALITYID LIKE ?4 "+orderBy;
   System.out.println("jpql ===== "+jpql);
    lsTLocality = OdataManager.getEm().createQuery(jpql)
                    .setParameter(1, "%" + search_value + "%").setParameter(2, "%" + search_value + "%")
                    .setParameter(3, commonparameter.statut_enable)
                    .setParameter(4, "%%").setFirstResult(Integer.parseInt(start)).setMaxResults(Integer.parseInt(String.valueOf(limit))).getResultList();
    
    
    jpql = "SELECT COUNT(t.lgLOCALITYID) FROM TLocality t WHERE (t.strNAME LIKE ?1 OR t.strDESCRIPTION LIKE ?2 ) AND t.strSTATUT = ?3 AND t.lgLOCALITYID LIKE ?4 "+orderBy;
    System.out.println("jpql count ===== "+jpql);
    /*lsTLocality_for_page = OdataManager.getEm().createQuery(jpql)
                    .setParameter(1, "%" + search_value + "%").setParameter(2, "%" + search_value + "%")
                    .setParameter(3, commonparameter.statut_enable)
                    .setParameter(4, "%%").getSingleResult().toString();*/
    //lsTLocality = OReasonmanagement.getAllLocality(lg_REASONS_ID, search_value);
    String nbre_page = OdataManager.getEm().createQuery(jpql)
                    .setParameter(1, "%" + search_value + "%").setParameter(2, "%" + search_value + "%")
                    .setParameter(3, commonparameter.statut_enable)
                    .setParameter(4, "%%").getSingleResult().toString();
    
    new logger().OCategory.info("Taille lsTLocality= "+lsTLocality.size());
    new logger().OCategory.info("Taille lsTLocality_for_page = "+nbre_page);
%>


<%    JSONArray arrayObj = new JSONArray();
    for (int i = 0; i < lsTLocality.size(); i++) {

        if (!lsTLocality.get(i).getLgLOCALITYID().equals(commonparameter.noReasonId)) {
            JSONObject json = new JSONObject();
            String date = "";
            json.put("lg_REASONS_ID", lsTLocality.get(i).getLgLOCALITYID());
            json.put("str_NAME", lsTLocality.get(i).getStrNAME());
            json.put("str_DESCRIPTION", lsTLocality.get(i).getStrDESCRIPTION());
            json.put("str_STATUT", lsTLocality.get(i).getStrSTATUT());

            arrayObj.put(json);
        }

    }
    String result = "{\"draw\":" + draw + ",\"recordsTotal\":" + lsTLocality.size() + ",\"recordsFiltered\":" + Integer.parseInt(nbre_page) + ",\"data\":" + arrayObj.toString() + "}";
%>

<%= result %>