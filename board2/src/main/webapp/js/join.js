function idCheck(){
	var id_=$("#id").val();
	var id=encodeURI(id_);
	  $.ajax({
	        url : "idCheck",
	        type : "POST",
	        data: JSON.stringify({id:id}),
	        contentType: "application/json",
	        success : function(data){
	        	console.log(data.result);
	        	var result=data.result;
	           if(result == 'ok'){
	        	   $("#checkResult").text("아이디를 사용하실수 있습니다.");
	        	   $("#id").attr('readonly','readonly');
	        	   $("#check").val('y');
	           }
	           else{
	        	   $("#checkResult").text("중복된 아이디가 있습니다.");
	        	   $("#id").val("");
	        	   $("#check").val('n');
	           }
	        },
	        error : function(){
	           alert("통신 중 오류가 발생하였습니다. 잠시 후 다시 시도해주세요.\n오류가 반복될 경우, 고객센터로 문의 부탁드립니다.\n(error_code: checkError)");
	        }
	     }); 
	
}

function allCheck(){
	
	var name_ch=/^[가-힣]+$/
	
	if(join_form.id.value==null || join_form.id.value==""){
		alert("아이디를 입력해 주세요");
		join_form.id.focus();
		return false;
	}
	if(join_form.check.value!='y'){
		alert("아이디 중복체크를 해주세요");
		join_form.id.focus();
		return false;
	}
	if(join_form.pw.value!=join_form.pw2.value){
		alert("비밀번호가 같지 않습니다.");
		join_form.pw2.value=="";
		return false;
	}
	if(!(name_ch.test(join_form.name.value))){
		alert("이름은 한글만 가능합니다.");
		join_form.name.value=="";
		return false;
	}
	return true;
}