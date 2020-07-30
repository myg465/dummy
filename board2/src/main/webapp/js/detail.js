function re_write(authId_,board_id_){
	
	var re_content=$("#re_write_content").val();
//	var re_content=encodeURI(re_content_);
	console.log(re_content);
	var authId=encodeURI(authId_);
	var board_id=encodeURI(board_id_);
	  $.ajax({
	        url : "reply_write",
	        type : "POST",
	        data: JSON.stringify({authId:authId,re_content:re_content,board_id:board_id}),
	        contentType: "application/json",
	        success : function(data){
	        	var result=data.result;
	           if(result == 'ok'){
	        	   alert('댓글이 작성되었습니다.');
	        	   location.reload();
	           }
	           else{
	        	   alert('댓글등록 실패');
	           }
	        },
	        error : function(){
	           alert("통신 중 오류가 발생하였습니다. 잠시 후 다시 시도해주세요.\n오류가 반복될 경우, 고객센터로 문의 부탁드립니다.\n(error_code: checkError)");
	        }
	  }); 
	
}

function re_modify(reply_id_){
	
	var modify_content=$("#re_modify_content").val();
	var reply_id=encodeURI(reply_id_);
	  $.ajax({
	        url : "reply_modify",
	        type : "POST",
	        data: JSON.stringify({reply_id:reply_id,re_content:modify_content}),
	        contentType: "application/json",
	        success : function(data){
	        	var result=data.result;
	           if(result == 'ok'){
	        	   alert('수정이 완료되었습니다.');
	        	   location.reload();
	           }
	           else{
	        	   alert('수정 실패');
	           }
	        },
	        error : function(){
	           alert("통신 중 오류가 발생하였습니다. 잠시 후 다시 시도해주세요.\n오류가 반복될 경우, 고객센터로 문의 부탁드립니다.\n(error_code: deleteError)");
	        }
	  }); 
	
}

function re_delete(reply_id_){
	
	var reply_id=encodeURI(reply_id_);
	if(confirm("댓글을 삭제하시겠습니까?")){
	  $.ajax({
	        url : "reply_delete",
	        type : "POST",
	        data: JSON.stringify({reply_id:reply_id}),
	        contentType: "application/json",
	        success : function(data){
	        	var result=data.result;
	           if(result == 'ok'){
	        	   alert('삭제가 완료되었습니다.');
	        	   location.reload();
	           }
	           else{
	        	   alert('삭제 실패');
	           }
	        },
	        error : function(){
	           alert("통신 중 오류가 발생하였습니다. 잠시 후 다시 시도해주세요.\n오류가 반복될 경우, 고객센터로 문의 부탁드립니다.\n(error_code: deleteError)");
	        }
	  }); 
	}
}