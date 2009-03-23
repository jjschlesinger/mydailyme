function show_hide(id)
{
    var tmp = $("#"+id).css("display");
    if(tmp == 'none')
    {
        $("#"+id).show();
        $("#img" + id).attr('src','/images/min.png');
        
    }
    else
    {
        $("#"+id).hide();
        $("#img" + id).attr('src','/images/max.png');
    }

 }
