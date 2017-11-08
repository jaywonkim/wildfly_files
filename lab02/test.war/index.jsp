<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ page import="java.net.InetAddress" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
    <title>Insert title here</title>
  </head>
  <body>
    <h1>Session Tracking Test</h1>
    Session tracking with JSP is easy
    <P>
    <%@ page session="true" %>
    <%
        Integer ival = (Integer) session.getValue ("counter");
        if(ival == null)
            ival = new Integer (1);
        else
            ival = new Integer (ival.intValue() + 1);
        session.putValue ("counter", ival);
    %>
    <h4>jvmRoute Name : <%=session.getId().substring(session.getId().indexOf(".") + 1) %></h4>
    You have hit this page <%= ival %> times.<br>
    <%
        out.println("Your Session ID is " + session.getId() +  "<br>");
        System.out.println("\n[SESSION_ID][" + session.getId() + "][COUNTER][" + ival + "]");
    %>
  </body>
</html>
