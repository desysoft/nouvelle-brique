<%@page import="bll.disciplinarymanagement.Reasonmanagement"%>
<%@page import="java.io.File"%>


<%@page import="toolkits.utils.logger"  %>
<%@page import="dal.dataManager"  %>
<%@page import="dal.TEmploye"  %>
<%@page import="dal.TReasons"  %>
<%@page import="dal.TRole"  %>

<%@page import="bll.bllBase"  %>
<%@page import="java.util.*"  %>
<%@page import="multilangue.Translate"  %>
<%@page import="toolkits.utils.date"  %>
<%@page import="toolkits.utils.jdom"  %>
<%@page import="bll.userManagement.privilege"  %>
<%@page import="toolkits.parameters.commonparameter"  %>
<%@page import="toolkits.filesmanagers.FilesType.XlsFiles_with_POI"  %>
<%@page import="java.math.BigInteger"  %>



<%!    String lg_REASONS_ID = "%%",str_DESCRIPTION = "%%", str_NAME = "%%", str_STATUT = "%%";
    Integer int_PRIORITY;
    Translate oTranslate = new Translate();
    dataManager OdataManager = new dataManager();
    date key = new date();
    privilege Oprivilege = new privilege();
    TReasons oTReasons = null;
    //Institution OInstitutionmanagement = new Institution(OdataManager);
    Reasonmanagement OReasonmanagement = new Reasonmanagement(OdataManager);

%>




<%
    if (request.getParameter("str_NAME") != null) {
        str_NAME = request.getParameter("str_NAME");
    }
    if (request.getParameter("lg_REASONS_ID") != null) {
        lg_REASONS_ID = request.getParameter("lg_REASONS_ID");
        oTReasons = OdataManager.getEm().find(TReasons.class, lg_REASONS_ID);
    
    }
    if (request.getParameter("str_DESCRIPTION") != null) {
        str_DESCRIPTION = request.getParameter("str_DESCRIPTION");
    }


    TEmploye OTEmploye = (TEmploye) session.getAttribute(commonparameter.AIRTIME_USER);
    OdataManager.initEntityManager();

    bllBase ObllBase = new bllBase();

    ObllBase.LoadDataManger(OdataManager);
    ObllBase.LoadMultilange(oTranslate);
    ObllBase.setMessage(commonparameter.PROCESS_FAILED);
    jdom.InitRessource();
    jdom.LoadRessource();
    ObllBase.setDetailmessage("PAS D'ACTION");
    new logger().oCategory.info("le mode : " + request.getParameter("mode"));

    if (request.getParameter("mode") != null) {

        if (request.getParameter("mode").toString().equals("create")) {
            new logger().oCategory.info("Creation");
            Boolean success = OReasonmanagement.CreateReasons(str_NAME, str_DESCRIPTION);
            if(success) ObllBase.setMessage(commonparameter.PROCESS_SUCCESS);
         
        } else if (request.getParameter("mode").toString().equals("update")) {
            Boolean success = OReasonmanagement.UpdateReasons(lg_REASONS_ID, str_NAME, str_DESCRIPTION);
            if(success) ObllBase.setMessage(commonparameter.PROCESS_SUCCESS);
       
        } else if (request.getParameter("mode").toString().equals("delete")) {
            Boolean success = OReasonmanagement.deleteReasons(lg_REASONS_ID);
            if(success) ObllBase.setMessage(commonparameter.PROCESS_SUCCESS);
            
        } else if (request.getParameter("mode").toString().equals("createuser")) {
          
        } else if (request.getParameter("mode").toString().equals("importer_file")) {
            //code gestion uoload
 
        }

    }

    String result;
    if (ObllBase.getMessage().equals(commonparameter.PROCESS_SUCCESS)) {
        result = "{\"success\":1, \"msg\": \"" + OReasonmanagement.getDetailmessage()+ "\" }";
    } else {
        result = "{\"success\":0, \"msg\": \"" + OReasonmanagement.getDetailmessage() + "\" }";
    }
%>
<%=result%>