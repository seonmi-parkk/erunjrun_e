
// loading 시 
function loading(){
	$('body').append('<div class="loading-bg"><div class="lds-spinner"><div></div><div></div><div></div><div></div><div></div><div></div><div></div><div></div><div></div><div></div><div></div><div></div></div></div>');
}
// loading 완료시
function loadingComplete(){
	$('.loading-bg').remove();
}


// 태그 체크박스 클릭시 label에 클래스 추가
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
 