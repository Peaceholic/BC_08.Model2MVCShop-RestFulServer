<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>

<% System.out.println("* [ listProduct.jsp ] "); %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>	

<%--

<%@ page import="java.util.List"%>

<%@ page import="com.model2.mvc.common.Search"%>
<%@ page import="com.model2.mvc.common.Page"%>
<%@ page import="com.model2.mvc.common.util.CommonUtil"%>

<%@ page import="com.model2.mvc.service.domain.User"%>
<%@ page import="com.model2.mvc.service.domain.Product"%>

	User user = (User) session.getAttribute("user");
	String menu = (String) request.getParameter("menu");

	List<Product> list = (List<Product>) request.getAttribute("list");
	Page resultPage = (Page) request.getAttribute("resultPage");

	Search search = (Search) request.getAttribute("search");

	//==> null �� ""(nullString)���� ����
	String searchCondition = CommonUtil.null2str(search.getSearchCondition());
	String searchKeyword = CommonUtil.null2str(search.getSearchKeyword());
--%>

<html>
<head>
<title>��ǰ �����ȸ</title>

<link rel="stylesheet" href="/css/admin.css" type="text/css">

<script type="text/javascript">
	function fncGetProductList(currentPage) {
		document.getElementById("currentPage").value = currentPage;
	   	document.detailForm.submit();	
	}
</script>
</head>

<body bgcolor="#ffffff" text="#000000">

	<div style="width: 98%; margin-left: 10px;">

		<form name="detailForm" action="/product/listProduct?menu=${menu}" method="post">

			<table width="100%" height="37" border="0" cellpadding="0"
				cellspacing="0">
				<tr>
					<td width="15" height="37"><img src="/images/ct_ttl_img01.gif"
						width="15" height="37"></td>
					<td background="/images/ct_ttl_img02.gif" width="100%"
						style="padding-left: 10px;">
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
							
								<%-- if (menu == null || menu.equals("manage")) { %>
							
								<td width="93%" class="ct_ttl01">��ǰ ����</td>
								
								<% } else { %>
								
								<td width="93%" class="ct_ttl01">��ǰ �����ȸ</td>
								
								<% } --%>
							<c:choose>
								<c:when test="${ empty param.menu || param.menu == 'manage'}"> 
									<td width="93%" class="ct_ttl01">��ǰ ����</td>
								</c:when>
								<c:otherwise>
									<td width="93%" class="ct_ttl01">��ǰ �����ȸ</td>
								</c:otherwise>
							</c:choose>

							</tr>

						</table>
					</td>
					<td width="12" height="37"><img src="/images/ct_ttl_img03.gif"
						width="12" height="37"></td>
				</tr>
			</table>

			<table width="100%" border="0" cellspacing="0" cellpadding="0"
				style="margin-top: 10px;">
				<tr>
					<td align="right"><select name="searchCondition"
						class="ct_input_g" style="width: 80px">
							<option value="0" ${search.searchCondition eq '0' ? "selected" : "" }>��ǰ��ȣ</option>
							<option value="1" ${search.searchCondition eq '1' ? "selected" : "" }>��ǰ��</option>
							<option value="2" ${search.searchCondition eq '2' ? "selected" : "" }>����</option>
					</select> 
					
						<input type="text" name="searchKeyword" 
						value="${! empty search.searchKeyword ? search.searchKeyword : ''}"  
						class="ct_input_g" style="width:200px; height:20px" > 
						
					
					<td align="right" width="70">
						<table border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td width="17" height="23"><img
									src="/images/ct_btnbg01.gif" width="17" height="23"></td>
								<td background="/images/ct_btnbg02.gif" class="ct_btn01"
									style="padding-top: 3px;"><a
									href="javascript:fncGetProductList(1);">�˻�</a></td>
								<td width="14" height="23"><img
									src="/images/ct_btnbg03.gif" width="14" height="23"></td>
							</tr>
						</table>
					</td>
				</tr>
			</table>

			<table width="100%" border="0" cellspacing="0" cellpadding="0"
				style="margin-top: 10px;">
				<tr>
					<td colspan="11">��ü ${resultPage.totalCount} �Ǽ�, ���� ${resultPage.currentPage }������
					</td>
				</tr>
				<tr>
					<td class="ct_list_b" width="50">No</td>
					<td class="ct_line02"></td>
					<td class="ct_list_b" width="150">��ǰ��</td>
					<td class="ct_line02"></td>
					<td class="ct_list_b" width="80">����</td>
					<td class="ct_line02"></td>
					<td class="ct_list_b" width="100">�����</td>
					<td class="ct_line02"></td>
					<td class="ct_list_b" width="150">�������</td>
				</tr>
				<tr>
					<td colspan="11" bgcolor="808285" height="1"></td>
				</tr>
			
	<c:set var="i" value="0" />
	<c:forEach var="product" items="${list}">
		<c:set var="i" value="${ i+1 }" />
		<tr class="ct_list_pop">
			<td align="center">${ i }</td>
			<td></td>
			
			<%-- if (( user != null && user.getRole().equals("admin")) || product.getProTranCode().equals("0")) { %>
					
			<td align="left">
			<a href="/getProduct.do?prodNo=<%=product.getProdNo()%>&menu=${param.menu}"><%=product.getProdName()%></a></td>
					
			<% } else { %>
			<td align="left"><%=product.getProdName()%></td>
				
			<% } --%>
			
			<c:choose>
				<c:when test="${ !empty user && user.role == 'admin' || product.proTranCode == '0' }"> 
					<td align="left">
					<a href="/product/getProduct?prodNo=${product.prodNo}&menu=${param.menu}">${product.prodName}</a></td>
				</c:when>
				<c:otherwise>
					<td align="left">
					<a href="/product/getProduct?prodNo=${product.prodNo}&menu=${param.menu}">${product.prodName}</a></td>
				</c:otherwise>
			</c:choose>	
		
			<td></td>
			<td align="center">${product.price}</td>
			<td></td>
			<td align="center">${product.regDate}			
			<td></td>
			<td align="left">
			
		<%-- if (product.getProTranCode() == null || product.getProTranCode().equals("0")) { %> 
		     �Ǹ��� 
		<% } else if (Integer.parseInt(product.getProTranCode()) > 0 && (user == null || user.getRole().equals("user"))) { %> 
			 ��� ���� 
		<% } else if (product.getProTranCode().equals("1")) { %> 
			 ���ſϷ� 
		<%  	if (menu.equals("manage")) { %> 
		    <a href="/updateTranCodeByProd.do?prodNo=<%=product.getProdNo()%>&tranCode=2">����ϱ�</a>
		<%		}
			} else if (product.getProTranCode().equals("2")) { %> 
			����� 
		<%	} else { %> 
			��ۿϷ� 
		<%	} --%>
			
			<c:choose>
				<c:when test="${ empty product.proTranCode || product.proTranCode == '0' }"> 
					�Ǹ���
				</c:when>				
				<c:when test="${ product.proTranCode == '1' }"> 
					<c:choose>
    					<c:when test="${ param.menu == 'manage' }"> 
    						���ſϷ� <a href="/purchase/updateTranCodeByProd?prodNo=${product.prodNo }&tranCode=2">����ϱ�</a>
    					</c:when>
    					<c:otherwise> 
    						���ſϷ�
    					</c:otherwise>
    				</c:choose>
				</c:when>
				<c:when test="${ product.proTranCode == '2' }"> 
					�����
				</c:when>							
				<c:otherwise>
					��ۿϷ�
				</c:otherwise>
				</c:choose>		
						
			</td>		
		</tr>
		<tr>
		<td colspan="11" bgcolor="D6D7D6" height="1"></td>
		</tr>
	</c:forEach>
			</table>

			<!-- PageNavigation Start... -->
			<table width="100%" border="0" cellspacing="0" cellpadding="0"
				style="margin-top: 10px;">
				<tr>
					<td align="center"><input type="hidden" id="currentPage"
						name="currentPage" value="" /> 
												
						<jsp:include page="../common/pageNavigatorProd.jsp"/>
					</td>
				</tr>
			</table>		
			<!-- PageNavigation End... -->
		</form>
	</div>

</body>
</html>