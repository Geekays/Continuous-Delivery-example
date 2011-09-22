<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="feature" uri="http://open.bekk.no/jsp/jstl/feature" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<h1><fmt:message key="course.search.title"/></h1>

<table class="search">
    <tr>
        <th><fmt:message key="course.form.name"/></th>
        <th><fmt:message key="course.form.date"/></th>
        <th><fmt:message key="course.form.location"/></th>
        <th></th>
        <feature:enabled name="Course.Attendants">
            <th><fmt:message key="course.form.attendants"/></th>
        </feature:enabled>
    </tr>
    <c:forEach var="course" items="${courses}" varStatus="status">
        <tr>
            <c:set var="courseFormId" value="course${status.index}"/>

            <c:url var="editUrl" value="/course/form.html">
                <c:param name="id" value="${course.id}"/>
            </c:url>
            <feature:enabled name="Course.Delete">
                <c:url var="deleteUrl" value="/course/delete.html"/>
                <form id="${courseFormId}" action="${deleteUrl}" method="POST">
                    <input id="id" name="id" type="hidden" value="${course.id}"/>
                </form>
            </feature:enabled>

            <td>${course.name}</td>
            <td>${course.date}</td>
            <td>${course.location}</td>
            <td>
                <a href='<c:out value="${editUrl}"/>'><fmt:message key="button.edit"/></a>
                <feature:enabled name="Course.Delete">
                    <a href="javascript:document.forms['${courseFormId}'].submit();"><fmt:message key="button.delete"/></a>
                </feature:enabled>
            </td>
            <feature:enabled name="Course.Attendants">
                <c:url var="editUrl" value="/attendant/form.html">
                    <c:param name="courseId" value="${course.id}"/>
                </c:url>
                <td>${fn:length(course.attendants)}
                    <a href='<c:out value="${editUrl}"/>'><fmt:message key="button.add"/></a>
                </td>
            </feature:enabled>
        </tr>
    </c:forEach>
</table>