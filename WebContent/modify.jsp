<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
<head>
<title>User Management Application</title>

<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"
	integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T"
	crossorigin="anonymous">

</head>

</head>
<body>
	<h1> MPHKA</h1>
	<div class="container col-md-5">
		<div class="card">
			<div class="card-body">
				<c:if test="${todoedit != null}">
					<form action="update" method="post">
				</c:if>
				<c:if test="${todoedit == null}">
					<form action="insert" method="post">
				</c:if>

				<caption>
					<h2>
						<c:if test="${todoedit != null}">
            			Edit Todo
            		</c:if>
						<c:if test="${todoedit == null}">
            			Add New Dream Trip
            		</c:if>
					</h2>
				</caption>

				<c:if test="${todoedit != null}">
					<input type="hidden" name="id" value="<c:out value='${todoedit.id}' />" />
				</c:if>

				<fieldset class="form-group">
					<label>Todo Title</label> <input type="text"
						value="<c:out value='${todoedit.title}' />" class="form-control"
						name="title" required="required" minlength="5">
				</fieldset>

				<fieldset class="form-group">
					<label>Todo Decription</label> <input type="text"
						value="<c:out value='${todoedit.description}' />" class="form-control"
						name="description" minlength="5">
				</fieldset>

				<fieldset class="form-group">
					<label>Todo Status</label> <select class="form-control"
						name="isDone">
						<option value="false">In Progress</option>
						<option value="true">Complete</option>
					</select>
				</fieldset>

				<fieldset class="form-group">
					<label>Todo Target Date</label> <input type="date"
						value="<c:out value='${todoedit.targetDate}' />" class="form-control"
						name="targetDate" required="required">
				</fieldset>
				<form action="modify" method="post">
					<button type="submit" class="btn btn-success">Save Changes</button>
				</form>
				</form>
			</div>
		</div>
	</div>

	<jsp:include page="/common/footer.jsp"></jsp:include>
</body>
</html>