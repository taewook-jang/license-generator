<%@ page import="io.dat.domain.init.DatabaseInitService" %>
<%@ page import="com.chequer.axboot.core.context.AppContextManager" %>
<%@ page import="com.chequer.axboot.core.utils.SessionUtils" %>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ax" tagdir="/WEB-INF/tags" %>
<%
    boolean initialized = AppContextManager.getBean(DatabaseInitService.class).initialized();

    String lastNavigatedPage = null;

    if (SessionUtils.isLoggedIn()) {
        lastNavigatedPage = "/jsp/main.jsp";
    }

    if (initialized) {
        request.setAttribute("redirect", lastNavigatedPage);
    } else {
        request.setAttribute("redirect", "/setup");
    }
%>

<c:if test="${redirect!=null}">
    <c:redirect url="${redirect}"/>
</c:if>

<ax:set key="axbody_class" value="login"/>

<ax:layout name="empty">
    <jsp:attribute name="css">
        <style>
            .ax-body.login {
                background: url(${config.background.login}) center center;
                background-size: cover;
                color: #ccc;
            }

            .ax5-ui-dialog .ax-dialog-body .ax-dialog-msg {
                color: black;
            }
        </style>
    </jsp:attribute>

    <jsp:attribute name="js">
        <script>
            axboot.requireSession('${config.sessionCookie}');
        </script>
        <%--<script type="text/javascript" src="<c:url value='/assets/js/axboot/dist/good-words.js' />"></script>--%>
    </jsp:attribute>

    <jsp:attribute name="script">
        <script type="text/javascript">

            var fnObj = {
                /*pageStart: function () {
                    $("#good_words").html(goodWords.get());
                },*/
                login: function () {
                    axboot.ajax({
                        method: "POST",
                        url: "/api/login",
                        data: JSON.stringify({
                            "userCd": $("#userCd").val(),
                            "userPs": $("#userPs").val()
                        }),
                        callback: function (res) {
                           location.reload();
                        },
                        options: {
                            nomask: false, apiType: "login",
                            onError: function(err){
                                axDialog.alert({
                                    title: '로그인 실패',
                                    theme: "default",
                                    msg: err.message
                                });
                            }
                        }
                    });
                    return false;
                }
            };
        </script>
    </jsp:attribute>

    <jsp:body>
        <ax:flex-layout valign="middle" align="center" style="width:100%;height:100%;">
            <div>
                <img src="${pageContext.request.contextPath}${config.logo.login}" class="img-logo">
            </div>

            <div class="panel">
                <div class="panel-heading"><ax:message code="axboot.admin.login.guide.message"/></div>
                <div class="panel-body">
                    <form name="login-form" class="" method="post" action="/api/login" onsubmit="return fnObj.login();" autocomplete="off">

                        <div class="form-group">
                            <label for="userCd"><i class="cqc-new-message"></i> <ax:message code="axboot.admin.id"/></label>
                            <input type="text" name="userCd" id="userCd" value="system" class="form-control ime-false" placeholder=""/>
                        </div>

                        <div class="form-group">
                            <label for="userPs"><i class="cqc-key"></i> <ax:message code="axboot.admin.password"/></label>
                            <input type="password" name="userPs" id="userPs" value="1234" class="form-control ime-false" placeholder=""/>
                        </div>

                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>

                        <div class="ax-padding-box" style="text-align: right;">
                            <button type="submit" class="btn">&nbsp;&nbsp;<ax:message code="axboot.admin.login"/>&nbsp;&nbsp;</button>
                        </div>

                    </form>
                </div>
                <ul class="list-group">
                    <li class="list-group-item">
                        <a href="#"><ax:message code="axboot.admin.find.id"/></a>
                        &nbsp;
                        &nbsp;
                        <a href="#"><ax:message code="axboot.admin.find.password"/></a>
                    </li>
                </ul>
            </div>

            <div class="txt-copyrights">
                    ${config.copyrights}
            </div>

            <%--<div class="txt-good-words" id="good_words">

            </div>--%>
        </ax:flex-layout>
    </jsp:body>

</ax:layout>
