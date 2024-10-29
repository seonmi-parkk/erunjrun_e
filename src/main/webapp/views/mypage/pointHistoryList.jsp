<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>이런저런</title>
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="resources/css/common.css">
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.2/js/bootstrap.min.js"></script>
    <style>
        /* 추가적인 CSS 스타일을 여기에 작성하세요 */
    </style>
</head>
<body>
    <jsp:include page="header.jsp"/> 
       
        <p class="title1">--------리스트--------</p>
        <select id="pagePerNum">
            <option value="5">5</option>
            <option value="10">10</option>
            <option value="15">15</option>
            <option value="20" selected>20</option>
        </select>
        개 씩 보기
        <table>
            <thead>
                <tr>
                    <th>글번호</th>
                    <th>제목</th>
                    <th>작성자</th>
                </tr>
            </thead>
            <tbody id="list">
                <!-- 리스트가 여기에 동적으로 추가됩니다. -->
            </tbody>
            <tr>
                <th colspan="6">
                    <div class="container">
                        <nav aria-label="Page navigation">
                            <ul class="pagination" id="pagination"></ul>
                        </nav>
                    </div>
                </th>
            </tr>
        </table>

       
    <jsp:include page="footer.jsp"/>



    <script>
        var show = 1;

        // 초기 리스트 불러오기
        pageCall(show);

        // 페이지당 항목 수 변경 시
        $('#pagePerNum').change(function(){
            $('#pagination').twbsPagination('destroy'); // 기존 페이징 파괴
            pageCall(show);
        });

        // 페이지 호출 함수
        function pageCall(page) {
            $.ajax({
                type: 'GET',
                url: '/pointHistoryList.ajax',
                data: {
                    'page': page,
                    'cnt': $('#pagePerNum').val()
                },
                datatype: 'JSON',
                success: function(data){
                    console.log(data);
                    drawList(data.list);
                    $('#pagination').twbsPagination({ // 페이징 객체 만들기
                        startPage: 1,
                        totalPages: data.totalpages,
                        visiblePages: 5,
                        onPageClick: function(evt, page){
                            console.log('evt', evt); 
                            console.log('page', page); 
                            pageCall(page);
                        }
                    });
                },
                error: function(e){
                    console.log(e);
                }
            });
        }

        // 리스트 그리기 함수
        function drawList(list) {
            var content = '';
            list.forEach(function(view, idx){ 
                content += '<tr>';
                content += '<td>' + view.idx + '</td>';
                content += '<td>';
                content += view.imgs > 0 ? '<img class="icon" src="img/img.png"/>' : '<img class="icon" src="img/noimg.png"/>';
                content += '<a href="detail.go?idx=' + view.idx + '">' + view.subject + '</a></td>';
                content += '<td>' + view.user_name + '</td>';
                content += '<td>' + view.bHit + '</td>';
                content += '<td>' + view.reg_date + '</td>';
                content += '<td><a href="del?idx=' + view.idx + '">삭제</a></td>';
                content += '</tr>';
            });
            $('#list').html(content);
        }
    </script>
</body>
</html>
