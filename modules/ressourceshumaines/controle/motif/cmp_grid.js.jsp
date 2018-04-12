
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
    default_nb_pagination_size = nb_pagination_size;
    /**
     * This JS is mainly used to list Odatas and support actions
     * that can be taken on the list of people.
     *
     * @author nvujasin
     * @Date May 1, 2008
     */
    var fm = Ext.form;

    // create the combo instance

    var OdataAction = 'Modifier';

    var OObject = Ext.data.Record.create([
        {
            name: 'lg_REASONS_ID',
            type: 'string'
        },
        {
            name: 'str_NAME',
            type: 'string'
        },
        {
            name: 'str_DESCRIPTION',
            type: 'string'
        }
    ]);


    Listtype_course = function () {

        //alert(gridPanel.getSelectionModel().getSelections());
        // Provides attractive and customizable tooltips for any element.
        // Init the singleton.  Any tag-based quick tips will start working.
        Ext.QuickTips.init();



        // Data reader class to create an Array of Ext.data.Record objects from a
        // JSON response based on mappings in a provided Ext.data.Record constructor.
        var OdataReader = new Ext.data.JsonReader(
                {
                    root: 'results', // Name of the property which contains the Array of row objects.
                    id: 'lg_REASONS_ID', // Name of the property within a row object that contains a record identifier value.
                    //successProperty: 'people.success', 	// Name of the property from which to retrieve the success attribute used by forms.
                    totalProperty: 'total'	// Name of the property from which to retrieve the total number of records in the dataset.
                            // from the remote server.
                },
        [{
                name: 'lg_REASONS_ID',
                mapping: 'lg_REASONS_ID'
            },
            {
                name: 'str_NAME',
                mapping: 'str_NAME'
           },
            {
                name: 'str_DESCRIPTION',
                mapping: 'str_DESCRIPTION'
            }

        ]
                );
        //str_Service_Number
        // Create an http proxy to be used to call the server and retrieve data to
        // be loaded using the reader and cached in the store.
        var httpProxy = new Ext.data.HttpProxy({
            url: 'cmp_grid.jsp'
        });

        // Fires if an error HTTP status was returned from the server. See
        // HTTP Status Code Definitions for details of HTTP status codes.
        // Handle any exception that may occur in the connection and http request.
        httpProxy.getConnection().on('requestexception', requestFailed);

        // The Store class encapsulates a client side cache of Record objects which
        // provide input data for Components such as the GridPanel, the ComboBox,
        // or the DataView.
        // A Store object uses its configured implementation of DataProxy to access
        // a data object unless you call loadData directly and pass in your data.
        // A Store object has no knowledge of the format of the data returned by
        // the Proxy.
        // A Store object uses its configured implementation of DataReader to
        // create Record instances from the data object. These Records are
        // cached and made available through accessor functions.
        var OdataDataStore = new Ext.data.Store({
            proxy: httpProxy,
            reader: OdataReader
        });
        //  OdataDataStore.setDefaultSort('str_Number', 'desc');
        // Fires if an exception occurs in the Proxy during data loading.
        // Called with the signature of the Proxy's "loadexception" event.
        // Handle any exception that may occur in the Proxy during data loading.
        OdataDataStore.on('loadexception', loadFailed);

        // Fires after a new set of Records has been loaded successfully.
        OdataDataStore.on('load', loadSuccessful);

        // The load method loads the Record cache from the configured Proxy using
        // the configured Reader. If using remote paging, then the first load call
        // must specify the start and limit properties in the options.params property
        // to establish the initial position within the dataset, and the number of
        // Records to cache on each read from the Proxy.
        // It is important to note that for remote data sources, loading is
        // asynchronous, and this call will return before the new data has been
        // loaded. Perform any post-processing in a callback function, or in a
        // "load" event handler.
        // Use a callback method to load and create the Grid.
        OdataDataStore.load({
            params: {
                start: 0,
                limit: getforcednb_pagination_size()
            },
            callback: loadAndShowGrid
        });

        /**
         * Handle the occurrence of an error HTTP status that was returned from the server.
         * See HTTP Status Code Definitions for details of HTTP status codes.
         * @param {Ext.data.Connection} connection The Connection object.
         * @param {Object} response The XHR object containing the response data.
         *		See http://www.w3.org/TR/XMLHttpRequest/ for details about accessing elements
         *		of the response.
         * @param {Object} options The options config object passed to the request method.
         */
        function requestFailed(connection, response, options) {

            Ext.MessageBox.alert('Error Message',
                    "Please contact support with the following: " +
                    "Status: " + response.status +
                    ", Status Text: " + response.statusText);
        }

        /**
         * Handle the occurrence of an exception that occurs in the Proxy during data
         * loading. This event can be fired for one of two reasons:
         * The load call returned success: false. This means the server logic returned
         * a failure status and there is no data to read. In this case, this event will
         * be raised and the fourth parameter (read error) will be null.
         * The load succeeded but the reader could not read the response. This means the
         * server returned jdata, but the configured Reader threw an error while reading
         * the data. In this case, this event will be raised and the caught error will be
         * passed along as the fourth parameter of this event.
         * @param {Object} proxy The HttpProxy object.
         * @param {Object) options The loading options that were specified (see load for details).
         * @param {Object} response The XMLHttpRequest object containing the response data.
         *		See http://www.w3.org/TR/XMLHttpRequest/ for details about accessing elements
         *		of the response.
         * @param {Error} error The JavaScript Error object caught if the configured Reader
         * could not read the data. If the load call returned success: false, this parameter
         * will be null.
         */
        function loadFailed(proxy, options, response, error) {

            // Decodes (parses) a JSON string to an object. If the JSON is invalid,
            // this function throws a SyntaxError.
            var object = Ext.util.JSON.decode(response.responseText);

            var errorMessage = "Error loading data.";

            // If the load from the server was successful and this method was called then
            // the reader could not read the response.
            if (object.people.success) {
                errorMessage = "The data returned from the server is in the wrong format. " +
                        "Please notify support with the following information: " + response.responseText;
            } else {
                // Error on the server side will include an error message in
                // the response.
                errorMessage = object.people.message;
            }

            Ext.MessageBox.alert('Error Message', errorMessage);
        }

        /**
         * Handle the occurrence of new set of Records have been loaded successfully.
         * @param {Store} store Store instance.
         * @param {Ext.data.Record[]} recordArray The Records that were loaded.
         * @param {Object} options The loading options that were specified (see load for details).
         */
        function loadSuccessful(store, recordArray, options) {

            // After any data loads, the raw JSON data is available for further
            // custom processing. If no data is loaded or there is a load exception
            // this property will be undefined.
            //Ext.MessageBox.alert('Confirm', OdataReader.jsonData.people.message);
        }

        /**
         * A callback method that is called when the data is returned from the
         * Store (OdataDataStore) load() method call. This method is called
         * after the Records have been loaded.
         *
         * Create and display the grid with the data in the datastore. Set any
         * events on the grid.
         *
         * The callback is passed the following arguments:
         * @param {Ext.data.Record[]} recordArray An array of Ext.data.Record objects
         *		loaded by the Ext.data.JsonReader that was received by the server.
         * @param {Object} options Options object from the load call.
         * @param {Boolean} success Boolean success indicator from the server. The
         * 		value is set on the JsonReader's successProperty.
         */
        function loadAndShowGrid(recordArray, options, success) {
            var menubar;
            var gridPanel;
            // This is the default implementation of a ColumnModel used by the Grid.
            // This class is initialized with an Array of column config objects.
            // An individual column's config object defines the header string,
            // the Ext.data.Record field the column draws its data from, an
            // optional rendering function to provide customized data formatting,
            // and the ability to apply a CSS class to all cells in a column through
            // its id config option.
            var OdataColumnModel = new Ext.grid.ColumnModel([
                // This is a utility class that can be passed into a Ext.grid.ColumnModel
                // as a column config that provides an automatic row numbering column.
                new Ext.grid.RowNumberer(),
                {
                    id: 'lg_REASONS_ID',
                    header: 'lg_REASONS_ID',
                    dataIndex: 'lg_REASONS_ID',
                    width: 45,
                    hidden: true,
                    sortable: true
                }, {
                    header: '<%=OTranslate1.getValue(MultilangueKeys.str_DESIGNATION.name())%>',
                    //  width: 100,
                    sortable: true,
                    dataIndex: 'str_NAME'
                }, {
                    header: '<%=OTranslate1.getValue(MultilangueKeys.str_DESCRIPTION.name())%>',
                    //  width: 100,
                    sortable: true,
                    dataIndex: 'str_DESCRIPTION'
                },
                {
                    header: "lg_REASONS_ID",
                    //  width: 100,
                    sortable: true,
                    hidden: true,
                    dataIndex: 'lg_REASONS_ID'
                }



            ]);

            // Add a paging toolbar to the grid's footer.
            var pagingToolbar = new Ext.PagingToolbar({
                pageSize: default_nb_pagination_size,
                displayInfo: true,
                displayMsg: '<%=OTranslate1.getValue(MultilangueKeys.ml_Displaying_Datas_Interval.name())%>',
                emptyMsg: "<%=OTranslate1.getValue(MultilangueKeys.ml_No_Result_To_Display.name())%>",
                store: OdataDataStore
            });
            var create = function () {
                new CreateOdata(OdataDataStore);
            };
            var supprimer = function () {
                new DeleteOdata(OdataDataStore, gridPanel);
            };

            var defaulthandler = function () {

            };

            var search = function () {
                new SearchOdata(Ext.getCmp('txtsearch').getValue());
                OdataDataStore.load();
            };
            var actionbtn = new Array();
            //begin
            Ext.Ajax.request({
                url: '../../../menuActions.jsp',
                params: {
                    str_VALUE: sessionStorage.getItem("menuIndex")
                },
                success: function (response) {

                    var isEditable = false;
                    var obj = Ext.decode(response.responseText);
                    if (obj != null) {

                        Ext.each(obj, function (i, v) {
                            var handlers;
                            var btn;
                            switch (i.str_HANDLER) {
                                case "create":
                                    handlers = create;
                                    break;
                                case "defaulthandler":
                                    handlers = defaulthandler;
                                    break;

                                case "search":
                                    handlers = search;
                                    break;
                                case "delete":
                                    handlers = supprimer;
                                    break;

                                default:
                                    handlers = defaulthandler;
                            }
                            ;
                            var text = "";
                            switch (i.str_TEXT) {
                                case "ml_Creer":
                                    text = "<%=OTranslate1.getValue(MultilangueKeys.ml_Creer.name())%>";
                                    break;
                                case "ml_VEHICLE_COLOR":
                                    text = "<%=OTranslate1.getValue(MultilangueKeys.ml_VEHICLE_COLOR.name())%>";
                                    break;
                                case "action_DETAIL":
                                    text = "<%=OTranslate1.getValue(MultilangueKeys.action_DETAIL.name())%>";
                                    break;
                                case "ml_Supprimer":
                                    text = "<%=OTranslate1.getValue(MultilangueKeys.ml_Supprimer.name())%>";
                                    break;
                                case "action_SEARCH":
                                    text = "<%=OTranslate1.getValue(MultilangueKeys.action_SEARCH.name())%>";
                                    break;

                            }
                            ;
                            if (i.str_XTYPE !== "menu") {
                                btn = {
                                    xtype: i.str_XTYPE,
                                    id: i.str_ID,
                                    text: text,
                                    tooltip: text,
                                    icon: i.str_ICON,
                                    handler: handlers

                                };
                            }


                            var separate = {
                                xtype: 'displayfield',
                                value: '<span class="xtb-sep"></span>'
                            };
                            actionbtn.push(btn);
                            actionbtn.push(separate);
                        });
                        actionbtn.pop();
                    }

                    menubar = [
                        actionbtn
                    ];
                    gridPanel = new Ext.grid.EditorGridPanel({
                        store: OdataDataStore,
                        cm: OdataColumnModel,
                        renderTo: 'content',
                        title: '<%=OTranslate1.getValue(MultilangueKeys.ml_MOTIF.name())%>',
                        frame: true,
                        height: 570,
                        width: '100%',
                        stripeRows: true,
                        loadMask: true,
                        trackMouseOver: false,
                        disableSelection: true,
                        clicksToEdit: 1,
                        selModel: new Ext.grid.RowSelectionModel({
                            singleSelect: true
                        }),
                        viewConfig: {
                            forceFit: true
                        },
                        enableColumnMove: true,
                        collapsible: true,
                        sm: new Ext.grid.RowSelectionModel({
                            singleSelect: true
                        }),
                        tbar: menubar,
                        bbar: pagingToolbar
                    });
                    // Handle double click action - edit a Odata.
                    gridPanel.on('rowdblclick', function (gridPanel, rowIndex, e) {
                        var selectedId = OdataDataStore.data.items[rowIndex].id;
                        new EditOdata(OdataDataStore, selectedId);
                    });
                    gridPanel.on('afteredit', SaveCurentObject);
                }


            });



            function SaveCurentObject(e) {

                Ext.Ajax.request({
                    waitMsg: 'Enregistrement en cours...',
                    url: 'cmp_transaction.jsp?mode=update',
                    params: {
                        gAction: OdataAction,
                        lg_REASONS_ID: e.record.data.lg_REASONS_ID,
                        str_DESCRIPTION: e.record.data.str_DESCRIPTION,
                        str_STATUT: e.record.data.str_STATUT,
                        str_NAME: e.record.data.str_NAME

                    },
                    success: function (response) {
                        var result = eval(response.responseText);
                        switch (result) {
                            case 1 :
                                OdataDataStore.commitChanges();
                                OdataDataStore.reload();
                                OdataAction = 'Modifier';
                                break;

                            case 2 :

                                Ext.MessageBox.alert('un partant du même code exist déja !');

                                break;

                            default :
                                Ext.MessageBox.alert('les données ne sont pas enregistré...');
                                break;

                        }

                    },
                    failure: function (response) {

                        var result = response.responseText;

                        Ext.MessageBox.alert('Erreur', result);

                    }

                });

            }

            // Handle double click action - edit a Odata.

        }
    }




    Ext.onReady(function () {

        new Listtype_course();

    });
</script>