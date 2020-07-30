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
		      "a.empnm,\n"+
		      "b.value rela,\n"+
		      "c.value addr,\n"+
		      "i.anallnco,\n"+
		      "((g.childeatra * e.value)+(h.oldeatra * f.value)) as familyco,\n"+
		      "(i.anallnco+((g.childeatra * e.value)+(h.oldeatra * f.value))) as totalco\n"+
		"from\n"+
		      "empbasics_t a,\n"+
		      "(select code,value from comcd_t where div='rela') b,\n"+
		      "(select code,value from comcd_t where div='zip') c,\n"+
		      "(select empcd,min(relacd) relacd from empfamily_t group by empcd) d,\n"+
		      "(select value from comcd_t where div='eatra' and code='child') e,\n"+
		      "(select value from comcd_t where div='eatra' and code='old') f,\n"+
		      "(select empcd,count(childeatra) childeatra from empfamily_t group by empcd) g,\n"+
		      "(select empcd,count(oldeatra) oldeatra from empfamily_t group by empcd) h,\n"+
		      "empanallnco_t i\n"+
		"where\n"+
		      "a.empzipcd=c.code\n"+ 
		      "and a.empcd=d.empcd\n"+
		      "and d.relacd=b.code\n"+
		      "and a.empcd=g.empcd\n"+
		      "and a.empcd=h.empcd\n"+
		      "and a.empcd=i.empcd\n"+
		"order by a.empcd";
	
	
	//String SQL = "select b.empnm,nvl(a.annuald,0)annuald,nvl(a.quantityd,0)quantityd,nvl((a.annuald-a.quantityd),0) remaind,case when nvl((a.annuald-a.quantityd),0) <10 then (nvl((a.annuald-a.quantityd),0) * (select to_number(value) from comcd_t where div='annual' and code=1)) when (a.annuald-a.quantityd)<20 then (((a.annuald-a.quantityd)-10) * (select to_number(value) from comcd_t where div='annual' and code=1)+(select to_number(value) from comcd_t where div='annual' and code=10)) else (select to_number(value) from comcd_t where div='annual' and code=20) end as remainCo from empbasics_t b,empannual a where b.empcd=a.empcd(+) order by b.empcd";

	rs = stmt.executeQuery(SQL);

	/********* Dataset Create ************/
	DataSet ds = new DataSet("empAnallnco");
	ds.addColumn("empNm", DataTypes.STRING, 20);
	ds.addColumn("rela", DataTypes.STRING, 20);
	ds.addColumn("addr", DataTypes.STRING, 256);
	ds.addColumn("anallnco", DataTypes.STRING, 40);
	ds.addColumn("familyco", DataTypes.STRING, 40);
	ds.addColumn("totalco", DataTypes.STRING, 40);
	int row = 0;
	while (rs.next()) {
		
		row = ds.newRow();
		ds.set(row, "empNm", rs.getString("empNm"));
		ds.set(row, "rela", rs.getString("rela"));
		ds.set(row, "addr", rs.getString("addr"));
		ds.set(row, "anallnco", rs.getString("anallnco"));
		ds.set(row, "familyco", rs.getString("familyco"));
		ds.set(row, "totalco", rs.getString("totalco"));
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