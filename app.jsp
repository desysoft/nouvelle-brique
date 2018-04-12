<%@page import="dal.TModule"%>
<!DOCTYPE html>

<%@page import="dal.TEmploye"  %>
<%@page import="dal.dataManager"  %>
<%@page import="multilangue.Translate"  %>
<%@page import="toolkits.parameters.commonparameter"  %>
<%@page import="toolkits.utils.logger"  %>
<%@page import="toolkits.utils.jdom"  %>
<%@page import="bll.userManagement.privilege"  %>
<%@page import="dal.TPrivileges"  %>
<%@page import="java.util.List"  %>
<%@page import="toolkits.web.json"  %>
<%
    TEmploye OTEmploye = (TEmploye) session.getAttribute(commonparameter.AIRTIME_USER);
    if (OTEmploye == null) {
        response.sendRedirect("login");
    }else{
        System.out.println("issession app.jsp === "+OTEmploye.getStrFIRSTNAME());
    }
%>
<%
    Translate OTranslate = new Translate();
    List<TPrivileges> LstTPrivilege = (List<TPrivileges>) session.getAttribute(commonparameter.USER_LIST_PRIVILEGE);
    privilege Oprivilege = new privilege();
    dataManager OdataManager = new dataManager();

    OdataManager.initEntityManager();
    Oprivilege.loadEmploye(OTEmploye);
    Oprivilege.LoadDataManger(OdataManager);
    Oprivilege.LoadMultilange(OTranslate);
    /* ThreadMail thread = new ThreadMail(OdataManager);
        thread.start();*/
    // tant que le thread est en vie...

%>
<%    new logger().OCategory.info("Modules app.jsp  :" + request.getParameter("mod"));

    if (request.getParameter("mod") != null) {
        TModule oTModule = OdataManager.getEm().find(TModule.class, request.getParameter("mod").toString());
        session.setAttribute("TModule", oTModule);
        session.setAttribute("MOD", request.getParameter("mod"));
    }
%>
<html lang="fr">
    <head>
        <meta charset="ISO-8859-1" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>ESG Admin</title> 

        <!-- Bootstrap framework -->
        <link rel="stylesheet" href="resources/template/geboadmin/bootstrap/css/bootstrap.min.css" />
        <link rel="stylesheet" href="resources/template/geboadmin/bootstrap/css/bootstrap-responsive.min.css" />
        <!-- breadcrumbs-->
        <link rel="stylesheet" href="resources/template/geboadmin/lib/jBreadcrumbs/css/BreadCrumb.css" />
        <!-- tooltips-->
        <link rel="stylesheet" href="resources/template/geboadmin/lib/qtip2/jquery.qtip.min.css" />
        <!-- colorbox -->
        <link rel="stylesheet" href="resources/template/geboadmin/lib/colorbox/colorbox.css" />    
        <!-- code prettify -->
        <link rel="stylesheet" href="resources/template/geboadmin/lib/google-code-prettify/prettify.css" />    
        <!-- notifications -->
        <link rel="stylesheet" href="resources/template/geboadmin/lib/sticky/sticky.css" />    
        <!-- splashy icons -->
        <link rel="stylesheet" href="resources/template/geboadmin/img/splashy/splashy.css" />
        <!-- flags -->
        <link rel="stylesheet" href="resources/template/geboadmin/img/flags/flags.css" />    
        <!-- calendar -->
        <link rel="stylesheet" href="resources/template/geboadmin/lib/fullcalendar/fullcalendar_gebo.css" />

        <link rel="stylesheet" href="resources/template/geboadmin/lib/antiscroll/antiscroll.css" />
        <link rel="stylesheet" href="resources/template/geboadmin/lib/datatables/extras/TableTools/media/css/TableTools.css">

        <link rel="stylesheet" href="resources/sweet-alert/dist/sweetalert.css" />
        <link rel="stylesheet" href="resources//sweet-alert/themes/facebook/facebook.css" />




        <!-- gebo color theme-->

        <link rel="stylesheet" href="resources/template/geboadmin/css/ie.css" id="" />
        <!--link rel="stylesheet" href="resources/template/geboadmin/css/blue.css" id="link_theme" />
        <link rel="stylesheet" href="resources/template/geboadmin/css/brown.css" id="link_theme" />
        <link rel="stylesheet" href="resources/template/geboadmin/css/dark.css" id="link_theme" />
        <link rel="stylesheet" href="resources/template/geboadmin/css/eastern_blue.css" id="link_theme" />
        <link rel="stylesheet" href="resources/template/geboadmin/css/green.css" id="link_theme" /-->
        <link rel="stylesheet" href="resources/template/geboadmin/css/tamarillo.css" id="link_theme" />

        <!-- main styles -->
        <link rel="stylesheet" href="resources/template/geboadmin/css/style.css" />
        <link rel="stylesheet" href="https://cdn.datatables.net/1.10.16/css/jquery.dataTables.min.css" />



        <link rel="stylesheet" href="http://fonts.googleapis.com/css?family=PT+Sans" />

        <!-- Favicon -->
        <link rel="shortcut icon" href="favicon.ico" />

        <!--[if lte IE 8]>
            <link rel="stylesheet" href="css/ie.css" />
            <script src="js/ie/html5.js"></script>
            <script src="js/ie/respond.min.js"></script>
            <script src="resources/template/geboadmin/lib/flot/excanvas.min.js"></script>
        <![endif]-->
        <!--
     <script src="resources/template/geboadmin/js/jquery.min.js"></script>
     
     <script src="resources/template/geboadmin/js/jquery-migrate.min.js"></script>
        -->
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.0.0/jquery.min.js"></script>
        <!--script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-migrate/1.4.1/jquery-migrate.js"></script-->
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-migrate/3.0.0/jquery-migrate.js"></script>
        <script src="//code.jquery.com/ui/1.12.1/jquery-ui.js"></script>



        <script src="https://cdn.datatables.net/1.10.16/js/jquery.dataTables.min.js"></script>

        <script>
            //* hide all elements & show preloader
            document.documentElement.className += 'js';
        </script>
    </head>
    <body class="menu_hover">
        <div id="loading_layer" style="display:none"><img src="resources/template/geboadmin/img/ajax_loader.gif" alt="" /></div>
            <jsp:include page="thememanager.jsp" ></jsp:include>

            <div id="maincontainer" class="">
                <!-- header -->
                <header>
                <jsp:include page="header/header.jsp"></jsp:include>
                </header>

                <!-- main content -->
                <div id="contentwrapper">
                <jsp:include page="modules/app_module.jsp"></jsp:include>

                    <!--div class="main_content">
                        
                    </div-->
                </div>


                <!-- sidebar -->
                <a href="javascript:void(0)" class="sidebar_switch on_switch ttip_r" title="Hide Sidebar">Sidebar switch</a>
                <aside class="sidebar">
                <jsp:include page="../backadmin/menu/menu.jsp"></jsp:include>
            </aside>

        </div>

        <script type="text/javascript" src="resources/template/geboadmin/bootstrap/js/bootstrap.js"></script>
        <script src="resources/template/geboadmin/lib/antiscroll/antiscroll.js"></script>
        <script src="resources/template/geboadmin/lib/antiscroll/jquery-mousewheel.js"></script>
        <script src="resources/template/geboadmin/lib/qtip2/jquery.qtip.js"></script>
        <script src="resources/template/geboadmin/lib/typeahead/typeahead.js"></script>
        <!-- jBreadcrumbs -->
        <script src="resources/template/geboadmin/lib/jBreadcrumbs/js/jquery.jBreadCrumb.1.1.min.js"></script>
        <!-- lightbox -->
        <script src="resources/template/geboadmin/lib/colorbox/jquery.colorbox.min.js"></script>
        <!-- scrollbar -->

        <!-- to top -->
        <script src="resources/template/geboadmin/lib/UItoTop/jquery.ui.totop.min.js"></script>

        <script src="resources/template/geboadmin/lib/jquery-ui/jquery-ui-1.10.0.custom.min.js"></script>
        <!-- charts -->
        <script src="resources/template/geboadmin/lib/flot/jquery.flot.min.js"></script>
        <script src="resources/template/geboadmin/lib/flot/jquery.flot.resize.min.js"></script>
        <script src="resources/template/geboadmin/lib/flot/jquery.flot.pie.min.js"></script>
        <!-- calendar -->
        <script src="resources/template/geboadmin/lib/fullcalendar/fullcalendar.min.js"></script>
        <!-- sortable/filterable list -->
        <script src="resources/template/geboadmin/lib/list_js/list.min.js"></script>
        <script src="resources/template/geboadmin/lib/list_js/plugins/paging/list.paging.js"></script>


        <!-- dashboard functions -->


        <!-- smart resize event -->
        <script src="resources/template/geboadmin/js/jquery.debouncedresize.min.js"></script>
        <!-- hidden elements width/height -->
        <script src="resources/template/geboadmin/js/jquery.actual.min.js"></script>
        <!-- js cookie plugin -->
        <script src="resources/template/geboadmin/js/jquery_cookie.min.js"></script>

        <!-- bootstrap plugins -->
        <script src="resources/template/geboadmin/js/bootstrap.plugins.min.js"></script>
        <!-- fix for ios orientation change -->
        <script src="resources/template/geboadmin/js/ios-orientationchange-fix.js"></script>
        <!-- mobile nav -->
        <script src="resources/template/geboadmin/js/selectNav.js"></script>


        <!-- touch events for jquery ui-->
        <script src="resources/template/geboadmin/js/forms/jquery.ui.touch-punch.min.js"></script>
        <!-- multi-column layout -->
        <script src="resources/template/geboadmin/js/jquery.imagesloaded.min.js"></script>
        <script src="resources/template/geboadmin/js/jquery.wookmark.js"></script>
        <!-- responsive table -->
        <script src="resources/template/geboadmin/js/jquery.mediaTable.min.js"></script>
        <!-- small charts -->
        <script src="resources/template/geboadmin/js/jquery.peity.min.js"></script>
        <!-- dashboard functions -->
        <script src="resources/template/geboadmin/js/gebo_dashboard.js"></script>


        <!-- common functions -->
        <script src="resources/template/geboadmin/js/gebo_common.js"></script>
        <script src="backadmin/modules/app_module.js"></script>

        <script src="https://cdn.datatables.net/1.10.16/js/jquery.dataTables.min.js"></script>
        <script src="resources/sweet-alert/dist/sweetalert-dev.js" type="text/javascript"></script>
        <script type="text/javascript">
            $(document).ready(function () {
                //* show all elements & remove preloader
                //alert('js')
                setTimeout('$("html").removeClass("js")', 1000);
            });

        </script>
    </body>

</html>