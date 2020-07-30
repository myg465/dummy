function login(){
	var id_=$("#id").val();
	var pw_=$("#pw").val();
	var id=encodeURI(id_);
	var pw=encodeURI(pw_);
	  $.ajax({
	        url : "loginOk",
	        type : "POST",
	        data: JSON.stringify({id:id,pw:pw}),
	        contentType: "application/json",
	        success : function(data){
	        	console.log(data.result);
	        	var result=data.result;
	           if(result == 'ok'){
	        	   console.log('로그인이 성공');
	        	   window.location.href="list";
	           }
	           else{
	        	   console.log('로그인이 실패');
	        	   $("#loginResult").text("아이디나 비밀번호가 틀렸습니다.");
	           }
	        },
	        error : function(){
	           alert("통신 중 오류가 발생하였습니다. 잠시 후 다시 시도해주세요.\n오류가 반복될 경우, 고객센터로 문의 부탁드립니다.\n(error_code: checkError)");
	        }
	     }); 
	
}