<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"></c:set>

<div class="sidebar">
  <a href="${ctp}/adMain.ad"><i class="fa fa-fw fa-home"></i> Home</a>
  <a href="${ctp}/adRoom.ad"><i class='bx bxs-buildings'></i> Room</a>
  <a href="${ctp}/adMemList.ad"><i class="fa fa-fw fa-user"></i> Client</a>
  <a href="${ctp}/adReserveList.ad"><i class='bx bxs-calendar-edit'></i> Reservation</a>
  <a href="${ctp}/adCoupon.ad"><i class='bx bxs-party'></i> Event</a>
  <a href="${ctp}/"><i class='bx bx-log-out'></i> Exit</a>
</div>