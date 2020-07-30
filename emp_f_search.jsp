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
	String SQL = "select b.empnm,(select value from comcd_t where div='rela' and code=(select min(relacd) from empfamily_t where empcd=b.empcd)) rela,((select count(*) from empfamily_t where empcd=b.empcd and childeatra is not null) * (select value from comcd_t where code='child')) childco,((select count(*) from empfamily_t where empcd=b.empcd and oldeatra is not null) * (select value from comcd_t where code='old')) oldco,(select value from comcd_t where code=(select empzipcd from empbasics_t where empcd=b.empcd)) addr from empbasics_t b order by b.empcd";

	rs = stmt.executeQuery(SQL);

	/********* Dataset Create ************/
	DataSet ds = new DataSet("empFamilyCo");
	ds.addColumn("empNm", DataTypes.STRING, 20);
	ds.addColumn("rela", DataTypes.STRING, 20);
	ds.addColumn("childCo", DataTypes.STRING, 30);
	ds.addColumn("oldCo", DataTypes.STRING, 30);
	ds.addColumn("addr", DataTypes.STRING, 256);
	int row = 0;
	while (rs.next()) {
		
		row = ds.newRow();
		ds.set(row, "empNm", rs.getString("empNm"));
		ds.set(row, "rela", rs.getString("rela"));
		ds.set(row, "childCo", rs.getString("childCo"));
		ds.set(row, "oldCo", rs.getString("oldCo"));
		ds.set(row, "addr", rs.getString("addr"));
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