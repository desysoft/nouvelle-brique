<%@page import="dal.TEmploye"  %>
<%@page import="toolkits.parameters.commonparameter"  %>
<%@page import="bll.userManagement.privilege"  %>
<%@page import="dal.TPrivileges"  %>
<%@page import="java.util.List"  %>
<%@page import="toolkits.utils.logger"  %>
<%@page import="toolkits.utils.jdom"  %>
<%@page import="multilangue.*"  %>
<%!
Translate OTranslate9= null;
%>
<%
      OTranslate9= new Translate();

//qsdfsf
           if (session.getAttribute(commonparameter.local).equals(commonparameter.Local_Culture_Lg_ENGLISH)) {
                OTranslate9.setLocal_Cty(commonparameter.Local_Culture_city_ENGLISH);
                OTranslate9.setLocal_Lg(commonparameter.Local_Culture_Lg_ENGLISH);
            } else {
                OTranslate9.setLocal_Cty(commonparameter.Local_Culture_city_FRANCAIS);
                OTranslate9.setLocal_Lg(commonparameter.Local_Culture_Lg_FRANCAIS);
            }
%>

<script type="text/javascript">

/**
 * This JS is used to handle deleting Odata(s).
 * hbhiuh uhih ihihn nininininjnojhohh
 * @author nvujasin
 * @Date May 4, 2008
 */
SearchOdata = function(search_value,OdataDataStore) {

    new Ext.data.Connection().request({
        url: 'cmp_grid.jsp?search_value='+search_value,
        failure: submitFailed,
        success: requestSuccessful
    });


    // Reload the Record cache from the configured Proxy using the
    // configured Reader.


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

        // Decodes (parses) a JSON string to an object. If the JSON is invalid,
        // this function throws a SyntaxError.
        // The response text from the server is:
        // {success: true, message: 'Odata was deleted successfully.'}
        // The object will contain two variables: success and message.
        var object = Ext.util.JSON.decode('{success:true}');
        //  alert(object.success);
        // If the delete was successfully executed on server.
        if (object.success) {
           // Ext.Msg.alert('<%=OTranslate9.getValue(MultilangueKeys.ml_Confirm.name())%>!', obj.errors.reason);
        } else {
            obj = Ext.util.JSON.decode(response.responseText);
            Ext.Msg.alert('Echec de suppression de la course!', obj.errors.reason);
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

    function submitFailed(form, action){
        if(action.failureType == 'server'){
            obj = Ext.util.JSON.decode(action.response.responseText);
            Ext.Msg.alert('Echec de suppression de course!', obj.errors.reason);
        }else{
            Ext.Msg.alert('Attention!', 'Identification serveur injoignable : ' + action.response.responseText);
        }
    }

}

</script>