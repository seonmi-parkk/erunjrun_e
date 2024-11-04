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
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<style>
   .input-container {
    display: flex;        /* Flexbox 사용 */
    align-items: center; /* 수직 중앙 정렬 */
    margin-bottom: 20px;
    margin-top: 20px;
   }
   #searchForm{
   margin-top: 20px; 
   margin-bottom: 10px; 
   }
   
   #text{
   
    margin-right: 15px
   }
   body {
    display: flex;
    flex-direction: column;
    min-height: 100vh;
    margin: 0;
   }
   /* 콘텐츠와 사이드바 감싸는 래퍼 */
   .content-wrapper {
       display: flex;
       width: 100%;
       margin: 80px 10px; /* 헤더 높이만큼 여백 */
       flex-grow: 1; /* 남은 공간 채우기 */
   }

   /* 사이드바 스타일 */
   .fixed-left {
       width: 300px;
       border-right: 1px solid #ccc;
       padding: 20px;
       position: sticky;
       top: 80px; /* 헤더 아래에 고정 */
       height: calc(100vh - 80px); /* 화면 높이에 맞추기 */
       overflow-y: auto;
   }
   .fixed-left p{
       margin: 15px 0;
       line-height: 1.5;
       font-size: 20px;
   }
   
   #admin_name{
   font-weight: 800;
   font-size: 23px;
   }
   
   .image img {
       width: 35%;  /* 또는 원하는 픽셀 값 */
       height: auto;
       margin-bottom: 20px; /* 비율을 유지 */
      }
   /* 메인 콘텐츠 */
   .main-content {
       flex: 1; /* 남은 공간 채우기 */
       padding: 20px;
       overflow: auto;
   }
   #content{
       width: 750px; /* 너비를 250픽셀로 설정 */
        height: 350px;
        resize: vertical; /* 높이를 50픽셀로 설정 */
        font-size: 20px; /* 글자 크기를 18픽셀로 설정 */
        padding: 10px; /* 내부 여백을 10픽셀로 설정 */
    
    }
   
   .btn01-l{
   margin-top: 10px;
   margin-left: 1450px;
   margin-bottom: 10px;
   }
</style>
</head>
<body>
   <!-- 헤더 -->
   <jsp:include page="../header.jsp"/> 
   
   <!-- inner 클래스 하위에 모든 요소들을 넣어서 만드시면 됩니다. -->
      
      <div class="content-wrapper">
      <aside class="fixed-left">
            <div class="image">
                <img class="profile-img" src="resources/img/common/admin_profile.png" alt="관리자 프로필 이미지"/>
            </div>
            <p class="title2" id="admin_name">관리자</p>
            <p class="title3" onclick="location.href='adminMember'">회원정보</p>
            <p class="title3" onclick="location.href='adminReport'">신고</p>
            <p class="title3" onclick="location.href='adminAsk'">문의하기</p>
            <p class="title3" onclick="location.href='adminTag'">태그</p>
            <p class="title3" onclick="location.href='adminIcon'">아이콘</p>
            <p class="title3" onclick="location.href='adminPopup'">팝업</p>
            <p class="title3" onclick="location.href='adminCode'">구분코드</p>
            <p class="title3" onclick="location.href='adminJoin'">회원가입</p>
        </aside>
        
        <main class="main-content">
      <p class="title1" >아이콘</p>
       
       <select id="yearSelect"></select>
      <canvas id="myChart"></canvas>
      <button id="monthlyBtn">월간</button>
      <button id="weeklyBtn">주간</button>
      <button id="dailyBtn">일간</button>
       <select id="yearSelect">
    <c:forEach var="year" items="${availableYears}">
        <option value="${year}">${year}</option>
    </c:forEach>
</select>

<div id="debugData">
    <c:forEach var="data" items="${iconSalesData}">
        <p>${data.icon_name}: ${data.purchaseCount}</p>
    </c:forEach>
</div>
       
      
        </main>
   </div>
   
   <!-- 푸터 -->
   <jsp:include page="../footer.jsp" />
</body>



<script>
let chart;

function fetchAvailableYears() {
    fetch('/availableYears')
        .then(response => response.json())
        .then(years => {
            const yearSelect = document.getElementById('yearSelect');
            yearSelect.innerHTML = '';
            years.forEach(year => {
                const option = document.createElement('option');
                option.value = year;
                option.textContent = year;
                yearSelect.appendChild(option);
            });
        });
}

function fetchChartData(period) {
    const year = document.getElementById('yearSelect').value;
    fetch(`/iconSalesData?period=${period}&year=${year}`)
        .then(response => response.json())
        .then(data => {
            // 데이터가 있는지 확인
            if (!data || data.length === 0) {
                console.error("No data available to display.");
                return;
            }

            // X축에 사용할 라벨들 생성 (기간)
            const labels = period === 'monthly' ? ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'] : Array.from({ length: (period === 'weekly' ? 7 : 31) }, (_, i) => i + 1);

            // 아이콘 별 데이터 세트 생성
            const datasets = [];
            const iconMap = {};

            data.forEach(item => {
                if (!iconMap[item.icon_name]) {
                    iconMap[item.icon_name] = {
                        label: item.icon_name,
                        data: Array(labels.length).fill(0), // 각 기간별 값을 0으로 초기화
                        fill: false,
                        borderColor: getRandomColor(),
                        borderWidth: 2
                    };
                    datasets.push(iconMap[item.icon_name]);
                }

                // 라벨과 맞는 위치에 데이터를 삽입
                const labelIndex = labels.indexOf(item.timePeriod);
                if (labelIndex !== -1) {
                    iconMap[item.icon_name].data[labelIndex] = item.purchaseCount;
                }
            });

            // 차트를 업데이트
            updateChart(labels, datasets);
        })
        .catch(error => console.error('Error fetching chart data:', error));
}

function updateChart(labels, datasets) {
    const ctx = document.getElementById('myChart').getContext('2d');
    if (chart) {
        chart.destroy();
    }
    chart = new Chart(ctx, {
        type: 'line',
        data: {
            labels: labels,
            datasets: datasets
        },
        options: {
            responsive: true,
            plugins: {
                legend: {
                    position: 'top',
                }
            },
            scales: {
            x: {
                title: {
                    display: true,
                    text: 'Time Period'
                }
            },
            y: {
                title: {
                    display: true,
                    text: 'Purchase Count'
                },
                beginAtZero: true,
                suggestedMin: 0,
                suggestedMax: 10
            }
        }
            },
            onClick: (e) => {
                const activePoints = chart.getElementsAtEventForMode(e, 'nearest', { intersect: true }, true);
                if (activePoints.length) {
                    const datasetIndex = activePoints[0].datasetIndex;
                    chart.data.datasets.forEach((dataset, index) => {
                        dataset.borderWidth = index === datasetIndex ? 5 : 2;
                    });
                    chart.update();
                }
            }
        
    });
}

function getRandomColor() {
    const letters = '0123456789ABCDEF';
    let color = '#';
    for (let i = 0; i < 6; i++) {
        color += letters[Math.floor(Math.random() * 16)];
    }
    return color;
}

// Event listeners for buttons to change period (monthly, weekly, daily)
document.getElementById('monthlyBtn').addEventListener('click', () => fetchChartData('monthly'));
document.getElementById('weeklyBtn').addEventListener('click', () => fetchChartData('weekly'));
document.getElementById('dailyBtn').addEventListener('click', () => fetchChartData('daily'));

// Fetch available years on page load
document.addEventListener('DOMContentLoaded', () => {
fetchAvailableYears();
setTimeout(() => fetchChartData('monthly'), 1000);
});

</script>
<script src="resources/js/common.js" type="text/javascript"></script>
<script src="resources/js/layerPopup.js"></script>
</html>