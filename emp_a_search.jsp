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
	String SQL="select b.empnm,\n"+
			"nvl(a.annuald,0)annuald,\n"+
			"nvl(a.quantityd,0)quantityd,\n"+
			"nvl((a.annuald-a.quantityd),0) remaind,\n"+
			"case\n"+
			"when nvl((a.annuald-a.quantityd),0) <10 then (nvl((a.annuald-a.quantityd),0) * (select to_number(value) from comcd_t where div='annual' and code=1))\n"+
			"when (a.annuald-a.quantityd)<20 then (((a.annuald-a.quantityd)-10) * (select to_number(value) from comcd_t where div='annual' and code=1)+(select to_number(value) from comcd_t where div='annual' and code=10))\n"+
			"else (select to_number(value) from comcd_t where div='annual' and code=20)\n"+
			"end as remainCo\n"+
			"from empbasics_t b,\n"+
			"empannual a\n"+
			"where b.empcd=a.empcd(+)\n"+
			"order by b.empcd";
	
	
	//String SQL = "select b.empnm,nvl(a.annuald,0)annuald,nvl(a.quantityd,0)quantityd,nvl((a.annuald-a.quantityd),0) remaind,case when nvl((a.annuald-a.quantityd),0) <10 then (nvl((a.annuald-a.quantityd),0) * (select to_number(value) from comcd_t where div='annual' and code=1)) when (a.annuald-a.quantityd)<20 then (((a.annuald-a.quantityd)-10) * (select to_number(value) from comcd_t where div='annual' and code=1)+(select to_number(value) from comcd_t where div='annual' and code=10)) else (select to_number(value) from comcd_t where div='annual' and code=20) end as remainCo from empbasics_t b,empannual a where b.empcd=a.empcd(+) order by b.empcd";

	rs = stmt.executeQuery(SQL);

	/********* Dataset Create ************/
	DataSet ds = new DataSet("empAnnual");
	ds.addColumn("empNm", DataTypes.STRING, 20);
	ds.addColumn("annualD", DataTypes.STRING, 20);
	ds.addColumn("quantityD", DataTypes.STRING, 20);
	ds.addColumn("remainD", DataTypes.STRING, 20);
	ds.addColumn("remainCo", DataTypes.STRING, 20);
	int row = 0;
	while (rs.next()) {
		
		row = ds.newRow();
		ds.set(row, "empNm", rs.getString("empNm"));
		ds.set(row, "annualD", rs.getString("annualD"));
		ds.set(row, "quantityD", rs.getString("quantityD"));
		ds.set(row, "remainD", rs.getString("remainD"));
		ds.set(row, "remainCo", rs.getString("remainCo"));
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