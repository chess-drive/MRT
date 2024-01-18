<%--
  Created by Eclipse.
  User: BBUGGE
  Date: 2023-12-28
  Time: ì¤ì  10:09
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<%@include file="/WEB-INF/views/header.jsp" %>
<script src="${CTX}/resources/js/kakao-1.38.0.js"></script>
<script type="text/javascript" src="https://static.nid.naver.com/js/naveridlogin_js_sdk_2.0.0.js" charset="utf-8"></script>
<script type="text/javascript">
    $(function(){
        Kakao.init('${paramMap.kakaoKey}');
        Kakao.Auth.createLoginButton({
            container: '#kakaoButton',
            success: function(response) {
                console.log("test : "+response);

                $.ajax({
                    type: "GET",
                    url: "/manager/kakaoLogin",
                    data: response,
                    cache: "false",
                    dataType: "JSON",
                    success: function (data) {
                        console.log(data.RESULT);
                        if(data.RESULT == 1){
                            alert("로그인 후 [마이페이지]에서 회원전환을 해주세요.");
                            location.href = "/login";
                        }else if(data.RESULT == 2){
                            location.href = "/";
                        }else if (data.RESULT == -1){
                            alert(data.MESSAGE);
                        }
                    }
                });
            },
            fail: function(error) {
                console.log(error);
            },
        });
    })
    function login(data){
        var param = {};
        param.id = data.obj_id.val();
        param.pw = data.obj_pw.val();
        param.url = data.url;

        if(isNull(param.id)){
            alert("아이디를 입력해주세요.");
            data.obj_id.focus();
            return;
        }

        if(isNull(param.pw)){
            alert("비밀번호를 입력해주세요.");
            data.obj_pw.focus();
            return;
        }

        $.ajax({
            type:"GET",
            url:"/manager/login/merchantLoginAjax",
            data: param,
            cache:"false",
            dataType:"JSON",
            success :function(res){
                if(res){
                    if(param.url == 'reload'){
                        location.reload();
                    }else{
                        location.href = param.url;
                    }
                }else{
                    alert("아이디 또는 비밀번호를 확인해주세요.");
                    return;
                }
            }
        })
    }
    function Login(){
        var data = {};
//        var referrer = document.referrer;
        data.obj_id = $('#merchant_id');
        data.obj_pw = $('#merchant_passwd');
        data.url = "/manager"
        /*if(isNull(referrer)){
            data.url = '/';
        }else{
            data.url = referrer;
        }*/
        login(data);
    }
    function moveCreateAccount(){
        location.href="/member/preMemberJoin";
    }
    function moveSearchID(){
        location.href = "/findID";
    }
    function moveSearchPasswd(){
        location.href = "/findPW";
    }
</script>

<body>
<div class="wrap">
    <div class="login-wrap">
        <ul class="login-body">
            <li class="login">
                <h1><img class="pointer" src="${CTX}/resources/image/logo_wh.png" onerror="imgError(this,'${CTX}')"> DB 로그인</h1>
                <ul>
                    <!-- <li>
                    	<select class="id" name="dbms" id="dbms">
	                    	<option value="ORACLE">ORACLE</option>
	                    	<option value="MYSQL" selected>MYSQL</option>
	                    	<option value="MARIADB">MARIADB</option>
	                    	<option value="ALTIBASE">ALTIBASE</option>
                    	</select>
                    </li> -->
                    <li><input type="text" class="id" name="db_ip" id="db_ip" onkeyup="if(event.keyCode==13)Login();" placeholder="DB IP ADDRESS"></li>
                    <li><input type="text" class="id" name="db_port" id="db_port" onkeyup="if(event.keyCode==13)Login();" placeholder="DB PORT"></li>
                    <li><input type="text" class="id" name="id" id="id" onkeyup="if(event.keyCode==13)Login();" placeholder="DB 계정 아이디"></li>
                    <li><input type="password" class="pw" name="passwd" id="passwd" onkeyup="if(event.keyCode==13)Login();" placeholder="DB 계정 비밀번호"></li>
                    <li><button type="button" class="btn-login" onclick="merchantLogin()">로그인</button></li>
                    <li class="link"></li>
                    <hr/>
                    <li></li>
                </ul>
            </li>
        </ul>
    </div>
</div>
</body>
</html>
