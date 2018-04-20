<%@page import="toolkits.parameters.commonparameter"%>
<%@page import="dal.TEmploye"%>
<%
    TEmploye OTEmploye = (TEmploye) session.getAttribute(commonparameter.AIRTIME_USER);
    if (OTEmploye == null) {
        response.sendRedirect("login");
    }else{
        System.out.println("issession app_module === "+OTEmploye.getStrFIRSTNAME());
    }
%>
<%
    //System.out.println("result brut ==== "+request.getParameter("result"));
    if (request.getParameter("result") != null && !request.getParameter("result").equals("")) {
        String result = request.getParameter("result");
        
        System.out.println("result ==== "+result);
        System.out.println("Taille result "+result.length());
 %> 
        <jsp:include page="<%=result%>"></jsp:include>
 <%
    }else{
 %>
        <jsp:include page="main_content.jsp"></jsp:include>
<%
    }   
%>