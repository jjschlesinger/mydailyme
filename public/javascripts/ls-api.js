 // Replace the following string with the AppId you received from the
    // Live Search Developer Center.
    var LSAppId = "A0F2E63EE5C53FE635DD0854AAD21F3E74FE2B3E";
    
    // Live Search API 2.0 code sample demonstrating the use of the
    // Image SourceType over the JSON Protocol.
    function LiveSearch(query, count, offset, adultFilter, callback)
    {
        var requestStr = "http://api.search.live.net/json.aspx?"
        
            // Common request fields (required)
            + "AppId=" + LSAppId
            + "&Query=" + query
            + "&Sources=Image"
            
            // Common request fields (optional)
            + "&Version=2.0"
            + "&Market=en-us"
            + "&Adult=" + adultFilter

            // Image-specific request fields (optional)
            + "&Image.Count=" + count
            + "&Image.Offset=" + offset

            // JSON-specific request fields (optional)
            + "&JsonType=callback"
            + "&JsonCallback=" + callback;

        var requestScript = document.createElement("script");
        requestScript.type = "text/javascript";
        requestScript.src = requestStr;
        
        var head = document.getElementsByTagName("head");
        head[0].appendChild(requestScript);
    }
