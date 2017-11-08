<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="javax.naming.*"%>
<%@page import="javax.sql.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>

<h1>DB Connection Test</h1>
<%

 PreparedStatement ptmt = null;
 ResultSet rs = null;
 String str = null;

 
DataSource ds = null;

	try{
		Context ct = new InitialContext();
		ds = (DataSource)ct.lookup("java:/jboss/JBTravelDatasource");
		System.out.println("success to look up");
	}catch(NamingException e){
		e.printStackTrace();
		System.out.println("fail to find datasource");
	}

 try{
   Connection con = ds.getConnection(); 
     String sql = "select version()";
     ptmt = con.prepareStatement(sql);
	 rs = ptmt.executeQuery();
	 rs.next();
	 System.out.println(rs);
     str=rs.getString(1);
     //add
     //Thread.sleep(100);
                if(rs != null) {
                    rs.close();
                }
                if(ptmt != null) {
                    ptmt.close();
                }
                if(con != null) {
                    con.close();
                }
    
 } catch(Exception e){
	 System.out.println(e);
 }

%>
Information about version<p/>
<%=str %>
</body>
</html>

