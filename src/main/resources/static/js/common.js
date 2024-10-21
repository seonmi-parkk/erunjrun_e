
alert("연결");
// 태그 체크박스 클릭시 label 스타일 변경
var checkboxes = document.querySelectorAll('#tagFilters input[type="checkbox"]');

checkboxes.forEach(function(checkbox){
  checkbox.addEventListener('click', function() {
    if (this.checked) {
      this.parentElement.classList.add('checked');
    } else {
      this.parentElement.classList.remove('checked');
    }
  });
});
 