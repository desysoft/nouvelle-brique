<%@page import="toolkits.parameters.commonparameter"%>
<%@page import="dal.TEmploye"%>
<%@page import="dal.TModule"%>
<%
    TModule oTModule = (TModule) session.getAttribute("TModule");
    System.out.println("HEADER.JSP session.getAttribute "+session.getAttribute(commonparameter.AIRTIME_USER).toString());
    TEmploye OTEmploye = (TEmploye) session.getAttribute(commonparameter.AIRTIME_USER);
    System.out.println("HEADER.JSP TEmploye"+OTEmploye.getStrFIRSTNAME());
%>

<div class="navbar navbar-fixed-top">
    <script src="backadmin/header/header.js"></script>
    <div class="navbar-inner">
        <div class="container-fluid">
            <a class="brand" href=""><i class="icon-home icon-white"></i> Administration</a>
            <ul class="nav user_menu pull-right">

                <li class="dropdown">
                    <a href="#" class="" style="color: #fff">Module <strong> <%= oTModule.getStrVALUE()%></strong></a>
                </li>
                <li class="hidden-phone hidden-tablet">
                    <div class="nb_boxes clearfix">
                        <a data-toggle="modal" data-backdrop="static" href="#myMail" class="label ttip_b" title="New messages">25 <i class="splashy-mail_light"></i></a>
                        <!--a data-toggle="modal" data-backdrop="static" href="#myTasks" class="label ttip_b" title="New tasks">10 <i class="splashy-calendar_week"></i></a-->
                    </div>
                </li>
                <li class="divider-vertical hidden-phone hidden-tablet"></li>
                <li class="dropdown">
                    <a href="#" class="dropdown-toggle nav_condensed" data-toggle="dropdown"><i class="flag-fr"></i> <b class="caret"></b></a>
                    <ul class="dropdown-menu">
                        <li><a href="javascript:void(0)"><i class="flag-gb"></i> Anglais</a></li>
                    </ul>
                </li>
                <li class="divider-vertical hidden-phone hidden-tablet"></li>
                <li class="dropdown">
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown"><img src="resources/template/geboadmin/img/user_avatar.png" alt="" class="user_avatar" /> <%= OTEmploye.getStrFIRSTNAME() + " " + OTEmploye.getStrLASTNAME() %><b class="caret"></b></a>
                    <ul class="dropdown-menu">
                        <li><a href="user_profile.html">My Profile</a></li>
                        <li><a href="javascrip:void(0)">Another action</a></li>
                        <li class="divider"></li>
                        <li><a href="login?mode=logout">Deconnexion</a></li>
                    </ul>
                </li>
            </ul>
            <ul class="nav" id="mobile-nav">
                <li class="dropdown">
                    <a data-toggle="dropdown" class="dropdown-toggle" href="#"><i class="icon-list-alt icon-white"></i> Forms <b class="caret"></b></a>
                    <ul class="dropdown-menu">
                        <li><a href="form_elements.html">Form elements</a></li>
                        <li><a href="form_extended.html">Extended form elements</a></li>
                        <li><a href="form_validation.html">Form Validation</a></li>
                    </ul>
                </li>
                <li class="dropdown">
                    <a data-toggle="dropdown" class="dropdown-toggle" href="#"><i class="icon-th icon-white"></i> Components <b class="caret"></b></a>
                    <ul class="dropdown-menu">
                        <li><a href="alerts_btns.html">Alerts & Buttons</a></li>
                        <li><a href="icons.html">Icons</a></li>
                        <li><a href="notifications.html">Notifications</a></li>
                        <li><a href="tables.html">Tables</a></li>
                        <li><a href="tables_more.html">Tables (more examples)</a></li>
                        <li><a href="tabs_accordion.html">Tabs & Accordion</a></li>
                        <li><a href="tooltips.html">Tooltips, Popovers</a></li>
                        <li><a href="typography.html">Typography</a></li>
                        <li><a href="widgets.html">Widget boxes</a></li>
                        <li class="dropdown">
                            <a href="#">Sub menu <b class="caret-right"></b></a>
                            <ul class="dropdown-menu">
                                <li><a href="#">Sub menu 1.1</a></li>
                                <li><a href="#">Sub menu 1.2</a></li>
                                <li><a href="#">Sub menu 1.3</a></li>
                                <li>
                                    <a href="#">Sub menu 1.4 <b class="caret-right"></b></a>
                                    <ul class="dropdown-menu">
                                        <li><a href="#">Sub menu 1.4.1</a></li>
                                        <li><a href="#">Sub menu 1.4.2</a></li>
                                        <li><a href="#">Sub menu 1.4.3</a></li>
                                    </ul>
                                </li>
                            </ul>
                        </li>
                    </ul>
                </li>
                <li class="dropdown">
                    <a data-toggle="dropdown" class="dropdown-toggle" href="#"><i class="icon-wrench icon-white"></i> Plugins <b class="caret"></b></a>
                    <ul class="dropdown-menu">
                        <li><a href="charts.html">Charts</a></li>
                        <li><a href="calendar.html">Calendar</a></li>
                        <li><a href="datatable.html">Datatable</a></li>
                        <li><a href="dynamic_tree.html">Dynamic Tree</a></li>
                        <li><a href="editable_elements.html">Editable elements</a></li>
                        <li><a href="file_manager.html">File Manager</a></li>
                        <li><a href="floating_header.html">Floating List Header</a></li>
                        <li><a href="google_maps.html">Google Maps</a></li>
                        <li><a href="gallery.html">Gallery Grid</a></li>
                        <li><a href="wizard.html">Wizard</a></li>
                    </ul>
                </li>
                <li class="dropdown">
                    <a data-toggle="dropdown" class="dropdown-toggle" href="#"><i class="icon-file icon-white"></i> Pages <b class="caret"></b></a>
                    <ul class="dropdown-menu">
                        <li><a href="blog_page.html">Blog Page</a></li>
                        <li><a href="chat.html">Chat</a></li>
                        <li><a href="error_404.html">Error 404</a></li>
                        <li><a href="invoice.html">Invoice</a></li>
                        <li><a href="mailbox.html">Mailbox</a></li>
                        <li><a href="search_page.html">Search page</a></li>
                        <li><a href="user_profile.html">User profile</a></li>
                        <li><a href="user_static.html">User profile (static)</a></li>
                    </ul>
                </li>
                <li>
                    <a href="documentation.html"><i class="icon-book icon-white"></i> Help</a>
                </li>
            </ul>
        </div>
    </div>
</div>
<div class="modal hide fade" id="myMail">
    <div class="modal-header">
        <button class="close" data-dismiss="modal">×</button>
        <h3>New messages</h3>
    </div>
    <div class="modal-body">
        <div class="alert alert-info">In this table jquery plugin turns a table row into a clickable link.</div>
        <table class="table table-condensed table-striped" data-provides="rowlink">
            <thead>
                <tr>
                    <th>Sender</th>
                    <th>Subject</th>
                    <th>Date</th>
                    <th>Size</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td>Declan Pamphlett</td>
                    <td><a href="javascript:void(0)">Lorem ipsum dolor sit amet</a></td>
                    <td>23/05/2012</td>
                    <td>25KB</td>
                </tr>
                <tr>
                    <td>Erin Church</td>
                    <td><a href="javascript:void(0)">Lorem ipsum dolor sit amet</a></td>
                    <td>24/05/2012</td>
                    <td>15KB</td>
                </tr>
                <tr>
                    <td>Koby Auld</td>
                    <td><a href="javascript:void(0)">Lorem ipsum dolor sit amet</a></td>
                    <td>25/05/2012</td>
                    <td>28KB</td>
                </tr>
                <tr>
                    <td>Anthony Pound</td>
                    <td><a href="javascript:void(0)">Lorem ipsum dolor sit amet</a></td>
                    <td>25/05/2012</td>
                    <td>33KB</td>
                </tr>
            </tbody>
        </table>
    </div>
    <div class="modal-footer">
        <a href="javascript:void(0)" class="btn">Go to mailbox</a>
    </div>
</div>
<div class="modal hide fade" id="myTasks">
    <div class="modal-header">
        <button class="close" data-dismiss="modal">×</button>
        <h3>New Tasks</h3>
    </div>
    <div class="modal-body">
        <div class="alert alert-info">In this table jquery plugin turns a table row into a clickable link.</div>
        <table class="table table-condensed table-striped" data-provides="rowlink">
            <thead>
                <tr>
                    <th>id</th>
                    <th>Summary</th>
                    <th>Updated</th>
                    <th>Priority</th>
                    <th>Status</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td>P-23</td>
                    <td><a href="javascript:void(0)">Admin should not break if URL&hellip;</a></td>
                    <td>23/05/2012</td>
                    <td class="tac"><span class="label label-important">High</span></td>
                    <td>Open</td>
                </tr>
                <tr>
                    <td>P-18</td>
                    <td><a href="javascript:void(0)">Displaying submenus in custom&hellip;</a></td>
                    <td>22/05/2012</td>
                    <td class="tac"><span class="label label-warning">Medium</span></td>
                    <td>Reopen</td>
                </tr>
                <tr>
                    <td>P-25</td>
                    <td><a href="javascript:void(0)">Featured image on post types&hellip;</a></td>
                    <td>22/05/2012</td>
                    <td class="tac"><span class="label label-success">Low</span></td>
                    <td>Updated</td>
                </tr>
                <tr>
                    <td>P-10</td>
                    <td><a href="javascript:void(0)">Multiple feed fixes and&hellip;</a></td>
                    <td>17/05/2012</td>
                    <td class="tac"><span class="label label-warning">Medium</span></td>
                    <td>Open</td>
                </tr>
            </tbody>
        </table>
    </div>
    <div class="modal-footer">
        <a href="javascript:void(0)" class="btn">Go to task manager</a>
    </div>
</div>