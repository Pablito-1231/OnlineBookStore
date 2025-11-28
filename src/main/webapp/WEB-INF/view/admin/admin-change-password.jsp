<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="../layouts/admin-layout-header.jsp" %>

<div class="container-fluid p-0">
    <div class="row justify-content-center">
        <div class="col-lg-6">
            <div class="glass-card mt-5">
                <h2 class="mb-4 text-center">Cambiar contraseña de administrador</h2>
                <c:if test="${not empty message}">
                    <div class="alert ${messageType eq 'error' ? 'alert-danger' : 'alert-success'}">
                        ${message}
                    </div>
                </c:if>
                <form method="post" action="${pageContext.request.contextPath}/admin/change-password/process">
                    <div class="form-group">
                        <label>Contraseña actual</label>
                        <input type="password" name="oldPassword" class="form-control" required autofocus>
                    </div>
                    <div class="form-group">
                        <label>Nueva contraseña</label>
                        <input type="password" name="newPassword" class="form-control" required>
                    </div>
                    <div class="form-group">
                        <label>Confirmar nueva contraseña</label>
                        <input type="password" name="confirmPassword" class="form-control" required>
                    </div>
                    <button type="submit" class="btn btn-primary w-100 mt-3">Cambiar contraseña</button>
                </form>
            </div>
        </div>
    </div>
</div>

<%@ include file="../layouts/admin-layout-footer.jsp" %>
