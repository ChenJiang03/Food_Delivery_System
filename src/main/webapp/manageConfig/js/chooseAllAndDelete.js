window.addEventListener("load",function (){
    $(".link-del").click(function (){
        //data-xxx data("xxx")
        //确认对话框 如果点击确认返回true，否则返回false
        if(confirm("是否确认删除?")){
            var id=$(this).data("id");
            var dataType=$(this).data("type")
            console.log(dataType)
            var path = $(this).data("path")
            $.ajax({
                url:path+"/manage/common/delete?dataType="+dataType+"&&id="+id,
                type:"post",
                data:{id:id},
                // success:(data)=>{
                //     if(data=="success"){
                //         $(this).parents("tr").remove();
                //     }
                //     else{
                //         alert("不好意思，删除失败了");
                //     }
                // }
                success:function (data){
                    if(data=="success"){
                        $(this).parents("tr").remove();
                    }
                    else if(data=="fail"){
                        alert("不好意思，删除失败了");
                    }
                }.bind(this)
            });
        }
        return false;  //阻止a标签跳转链接
    });

    //全选
    $(".allChoose").click(function (){
        $(".check").prop("checked",$(this).prop("checked"))
    })


  // 批量删除
    $("#batchDel").click(function (){
        if(!confirm("是否确认批量删除?")){
            return;
        }
        var idArr = new Array();
        var dataType=$(this).data("type")
        console.log(dataType)
        var path = $(this).data("path")
        $(".check:checked").each(function (){
            var id = $(this).data("id")
            idArr.push(id)
        })
        if (idArr.length==0){
            alert("请选择要删除的项目")
        }
        var idStr = idArr.join(",")
        console.log(idStr)

        $.ajax({
            url:path+"/manage/common/batchDel?dataType="+dataType,
            type: "post",
            data:{ids:idStr},
            success: function (data){
                if(data=="success"){
                    for (var i=0;i<idArr.length;i++) {
                        $("#tr_" + idArr[i]).remove()
                    }
                    location.reload()
                }else if(data=="fail"){
                    alert("批量删除失败！")

                }


            }


        })



    })



})