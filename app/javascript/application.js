import "@hotwired/turbo-rails"

function initSettingsMenu() {
  var settingsButton = document.getElementById('settings-btn');
  var settingsMenu = document.getElementById('settings-menu');
  var lightModeBtn = document.getElementById('light-mode-btn');
  var darkModeBtn = document.getElementById('dark-mode-btn');
  var fontIncreaseBtn = document.getElementById('font-increase');
  var fontDecreaseBtn = document.getElementById('font-decrease');
  var chapterBody = document.querySelector('.book-chapter-body');

  if (!settingsButton || !settingsMenu) { return; }

  var savedTheme = localStorage.getItem('theme');
  if (savedTheme === 'dark') { document.body.classList.add('dark-mode'); }
  if (savedTheme === 'light') { document.body.classList.remove('dark-mode'); }

  var savedFontPercent = parseInt(localStorage.getItem('chapterFontPercent'), 10);
  if (!isNaN(savedFontPercent) && chapterBody) {
    chapterBody.style.fontSize = savedFontPercent + '%';
  }

  settingsButton.addEventListener('click', function (e) {
    e.stopPropagation();
    var expanded = settingsButton.getAttribute('aria-expanded') === 'true';
    settingsButton.setAttribute('aria-expanded', (!expanded).toString());
    settingsMenu.classList.toggle('hidden');
  });

  document.addEventListener('click', function (e) {
    if (!settingsMenu.classList.contains('hidden')) {
      var isInside = settingsMenu.contains(e.target) || settingsButton.contains(e.target);
      if (!isInside) { settingsMenu.classList.add('hidden'); settingsButton.setAttribute('aria-expanded','false'); }
    }
  });

  if (lightModeBtn) lightModeBtn.addEventListener('click', function () { document.body.classList.remove('dark-mode'); localStorage.setItem('theme','light'); });
  if (darkModeBtn) darkModeBtn.addEventListener('click', function () { document.body.classList.add('dark-mode'); localStorage.setItem('theme','dark'); });

  function clamp(v, min, max) { return Math.min(Math.max(v, min), max); }
  function getCurrentFontPercent() {
    var target = chapterBody || document.body;
    var computed = window.getComputedStyle(target).fontSize;
    var base = 16; var currentPx = parseFloat(computed) || base;
    return Math.round((currentPx / base) * 100);
  }
  function setFontPercent(percent) {
    var clamped = clamp(percent, 85, 200);
    if (chapterBody) { chapterBody.style.fontSize = clamped + '%'; }
    localStorage.setItem('chapterFontPercent', String(clamped));
  }
  if (fontIncreaseBtn) fontIncreaseBtn.addEventListener('click', function () { setFontPercent(getCurrentFontPercent() + 10); });
  if (fontDecreaseBtn) fontDecreaseBtn.addEventListener('click', function () { setFontPercent(getCurrentFontPercent() - 10); });
}

document.addEventListener('DOMContentLoaded', initSettingsMenu);
document.addEventListener('turbo:load', initSettingsMenu);