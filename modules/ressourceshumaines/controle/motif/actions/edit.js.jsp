<%@page import="toolkits.parameters.commonparameter"  %>
<%@page import="bll.userManagement.privilege"  %>
<%@page import="java.util.List"  %>
<%@page import="toolkits.utils.logger"  %>
<%@page import="toolkits.utils.jdom"  %>
<%@page import="multilangue.*"  %>
<%!    Translate OTranslate10 = null;
%>
<%
            OTranslate10 = new Translate();
//dsds
            new logger().OCategory.debug(jdom.int_size_pagination);
            if (session.getAttribute(commonparameter.local).equals(commonparameter.Local_Culture_Lg_ENGLISH)) {
                OTranslate10.setLocal_Cty(commonparameter.Local_Culture_city_ENGLISH);
                OTranslate10.setLocal_Lg(commonparameter.Local_Culture_Lg_ENGLISH);
            } else {
                OTranslate10.setLocal_Cty(commonparameter.Local_Culture_city_FRANCAIS);
                OTranslate10.setLocal_Lg(commonparameter.Local_Culture_Lg_FRANCAIS);
            }
%>

<script type="text/javascript">
    /**
     * This JS is used to handle the new Odata create action.
     *
     * @author nvujasin
     * @Date May 1, 2008
     */
    var new_date='';
    var new_time='';


    EditOdata = function(OdataDataStore, selectedId) {



        var str_DESCRIPTION = new Ext.form.TextField({
            fieldLabel: 'DESCRIPTION',
            allowBlank: false,
            name: 'str_DESCRIPTION',
            anchor: '90%'
        });


        var str_NAME = new Ext.form.TextField({
            fieldLabel: 'NOM',
            allowBlank: false,
            name: 'str_NAME',
            anchor: '90%'
        });

    /*  var str_PHONE = new Ext.form.TextField({
            fieldLabel: 'N° TELEPHONE:',
            allowBlank: false,
            name: 'str_PHONE',
            anchor: '90%'
        });
        var str_MAIL = new Ext.form.TextField({
            fieldLabel: 'str_EMAIL',
           
            name: 'str_MAIL',
            anchor: '90%',
             vtype: 'email',
            vtypeText: 'Veuillez saisir un e-mail valide'
        });*/



        // By default, Ext Forms are submitted through Ajax, using Ext.form.Action.
        // To enable normal browser submission of the Ext Form contained in this
        // FormPanel, override the Form's onSubmit, and submit methods. The onSubmit
        // method is overridden here with an empty function (does nothing). The submit
        // method is overridden in the saveOdata function below.
        var formPanel = new Ext.form.FormPanel({
            baseCls: 'x-plain',
            labelWidth: 120,
            url:'cmp_transaction.jsp?mode=update&lg_REASONS_ID='+selectedId,	// When the form is submitted call this url.

            onSubmit: Ext.emptyFn,


            reader: new Ext.data.JsonReader(
           {
                root: 'results',				// Name of the property which contains the Array of row objects.
                id: 'lg_REASONS_ID' 							// Name of the property within a row object that contains a record identifier value.
            },
            [
                {
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
        ),


            items: [
                str_NAME,
                str_DESCRIPTION
                
            ]
        });




        formPanel.form.load({
            url: 'cmp_grid.jsp?lg_REASONS_ID=' + selectedId,
            waitTitle:'Chargement',
            waitMsg:'Please wait...'
        });



        // Define a window with the form panel in it and show it.
        var Mywindow = new Ext.Window({
            title: 'Modifier Motif',
            width: 400,
            height: 210,
            minWidth: 300,
            minHeight: 200,
            layout: 'fit',
            plain: true,
            bodyStyle: 'padding:5px;',
            buttonAlign: 'center',
            items: formPanel,

            buttons: [{
                    text: '<%=OTranslate10.getValue(MultilangueKeys.action_REGISTER.name())%>',
                    handler: saveOdata					// The method to call when the save button is clicked.
                },{
                    text: '<%=OTranslate10.getValue(MultilangueKeys.action_CANCEL.name())%>',
                    handler: cancelAdd					// The method to call when the cancel button is clicked.
                }]
        });

        Mywindow.show();								// Display the popup window.
        // Display the popup window.

        /**
         * Method is called when the cancel button is clicked on the create Odata window.
         * Simply hide the window.
         */
        function cancelAdd() {
            // window.hide();
            Mywindow.close();
        }

        /**
         * Method is called when the save button is clicked on the create Odata window.
         * Method validates the form in the window and if valid, submits the form to the
         * server. If the form is not valid then let's the user know of any errors.
         * Handles the server response (successful or unsuccessful) accordingly.
         */
        function saveOdata() {

            // Check if the form is valid.
            if (formPanel.form.isValid()) {

                // If the form is valid, submit it.
                // To enable normal browser submission of the Ext Form contained in this
                // FormPanel, override the submit method.
                formPanel.form.submit({
                    waitMsg: 'In processing',
                    // The function to call when the response from the server was a failed
                    // attempt (save in this case), or when an error occurred in the Ajax
                    // communication.
                    failure: submitFailed,
                    // The function to call when the response from the server was a successful
                    // attempt (save in this case).
                    success: submitSuccessful
                });
            } else {
                // If the form is invalid.
                Ext.MessageBox.alert('Error Message', 'Please fix the errors noted.');
            }
        }




        /**
         * The function to call when the response from the server was a successful
         * attempt (save in this case). The function is passed the following parameters:
         *
         * @param {Ext.form.BasicForm} form The form that requested the action.
         * @param {Ext.form.Action} action The Action class.
         * The result property of this object may be examined to perform custom postprocessing.
         *
         * A successful attempt (save in this case) response from the server will be:
         * {success: true, message: 'Success message to be displayed.'}
         */
        function submitSuccessful(form, action) {
            Mywindow.close();
            // window.hide();

            // Reload the data store with a call to the server and load
            // the grid again with the newly added Odata.
            OdataDataStore.load({
                params:{
                    start:0,
                    limit:10
                }
            });
            obj = Ext.util.JSON.decode(action.response.responseText);
            Ext.Msg.alert('Succes Modification!', "Modification effectuée avec succès");
            // Hide the popup window.

        }

        /**
         * The function to call when the response from the server was a failed
         * attempt (save in this case), or when an error occurred in the Ajax
         * communication. The function is passed the following parameters:
         * @param {Ext.form.BasicForm} form The form that requested the action.
         * @param {Ext.form.Action} action The Action class.
         * If an Ajax error ocurred, the failure type will be in failureType.
         * The result property of this object may be examined to perform custom postprocessing.
         *
         * A failed attempt (save in this case) response from the server will be:
         * {success: false, message: 'Failure message to be displayed.'}
         *
         * A failed attempt (validation in this case) response from the server will be:
         * {
         *	 success: false,
         *   errors: {
         *	   "clientCode": "Client not found",
         *     "phone": "This field must be in the format of xxx-xxx-xxxx"
         *   },
         *   message : 'Validation Errors, please fix the errors noted.'
         * }
         */
        // action.result.message
        function submitFailed(form, action){
            if(action.failureType == 'server'){
                obj = Ext.util.JSON.decode(action.response.responseText);
                Ext.Msg.alert('Echec de creation de course!', obj.errors.reason);
            }else{
                Ext.Msg.alert('Attention!', 'Identification serveur injoignable : ' + action.response.responseText);
            }
        }


        // NOTES ON SUBMITTING A FORM.
        // Ext.action.Form.Submit
        // A class which handles submission of data from Forms and
        // processes the returned response.
        // Instances of this class are only created by a Form when submitting.
        // A response packet must contain a boolean success property, and,
        // optionally an errors property. The errors property contains
        // error messages for invalid fields.
        // By default, response packets are assumed to be JSON, so a
        // typical response packet may look like this:
        // {
        //	 success: false,
        //   errors: {
        //	   "clientCode": "Client not found",
        //     "phone": "This field must be in the format of xxx-xxx-xxxx"
        //   },
        //   message : 'Validation Errors, please fix the errors noted.'
        // }
        // Other data may be placed into the response for processing the
        // Ext.form.BasicForm's callback or event handler methods.
        // The object decoded from this JSON is available in the
        // result property.
        //
        // Instances of Ext.form.Action are only created by
        // a Form when the Form needs to perform an action such as
        // submit or load:
        // 		submit - Ext.form.Action.Submit,
        //		load - Ext.form.Action.Load
        // The instance of Action which performed the action is passed
        // to the success and failure callbacks of the Form's action
        // methods (submit, load and doAction) event handlers.  The object
        // decoded from JSON is available in the result property.
    }
</script>