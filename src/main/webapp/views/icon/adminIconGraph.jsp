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
   margin-left: 1400px;
   margin-bottom: 10px;
   }
   #yearSelect{
   margin-left: 1200px;
   top: 10px;
   }
   .selectmwd{
   margin-left: 1450px;
   

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
            <p class="title3" onclick="location.href='adminIconListView'">아이콘</p>
            <p class="title3" onclick="location.href='adminPopup'">팝업</p>
            <p class="title3" onclick="location.href='adminCode'">구분코드</p>
            <p class="title3" onclick="location.href='adminJoin'">회원가입</p>
        </aside>
        
        <main class="main-content">
      <p class="title1" >아이콘</p>
       
       <div class="btn03-l" onclick="location.href='adminIconChart'">차트</div>
       <div class="btn02-l" onclick="location.href='adminIconGraph'">그래프</div>
       <select id="yearSelect"></select>
     <select id="monthSelect" style="display: none;">
       <option value="1">1월</option>
       <option value="2">2월</option>
       <option value="3">3월</option>
       <option value="4">4월</option>
       <option value="5">5월</option>
       <option value="6">6월</option>
       <option value="7">7월</option>
       <option value="8">8월</option>
       <option value="9">9월</option>
       <option value="10">10월</option>
       <option value="11">11월</option>
       <option value="12">12월</option>
      </select>
      
      
       <div class="selectmwd">       
         <button  id="monthlyBtn">월간</button>
         <button  id="weeklyBtn">주간</button>
         <button  id="dailyBtn">일간</button>
       </div>
      <canvas id="myChart"></canvas>
       <div class="btn01-l" onclick="location.href='adminIcon'">리스트</div>
      
        </main>
   </div>
   
   <!-- 푸터 -->
   <jsp:include page="../footer.jsp" />
</body>



<script>



let chart;

// fetchAvailableYears 함수 정의
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
        })
        .catch(error => console.error('Error fetching available years:', error));
}

function fetchChartData(period, month) {
    const year = document.getElementById('yearSelect').value || new Date().getFullYear();
    const currentYear = new Date().getFullYear();
    const currentMonth = month || new Date().getMonth() + 1;

    let url = "/iconSalesData?period=" + period + "&year=" + year;

    if (period === 'weekly' || period === 'daily') {
        url += "&month=" + currentMonth;
    }

    fetch(url)
        .then(response => response.json())
        .then(data => {
            let labels;

            if (period === 'monthly') {
                labels = ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'];
            } else if (period === 'weekly') {
                labels = [];
                const weeksInMonth = Math.ceil(new Date(currentYear, currentMonth, 0).getDate() / 7);
                for (let i = 1; i <= weeksInMonth; i++) {
                    labels.push(currentMonth + '월 ' + i + '주차');
                }
            } else if (period === 'daily') {
                labels = [];
                const daysInMonth = new Date(year, currentMonth, 0).getDate();
                for (let i = 1; i <= daysInMonth; i++) {
                    labels.push(currentMonth + '월 ' + i + '일');
                }
            }

            const datasets = [];
            let iconMap = {};

            // 데이터가 없는 경우 빈 데이터셋으로 초기화
            if (!data || data.length === 0) {
                labels.forEach((label, index) => {
                    datasets.push({
                        label: "No Data",
                        data: Array(labels.length).fill(0),
                        fill: false,
                        borderColor: getRandomColor(),
                        borderWidth: 2
                    });
                });
            } else {
                // 데이터가 있을 경우 해당 데이터셋 생성
                data.forEach(item => {
                    if (!iconMap[item.icon_name]) {
                        iconMap[item.icon_name] = {
                            label: item.icon_name,
                            data: Array(labels.length).fill(0),
                            fill: false,
                            borderColor: getRandomColor(),
                            borderWidth: 2
                        };
                        datasets.push(iconMap[item.icon_name]);
                    }

                    let labelIndex;
                    if (period === 'monthly') {
                        labelIndex = item.timePeriod - 1;  // 1~12월을 인덱스로
                    } else if (period === 'weekly' || period === 'daily') {
                        labelIndex = item.timePeriod - 1; // 주차 및 일차 인덱스 설정
                    }

                    if (labelIndex >= 0 && labelIndex < labels.length) {
                        iconMap[item.icon_name].data[labelIndex] = item.purchaseCount;
                    }
                });
            }

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

function getCurrentWeek() {
    const currentDate = new Date();
    const startOfMonth = new Date(currentDate.getFullYear(), currentDate.getMonth(), 1);
    const dayOfMonth = currentDate.getDate();
    return Math.ceil((dayOfMonth + startOfMonth.getDay()) / 7);
}

// 페이지 로드 시 이벤트 리스너 추가
document.addEventListener('DOMContentLoaded', () => {
    fetchAvailableYears();  // 연도 목록 불러오기
    setTimeout(() => fetchChartData('monthly'), 1000);

    // 현재 달을 기본으로 선택 설정
    const currentMonth = new Date().getMonth() + 1;
    document.getElementById('monthSelect').value = currentMonth;
});
// 버튼 이벤트 리스너 추가
document.getElementById('monthlyBtn').addEventListener('click', () => {
    fetchChartData('monthly');
    document.getElementById('monthSelect').style.display = 'none'; // 월 선택 드롭다운 숨기기
});

document.getElementById('weeklyBtn').addEventListener('click', () => {
    fetchChartData('weekly');
    document.getElementById('monthSelect').style.display = 'block'; // 월 선택 드롭다운 보이기

    // 현재 달을 기본으로 선택 설정
    const currentMonth = new Date().getMonth() + 1;
    document.getElementById('monthSelect').value = currentMonth;
});

document.getElementById('dailyBtn').addEventListener('click', () => {
    fetchChartData('daily');
    document.getElementById('monthSelect').style.display = 'block'; // 월 선택 드롭다운 보이기

    // 현재 달을 기본으로 선택 설정
    const currentMonth = new Date().getMonth() + 1;
    document.getElementById('monthSelect').value = currentMonth;
});

document.querySelectorAll('.selectmwd button').forEach(button => {
    button.addEventListener('click', () => {
        // 기존 active 클래스 제거
        document.querySelectorAll('.selectmwd button').forEach(btn => btn.classList.remove('active'));
        
        // 클릭된 버튼에 active 클래스 추가
        button.classList.add('active');
    });
});

document.getElementById('monthSelect').addEventListener('change', () => {
    const selectedMonth = document.getElementById('monthSelect').value;
    if (selectedMonth) {
        // 사용자가 월을 선택하면 해당 월의 데이터를 가져옵니다.
        const period = document.querySelector('.selectmwd button.active').id.replace('Btn', '');
        fetchChartData(period, selectedMonth);
    }
});

</script>
<script src="resources/js/common.js" type="text/javascript"></script>
<script src="resources/js/layerPopup.js"></script>
</html>
