function show_hide(id)
{
	
    var tmp = $("#"+id).css("display");
    if(tmp == 'none')
    {
        $("#"+id).slideDown(300);
        $("#img" + id).attr('src','/images/min.png');
        
    }
    else
    {
        $("#"+id).slideUp(300);
        $("#img" + id).attr('src','/images/max.png');
    }

 }
