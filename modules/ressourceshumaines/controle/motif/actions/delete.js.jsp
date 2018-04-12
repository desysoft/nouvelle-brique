<%@page import="toolkits.parameters.commonparameter"  %>
<%@page import="bll.userManagement.privilege"  %>
<%@page import="java.util.List"  %>
<%@page import="toolkits.utils.logger"  %>
<%@page import="toolkits.utils.jdom"  %>
<%@page import="multilangue.*"  %>
<%!    Translate OTranslate2 = null;
%>
<%
            OTranslate2 = new Translate();
//qsdfs

            if (session.getAttribute(commonparameter.local).equals(commonparameter.Local_Culture_Lg_ENGLISH)) {
                OTranslate2.setLocal_Cty(commonparameter.Local_Culture_city_ENGLISH);
                OTranslate2.setLocal_Lg(commonparameter.Local_Culture_Lg_ENGLISH);
            } else {
                OTranslate2.setLocal_Cty(commonparameter.Local_Culture_city_FRANCAIS);
                OTranslate2.setLocal_Lg(commonparameter.Local_Culture_Lg_FRANCAIS);
            }
%>

<script type="text/javascript">
    /**
     * This JS is used to handle deleting Odata(s).
     *
     * @author nvujasin
     * @Date May 4, 2008
     */
    DeleteOdata = function(OdataDataStore, OdataGridPanel) {
       // alert('11111');

        var selectedOdatas = OdataGridPanel.getSelectionModel().getSelections();
        // Check if any Odatas were selected.
        if (selectedOdatas.length > 0) {

            Ext.MessageBox.confirm('Message',
            '<%=OTranslate2.getValue(MultilangueKeys.ml_Confirm_Delete_General.name())%>',
            function(btn) {

                if (btn == 'yes') {

                    // Send a HTTP request to a remote server.
                    // Important: Ajax server requests are asynchronous, and this
                    // call will return before the response has been recieved.
                    // Process any returned data in a callback function.
                    new Ext.data.Connection().request({
                        url: 'cmp_transaction.jsp?mode=delete',
                        params: {lg_REASONS_ID: selectedOdatas[0].get("lg_REASONS_ID")},
                        failure: requestFailed,
                        success: requestSuccessful
                    });

                    // Reload the Record cache from the configured Proxy using the
                    // configured Reader.
                    //Ext.MessageBox.alert('Message', 'Suppression effectue avec succes!');
                    OdataDataStore.load({params: {start: 0, limit: 10}});
                }
            }
        );
        }
        else
        {
            Ext.MessageBox.alert('Error',
            'To process delete action, please select at least one Odata to delete.'
        );
        }

        /**
         * Handle a successful connection and http request to the server.
         * The response from the application may still be unsuccessful so
         * that needs to be checked.
         * @param {Object} response The XMLHttpRequest object containing the
         * 		response data. See http://www.w3.org/TR/XMLHttpRequest/ for
         *		details about accessing elements of the response.
         * @param {Object} options The parameter to the request call.
         */
        function requestSuccessful(response, options) {
  OdataDataStore.load({params: {start: 0, limit: 10}});
            // Decodes (parses) a JSON string to an object. If the JSON is invalid,
            // this function throws a SyntaxError.
            // The response text from the server is:
            // {success: true, message: 'Odata was deleted successfully.'}
            // The object will contain two variables: success and message.
            var object = Ext.util.JSON.decode(response.responseText);

            // If the delete was successfully executed on server.
            if (object.success) {
                Ext.Msg.alert('<%=OTranslate2.getValue(MultilangueKeys.ml_Confirm.name())%>!', 
                                        '<%=OTranslate2.getValue(MultilangueKeys.msg_success_delete.name())%>');
            } else {
                Ext.MessageBox.alert('Error Message', object.message);
            }
        }

        /**
         * Handle an unsuccessful connection or http request to the server.
         * This has nothing to do with the response from the application.
         * @param {Object} response The XMLHttpRequest object containing the
         * 		response data. See http://www.w3.org/TR/XMLHttpRequest/ for
         *		details about accessing elements of the response.
         * @param {Object} options The parameter to the request call.
         */
        function requestFailed(response, options) {

            // The request to the server was unsuccessful.
            Ext.MessageBox.alert('Error Message',
            "Please contact support with the following: " +
                "Status: " + response.status +
                ", Status Text: " + response.statusText);
        }
    }
</script>