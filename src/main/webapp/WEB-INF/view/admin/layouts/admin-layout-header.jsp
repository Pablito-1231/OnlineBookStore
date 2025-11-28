<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Admin Panel</title>
    <link href="${pageContext.request.contextPath}/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/theme-unified.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin-modern.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin-modern-v2.css">
</head>
<body class="admin-wrapper">
<div style="display:flex; margin:0; padding:0;">

<%@ include file="../sidebar.jsp" %>

<main class="admin-main">
