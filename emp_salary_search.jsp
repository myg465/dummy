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
			  "to_char(b.anallnco,'999,999,999') anallnco,\n"+
			  "to_char(c.tax,'999,999,999') tax,\n"+
			  "to_char(nvl((d.sal-round(c.tax/12)+(select sum(dayeatra)from empschedule where month=1 and empcd=a.empcd group by empcd)),(d.sal-round(c.tax/12))),'999,999,999') jan,\n"+
			  "to_char(nvl((d.sal-round(c.tax/12)+(select sum(dayeatra)from empschedule where month=2 and empcd=a.empcd group by empcd)),(d.sal-round(c.tax/12))),'999,999,999') feb,\n"+
			  "to_char(nvl((d.sal-round(c.tax/12)+(select sum(dayeatra)from empschedule where month=3 and empcd=a.empcd group by empcd)),(d.sal-round(c.tax/12))),'999,999,999') mar,\n"+
			  "to_char(nvl((d.sal-round(c.tax/12)+(select sum(dayeatra)from empschedule where month=4 and empcd=a.empcd group by empcd)),(d.sal-round(c.tax/12))),'999,999,999') apr,\n"+
			  "to_char(nvl((d.sal-round(c.tax/12)+(select sum(dayeatra)from empschedule where month=5 and empcd=a.empcd group by empcd)),(d.sal-round(c.tax/12))),'999,999,999') may,\n"+
			  "to_char(nvl((d.sal-round(c.tax/12)+(select sum(dayeatra)from empschedule where month=6 and empcd=a.empcd group by empcd)),(d.sal-round(c.tax/12))),'999,999,999') jun,\n"+
			  "to_char(nvl((d.sal-round(c.tax/12)+(select sum(dayeatra)from empschedule where month=7 and empcd=a.empcd group by empcd)),(d.sal-round(c.tax/12))),'999,999,999') jul,\n"+
			  "to_char(nvl((d.sal-round(c.tax/12)+(select sum(dayeatra)from empschedule where month=8 and empcd=a.empcd group by empcd)),(d.sal-round(c.tax/12))),'999,999,999') aug,\n"+
			  "to_char(nvl((d.sal-round(c.tax/12)+(select sum(dayeatra)from empschedule where month=9 and empcd=a.empcd group by empcd)),(d.sal-round(c.tax/12))),'999,999,999') sep,\n"+
			  "to_char(nvl((d.sal-round(c.tax/12)+(select sum(dayeatra)from empschedule where month=10 and empcd=a.empcd group by empcd)),(d.sal-round(c.tax/12))),'999,999,999') oct,\n"+
			  "to_char(nvl((d.sal-round(c.tax/12)+(select sum(dayeatra)from empschedule where month=11 and empcd=a.empcd group by empcd)),(d.sal-round(c.tax/12))),'999,999,999') nov,\n"+
			  "to_char(nvl((d.sal-round(c.tax/12)+(select sum(dayeatra)from empschedule where month=12 and empcd=a.empcd group by empcd)),(d.sal-round(c.tax/12))),'999,999,999') dec\n"+
			"from\n"+
			  "empbasics_t a,\n"+
			  "empanallnco_t b,\n"+
			  "(select a.empcd,(b.basicstax+b.residencetax) as tax from empannual a, emptax_t b where a.year=b.year) c,\n"+
			  "(select empcd,round(anallnco/12) as sal from empanallnco_t) d\n"+
			"where\n"+
			  "a.empcd=b.empcd\n"+
			  "and a.empcd=c.empcd\n"+
			  "and a.empcd=d.empcd";
	
	rs = stmt.executeQuery(SQL);

	/********* Dataset Create ************/
	DataSet ds = new DataSet("empSalary");
	ds.addColumn("empNm", DataTypes.STRING, 30);
	ds.addColumn("anallnCo", DataTypes.STRING, 30);
	ds.addColumn("tax", DataTypes.STRING, 30);
	ds.addColumn("jan", DataTypes.STRING, 30);
	ds.addColumn("feb", DataTypes.STRING, 30);
	ds.addColumn("mar", DataTypes.STRING, 30);
	ds.addColumn("apr", DataTypes.STRING, 30);
	ds.addColumn("may", DataTypes.STRING, 30);
	ds.addColumn("jun", DataTypes.STRING, 30);
	ds.addColumn("jul", DataTypes.STRING, 30);
	ds.addColumn("aug", DataTypes.STRING, 30);
	ds.addColumn("sep", DataTypes.STRING, 30);
	ds.addColumn("oct", DataTypes.STRING, 30);
	ds.addColumn("nov", DataTypes.STRING, 30);
	ds.addColumn("dec", DataTypes.STRING, 30);
	
	int row = 0;
	while (rs.next()) {
		
		row = ds.newRow();
		ds.set(row, "empNm", rs.getString("empNm"));
		ds.set(row, "anallnCo", rs.getString("anallnCo"));
		ds.set(row, "tax", rs.getString("tax"));
		ds.set(row, "jan", rs.getString("jan"));
		ds.set(row, "feb", rs.getString("feb"));
		ds.set(row, "mar", rs.getString("mar"));
		ds.set(row, "apr", rs.getString("apr"));
		ds.set(row, "may", rs.getString("may"));
		ds.set(row, "jun", rs.getString("jun"));
		ds.set(row, "jul", rs.getString("jul"));
		ds.set(row, "aug", rs.getString("aug"));
		ds.set(row, "sep", rs.getString("sep"));
		ds.set(row, "oct", rs.getString("oct"));
		ds.set(row, "nov", rs.getString("nov"));
		ds.set(row, "dec", rs.getString("dec"));
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