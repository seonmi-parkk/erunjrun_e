function setCookie(name, value, days) {
    const date = new Date();
    date.setTime(date.getTime() + (days * 24 * 60 * 60 * 1000));
    document.cookie = `${name}=${value}; expires=${date.toUTCString()}; path=/`;
}

function getCookie(name) {
    const value = `; ${document.cookie}`;
    const parts = value.split(`; ${name}=`);
    if (parts.length === 2) return parts.pop().split(';').shift();
    return null;
}

function closePopup(popupId) {
    setCookie(`hidePopup_${popupId}`, 'true', 1);
    document.getElementById(`popup_${popupId}`).style.display = 'none';
}

window.onload = function () {
    document.querySelectorAll('[id^="popup_"]').forEach(popup => {
        const popupId = popup.id.split('_')[1];
        if (getCookie(`hidePopup_${popupId}`) === 'true') {
            popup.style.display = 'none';
        }
    });
};
