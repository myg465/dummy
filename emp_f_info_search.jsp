<%@ page import="java.util.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.io.*"%>
<%@ page import="com.nexacro17.xapi.data.*"%>
<%@ page import="com.nexacro17.xapi.tx.*"%>

<%@ page contentType="text/xml; charset=utf-8"%>

<%
	/****** Service API initialization ******/
PlatformData pdata = new PlatformData();

int nErrorCode = 0;
String strErrorMsg = "START";

/******* JDBC Connection *******/
Connection conn = null;
Statement stmt = null;
ResultSet rs = null;

try {
	Class.forName("oracle.jdbc.driver.OracleDriver");
	String url = "jdbc:oracle:thin:@localhost:1521:orcl";
	String id = "ora_user";
	String pw = "1234";
	conn = DriverManager.getConnection(url, id, pw);
	stmt = conn.createStatement();
	/******* SQL query *************/
	String SQL="select\n"+ 
			  "a.empNm,\n"+
			  "c.value rela,\n"+
			  "case\n"+
			    "when b.relacd = 1\n"+
			    "  then a.empnm\n"+
			    "else\n"+
			    "  (select familyname\n"+
			    "  from familyinfo_t\n"+
			    "  where relacd=b.relacd and empcd=a.empcd)\n"+
			    "end familyname\n"+
			"from\n"+
			  "empbasics_t a,\n"+
			  "empfamily_t b,\n"+
			  "(select code,value from comcd_t where div='rela') c\n"+
			"where\n"+ 
			  "b.relacd=c.code\n"+ 
			  "and\n"+ 
			  "a.empcd=b.empcd";
	
	rs = stmt.executeQuery(SQL);

	/********* Dataset Create ************/
	DataSet ds = new DataSet("empFamily");
	ds.addColumn("empNm", DataTypes.STRING, 30);
	ds.addColumn("familyName", DataTypes.STRING, 30);
	ds.addColumn("rela", DataTypes.STRING, 40);
	int row = 0;
	while (rs.next()) {
		
		row = ds.newRow();
		ds.set(row, "empNm", rs.getString("empNm"));
		ds.set(row, "familyName", rs.getString("familyName"));
		ds.set(row, "rela", rs.getString("rela"));
	}

	/********* Adding Dataset to PlatformData ************/
	pdata.addDataSet(ds);
	System.out.println("ds : "+ds.toString());
	nErrorCode = 0;
	strErrorMsg = "SUCC";
} catch (SQLException e) {
	nErrorCode = -1;
	strErrorMsg = e.getMessage();
}

/******** JDBC Close *******/
if (stmt != null)
	try {
		stmt.close();
	} catch (Exception e) {
	}
if (conn != null)
	try {
		conn.close();
	} catch (Exception e) {
	}

PlatformData senddata = new PlatformData();
VariableList varList = senddata.getVariableList();
varList.add("ErrorCode", nErrorCode);
varList.add("ErrorMsg", strErrorMsg);

/******** XML data Create ******/
HttpPlatformResponse res = new HttpPlatformResponse(response, PlatformType.CONTENT_TYPE_XML, "UTF-8");
res.setData(pdata);
res.sendData();
%>